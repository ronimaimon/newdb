class Subject < ActiveRecord::Base
 self.table_name='t_subjects'
 self.primary_key='SUBJECT_ID'
 
 attr_protected
 has_many :task_runs, :foreign_key => 'SUBJECT_ID', :primary_key => 'SUBJECT_ID'
 belongs_to :age_group , :foreign_key => 'AGE_GROUP_ID'
 #has_and_belongs_to_many :tags , :join_table => 't_subjects_tags'
 
 has_many :taggings
 has_many :tags, :select => "#{Tag.table_name}.*, #{Tagging.table_name}.value AS value" , through: :taggings


  def self.tag_counts
    Tag.select("tags.*, count(taggings.TAG_ID) as count").
      joins(:taggings).group("taggings.TAG_ID")
  end
  
  def tag_list
    tags.reload.map{|n| n.value.nil? ? n.NAME: n.NAME+'='+ n.value}.join(", ")
  end

 def tag_list=(names)
   self.tags.destroy_all
   unless names.nil?
     names.split(",").map do |n|
       if n.include?('=')
         tag_name, tag_value = n.split('=')
         tag = Tag.where(NAME: tag_name.strip).first_or_create!
         self.taggings.create(TAG_ID: tag.TAG_ID, value: tag_value.strip)
       else
         tag = Tag.where(NAME: n.strip).first_or_create!
         self.taggings.create(TAG_ID: tag.TAG_ID)
       end
     end
   end
 end
end
