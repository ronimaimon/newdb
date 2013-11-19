class ResearchComputer < ActiveRecord::Base
  self.table_name='t_research_computer'
  self.primary_key='RESEARCH_COMPUTER_ID'
  
  attr_accessible :research_computer_id, :computer_desc
end
