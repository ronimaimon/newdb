require 'ans_parse/enums'
require 'ans_parse/parser'
class AcptParser < Parser

	ACPT_STIMULUS_OFFSET = (StimulusIds::NA) -1

	def initialize
		
	end

	def parseTrial(trial_line,task_run)
		trial = Trial.new
		values = trial_line.split(",")
		# => 0		  1		    2	   3		  4		         5				   6		     7				   8	     9
		#BlockID, StepID, Date, ID,	StationID, TargetStatus, TargetID, TargetSound, Accuracy, RT
		trial.BLOCK_NO = (values[0]=="1" ? 0:1)
		trial.IS_TARGET = (values[5]=="1" ? true : false)
		trial.STIMULUS_ID = values[6].to_i + ACPT_STIMULUS_OFFSET
		trial.ACCURACY = (values[8]=="1")
		trial.RT = values[9].to_i
    	trial.INPUT = ((trial.ACCURACY == trial.IS_TARGET) ? "SpaceBar": nil)
    	if(task_run.TASK_RUN_DATE ==nil)
    		task_run.TASK_RUN_DATE = Time.parse values[2]
    	end
		return trial	
	end
end