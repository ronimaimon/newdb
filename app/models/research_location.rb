class ResearchLocation < ActiveRecord::Base
  self.table_name='t_research_location'
  self.primary_key='RESEARCH_LOCATION_ID'
  
  attr_accessible :research_location_id, :location_name
end
