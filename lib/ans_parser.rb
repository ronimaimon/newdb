require 'enums'
require 'cpt_parser'
require 'acpt_parser'
require 'posner_parser'
require 'posnertc_parser'
require 'search_parser'
require 'simplert_parser'
require 'strooplike_parser'
class AnsParser
	
	def initialize
	end
	
	def parse(fileContent, filename)
		parser = nil
		taskRun = TaskRun.new
		taskRun.SUBJECT_IDENTIFIER = filename.split("_")[0]
		case filename
			when /.*_CPTi.ans/
				parser = CptParser.new
				taskRun.TASK_ID = TaskType::CPTI
			when /.*_ACPT.ans/
				parser = AcptParser.new
				taskRun.TASK_ID = TaskType::ACPT
			when /.*_CPT.ans/
				parser = CptParser.new
				taskRun.TASK_ID = TaskType::CPT
			when /.*_PosnerTemporalCue.ans/
				parser = PosnerTCParser.new
				taskRun.TASK_ID = TaskType::POSNERTEMPORALCUE
			when /.*_Posner.ans/
					parser = PosnerParser.new
					taskRun.TASK_ID = TaskType::POSNER
			when /.*_StroopLike.ans/
				parser = StroopLikeParser.new
				taskRun.TASK_ID = TaskType::STROOPLIKE
			when /.*_Search.ans*/
				parser = SearchParser.new
				taskRun.TASK_ID = TaskType::SEARCH
			when /.*_ReactionTime.ans/
				parser = SimpleRTParser.new
				taskRun.TASK_ID = TaskType::SIMPLERT
			else
				return nil
		end
		#non training trial count for validation
		trial_count = 0
		fileContent.each_line do |line|
			if(line.match(/^[0-9].*/) != nil)
			  trial = parser.parseTrial(line,taskRun)
			  if trial.BLOCK_NO != 0
			    trial_count += 1
			  end
				taskRun.trials.append(trial)
			end
		end
		if(taskRun.trials.size ==0)
		  raise "Task run is empty"
		end
		taskRunIncompleteCheck(taskRun,trial_count)  
		
		return taskRun
		
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
  	  when "Simple RT"
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