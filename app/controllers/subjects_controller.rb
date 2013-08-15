require 'utils'
include Utils
class SubjectsController < ApplicationController
  
  
  def index
    
  end
  
  
  def bulk_update
    @subjects = []
    if(not params[:subjects_ids].nil? and not params[:subjects_ids].empty?)
      @subjects =  Subject.find(params[:subjects_ids])
    else
      research_id = Utils.getRIdFromParams(params)
      if(research_id)
        research = Research.find(research_id) if Research.exists?(research_id)
        puts research.task_runs.first.subject
        research.task_runs.each do |t|
          @subjects << t.subject if not @subjects.include?(t.subject)
        end
      end
    end
  end
  
  def bulk_update_save
    
    result = Subject.update(params[:subjects].keys, params[:subjects].values).reject { |p| p.errors.empty? }
    flash.now[:alert] = "Successfully updated the records"
    render :index
   
     if result.empty?
       flash.now[:alert] = "Successfully updated the records"
      render :index
      else
       flash[:error] = "Error occurred updating"  
     end

  end
  
  def summary
    
  end
end
