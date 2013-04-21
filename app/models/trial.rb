class Trial < ActiveRecord::Base
 self.table_name='T_TRIAL'
 self.primary_key='TRIAL_ID'
 attr_protected
 belongs_to :task_run, :foreign_key => 'TASK_RUN_ID'
end
