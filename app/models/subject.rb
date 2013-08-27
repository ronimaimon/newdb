class Subject < ActiveRecord::Base
 self.table_name='t_subjects'
 self.primary_key='SUBJECT_ID'
 
 attr_protected
 has_many :task_runs, :foreign_key => 'SUBJECT_ID', :primary_key => 'SUBJECT_ID'
 belongs_to :age_group , :foreign_key => 'AGE_GROUP_ID'
end
