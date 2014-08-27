SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


ALTER TABLE `trialdb`.`t_norm_groups` 
	DROP FOREIGN KEY `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1`,
	DROP FOREIGN KEY `fk_T_NORM_GROUPS_T_MEASURES1`;

ALTER TABLE `trialdb`.`t_measures` 
	ADD COLUMN `MEASURE_DESC` VARCHAR(90) NULL DEFAULT NULL AFTER `MEASURE_NAME`,
	ADD COLUMN `FUNCTION` VARCHAR(15) NULL DEFAULT 'AVG' AFTER `MEASURE_DESC`,
	ADD COLUMN `FIELD` VARCHAR(20) NULL DEFAULT 'rt' AFTER `FUNCTION`,
	ADD COLUMN `CONDITION` VARCHAR(200) NULL DEFAULT NULL AFTER `FIELD`,
	ADD COLUMN `STDEV_RANGE` INT(11) NULL DEFAULT NULL AFTER `CONDITION`,
	ADD COLUMN `HAS_MIN_COND` TINYINT(1) NULL DEFAULT '1' AFTER `STDEV_RANGE`,
	ADD COLUMN `IS_EXTREME_MEASURE` TINYINT(1) NULL DEFAULT '0' AFTER `HAS_MIN_COND`;

ALTER TABLE `trialdb`.`t_norm_groups` 
	DROP COLUMN `MEASURE_VALUE`,
	DROP COLUMN `MEASURE_ID`,
	DROP COLUMN `NORM_ID`,
	ADD COLUMN `NORM_GROUP_ID` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	ADD COLUMN `NORM_NAME` VARCHAR(45) NOT NULL AFTER `NORM_GROUP_ID`,
	ADD PRIMARY KEY (`NORM_GROUP_ID`),
	DROP INDEX `fk_T_NORM_GROUPS_T_MEASURES1` ,
	DROP INDEX `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1` ;

