require 'sql_measure'

module MeasureConfig
  
  @measureArray = []
  Measure.find_each do |measure|
    @measureArray << MeasureFormula.new(measure)
  end
  
  @presentationArray = MeasurePresentation.all  
  
  def self.measureArray
  @measureArray 
  end

  def self.presentationArray
  @presentationArray 
  end
  
end