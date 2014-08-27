require 'ans_parse/enums'
require 'ans_parse/cpt_parser'
require 'ans_parse/acpt_parser'
require 'ans_parse/posner_parser'
require 'ans_parse/posnertc_parser'
require 'ans_parse/search_parser'
require 'ans_parse/simplert_parser'
require 'ans_parse/strooplike_parser'
class AnsParser
	
	def initialize
	end
	
	def parse(file_content, filename,is_temp=false)
		parser = nil
    if(is_temp)
      task_run = TempTaskRun.new
     else
      task_run = TaskRun.new
    end
		task_run.SUBJECT_IDENTIFIER = filename.split("_")[0]
		case filename
			when /.*_CPTi.ans/
				parser = CptParser.new
				task_run.TASK_ID = TaskType::CPTI
			when /.*_ACPT.ans/
				parser = AcptParser.new
				task_run.TASK_ID = TaskType::ACPT
			when /.*_CPT.ans/
				parser = CptParser.new
				task_run.TASK_ID = TaskType::CPT
			when /.*_PosnerTemporalCue.ans/
				parser = PosnerTCParser.new
				task_run.TASK_ID = TaskType::POSNERTEMPORALCUE
			when /.*_Posner.ans/
					parser = PosnerParser.new
					task_run.TASK_ID = TaskType::POSNER
			when /.*_StroopLike.ans/
				parser = StroopLikeParser.new
				task_run.TASK_ID = TaskType::STROOPLIKE
			when /.*_Search.ans*/
				parser = SearchParser.new
				task_run.TASK_ID = TaskType::SEARCH
			when /.*_ReactionTime.ans/
				parser = SimpleRTParser.new
				task_run.TASK_ID = TaskType::SIMPLERT
			else
				return nil
		end
		#non training trial count for validation
		trial_count = 0
		file_content.each_line do |line|
			if(line.match(/^[0-9].*/) != nil)
        if(is_temp)
          trial = TempTrial.new
        else
          trial = Trial.new
        end
        trial = parser.parseTrial(trial,line,task_run)
        if trial.BLOCK_NO != 0
			    trial_count += 1
        end
				task_run.trials.append(trial)
			end
		end
		if(task_run.trials.size ==0)
		  raise "Task run is empty"
		end
		taskRunIncompleteCheck(task_run,trial_count)  
		
		return task_run
		
	end
	
	private
	
	 # Checks whether the task was completed to the full.
	 # raises an exeption if the number of non training trials don't match the expected amount
	def taskRunIncompleteCheck(task_run,trial_count)
	  expected = 0
	  case task_run.task.TASK_NAME
  	  when "Search","StroopLike"
  	    expected = 160
  	  when "CPT","CPTi","ACPT"
  	    expected = 320
  	  when "SimpleRT"
  	    expected = 66
  	  when "Posner"
  	    expected = 180
  	  when "PosnerTemporalCue"
        expected = 168  
  	  else
	  end
	  if (expected != trial_count)
	    raise "The number of trials is: " + trial_count.to_s + " expected: " + expected.to_s
 	  end
	end
	
end