CREATE TABLE IF NOT EXISTS `trialdb`.`t_norm_values` (
  `NORM_VALUE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NORM_VALUE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `NORM_GROUP_ID` INT(11) NOT NULL,
  `MEASURE_ID` INT(11) NULL DEFAULT NULL,
  `NORM_MEAN` FLOAT(11) NOT NULL,
  `NORM_STD` FLOAT(11) NOT NULL,
  `REVERSE_SIGN` TINYINT(1) NULL DEFAULT '0',
  `COMBINED_MEASURE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`NORM_VALUE_ID`),
  INDEX `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1` (`NORM_GROUP_ID` ASC),
  INDEX `fk_T_NORM_GROUPS_T_MEASURES1` (`MEASURE_ID` ASC),
  CONSTRAINT `fk_T_NORM_GROUPS_T_MEASURES1`
    FOREIGN KEY (`MEASURE_ID`)
    REFERENCES `trialdb`.`t_measures` (`MEASURE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_NORM_GROUPS_T_NORM_DEFINITIONS1`
    FOREIGN KEY (`NORM_GROUP_ID`)
    REFERENCES `trialdb`.`t_norm_groups` (`NORM_GROUP_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 54
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;

ALTER TABLE `trialdb`.`t_subjects` 
	DROP COLUMN `YEAR_OF_BIRTH`,
	ADD COLUMN `AGE` INT(11) NULL DEFAULT NULL AFTER `AGE_GROUP_ID`,
	ADD COLUMN `DOMINANT_HAND` CHAR(1) NULL DEFAULT NULL AFTER `GENDER`;

DELETE FROM t_trial WHERE TASK_RUN_ID IN(1772,1773,1774,1775,1396,1585,1586,1587);
DELETE FROM t_task_run WHERE TASK_RUN_ID IN(1772,1773,1774,1775,1396,1585,1586,1587);
ALTER TABLE `trialdb`.`t_task_run` 
	ADD UNIQUE INDEX `unique` (`RESEARCH_ID` ASC, `SUBJECT_ID` ASC, `TASK_ID` ASC);

CREATE TABLE IF NOT EXISTS `trialdb`.`t_measure_presentation` (
  `PRESENTATION_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DISPLAY_NAME` VARCHAR(64) NULL DEFAULT NULL,
  `MEASURE_TYPE` CHAR(1) NOT NULL,
  `MEASURE_SOURCE` VARCHAR(1024) NULL DEFAULT NULL,
  `MEASURE_ID` INT(11) NULL DEFAULT NULL,
  `DISPLAY_ORDER` INT(11) NOT NULL,
  `IS_DEFAULT` TINYINT(1) NOT NULL,
  PRIMARY KEY (`PRESENTATION_ID`),
  INDEX `MEASURE_ID_FK_idx` (`MEASURE_ID` ASC),
  CONSTRAINT `MEASURE_ID_FK`
    FOREIGN KEY (`MEASURE_ID`)
    REFERENCES `trialdb`.`t_measures` (`MEASURE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;

CREATE TABLE IF NOT EXISTS `trialdb`.`t_subjects_tags` (
  `SUBJECT_TAG_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `subject_id` INT(11) NULL DEFAULT NULL,
  `TAG_ID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`SUBJECT_TAG_ID`),
  INDEX `Subjects_fk_idx` (`subject_id` ASC),
  INDEX `Tags_fk_idx` (`TAG_ID` ASC),
  CONSTRAINT `Subjects_fk`
    FOREIGN KEY (`subject_id`)
    REFERENCES `trialdb`.`t_subjects` (`SUBJECT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tags_fk`
    FOREIGN KEY (`TAG_ID`)
    REFERENCES `trialdb`.`t_tags` (`TAG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;

CREATE TABLE IF NOT EXISTS `trialdb`.`t_tags` (
  `TAG_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`TAG_ID`),
  UNIQUE INDEX `TAG_TEXT_UNIQUE` (`NAME` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = hebrew
COLLATE = hebrew_general_ci;

DROP TABLE IF EXISTS `trialdb`.`t_norm_definitions` ;


-- -----------------------------------------------------
-- Placeholder table for view `trialdb`.`v_norm_values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trialdb`.`v_norm_values` (`NORM_VALUE_ID` INT, `NORM_GROUP_ID` INT, `MEASURE_ID` INT, `NORM_MEAN` INT, `NORM_STD` INT, `REVERSE_SIGN` INT, `TASK_NAME` INT, `M_NAME` INT, `description` INT);

-- -----------------------------------------------------
-- Placeholder table for view `trialdb`.`v_measure_presentation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trialdb`.`v_measure_presentation` (`presentation_id` INT, `display_name` INT, `measure_type` INT, `measure_source` INT, `display_order` INT, `is_default` INT);


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_norm_values`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_norm_values`;
USE `trialdb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `trialdb`.`v_norm_values` AS select `n`.`NORM_VALUE_ID` AS `NORM_VALUE_ID`,`n`.`NORM_GROUP_ID` AS `NORM_GROUP_ID`,`n`.`MEASURE_ID` AS `MEASURE_ID`,`n`.`NORM_MEAN` AS `NORM_MEAN`,`n`.`NORM_STD` AS `NORM_STD`,`n`.`REVERSE_SIGN` AS `REVERSE_SIGN`,`t`.`TASK_NAME` AS `TASK_NAME`,coalesce(concat(`t`.`TASK_NAME`,'_',`m`.`MEASURE_NAME`),`n`.`COMBINED_MEASURE_NAME`) AS `M_NAME`,coalesce(`m`.`MEASURE_DESC`,`n`.`NORM_VALUE_NAME`) AS `description` from ((`trialdb`.`t_norm_values` `n` left join `trialdb`.`t_measures` `m` on((`m`.`MEASURE_ID` = `n`.`MEASURE_ID`))) left join `trialdb`.`t_tasks` `t` on((`m`.`TASK_ID` = `t`.`TASK_ID`)));


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_measure_presentation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_measure_presentation`;
USE `trialdb`;
CREATE  OR REPLACE VIEW `v_measure_presentation` AS
    SELECT 
        p.presentation_id,
        COALESCE(p.display_name, concat(t.task_name,'_',m.measure_name)) AS display_name,
        p.measure_type,
        COALESCE(p.measure_source, concat(t.task_name,'_',m.measure_name)) AS measure_source,
        p.display_order,
        p.is_default
    FROM
        trialdb.t_measure_presentation p
            LEFT JOIN
        trialdb.t_measures m ON (p.measure_id = m.measure_id)
		LEFT JOIN trialdb.t_tasks t ON (t.task_id=m.task_id)
    ORDER BY display_order ASC;

-- ---------------------------------------------------------
-- Fix AGE_GROUP_ID TABLE
-- --------------------------------------------------------
UPDATE t_age_groups SET AGE_GROUP_ID IS NULL WHERE AGE_GROUP_ID = 0;
DELETE FROM `trialdb`.`t_age_groups` WHERE `AGE_GROUP_ID`='3';
DELETE FROM `trialdb`.`t_age_groups` WHERE `AGE_GROUP_ID`='6';
DELETE FROM `trialdb`.`t_age_groups` WHERE `AGE_GROUP_ID`='9';
DELETE FROM `trialdb`.`t_age_groups` WHERE `AGE_GROUP_ID`='12';
UPDATE `trialdb`.`t_age_groups` SET `NAME`='ט-יב**' WHERE `AGE_GROUP_ID`='13';
	
	
UPDATE `trialdb`.`t_tasks` SET `TASK_NAME`='PosnerTemporalCue' WHERE `TASK_ID`='5';
UPDATE `trialdb`.`t_tasks` SET `TASK_NAME`='SimpleRT' WHERE `TASK_ID`='8';

INSERT INTO `t_norm_groups` VALUES (1,'adult-jews');

LOCK TABLES `t_norm_values` WRITE;
/*!40000 ALTER TABLE `t_norm_values` DISABLE KEYS */;
INSERT INTO `t_norm_values` VALUES (1,NULL,1,163,412.02,46.5,1,NULL),(2,NULL,1,164,391.35,49.36,1,NULL),(3,NULL,1,166,65.01,22.1,1,NULL),(4,NULL,1,167,69.46,21.92,1,NULL),(5,NULL,1,169,0.0033,0.0086,1,NULL),(6,NULL,1,170,0.0014,0.0037,1,NULL),(7,NULL,1,172,0.0047,0.0064,1,NULL),(8,NULL,1,173,0.0466,0.0389,1,NULL),(9,NULL,1,192,543.94,104.8,1,NULL),(10,NULL,1,193,504.57,77.15,1,NULL),(11,NULL,1,194,505.58,94.47,1,NULL),(12,NULL,1,195,462.11,68.83,1,NULL),(13,NULL,1,212,0.93,0.022,0,NULL),(14,NULL,1,213,0.9717,0.0288,0,NULL),(15,NULL,1,214,0.97,0.031,0,NULL),(16,NULL,1,215,0.9562,0.0464,0,NULL),(17,NULL,1,252,524.38,96.6,1,NULL),(18,NULL,1,258,0.976,0.029,0,NULL),(19,NULL,1,263,581.34,85.75,1,NULL),(20,NULL,1,264,664.88,104.34,1,NULL),(21,NULL,1,265,611.02,93.99,1,NULL),(22,NULL,1,266,710.35,128.9,1,NULL),(23,NULL,1,267,680.82,103.49,1,NULL),(24,NULL,1,268,865.04,198.87,1,NULL),(25,NULL,1,269,809.39,151.91,1,NULL),(26,NULL,1,270,1198.47,330.82,1,NULL),(27,NULL,1,271,0.9736,0.043,0,NULL),(28,NULL,1,272,0.9826,0.031,0,NULL),(29,NULL,1,273,0.9833,0.0367,0,NULL),(30,NULL,1,274,0.9888,0.0244,0,NULL),(31,NULL,1,275,0.9623,0.0505,0,NULL),(32,NULL,1,276,0.9907,0.0205,0,NULL),(33,NULL,1,277,0.9345,0.0684,0,NULL),(34,NULL,1,278,0.9926,0.0199,0,NULL),(35,NULL,1,303,415.27,82.11,1,NULL),(36,NULL,1,304,415.07,81.2,1,NULL),(37,NULL,1,305,473.95,79.48,1,NULL),(38,NULL,1,306,533.74,83.75,1,NULL),(39,NULL,1,307,0.9847,0.0214,0,NULL),(40,NULL,1,308,0.9797,0.0278,0,NULL),(41,NULL,1,309,0.9867,0.0201,0,NULL),(42,NULL,1,310,0.9338,0.0559,0,NULL),(43,'Task Score',1,NULL,10.41,5.76,1,'Search_task_score'),(44,'Combined Dir. Incong. All',1,NULL,572.28,86.71,1,'StroopLike_combined_direction_incong'),(45,'Combined Dir. Incong. Male',1,NULL,542.18,75.19,1,'StroopLike_combined_direction_incong'),(46,'Combined Dir. Incong. Female',1,NULL,594.65,88.38,1,'StroopLike_combined_direction_incong'),(47,'Task Score All Subjects',1,NULL,0.1054,0.0625,1,'StroopLike_task_score'),(48,'Task Score Male Subjects',1,NULL,0.085904,0.0522235,1,'StroopLike_task_score'),(49,'Task Score Female Subjects',1,NULL,0.126285,0.0666351,1,'StroopLike_task_score'),(50,'Task Score',1,NULL,0.1041,0.0647,1,'Posner_task_score'),(51,'Task Score',1,NULL,0.0721,0.053,1,'PosnerTemporalCue_task_score'),(52,'Cue Cost Score',1,NULL,0.0357,0.0887,1,'PosnerTemporalCue_cost'),(53,'Cue Benefit Score',1,NULL,0.036,0.092,1,'PosnerTemporalCue_benefit');
/*!40000 ALTER TABLE `t_norm_values` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `t_research_location` WRITE;
/*!40000 ALTER TABLE `t_research_location` DISABLE KEYS */;
INSERT INTO `t_research_location` VALUES (5,'Tel Aviv Lab- A'),(6,'Tel Aviv Lab- B'),(7,'Tel Aviv Lab- D'),(8,'Tel Aviv Lab-F');
/*!40000 ALTER TABLE `t_research_location` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `t_measure_presentation` WRITE;
/*!40000 ALTER TABLE `t_measure_presentation` DISABLE KEYS */;
INSERT INTO `t_measure_presentation` VALUES (1,NULL,'M',NULL,162,1,0),(2,NULL,'M',NULL,165,2,0),(3,NULL,'M',NULL,168,3,0),(4,NULL,'M',NULL,171,4,0),(5,NULL,'M',NULL,174,5,0),(6,NULL,'M',NULL,177,6,0),(7,NULL,'M',NULL,180,7,0),(8,NULL,'M',NULL,323,8,0),(9,NULL,'M',NULL,163,9,0),(10,NULL,'M',NULL,166,10,0),(11,NULL,'M',NULL,169,11,0),(12,NULL,'M',NULL,172,12,0),(13,NULL,'M',NULL,175,13,0),(14,NULL,'M',NULL,178,14,0),(15,NULL,'M',NULL,181,15,0),(16,NULL,'M',NULL,324,16,0),(17,NULL,'M',NULL,164,17,0),(18,NULL,'M',NULL,167,18,0),(19,NULL,'M',NULL,170,19,0),(20,NULL,'M',NULL,173,20,0),(21,NULL,'M',NULL,176,21,0),(22,NULL,'M',NULL,179,22,0),(23,NULL,'M',NULL,182,23,0),(24,NULL,'M',NULL,325,24,0),(25,NULL,'M',NULL,193,25,0),(26,NULL,'M',NULL,195,26,0),(27,NULL,'M',NULL,197,27,0),(28,NULL,'M',NULL,199,28,0),(29,NULL,'M',NULL,201,29,0),(30,NULL,'M',NULL,203,30,0),(31,NULL,'M',NULL,205,31,0),(32,NULL,'M',NULL,207,32,0),(33,NULL,'M',NULL,209,33,0),(34,NULL,'M',NULL,211,34,0),(35,NULL,'M',NULL,213,35,0),(36,NULL,'M',NULL,215,36,0),(37,NULL,'M',NULL,217,37,0),(38,NULL,'M',NULL,219,38,0),(39,NULL,'M',NULL,221,39,0),(40,NULL,'M',NULL,223,40,0),(41,NULL,'M',NULL,225,41,0),(42,NULL,'M',NULL,227,42,0),(43,NULL,'M',NULL,229,43,0),(44,NULL,'M',NULL,231,44,0),(45,NULL,'M',NULL,233,45,0),(46,NULL,'M',NULL,235,46,0),(47,NULL,'M',NULL,237,47,0),(48,NULL,'M',NULL,239,48,0),(49,NULL,'M',NULL,241,49,0),(50,NULL,'M',NULL,243,50,0),(51,NULL,'M',NULL,245,51,0),(52,NULL,'M',NULL,247,52,0),(53,NULL,'M',NULL,249,53,0),(54,NULL,'M',NULL,251,54,0),(55,NULL,'M',NULL,326,55,0),(56,NULL,'M',NULL,192,56,0),(57,NULL,'M',NULL,194,57,0),(58,NULL,'M',NULL,196,58,0),(59,NULL,'M',NULL,198,59,0),(60,NULL,'M',NULL,200,60,0),(61,NULL,'M',NULL,202,61,0),(62,NULL,'M',NULL,204,62,0),(63,NULL,'M',NULL,206,63,0),(64,NULL,'M',NULL,208,64,0),(65,NULL,'M',NULL,210,65,0),(66,NULL,'M',NULL,212,66,0),(67,NULL,'M',NULL,214,67,0),(68,NULL,'M',NULL,216,73,0),(69,NULL,'M',NULL,218,74,0),(70,NULL,'M',NULL,220,75,0),(71,NULL,'M',NULL,222,76,0),(72,NULL,'M',NULL,224,77,0),(73,NULL,'M',NULL,226,78,0),(74,NULL,'M',NULL,228,79,0),(75,NULL,'M',NULL,230,80,0),(76,NULL,'M',NULL,232,81,0),(77,NULL,'M',NULL,234,82,0),(78,NULL,'M',NULL,236,83,0),(79,NULL,'M',NULL,238,84,0),(80,NULL,'M',NULL,240,85,0),(81,NULL,'M',NULL,242,86,0),(82,NULL,'M',NULL,244,87,0),(83,NULL,'M',NULL,246,88,0),(84,NULL,'M',NULL,248,89,0),(85,NULL,'M',NULL,250,90,0),(86,NULL,'M',NULL,252,91,0),(87,NULL,'M',NULL,253,92,0),(88,NULL,'M',NULL,254,93,0),(89,NULL,'M',NULL,255,94,0),(90,NULL,'M',NULL,256,95,0),(91,NULL,'M',NULL,257,96,0),(92,NULL,'M',NULL,258,97,0),(93,NULL,'M',NULL,327,98,0),(94,NULL,'M',NULL,303,99,0),(95,NULL,'M',NULL,304,100,0),(96,NULL,'M',NULL,305,101,0),(97,NULL,'M',NULL,306,102,0),(98,NULL,'M',NULL,307,103,0),(99,NULL,'M',NULL,308,104,0),(100,NULL,'M',NULL,309,105,0),(101,NULL,'M',NULL,310,106,0),(102,NULL,'M',NULL,311,107,0),(103,NULL,'M',NULL,312,108,0),(104,NULL,'M',NULL,313,109,0),(105,NULL,'M',NULL,314,110,0),(106,NULL,'M',NULL,315,111,0),(107,NULL,'M',NULL,316,112,0),(108,NULL,'M',NULL,317,113,0),(109,NULL,'M',NULL,318,118,0),(110,NULL,'M',NULL,319,115,0),(111,NULL,'M',NULL,320,116,0),(112,NULL,'M',NULL,321,117,0),(113,NULL,'M',NULL,322,9,0),(114,NULL,'M',NULL,328,9,0),(115,NULL,'M',NULL,263,9,0),(116,NULL,'M',NULL,264,9,0),(117,NULL,'M',NULL,265,9,0),(118,NULL,'M',NULL,266,9,0),(119,NULL,'M',NULL,267,9,0),(120,NULL,'M',NULL,268,9,0),(121,NULL,'M',NULL,269,9,0),(122,NULL,'M',NULL,270,9,0),(123,NULL,'M',NULL,271,9,0),(124,NULL,'M',NULL,272,9,0),(125,NULL,'M',NULL,273,9,0),(126,NULL,'M',NULL,274,9,0),(127,NULL,'M',NULL,275,9,0),(128,NULL,'M',NULL,276,9,0),(129,NULL,'M',NULL,277,9,0),(130,NULL,'M',NULL,278,9,0),(131,NULL,'M',NULL,279,9,0),(132,NULL,'M',NULL,280,9,0),(133,NULL,'M',NULL,281,9,0),(134,NULL,'M',NULL,282,9,0),(135,NULL,'M',NULL,283,9,0),(136,NULL,'M',NULL,284,9,0),(137,NULL,'M',NULL,285,9,0),(138,NULL,'M',NULL,286,9,0),(139,NULL,'M',NULL,287,9,0),(140,NULL,'M',NULL,288,9,0),(141,NULL,'M',NULL,289,9,0),(142,NULL,'M',NULL,290,9,0),(143,NULL,'M',NULL,291,9,0),(144,NULL,'M',NULL,292,9,0),(145,NULL,'M',NULL,293,9,0),(146,NULL,'M',NULL,294,9,0),(147,NULL,'M',NULL,295,9,0),(148,NULL,'M',NULL,296,9,0),(149,NULL,'M',NULL,297,9,0),(150,NULL,'M',NULL,298,9,0),(151,NULL,'M',NULL,299,9,0),(152,NULL,'M',NULL,300,9,0),(153,NULL,'M',NULL,301,9,0),(154,NULL,'M',NULL,302,9,0),(155,NULL,'M',NULL,329,9,0),(156,NULL,'M',NULL,259,9,0),(157,NULL,'M',NULL,260,9,0),(158,NULL,'M',NULL,261,9,0),(159,NULL,'M',NULL,262,9,0),(160,NULL,'M',NULL,330,9,0),(256,'CPT_task_score','C','CPT_std_rt_3std_clean/CPT_avg_rt_3std_clean',NULL,1,1),(257,'CPTi_task_score','C','CPTi_std_rt_3std_clean/CPTi_avg_rt_3std_clean',NULL,1,1),(258,'ACPT_task_score','C','ACPT_std_rt_3std_clean/ACPT_avg_rt_3std_clean',NULL,1,1),(259,'StroopLike_task_score','C','(((StroopLike_avg_rt_direction_incong/StroopLike_acc_rate_direction_incong) +(StroopLike_avg_rt_location_incong/StroopLike_acc_rate_location_incong))-((StroopLike_avg_rt_direction_cong/StroopLike_acc_rate_direction_cong)+(StroopLike_avg_rt_location_cong/StroopLike_acc_rate_location_cong)))/((((StroopLike_avg_rt_direction_incong/StroopLike_acc_rate_direction_incong) +(StroopLike_avg_rt_location_incong/StroopLike_acc_rate_location_incong))+((StroopLike_avg_rt_direction_cong/StroopLike_acc_rate_direction_cong)+(StroopLike_avg_rt_location_cong/StroopLike_acc_rate_location_cong)))/2)',NULL,1,1),(260,'Search_task_score','C','(\n	3\n	*\n	(\n		(8*Search_avg_rt_8s_wt/Search_acc_rate_8s_wt)\n		+\n		(16*Search_avg_rt_16s_wt/Search_acc_rate_16s_wt)\n		+\n		(32*Search_avg_rt_32s_wt/Search_acc_rate_32s_wt)\n	)\n	-\n	(8+16+32)\n	*\n	(\n		(Search_avg_rt_8s_wt/Search_acc_rate_8s_wt)\n		+\n		(Search_avg_rt_16s_wt/Search_acc_rate_16s_wt)\n		+\n		(Search_avg_rt_32s_wt/Search_acc_rate_32s_wt)	\n	)\n)\n/\n(\n	3.0*((8*8)+(16*16)+(32*32)) - ((8+16+32)*(8+16+32))\n)',NULL,1,1),(261,'PosnerTemporalCue_cost','C','(\n	(PosnerTemporalCue_avg_rt_invalid/PosnerTemporalCue_acc_rate_invalid)\n	-\n	(PosnerTemporalCue_avg_rt_neutral/PosnerTemporalCue_acc_rate_neutral)\n)\n/\n(\n	(\n		(PosnerTemporalCue_avg_rt_invalid/PosnerTemporalCue_acc_rate_invalid)\n		+\n		(PosnerTemporalCue_avg_rt_neutral/PosnerTemporalCue_acc_rate_neutral)\n	)/2\n)	',NULL,1,1),(262,'PosnerTemporalCue_benefit','C','(\n	(PosnerTemporalCue_avg_rt_neutral/PosnerTemporalCue_acc_rate_neutral)\n	-\n	(PosnerTemporalCue_avg_rt_valid/PosnerTemporalCue_acc_rate_valid)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_neutral/PosnerTemporalCue_acc_rate_neutral)\n	+\n	(PosnerTemporalCue_avg_rt_valid/PosnerTemporalCue_acc_rate_valid)\n	)/2\n)',NULL,1,1),(263,'PosnerTemporalCue_cost_left','C','(\n	(PosnerTemporalCue_avg_rt_invalid_left_target/PosnerTemporalCue_acc_rate_invalid_left_target)\n	-\n	(PosnerTemporalCue_avg_rt_neutral_left_target/PosnerTemporalCue_acc_rate_neutral_left_target)\n)\n/\n(\n	(\n		(PosnerTemporalCue_avg_rt_invalid_left_target/PosnerTemporalCue_acc_rate_invalid_left_target)\n		+\n		(PosnerTemporalCue_avg_rt_neutral_left_target/PosnerTemporalCue_acc_rate_neutral_left_target)\n	)/2\n)',NULL,1,1),(264,'PosnerTemporalCue_cost_right','C','(\n	(PosnerTemporalCue_avg_rt_invalid_right_target/PosnerTemporalCue_acc_rate_invalid_right_target)\n	-\n	(PosnerTemporalCue_avg_rt_neutral_right_target/PosnerTemporalCue_acc_rate_neutral_right_target)\n)\n/\n(\n	(\n		(PosnerTemporalCue_avg_rt_invalid_right_target/PosnerTemporalCue_acc_rate_invalid_right_target)\n		+\n		(PosnerTemporalCue_avg_rt_neutral_right_target/PosnerTemporalCue_acc_rate_neutral_right_target)\n	)/2\n)	',NULL,1,1),(265,'PosnerTemporalCue_benefit_left','C','(\n	(PosnerTemporalCue_avg_rt_neutral_left_target/PosnerTemporalCue_acc_rate_neutral_left_target)\n	-\n	(PosnerTemporalCue_avg_rt_valid_left_target/PosnerTemporalCue_acc_rate_valid_left_target)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_neutral_left_target/PosnerTemporalCue_acc_rate_neutral_left_target)\n	+\n	(PosnerTemporalCue_avg_rt_valid_left_target/PosnerTemporalCue_acc_rate_valid_left_target)\n	)/2\n)',NULL,1,1),(266,'PosnerTemporalCue_benefit_right','C','(\n	(PosnerTemporalCue_avg_rt_neutral_right_target/PosnerTemporalCue_acc_rate_neutral_right_target)\n	-\n	(PosnerTemporalCue_avg_rt_valid_right_target/PosnerTemporalCue_acc_rate_valid_right_target)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_neutral_right_target/PosnerTemporalCue_acc_rate_neutral_right_target)\n	+\n	(PosnerTemporalCue_avg_rt_valid_right_target/PosnerTemporalCue_acc_rate_valid_right_target)\n	)/2\n)',NULL,1,1),(277,'PosnerTemporalCue_task_score','C','\n(\n	(PosnerTemporalCue_avg_rt_invalid/PosnerTemporalCue_acc_rate_invalid)\n	-\n	(PosnerTemporalCue_avg_rt_valid/PosnerTemporalCue_acc_rate_valid)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_invalid/PosnerTemporalCue_acc_rate_invalid)\n	+\n	(PosnerTemporalCue_avg_rt_valid/PosnerTemporalCue_acc_rate_valid)\n	)/2\n)',NULL,1,1),(278,'PosnerTemporalCue_task_score_left','C','(\n	(PosnerTemporalCue_avg_rt_invalid_left_target/PosnerTemporalCue_acc_rate_invalid_left_target)\n	-\n	(PosnerTemporalCue_avg_rt_valid_left_target/PosnerTemporalCue_acc_rate_valid_left_target)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_invalid_left_target/PosnerTemporalCue_acc_rate_invalid_left_target)\n	+\n	(PosnerTemporalCue_avg_rt_valid_left_target/PosnerTemporalCue_acc_rate_valid_left_target)\n	)/2\n)',NULL,1,1),(279,'PosnerTemporalCue_task_score_right','C','(\n	(PosnerTemporalCue_avg_rt_invalid_right_target/PosnerTemporalCue_acc_rate_invalid_right_target)\n	-\n	(PosnerTemporalCue_avg_rt_valid_right_target/PosnerTemporalCue_acc_rate_valid_right_target)\n)\n/\n(\n	(\n	(PosnerTemporalCue_avg_rt_invalid_right_target/PosnerTemporalCue_acc_rate_invalid_right_target)\n	+\n	(PosnerTemporalCue_avg_rt_valid_right_target/PosnerTemporalCue_acc_rate_valid_right_target)\n	)/2\n)',NULL,1,1),(280,'Posner_task_score_right','C','(\n	(Posner_avg_rt_invalid_right_target/Posner_acc_rate_invalid_right_target)\n	-\n	(Posner_avg_rt_valid_right_target/Posner_acc_rate_valid_right_target)\n)\n/\n(\n	(\n	(Posner_avg_rt_invalid_right_target/Posner_acc_rate_invalid_right_target)\n	+\n	(Posner_avg_rt_valid_right_target/Posner_acc_rate_valid_right_target)\n	)/2\n)',NULL,1,1),(281,'Posner_task_score_left','C','(\n	(Posner_avg_rt_invalid_left_target/Posner_acc_rate_invalid_left_target)\n	-\n	(Posner_avg_rt_valid_left_target/Posner_acc_rate_valid_left_target)\n)\n/\n(\n	(\n	(Posner_avg_rt_invalid_left_target/Posner_acc_rate_invalid_left_target)\n	+\n	(Posner_avg_rt_valid_left_target/Posner_acc_rate_valid_left_target)\n	)/2\n)',NULL,1,1),(282,'Posner_task_score','C','(\n	(Posner_avg_rt_invalid/Posner_acc_rate_invalid)\n	-\n	(Posner_avg_rt_valid/Posner_acc_rate_valid)\n)\n/\n(\n	(\n	(Posner_avg_rt_invalid/Posner_acc_rate_invalid)\n	+\n	(Posner_avg_rt_valid/Posner_acc_rate_valid)\n	)/2\n)',NULL,1,1);
/*!40000 ALTER TABLE `t_measure_presentation` ENABLE KEYS */;
UNLOCK TABLES;


	
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
