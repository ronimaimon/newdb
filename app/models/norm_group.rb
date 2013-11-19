class NormGroup < ActiveRecord::Base
  self.table_name='t_norm_groups'
  self.primary_key='NORM_GROUP_ID'
  
  has_many :norm_values, :foreign_key => 'NORM_GROUP_ID', :primary_key => 'NORM_GROUP_ID'
  attr_accessible :norm_group_id, :norm_name
  
end
