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
      research = Research.find_by_RESEARCH_ID(research_id)
      if not research.nil?
        research.task_runs.each do |t|
          @subjects << t.subject if not @subjects.include?(t.subject)
        end
      end
    end
  end
  
  def bulk_update_save
    
    result = Subject.update(params[:subjects].keys, params[:subjects].values).reject { |p| p.errors.empty? }
   
   respond_to do |format|
      if result.empty?
        format.html { redirect_to subjects_index_path, notice: 'Subjects were successfully updated.' }
        format.json { head :no_content }

      else
        format.html { render "bulk_update_save" }
        format.json { render json: result.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def summary
    
  end
end
