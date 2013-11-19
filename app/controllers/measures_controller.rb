require 'sql_measure'
require 'measures/measures_calculator'
class MeasuresController < ApplicationController
  include MeasuresCalculator
  
  # def initialize
    # #
  # end
  
  def index
    
  end

  def measure
    @measures = MeasureConfig.measureArray
    @subject_ids = nil # this feature is currently not in use
	
	#replace with Utils.getRIdFromParams
 	@research_id = (params["r_e_id"])
	if (@research_id.nil? or @research_id.empty? )
		name_id = params["r_e_name"].split(":")
		@research_id = (params["r_e_name"].split(":")[1])  if (name_id.size ==2)
	end
      #@subject_ids = params[:subject_ids].delete(" ").split(",") if params[:subject_ids] != ""

	  if (@research_id)
	     
      @result = MeasuresCalculator.calculateAllMeasuresForReaserch(@research_id,nil)
    
		if @result.first
			respond_to do |format|
				format.html
				format.csv do #{ render :layout => false }
					csv_string = CSV.generate do |csv| 
						csv << @result.first.keys
						@result.each do |row|
							csv << row.map(&:last)
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
 
  
  
end
