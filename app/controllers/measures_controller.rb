require 'measures/sql_measure'
require 'measures/measures_calculator'
require 'utils'
include Utils
include MeasuresCalculator
class MeasuresController < ApplicationController 
  
  def index
        @measures = MeasureConfig.presentationArray
 
  end

  def measure
    @measures = MeasureConfig.measureArray
    @subject_ids = nil # this feature is currently not in use
	
    research_id = Utils.getRIdFromParams(params)

	  if (research_id)
	     
      @result = MeasuresCalculator.calculateAllMeasuresForResearch(research_id,"t")
    
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
