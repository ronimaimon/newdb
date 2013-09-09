class Measure < ActiveRecord::Base
 self.table_name='t_measures'
 self.primary_key='MEASURE_ID'
 
 attr_protected
 belongs_to :task , :foreign_key => 'TASK_ID'
end