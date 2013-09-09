require 'sql_measure'
require 'combined_measure'
class MeasuresController < ApplicationController
  include CombinedMeasure
  
  # def initialize
    # #
  # end
  
  def index
    
  end

  def measure
    @measures = MeasureConfig.measureArray
    @subject_ids = nil # this feature is currently not in use
	
	#replace with Utils.getRIdFromParams
 	@research_id = (params["r_id"])
	if (@research_id.nil? or @research_id.empty? )
		name_id = params["r_name"].split(":")
		@research_id = (params["r_name"].split(":")[1])  if (name_id.size ==2)
	end
      #@subject_ids = params[:subject_ids].delete(" ").split(",") if params[:subject_ids] != ""

	  if (@research_id)
      sql_m = SQLMeasure.new(@research_id, @subject_ids)

      @measures.each do |measure|
        sql_m.add_formula!(measure)
      end
      

      @result = ActiveRecord::Base.connection.exec_query(sql_m.get_sql)
    
    
		CombinedMeasure.addCombinedMeasures(@result)
    
		if @result.first
			respond_to do |format|
				format.html
				format.csv do #{ render :layout => false }
					csv_string = CSV.generate do |csv| 
						csv << @result.first.keys.sort
						@result.each do |row|
							csv << row.sort.map(&:last)
						end
					end
				send_data csv_string, :filename => "Measures_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.csv", :type => "application/csv"
				end
			end
		else 
			flash.now[:alert] = "The research is empty."
			redirect_to measures_index_path 
		end
		end
 end
 
  def getvalue
  @researches = []
  @r_hash = []
  if params[:term]
	@researches = Research.find(:all, :conditions => ['RESEARCH_NAME LIKE ?', "%#{params[:term]}%"])
	@researches.each do |r|
		value = r.RESEARCH_NAME + ":" + r.RESEARCH_ID.to_s
		@r_hash << {"label" => value, "value"=> value}
	end
  end
	
	respond_to do |format|
	format.html
	format.json { render :json =>  @r_hash}
	end
  end
  
  
end
