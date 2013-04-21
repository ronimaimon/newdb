require 'parser'
require 'enums'
class CptParser < Parser
	
	def initialize
	end

	def parseTrial(trialLine,taskRun)
		trial = Trial.new
		values = trialLine.split(",")
		#BlockID, StepID, Date, ID,StationID, TargetStatus, TargetID, TargetColor, Accuracy, RT
		trial.BLOCK_NO = (values[0]=="1" ? 0:1)
		trial.IS_TARGET = (values[5]=="1" ? true : false)
		trial.STIMULUS_ID = getStimulusId(values[6],values[7])
		trial.ACCURACY = (values[8]=="1")
		trial.RT = values[9].to_i
    	trial.INPUT = (trial.ACCURACY == trial.IS_TARGET ? "SpaceBar": nil)
    	if(taskRun.TASK_RUN_DATE ==nil)
    		taskRun.TASK_RUN_DATE =Time.parse values[2]
    	end
		return trial	
	end


	

	private
	def getStimulusId(shapeId,colorId)
		case (shapeId << "," << colorId)
			when "1,1"
				return StimulusIds::RED_SQUARE
			when "1,2"
				return StimulusIds::BLUE_SQUARE
			when "1,3"
				return StimulusIds::GREEN_SQUARE
			when "1,4"
				return StimulusIds::YELLOW_SQUARE
			when "2,1"
				return StimulusIds::RED_CIRCLE
			when "2,2"
				return StimulusIds::BLUE_CIRCLE
			when "2,3"
				return StimulusIds::GREEN_CIRCLE
			when "2,4"
				return StimulusIds::YELLOW_CIRCLE
			when "3,1"
				return StimulusIds::RED_TRIANGLE
			when "3,2"
				return StimulusIds::BLUE_TRIANGLE
			when "3,3"
				return StimulusIds::GREEN_TRIANGLE
			when "3,4"
				return StimulusIds::YELLOW_TRIANGLE
			when "4,1"
				return StimulusIds::RED_STAR
			when "4,2"
				return StimulusIds::BLUE_STAR
			when "4,3"
				return StimulusIds::GREEN_STAR
			when "4,4"
				return StimulusIds::YELLOW_STAR
		end
	end
end