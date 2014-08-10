require 'ans_parse/ans_parser'
class SimpleMeasuresController < ApplicationController
  def initialize
    super
    @parser = AnsParser.new
    @research = nil
  end
  
  def index
    
  end

  def loading  
      @research = Research.new
      @research.save
      
    #Parse and upload task_runs
    @subject_ids_map = Hash.new
    @task_run_count = 0
    @bad_files = ""
    @subjects_id_list=[]
    if(params[:item].nil? or params[:item][:attached_assets_attributes].nil?)
      redirectError("Please select files to upload")
      return
    else
      params[:item][:attached_assets_attributes].each do |f|
       begin
          task_run = @parser.parse(f[:asset].read,  f[:asset].original_filename)
            task_run.RESEARCH_ID = @research.RESEARCH_ID 
            task_run.SUBJECT_ID = task_run.SUBJECT_IDENTIFIER
            task_run.save
     rescue ActiveRecord::RecordNotUnique => er
         @bad_files << f[:asset].original_filename + ": Duplicate file\n"
       rescue Exception => e  
         @bad_files << f[:asset].original_filename + ": " + e.message + "\n"
        end
      end
    end
  end
  
 
 def redirectError(msg)
  flash.now[:alert] = "Invalid form submission: #{msg}"
  render :index and return
 end
 

end
