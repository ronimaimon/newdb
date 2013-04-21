require 'enums'
require 'parser'
class SearchParser < Parser
	def initialize
	end

	def parseTrial(trialLine,taskRun)
		trial = Trial.new
		values = trialLine.split(",")
		# => 0		1		2	3		4		5		6		7		 8		 9
		#BlockID, StepID, Date, ID,	StationID, Target, Stimuli, Input, Accuracy, RT
		trial.BLOCK_NO = (values[0]=="1" ? 0: (values[0].to_i) -1)
		trial.IS_TARGET = (values[5]=="1")
		trial.NUM_OF_DISTRACTORS = values[6].to_i
		
		trial.INPUT = values[7]
		trial.ACCURACY = (values[8]=="1")
		trial.RT = values[9].to_i
    	
    	if(taskRun.TASK_RUN_DATE ==nil)
    		taskRun.TASK_RUN_DATE =Time.parse values[2]
    		
    	end
		return trial	
	end

end