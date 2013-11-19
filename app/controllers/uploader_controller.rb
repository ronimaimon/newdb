require 'ans_parser'
require 'utils'
include Utils
class UploaderController < ApplicationController
  
    
	def initialize
	  super
		@parser = AnsParser.new
		@research = nil
	end
  
  def index
    
  end

  def loading  
    
    researchId = Utils.getRIdFromParams(params)
    if not researchId.nil? and Research.exists?(researchId)
      @research = Research.find_by_RESEARCH_ID(researchId) 
    elsif params["r"][:name] == ""
      redirectError("Make sure you selected an existing research")
      return
    end  
    
  	
  	if  @research.nil?
    	@research = Research.new
  		@research.RESEARCH_NAME = params["r"][:name]
  		@research.RESEARCH_OWNER = params["r"][:owner]
  		@research.RESEARCH_DESCRIPTION = params["r"][:desc]
  		@research.RESEARCH_LOCATION_ID = params["r"][:loc]
  		@research.RESEARCH_COMPUTER_ID = params["r"][:comp]
  		@research.RESEARCH_COMPUTER_SIZE = params["r"][:comp_size]
  		@research.save
  		
  	end
    @subject_ids_map =Hash.new
  	@taskRunCount = 0
  	@bad_files = ""
  	@subjectsIdList=[]
  	if(params[:item].nil? or params[:item][:attached_assets_attributes].nil?)
  		redirectError("Please select files to upload")
  		return
  	else
  		params[:item][:attached_assets_attributes].each do |f|
  		 begin
  		    task_run = @parser.parse(f[:asset].read,	f[:asset].original_filename)
            task_run.RESEARCH_ID = @research.RESEARCH_ID 
            task_run.SUBJECT_ID = getSubjectID(task_run.SUBJECT_IDENTIFIER)
            task_run.save
            @subjectsIdList << task_run.SUBJECT_ID
            @taskRunCount+=1
     rescue ActiveRecord::RecordNotUnique => er
         @bad_files << f[:asset].original_filename + ": Duplicate file\n"
  		 rescue Exception => e  
  		   @bad_files << f[:asset].original_filename + ": " + e.message + "\n"
  		  end
  		end
  	end
  end
  
 private
 def getSubjectID(subjectIdentifier)
   subject_id = @subject_ids_map[subjectIdentifier]
   if((subject_id.nil?))
    subject = Subject.find(:last,:conditions => ["SUBJECT_IDENTIFIER = ?",subjectIdentifier])
    if(subject.nil?)
      if(subjectIdentifier.nil?)
        raise "subjectidentifier is null"
      end
      subject = Subject.new
      subject.SUBJECT_IDENTIFIER = subjectIdentifier
      subject.save
	  
    end
    subject_id = subject.SUBJECT_ID
    @subject_ids_map[subjectIdentifier] = subject.SUBJECT_ID
   end
   return subject_id
 end
 
 def redirectError(msg)
	flash.now[:alert] = "Invalid form submission: #{msg}"
	render :index and return
 end
 
end
