class TempTrial < ActiveRecord::Base
 self.table_name='temp_trial'
 self.primary_key='TRIAL_ID'
 attr_protected
 belongs_to :temp_task_run, :foreign_key => 'TASK_RUN_ID'
end
