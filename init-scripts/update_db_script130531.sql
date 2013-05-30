SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE  TABLE IF NOT EXISTS `trialdb`.`T_RESEARCH_LOCATION` (
  `RESEARCH_LOCATION_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `LOCATION_NAME` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`RESEARCH_LOCATION_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;

CREATE  TABLE IF NOT EXISTS `trialdb`.`T_RESEARCH_COMPUTER` (
  `RESEARCH_COMPUTER_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `COMPUTER_DESC` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`RESEARCH_COMPUTER_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;


-- -----------------------------------------------------
-- View `trialdb`.`v_strooplike_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_strooplike_data`;
DROP VIEW IF EXISTS `trialdb`.`v_strooplike_data` ;


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_posner_temporal_cue_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_posner_temporal_cue_data`;
DROP VIEW IF EXISTS `trialdb`.`v_posner_temporal_cue_data` ;


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_posner_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_posner_data`;
DROP VIEW IF EXISTS `trialdb`.`v_posner_data` ;


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_acpt_range`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_acpt_range`;
DROP VIEW IF EXISTS `trialdb`.`v_acpt_range` ;


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_acpt_measures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_acpt_measures`;
DROP VIEW IF EXISTS `trialdb`.`v_acpt_measures` ;


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_acpt_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_acpt_data`;
DROP VIEW IF EXISTS `trialdb`.`v_acpt_data` ;

source 'init_computer_types.sql';
source 'init_research_locations.sql';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
