class TaskRun < ActiveRecord::Base
 self.table_name='t_task_run'
 self.primary_key='TASK_RUN_ID'
 
 attr_accessor :SUBJECT_IDENTIFIER
  attr_protected
 has_many :trials, :foreign_key => 'TASK_RUN_ID', :primary_key => 'TASK_RUN_ID', :dependent => :destroy
  belongs_to :subject, :foreign_key => 'SUBJECT_ID'
  belongs_to :research, :foreign_key => 'RESEARCH_ID'
  belongs_to :task , :foreign_key => 'TASK_ID'
end
