require 'ans_parse/ans_parser'
require 'measures/sql_measure'
require 'measures/measures_calculator'
include MeasuresCalculator
class SimpleMeasuresController < ApplicationController
  def initialize
    super
    @parser = AnsParser.new
    @research = nil
  end

  def index

  end

  def db_bulk_operation
    ActiveRecord::Base.connection.execute("SET autocommit=0;")
    ActiveRecord::Base.connection.execute("SET SESSION tx_isolation='READ-UNCOMMITTED';")
    yield
    ActiveRecord::Base.connection.execute("COMMIT;")
  end

  def loading
    @research = TempResearch.new
    @research.save

    #Parse and upload task_runs
    @subject_ids_map = Hash.new
    @task_run_count = 0
    @bad_files = ''
    @subjects_id_list=[]
    if params[:item].nil? or params[:item][:attached_assets_attributes].nil?
      redirect_error("Please select files to upload")
      return
    else
      params[:item][:attached_assets_attributes].each do |f|
        begin
          task_run = @parser.parse(f[:asset].read, f[:asset].original_filename, true)
          task_run.RESEARCH_ID = @research.RESEARCH_ID
          task_run.SUBJECT_ID = get_subject_id(task_run.SUBJECT_IDENTIFIER)
          db_bulk_operation { task_run.save }
        rescue ActiveRecord::RecordNotUnique => er
          @bad_files << f[:asset].original_filename + ": Duplicate file\n"
        rescue Exception => e
          @bad_files << f[:asset].original_filename + ": " + e.message + "\n"
        end
      end
    end
    @result = MeasuresCalculator.calculateAllMeasuresForResearch(@research.RESEARCH_ID, "temp")

    if @result.first
      respond_to do |format|
        format.html
        format.csv do #{ render :layout => false }
          csv_string = CSV.generate do |csv|
            csv << [@bad_files]
            csv << @result.first.keys
            @result.each do |row|
              csv << row.map(&:last)
            end
          end
          logger.info 'sending csv'
          send_data csv_string, :filename => "Measures_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.csv", :type => "application/csv"
        end
      end
    end
    db_bulk_operation {@research.destroy}
  end

  def get_subject_id(subject_identifier)
    #Check if the subject id was already fetched for a previous task run
    subject_id = @subject_ids_map[subject_identifier]

    #Check if the identifier exists in the db
    if subject_id.nil?
      if subject_identifier.nil?
        raise 'subject identifier is null'
      end
      subject = TempSubject.new
      subject.SUBJECT_IDENTIFIER = subject_identifier
      subject.save
      subject_id = subject.SUBJECT_ID
      @subject_ids_map[subject_identifier] = subject.SUBJECT_ID
    end

    subject_id
  end


  def redirect_error(msg)
    flash.now[:alert] = "Invalid form submission: #{msg}"
    render :index and return
  end


end
