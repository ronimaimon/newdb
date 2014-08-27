require 'ans_parse/enums'
require 'ans_parse/parser'
class SimpleRTParser < Parser
	def initialize
	end

	def parseTrial(trial, trial_line,task_run)
		values = trial_line.split(",")
		# => 0		1		2	3		4		5				6		7	 
		#BlockID, StepID, Date, ID,	StationID, TargetStatus, Accuracy, RT
		trial.BLOCK_NO = (values[0]=="1" ? 0: (values[0].to_i) -1)
		trial.IS_TARGET = (values[5]=="1")
		
		
		trial.ACCURACY = (values[6]=="1")
		trial.RT = values[7].to_i
    	
    	if(task_run.TASK_RUN_DATE ==nil)
    		task_run.TASK_RUN_DATE =Time.parse values[2]
    		
    	end
		return trial	
	end

end