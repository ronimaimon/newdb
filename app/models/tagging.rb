class Tagging < ActiveRecord::Base
  self.table_name = 't_subjects_tags'
  
  belongs_to :tag, :foreign_key => 'TAG_ID'
  belongs_to :subject, :foreign_key => 'SUBJECT_ID'
   attr_accessible :SUBJECT_ID, :TAG_ID
  
  
end
