require 'sql_measure'
require 'combined_measure'
module MeasuresCalculator
  include CombinedMeasure

  def self.calculateAllMeasuresForReaserch(research_id, subject_ids=nil)
    measures = MeasureConfig.measureArray
        sql_m = SQLMeasure.new(research_id, subject_ids)
          measures.each do |measure|
          sql_m.add_formula!(measure)
        end
        
        # fh = File.open("query.log", "w")
         # TODO: Find a better way to hold the presentation Array and pass to class
        # fh.write(sql_m.get_sql(MeasureConfig.presentationArray))
        # fh.close()
#  
        # TODO: Find a better way to hold the presentation Array and pass to class       
        result = ActiveRecord::Base.connection.exec_query(sql_m.get_sql(MeasureConfig.presentationArray))
        
        result
  
   end
end
