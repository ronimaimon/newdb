require 'ans_parser'

class UploaderController < ApplicationController
  
    
	def initialize
	  super
		@parser = AnsParser.new
		@research = nil
	end
  
  def index
  end

  def loading
  
  @research = nil
  if (params["r_ex_name"] and !params["r_name"].blank?)
		name_id = params["r_ex_name"].split(":")
		research_id = (params["r_ex_name"].split(":")[1])  if (name_id.size ==2)
		@research = Research.find(research_id) if Research.exists?(research_id)
		if(@research.nil?)
			redirectError("Make sure to select an existing research from the drop down list")
			return
		end
	else	
  	@research = Research.new
		@research.RESEARCH_NAME = params["r"][:name]
		@research.RESEARCH_OWNER = params["r"][:owner]
		@research.RESEARCH_DESCRIPTION = params["r"][:desc]
		@research.save
	end
  	@subject_ids_map =Hash.new
	@taskRunCount = 0
	@bad_files = []
	if(params[:item].nil? or params[:item][:attached_assets_attributes].nil?)
		redirectError("Please select files to upload")
		return
	else
		params[:item][:attached_assets_attributes].each do |f|
		 taskRun = @parser.parse(f[:asset].read,	f[:asset].original_filename)
		  if(!taskRun.nil?)
			taskRun.RESEARCH_ID = @research.RESEARCH_ID	
			taskRun.SUBJECT_ID = getSubjectID(taskRun.SUBJECT_ID)
			taskRun.save
			@taskRunCount+=1
	 	  else
			@bad_files << f[:asset].original_filename
		  end
		end
	end
  end
  
 private
 def getSubjectID(subjectIdentifier)
   subjectID = @subject_ids_map[subjectIdentifier]
   if((subjectID.nil?))
    subject = Subject.find(:last,:conditions => ["SUBJECT_IDENTIFIER = ?",subjectIdentifier])
    if(subject.nil?)
      if(subjectIdentifier.nil?)
        raise "subjectidentifier is null"
      end
      subject = Subject.new
      subject.SUBJECT_IDENTIFIER = subjectIdentifier
      subject.save
	  
    end
    subjectID = subject.SUBJECT_ID
    @subject_ids_map[subjectIdentifier] = subject.SUBJECT_ID
   end
   return subjectID
 end
 
 def redirectError(msg)
	flash[:alert] = "Invalid form submission: #{msg}"
	redirect_to :action => 'index'
 end
 
end
