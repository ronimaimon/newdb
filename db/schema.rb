# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "t_locations", :primary_key => "LOCATION_ID", :force => true do |t|
    t.string "LOCATION_DESCRIPTION", :limit => 45, :null => false
  end

  create_table "t_measures", :primary_key => "MEASURE_ID", :force => true do |t|
    t.integer "TASK_ID",                    :null => false
    t.string  "MEASURE_NAME", :limit => 45, :null => false
  end

  add_index "t_measures", ["TASK_ID"], :name => "fk_T_MEASURES_T_TASKS1"

  create_table "t_norm_definitions", :primary_key => "NORM_ID", :force => true do |t|
    t.string "NORM_NAME", :limit => 45, :null => false
  end

  create_table "t_norm_groups", :id => false, :force => true do |t|
    t.integer "NORM_ID",       :null => false
    t.integer "MEASURE_ID",    :null => false
    t.float   "MEASURE_VALUE", :null => false
  end

  add_index "t_norm_groups", ["MEASURE_ID"], :name => "fk_T_NORM_GROUPS_T_MEASURES1"
  add_index "t_norm_groups", ["NORM_ID"], :name => "fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1"

  create_table "t_researches", :primary_key => "RESEARCH_ID", :force => true do |t|
    t.string "RESEARCH_NAME",        :limit => 45, :null => false
    t.string "RESEARCH_OWNER",       :limit => 45
    t.string "RESEARCH_DESCRIPTION", :limit => 45
  end

  create_table "t_stimuli", :primary_key => "STIMULUS_ID", :force => true do |t|
    t.string "STIMULUS_DESCRIPTION", :limit => 45, :null => false
  end

  create_table "t_sub_task_type", :primary_key => "SUB_TASK_TYPE_ID", :force => true do |t|
    t.string "SUB_TASK_TYPE_DESCRIPTION", :limit => 45, :null => false
  end

  create_table "t_subjects", :primary_key => "SUBJECT_ID", :force => true do |t|
    t.string "SUBJECT_IDENTIFIER", :limit => 45, :null => false
    t.string "SUBJECT_NAME",       :limit => 45
  end

  create_table "t_task_run", :primary_key => "TASK_RUN_ID", :force => true do |t|
    t.integer "RESEARCH_ID"
    t.integer "TASK_ID",                                     :null => false
    t.integer "SUBJECT_ID",                                  :null => false
    t.string  "EXPERIMENTER_ID",               :limit => 60
    t.date    "TASK_RUN_DATE",                               :null => false
    t.boolean "IS_CONTROL_GROUP"
    t.string  "TARGET_POPULATION_DESCRIPTION", :limit => 60
  end

  add_index "t_task_run", ["RESEARCH_ID"], :name => "fk_T_TASK_RUN_T_RESEARCHES1"
  add_index "t_task_run", ["SUBJECT_ID"], :name => "fk_T_TASK_RUN_T_SUBJECTS1"
  add_index "t_task_run", ["TASK_ID"], :name => "fk_T_TASK_RUN_T_TASKS1"

  create_table "t_tasks", :primary_key => "TASK_ID", :force => true do |t|
    t.string "TASK_NAME", :limit => 45, :null => false
  end

  create_table "t_trial", :primary_key => "TRIAL_ID", :force => true do |t|
    t.integer "TASK_RUN_ID",                      :null => false
    t.string  "RT",                 :limit => 45
    t.boolean "ACCURACY"
    t.integer "STIMULUS_ID"
    t.string  "INPUT",              :limit => 20
    t.boolean "VALIDITY"
    t.boolean "CONGRUENCY"
    t.integer "DELAY_BEFORE_STEP"
    t.integer "NUM_OF_DISTRACTORS"
    t.boolean "IS_TARGET"
    t.integer "PRECUE_LOCATION"
    t.integer "STIMULUS_LOCATION"
    t.integer "BLOCK_NO"
    t.integer "SUB_TASK_TYPE"
    t.integer "TRIAL_INSTRUCTIONS"
  end

  add_index "t_trial", ["PRECUE_LOCATION"], :name => "fk_T_TRIAL_T_LOCATIONS1"
  add_index "t_trial", ["STIMULUS_ID"], :name => "fk_T_TRIAL_T_STIMULI"
  add_index "t_trial", ["STIMULUS_LOCATION"], :name => "fk_T_TRIAL_T_LOCATIONS2"
  add_index "t_trial", ["SUB_TASK_TYPE"], :name => "fk_T_TRIAL_T_SUB_TASK_TYPE1"
  add_index "t_trial", ["TASK_RUN_ID"], :name => "fk_T_TRIAL_T_TASK_RUN1"
  add_index "t_trial", ["TRIAL_INSTRUCTIONS"], :name => "fk_T_TRIAL_T_TRIAL_INSTRUCTIONS1"

  create_table "t_trial_instructions", :primary_key => "TRIAL_INSTRUCTION_ID", :force => true do |t|
    t.string "TRIAL_INSTRUCTION_DESCRIPTION", :limit => 45, :null => false
  end

  create_table "v_acpt_data", :id => false, :force => true do |t|
    t.integer "trial_id",                           :default => 0, :null => false
    t.integer "task_run_id",                                       :null => false
    t.integer "block_no"
    t.string  "rt",                   :limit => 45
    t.boolean "accuracy"
    t.string  "input",                :limit => 20
    t.boolean "is_target"
    t.integer "delay_before_step"
    t.string  "stimulus_description", :limit => 45,                :null => false
  end

  create_table "v_acpt_measures", :id => false, :force => true do |t|
    t.integer "task_run_id",                                  :null => false
    t.float   "avg_clean_rt"
    t.float   "avg_rt"
    t.integer "num_outliars",     :limit => 8, :default => 0, :null => false
    t.integer "num_observations", :limit => 8, :default => 0, :null => false
  end

  create_table "v_acpt_range", :id => false, :force => true do |t|
    t.integer "task_run_id", :null => false
    t.float   "lower_bound"
    t.float   "upper_bound"
  end

  create_table "v_posner_data", :id => false, :force => true do |t|
    t.integer "trial_id",                           :default => 0, :null => false
    t.integer "task_run_id",                                       :null => false
    t.integer "block_no"
    t.string  "rt",                   :limit => 45
    t.boolean "accuracy"
    t.string  "input",                :limit => 20
    t.boolean "validity"
    t.string  "stimulus_description", :limit => 45,                :null => false
    t.string  "stimulus_location",    :limit => 45,                :null => false
    t.string  "precue_location",      :limit => 45,                :null => false
  end

  create_table "v_posner_temporal_cue_data", :id => false, :force => true do |t|
    t.integer "trial_id",                                :default => 0, :null => false
    t.integer "task_run_id",                                            :null => false
    t.integer "block_no"
    t.string  "rt",                        :limit => 45
    t.boolean "accuracy"
    t.string  "input",                     :limit => 20
    t.boolean "validity"
    t.string  "stimulus_description",      :limit => 45,                :null => false
    t.string  "sub_task_type_description", :limit => 45,                :null => false
    t.string  "stimulus_location",         :limit => 45,                :null => false
    t.string  "precue_location",           :limit => 45,                :null => false
  end

  create_table "v_strooplike_data", :id => false, :force => true do |t|
    t.integer "trial_id",                           :default => 0, :null => false
    t.integer "task_run_id",                                       :null => false
    t.integer "block_no"
    t.string  "rt",                   :limit => 45
    t.boolean "accuracy"
    t.string  "input",                :limit => 20
    t.boolean "congruency"
    t.string  "trial_instructions",   :limit => 45,                :null => false
    t.string  "stimulus_description", :limit => 45,                :null => false
    t.string  "stimulus_location",    :limit => 45,                :null => false
  end

end
