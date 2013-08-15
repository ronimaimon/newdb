SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `trialdb`.`t_subjects` ADD COLUMN `AGE_GROUP_ID` INT(11) NOT NULL  AFTER `SUBJECT_NAME` , ADD COLUMN `YEAR_OF_BIRTH` INT(11) NULL DEFAULT NULL  AFTER `AGE_GROUP_ID` , ADD COLUMN `GENDER` CHAR NULL DEFAULT NULL  AFTER `YEAR_OF_BIRTH` , ADD COLUMN `CONTROL` TINYINT(1) NULL DEFAULT NULL  AFTER `GENDER` , 
  ADD CONSTRAINT `fk_t_subjects_t_age_groups1`
  FOREIGN KEY (`AGE_GROUP_ID` )
  REFERENCES `trialdb`.`t_age_groups` (`AGE_GROUP_ID` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_t_subjects_t_age_groups1` (`AGE_GROUP_ID` ASC) ;

CREATE  TABLE IF NOT EXISTS `trialdb`.`t_age_groups` (
  `AGE_GROUP_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`AGE_GROUP_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;


USE `trialdb`;
DROP procedure IF EXISTS `trialdb`.`clean_calc1`;

USE `trialdb`;
DROP procedure IF EXISTS `trialdb`.`clean_calc`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
