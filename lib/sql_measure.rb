require 'json'

module RangeConditions
  MIN_RT_LIMIT = 100
  MAX_RT_LIMIT = 4000

  NO_MIN_LIMIT_CONDITION = "rt < #{MAX_RT_LIMIT}"
  RANGE_LIMIT_CONDITION = "rt BETWEEN #{MIN_RT_LIMIT} AND #{MAX_RT_LIMIT}"
end

class SQLFormula
  @attributes = {}
    
  def get_formula    
  end
  
  def get_outliars_formula    
    return ""
  end

  def to_json(*a)
    {
      'json_class'   => self.class.name,
      'data'         => @attributes
    }.to_json(*a)
  end
  
  def self.json_create(o)
    new(*o['data'])
  end
  
  def self.from_json(data)
    return Object::const_get(data[:class]).new data[:attributes]
  end
  
  def task_name=(task_name)
    @attributes[:task_name] = task_name
  end
  
  def get_formula_full_name
        
  end
end

class SQLDateField < SQLFormula
  def initialize(opt = {})
    @attributes = {
      :task_name => "ACPT"
    }
    
    @attributes = @attributes.merge opt
   
  end

  def get_formula_full_name
        return @attributes[:task_name].tr(" ", "") + "_Date"
  end
  
  def get_formula
    query = ""
    
    query << "MAX(CASE WHEN task_name = '#{@attributes[:task_name]}' THEN task_run_date END)"
    query << " AS " << get_formula_full_name 
    
    return query    
  end
end

class MeasureFormula < SQLFormula
  NO_PRACTICE_CONDITION = "block_no <> 0"
  
  def initialize(opt = {})
    @attributes = {
      :task_name => "ACPT",
      :function => "AVG",
      :field => "rt",
      :formula_name => "avg_rt_clean",
      :condition => "accuracy = TRUE AND (validity = FALSE OR validity IS NULL)",
      :stdev_range => 2,
      :has_min_cond => true,
      :is_extreme_measure => false
    }

    @attributes = @attributes.merge opt
  end

  def get_formula_full_name
        @attributes[:task_name].tr(" ", "") + "_" + @attributes[:formula_name]
  end

  def get_constant_condition
    cnd = ""
    
    cnd << NO_PRACTICE_CONDITION
    if (@attributes[:has_min_cond])
      cnd << " AND " << RangeConditions::RANGE_LIMIT_CONDITION
    else
      cnd << " AND " << RangeConditions::NO_MIN_LIMIT_CONDITION
    end
    cnd
  end

  def get_formula
    f = ""

    f << @attributes[:function].to_s
    f << "(CASE WHEN task_name = '#{@attributes[:task_name]}'"
    f << " AND " << get_constant_condition
    f << " AND #{@attributes[:condition]}" if not @attributes[:condition].nil?
    
    if(@attributes[:is_extreme_measure])
      f << " AND rt NOT BETWEEN lb_#{get_formula_full_name} AND ub_#{get_formula_full_name}"
    else 
      if (not @attributes[:stdev_range].nil?)
        f << " AND rt BETWEEN lb_#{get_formula_full_name} AND ub_#{get_formula_full_name}"
      end
    end
    
    f << " THEN "
    f << @attributes[:field]
    f << " END)"
    f << " AS #{get_formula_full_name}"
     
    return f
  end

  def get_outliars_formula
    f = ""

    if (@attributes[:stdev_range].nil?)
      return ""
    else
      f << get_outliars_formula_type(true) << ", \n"
      f << get_outliars_formula_type(false)
    end
    
    return f
  end
  
  def get_outliars_formula_type(lower=true)
    f = ""

    f << "AVG(CASE WHEN task_name = '#{@attributes[:task_name]}'"
    f << " AND " << get_constant_condition
    f << " AND #{@attributes[:condition]}" if not @attributes[:condition].nil?
    f << " THEN rt END)"

    f << (lower ? "-" : "+")
    f << "(#{@attributes[:stdev_range]}*"

    f << "STD(CASE WHEN task_name = '#{@attributes[:task_name]}'"
    f << " AND " << get_constant_condition
    f << " AND #{@attributes[:condition]}" if not @attributes[:condition].nil?
    f << " THEN rt END)) "

    f << " AS " << (lower ? "lb_" : "ub_") << get_formula_full_name << "\n"
     
    return f
  end
