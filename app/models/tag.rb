class Tag < ActiveRecord::Base
  self.table_name='t_tags'
  self.primary_key='TAG_ID'
  
  attr_accessible :tag_id, :name
  
  has_many :taggings
  has_many :subjects, through: :taggings
end
