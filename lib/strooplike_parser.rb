require 'enums'
require 'parser'
class StroopLikeParser < Parser
	def initialize
	end

	def parseTrial(trialLine,taskRun)
		trial = Trial.new
		values = trialLine.split(",")
		# => 0		1		     2	  3		 4	       5			  6		            7				   8   	     9		   10	  	11
		#BlockID, StepID, Date, ID,	StationID, Task, StimulusLoc, StimulusDir, Congruency, Input, Accuracy, RT
		trial.BLOCK_NO = getBlockNo(values[0].to_i)
		trial.STIMULUS_ID = (values[7]=="1" ? StimulusIds::UP_ARROW : StimulusIds::DOWN_ARROW)
		trial.STIMULUS_LOCATION = (values[6] =="1" ? Locations::UP : Locations::DOWN)
		trial.TRIAL_INSTRUCTIONS = values[5].to_i
		trial.CONGRUENCY = (values[8] == "1")
		trial.INPUT = values[9]
		trial.ACCURACY = (values[10]=="1")
		trial.RT = values[11].to_i
    	if(taskRun.TASK_RUN_DATE ==nil)
    		taskRun.TASK_RUN_DATE =Time.parse values[2]
    		
    	end
		return trial	
	end


	def getBlockNo(block)
		case block
		when 1,4
			return 0
		when 2,3
			return block +1
		when 5,6
			return block -4
		end
	end

end