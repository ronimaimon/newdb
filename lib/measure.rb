	
class Measure
	MAX_RT_LIMIT = "4000"
	MIN_RT_LIMIT = "100"
	NO_PRACTICE_STEPS_COND = "block_no <> 0"
	MAX_RT_CONDITION = "rt < "+ MAX_RT_LIMIT
	MIN_MAX_RT_CONDITION = "rt BETWEEN " + MIN_RT_LIMIT	+ " AND " + MAX_RT_LIMIT
	attr_accessor :name , :noMinCond
	@name = nil
	@noMinCond = false

        
	def getConstantCondition
    	constantCondition = NO_PRACTICE_STEPS_COND + " AND "
        if(noMinCond) 
        	constantConditiocn << MAX_RT_CONDITION
        else
        	constantCondition << MIN_MAX_RT_CONDITION
        end
        return constantCondition
    end
	
	
end