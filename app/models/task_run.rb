class TaskRun < ActiveRecord::Base
 self.table_name='T_TASK_RUN'
 self.primary_key='TASK_RUN_ID'
  attr_protected
 has_many :trials, :foreign_key => 'TASK_RUN_ID', :primary_key => 'TASK_RUN_ID'
  belongs_to :subject, :foreign_key => 'SUBJECT_ID'
  belongs_to :research, :foreign_key => 'RESEARCH_ID'
end
