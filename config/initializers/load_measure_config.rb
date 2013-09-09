require 'sql_measure'

module MeasureConfig
  
  @measureArray = []
  Measure.find_each do |measure|
    @measureArray << MeasureFormula.new(measure)
  end
  Task.find_each do |task|
        @measureArray << SQLDateField.new(task.TASK_NAME)
  end
  
  def self.measureArray
	@measureArray 
  end
  
end