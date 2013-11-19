class Research < ActiveRecord::Base
	self.table_name='t_researches'
 	self.primary_key='RESEARCH_ID'
 	attr_protected
 	has_many :task_runs, :foreign_key => 'RESEARCH_ID', :primary_key => 'RESEARCH_ID', :dependent => :destroy
  belongs_to :research_location, :foreign_key => 'RESEARCH_LOCATION_ID'
  belongs_to :research_computer, :foreign_key => 'RESEARCH_COMPUTER_ID'
end
