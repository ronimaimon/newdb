class TempTaskRun < ActiveRecord::Base
 self.table_name='temp_task_run'
 self.primary_key='TASK_RUN_ID'
 
 attr_accessor :SUBJECT_IDENTIFIER
  attr_protected
 has_many :temp_trials, :foreign_key => 'TASK_RUN_ID', :primary_key => 'TASK_RUN_ID', :dependent => :destroy
  belongs_to :temp_subject, :foreign_key => 'SUBJECT_ID'
  belongs_to :temp_research, :foreign_key => 'RESEARCH_ID'
  belongs_to :task , :foreign_key => 'TASK_ID'


 def trials
   logger.debug 'in trials'
   temp_trials
 end
end
