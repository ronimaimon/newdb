require 'measures/sql_measure'
module MeasuresCalculator

  def self.calculateAllMeasuresForReaserch(research_id, subject_ids=nil)
    measures = MeasureConfig.measureArray
    sql_m = SQLMeasure.new(research_id, subject_ids)
    measures.each do |measure|
      sql_m.add_formula!(measure)
    end
        
    result = nil
    sql_m.get_sql(MeasureConfig.presentationArray).each do |query|
    # fh.write(query << "\n\n")
        result = ActiveRecord::Base.connection.execute(query)
    #  fh.write(query << "finished")
    end

    #   fh.close()
    result = ActiveRecord::Result.new(result.fields, result.to_a)

    result
  
   end
end
