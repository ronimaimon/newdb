require 'sql_measure'

module MeasureConfig
  file = File.read("config/measures_config.json")
  @formulaArray = []
  jsonArray = JSON.parse(file, {:symbolize_names => true})

  jsonArray.each do |f|
    f[:formulas].each do |one_formula|
      f[:tasks].each do |task|
        f_object = MeasureFormula.from_json one_formula
        f_object.task_name = task
		@formulaArray.push(f_object)
	  end	
	end
  end
  
  def self.formulaArray
	@formulaArray
  end
  
end