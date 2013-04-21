class Research < ActiveRecord::Base
	self.table_name='t_researches'
 	self.primary_key='RESEARCH_ID'
 	attr_protected
 	has_many :task_runs, :foreign_key => 'RESEARCH_ID', :primary_key => 'RESEARCH_ID'

end
