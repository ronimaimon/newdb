class Trial < ActiveRecord::Base
 self.table_name='t_trial'
 self.primary_key='TRIAL_ID'
 attr_protected
 belongs_to :task_run, :foreign_key => 'TASK_RUN_ID'
end