end

class SQLMeasure
  #Name
  #Source
  #

  MAX_RT_LIMIT = "4000"
  MIN_RT_LIMIT = "100"

  def initialize(research_id, subject_ids=nil)
    @formulas = []
    @subject_ids = subject_ids
    @research_id = research_id
  end
  
  def add_formula!(f)
    @formulas.push(f)
  end

  def get_measure_calculations
    formulas = "sub.subject_identifier as AA_subject_identifier"    
    @formulas.each do |f|
      formulas << ", \n"
      formulas << "       " << f.get_formula
    end


    return formulas
  end

  def get_sources(prefix="")
    sources = ""
    
    sources << "t_task_run t\n"
    sources << prefix << " INNER JOIN t_tasks s ON (s.task_id = t.task_id)\n"
    sources << prefix << " INNER JOIN t_trial l ON (l.task_run_id = t.task_run_id)\n"
    sources << prefix << " INNER JOIN t_subjects sub ON (sub.subject_id = t.subject_id)\n"
    sources << prefix << "  LEFT JOIN (SELECT location_id, location_description AS stimulus_location_desc FROM t_locations) sloc ON (l.stimulus_location = sloc.location_id) \n"
    sources << prefix << "  LEFT JOIN (SELECT location_id, location_description AS precue_location_desc FROM t_locations) ploc ON (l.precue_location = ploc.location_id) \n"
    sources << prefix << "  LEFT JOIN t_stimuli st ON (l.stimulus_id = st.stimulus_id)\n"
    sources << prefix << "  LEFT JOIN t_trial_instructions ti ON (l.trial_instructions = ti.trial_instruction_id)\n"
    sources << prefix << " INNER JOIN (SELECT subject_id, task_id, MAX(task_run_id) AS last_task FROM t_task_run WHERE research_id IN (#{@research_id}) GROUP BY subject_id, task_id) n ON (n.subject_id = t.subject_id AND n.task_id = t.task_id AND n.last_task = t.task_run_id)"
    
    return sources
  end

  def population_conditions
    pop_condition = "t.research_id IN (#{@research_id})"
    
    if (!@subject_ids.nil?)
      pop_condition << " AND t.subject_id IN (#{@subject_ids.to_s.tr("[","").tr("]","")})"
    end
    
    return pop_condition
  end

  def get_grouping_fields
    "t.subject_id"
  end

  def get_outliars_query
    ""
  end

  def get_outliars_query_join_condition
    "o.subject_id = t.subject_id"
  end


  def get_outliar_computations
    formulas = "t.subject_id"    
    @formulas.each do |f|
      if (f.get_outliars_formula != "")
        formulas << ", \n"
        formulas << "       " << f.get_outliars_formula
      end
    end

    return formulas
  end

  def get_outliars_query
    query = ""
    
    query << "SELECT "                    << self.get_outliar_computations << "\n"
    query << "               FROM "       << self.get_sources("             ") << "\n"
    query << "              WHERE "       << self.population_conditions << "\n"
    query << "              GROUP BY "    << self.get_grouping_fields << ""

    return query
  end


  def get_sql
    query = ""
    
    query << "SELECT "       << self.get_measure_calculations << "\n"
    query << "  FROM "       << self.get_sources << "\n"
    query << " INNER JOIN (" << self.get_outliars_query << ") o ON (" << self.get_outliars_query_join_condition << ")\n"
    query << " WHERE "       << self.population_conditions << "\n"
    query << " GROUP BY "    << self.get_grouping_fields << "\n"

    return query
  end
end