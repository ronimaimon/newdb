class AgeGroup < ActiveRecord::Base
  self.table_name='t_age_groups'
  self.primary_key='AGE_GROUP_ID'
  
  attr_accessible :age_group_id, :name
end
