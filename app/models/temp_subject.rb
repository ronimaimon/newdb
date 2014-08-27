class TempSubject < ActiveRecord::Base
 self.table_name='temp_subjects'
 self.primary_key='SUBJECT_ID'
 
 attr_protected
 has_many :temp_task_runs, :foreign_key => 'SUBJECT_ID', :primary_key => 'SUBJECT_ID'
 belongs_to :age_group , :foreign_key => 'AGE_GROUP_ID'
 #has_and_belongs_to_many :tags , :join_table => 't_subjects_tags'
 
 #has_many :taggings
 #has_many :tags, through: :taggings
 #
 #def self.tagged_with(name)
 #   Tag.find_by_NAME!(name).articles
 # end
 #
 # def self.tag_counts
 #   Tag.select("tags.*, count(taggings.TAG_ID) as count").
 #     joins(:taggings).group("taggings.TAG_ID")
 # end
 #
 # def tag_list
 #   tags.map(&:NAME).join(", ")
 # end
 #
 #def tag_list=(names)
 #  unless names.nil?
 #    self.tags = names.split(",").map do |n|
 #      Tag.where(NAME: n.strip).first_or_create!
 #    end
 #  end
 #end
end
