class Task < ActiveRecord::Base
  self.table_name='t_tasks'
  self.primary_key='TASK_ID'
  
  attr_accessible :task_id, :task_name
end
