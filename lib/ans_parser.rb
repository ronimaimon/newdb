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
		taskRun.SUBJECT_ID = filename.split("_")[0]
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
		fileContent.each_line do |line|
			if(line.match(/^[0-9].*/) != nil)
				taskRun.trials.append(parser.parseTrial(line,taskRun))
			end
		end
		if(taskRun.trials.size ==0)
		  return nil
		end
		return taskRun
		
	end
end