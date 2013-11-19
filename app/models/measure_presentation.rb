class MeasurePresentation < ActiveRecord::Base
 self.table_name='v_measure_presentation'
 self.primary_key='PRESENTATION_ID'
 
 attr_protected
 has_one :measure, :foreign_key => 'MEASURE_ID'
end