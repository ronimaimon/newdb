class Subject < ActiveRecord::Base
 self.table_name='T_SUBJECTS'
 self.primary_key='SUBJECT_ID'
 
 attr_protected
 has_many :task_runs, :foreign_key => 'SUBJECT_ID', :primary_key => 'SUBJECT_ID'
end
