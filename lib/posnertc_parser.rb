require 'enums'
require 'parser'
class PosnerTCParser < Parser
	def initialize
	end

	def parseTrial(trialLine,taskRun)
		trial = Trial.new
		values = trialLine.split(",")
		# => 0		1		2	3		4		5				6		7				8	  9		10		11
		#BlockID, StepID, Date, ID, StationID, Stimulus, StimulusLoc, PreCueLoc, Validity, Input, Accuracy, RT 
		trial.BLOCK_NO = getBlockNo(values[0].to_i)
		trial.STIMULUS_ID = (values[5]=="1" ? StimulusIds::CIRCLE : StimulusIds::TRIANGLE)
		trial.STIMULUS_LOCATION = getLocationID(values[6].to_i)
		trial.PRECUE_LOCATION = getLocationID(values[7].to_i)
		trial.VALIDITY = getValidity(values[8].to_i)
		trial.INPUT = values[9]
		trial.ACCURACY = (values[10]=="1")
		trial.RT = values[11].to_i
		#trial.SUB_TASK_TYPE = getSubTaskType(values[0].to_i)
    	if(taskRun.TASK_RUN_DATE ==nil)
    		taskRun.TASK_RUN_DATE =Time.parse values[2]
    		
    	end
		return trial	
	end

	def getLocationID(loc)
		case loc
		when 1
			return Locations::LEFT
		when 2
			return Locations::RIGHT
		when 3
			return Locations::LEFT_AND_RIGHT
		end
		return nil
	end

	def getValidity(val)
		case val
		when 1
			return true
		when 2
			return false
		when 3
			return nil
		end
		return nil
	end


	def getBlockNo(block)
		case block
		when 1,3
			return 0
		when 2
			return 1
		when 4,5
			return block -2
		end
	end

	def getSubTaskType(block)
		case block
		when 1..2
			return SubTaskType::NEUTRAL
		when 3..5
			return SubTaskType::VALID_INVALID
		end
	end
end