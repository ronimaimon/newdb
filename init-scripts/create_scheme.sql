SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `trialdb` DEFAULT CHARACTER SET hebrew ;
USE `trialdb` ;

-- -----------------------------------------------------
-- Table `trialdb`.`t_stimuli`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_stimuli` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_stimuli` (
  `STIMULUS_ID` INT NOT NULL AUTO_INCREMENT ,
  `STIMULUS_DESCRIPTION` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`STIMULUS_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_subjects` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_subjects` (
  `SUBJECT_ID` INT NOT NULL AUTO_INCREMENT ,
  `SUBJECT_IDENTIFIER` VARCHAR(45) NOT NULL ,
  `SUBJECT_NAME` VARCHAR(45) NULL ,
  PRIMARY KEY (`SUBJECT_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_research_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_research_location` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_research_location` (
  `RESEARCH_LOCATION_ID` INT NOT NULL AUTO_INCREMENT ,
  `LOCATION_NAME` VARCHAR(45) NULL ,
  PRIMARY KEY (`RESEARCH_LOCATION_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_research_computer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_research_computer` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_research_computer` (
  `RESEARCH_COMPUTER_ID` INT NOT NULL AUTO_INCREMENT ,
  `COMPUTER_DESC` VARCHAR(45) NULL ,
  PRIMARY KEY (`RESEARCH_COMPUTER_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_researches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_researches` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_researches` (
  `RESEARCH_ID` INT NOT NULL AUTO_INCREMENT ,
  `RESEARCH_NAME` VARCHAR(45) NOT NULL ,
  `RESEARCH_OWNER` VARCHAR(45) NULL ,
  `RESEARCH_DESCRIPTION` VARCHAR(45) NULL ,
  `RESEARCH_LOCATION_ID` INT NULL ,
  `RESEARCH_COMPUTER_ID` INT NULL ,
  `RESEARCH_COMPUTER_SIZE` INT NULL ,
  PRIMARY KEY (`RESEARCH_ID`) ,
  INDEX `fk_T_RESEARCHES_T_RESEARCH_LOCATION1` (`RESEARCH_LOCATION_ID` ASC) ,
  INDEX `fk_T_RESEARCHES_T_RESEARCH_COMPUTER1` (`RESEARCH_COMPUTER_ID` ASC) ,
  CONSTRAINT `fk_T_RESEARCHES_T_RESEARCH_LOCATION1`
    FOREIGN KEY (`RESEARCH_LOCATION_ID` )
    REFERENCES `trialdb`.`t_research_location` (`RESEARCH_LOCATION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_RESEARCHES_T_RESEARCH_COMPUTER1`
    FOREIGN KEY (`RESEARCH_COMPUTER_ID` )
    REFERENCES `trialdb`.`t_research_computer` (`RESEARCH_COMPUTER_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_tasks` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_tasks` (
  `TASK_ID` INT NOT NULL AUTO_INCREMENT ,
  `TASK_NAME` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`TASK_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_task_run`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_task_run` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_task_run` (
  `TASK_RUN_ID` INT NOT NULL AUTO_INCREMENT ,
  `RESEARCH_ID` INT NULL ,
  `TASK_ID` INT NOT NULL ,
  `SUBJECT_ID` INT NOT NULL ,
  `EXPERIMENTER_ID` VARCHAR(60) NULL ,
  `TASK_RUN_DATE` DATE NOT NULL ,
  `IS_CONTROL_GROUP` TINYINT(1) NULL ,
  `TARGET_POPULATION_DESCRIPTION` VARCHAR(60) NULL ,
  PRIMARY KEY (`TASK_RUN_ID`) ,
  INDEX `fk_T_TASK_RUN_T_SUBJECTS1` (`SUBJECT_ID` ASC) ,
  INDEX `fk_T_TASK_RUN_T_RESEARCHES1` (`RESEARCH_ID` ASC) ,
  INDEX `fk_T_TASK_RUN_T_TASKS1` (`TASK_ID` ASC) ,
  CONSTRAINT `fk_T_TASK_RUN_T_SUBJECTS1`
    FOREIGN KEY (`SUBJECT_ID` )
    REFERENCES `trialdb`.`t_subjects` (`SUBJECT_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TASK_RUN_T_RESEARCHES1`
    FOREIGN KEY (`RESEARCH_ID` )
    REFERENCES `trialdb`.`t_researches` (`RESEARCH_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TASK_RUN_T_TASKS1`
    FOREIGN KEY (`TASK_ID` )
    REFERENCES `trialdb`.`t_tasks` (`TASK_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_locations` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_locations` (
  `LOCATION_ID` INT NOT NULL AUTO_INCREMENT ,
  `LOCATION_DESCRIPTION` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`LOCATION_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_trial_instructions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_trial_instructions` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_trial_instructions` (
  `TRIAL_INSTRUCTION_ID` INT NOT NULL AUTO_INCREMENT ,
  `TRIAL_INSTRUCTION_DESCRIPTION` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`TRIAL_INSTRUCTION_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_sub_task_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_sub_task_type` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_sub_task_type` (
  `SUB_TASK_TYPE_ID` INT NOT NULL AUTO_INCREMENT ,
  `SUB_TASK_TYPE_DESCRIPTION` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`SUB_TASK_TYPE_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_trial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_trial` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_trial` (
  `TRIAL_ID` INT NOT NULL AUTO_INCREMENT ,
  `TASK_RUN_ID` INT NOT NULL ,
  `RT` VARCHAR(45) NULL ,
  `ACCURACY` TINYINT(1) NULL ,
  `STIMULUS_ID` INT NULL ,
  `INPUT` VARCHAR(20) NULL ,
  `VALIDITY` TINYINT(1) NULL ,
  `CONGRUENCY` TINYINT(1) NULL ,
  `DELAY_BEFORE_STEP` INT NULL ,
  `NUM_OF_DISTRACTORS` INT NULL ,
  `IS_TARGET` TINYINT(1) NULL ,
  `PRECUE_LOCATION` INT NULL ,
  `STIMULUS_LOCATION` INT NULL ,
  `BLOCK_NO` INT NULL ,
  `SUB_TASK_TYPE` INT NULL ,
  `TRIAL_INSTRUCTIONS` INT NULL ,
  PRIMARY KEY (`TRIAL_ID`) ,
  INDEX `fk_T_TRIAL_T_STIMULI` (`STIMULUS_ID` ASC) ,
  INDEX `fk_T_TRIAL_T_TASK_RUN1` (`TASK_RUN_ID` ASC) ,
  INDEX `fk_T_TRIAL_T_LOCATIONS1` (`PRECUE_LOCATION` ASC) ,
  INDEX `fk_T_TRIAL_T_LOCATIONS2` (`STIMULUS_LOCATION` ASC) ,
  INDEX `fk_T_TRIAL_T_TRIAL_INSTRUCTIONS1` (`TRIAL_INSTRUCTIONS` ASC) ,
  INDEX `fk_T_TRIAL_T_SUB_TASK_TYPE1` (`SUB_TASK_TYPE` ASC) ,
  CONSTRAINT `fk_T_TRIAL_T_STIMULI`
    FOREIGN KEY (`STIMULUS_ID` )
    REFERENCES `trialdb`.`t_stimuli` (`STIMULUS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TRIAL_T_TASK_RUN1`
    FOREIGN KEY (`TASK_RUN_ID` )
    REFERENCES `trialdb`.`t_task_run` (`TASK_RUN_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TRIAL_T_LOCATIONS1`
    FOREIGN KEY (`PRECUE_LOCATION` )
    REFERENCES `trialdb`.`t_locations` (`LOCATION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TRIAL_T_LOCATIONS2`
    FOREIGN KEY (`STIMULUS_LOCATION` )
    REFERENCES `trialdb`.`t_locations` (`LOCATION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TRIAL_T_TRIAL_INSTRUCTIONS1`
    FOREIGN KEY (`TRIAL_INSTRUCTIONS` )
    REFERENCES `trialdb`.`t_trial_instructions` (`TRIAL_INSTRUCTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_TRIAL_T_SUB_TASK_TYPE1`
    FOREIGN KEY (`SUB_TASK_TYPE` )
    REFERENCES `trialdb`.`t_sub_task_type` (`SUB_TASK_TYPE_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_norm_definitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_norm_definitions` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_norm_definitions` (
  `NORM_ID` INT NOT NULL AUTO_INCREMENT ,
  `NORM_NAME` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`NORM_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_measures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_measures` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_measures` (
  `MEASURE_ID` INT NOT NULL AUTO_INCREMENT ,
  `TASK_ID` INT NOT NULL ,
  `MEASURE_NAME` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`MEASURE_ID`) ,
  INDEX `fk_T_MEASURES_T_TASKS1` (`TASK_ID` ASC) ,
  CONSTRAINT `fk_T_MEASURES_T_TASKS1`
    FOREIGN KEY (`TASK_ID` )
    REFERENCES `trialdb`.`t_tasks` (`TASK_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trialdb`.`t_norm_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`t_norm_groups` ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_norm_groups` (
  `NORM_ID` INT NOT NULL ,
  `MEASURE_ID` INT NOT NULL ,
  `MEASURE_VALUE` FLOAT NOT NULL ,
  INDEX `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1` (`NORM_ID` ASC) ,
  INDEX `fk_T_NORM_GROUPS_T_MEASURES1` (`MEASURE_ID` ASC) ,
  CONSTRAINT `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1`
    FOREIGN KEY (`NORM_ID` )
    REFERENCES `trialdb`.`t_norm_definitions` (`NORM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_NORM_GROUPS_T_MEASURES1`
    FOREIGN KEY (`MEASURE_ID` )
    REFERENCES `trialdb`.`t_measures` (`MEASURE_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
