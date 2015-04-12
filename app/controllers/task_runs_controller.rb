class TaskRunsController < AdminController

  def destroy
    
    @task_run = TaskRun.find(params[:id])
    @task_run.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def move
    unless params[:ids].nil? or params[:r_id].nil?
      ids= params[:ids].delete(' ')
      first_index = ids.index(',')
      TaskRun.where("SUBJECT_ID IN(#{ids[first_index+1..-1]}) AND RESEARCH_ID = #{params[:r_id]}").update_all(:SUBJECT_ID => ids[0..first_index-1])
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end

  end
  
  
  
end
