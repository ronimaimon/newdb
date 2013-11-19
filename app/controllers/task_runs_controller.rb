class TaskRunsController < ApplicationController

  def destroy
    
    @task_run = TaskRun.find(params[:id])
    @task_run.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
  
  
  
end
