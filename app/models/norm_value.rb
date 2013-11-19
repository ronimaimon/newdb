class  NormValue < ActiveRecord::Base
  self.table_name='v_norm_values'
  self.primary_key='NORM_VALUE_ID'
  
  belongs_to :norm_group, :foreign_key => 'NORM_GROUP_ID'
  attr_protected
  
end