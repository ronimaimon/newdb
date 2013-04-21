require 'enums'
require 'parser'
class PosnerParser < Parser
	def initialize
	end

	def parseTrial(trialLine,taskRun)
		trial = Trial.new
		values = trialLine.split(",")
		# => 0		1		2	3		4		5				6		7				8	  9		10		11
		#BlockID, StepID, Date, ID, StationID, Stimulus, StimulusLoc, PreCueLoc, Validity, Input, Accuracy, RT 
		trial.BLOCK_NO = (values[0]=="1" ? 0: (values[0].to_i) -1)
		trial.STIMULUS_ID = (values[5]=="1" ? StimulusIds::CIRCLE : StimulusIds::TRIANGLE)
		trial.STIMULUS_LOCATION = (values[6]=="1" ? Locations::LEFT : Locations::RIGHT)
		trial.PRECUE_LOCATION = (values[7]=="1" ? Locations::LEFT : Locations::RIGHT)
		trial.VALIDITY = (values[8]=="1")
		trial.ACCURACY = (values[10]=="1")
		trial.RT = values[11].to_i
    	trial.INPUT = values[9]
    	if(taskRun.TASK_RUN_DATE ==nil)
    		taskRun.TASK_RUN_DATE =Time.parse values[2]
    		
    	end
		return trial	
	end
end