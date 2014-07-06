SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Placeholder table for view `trialdb`.`v_norm_values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trialdb`.`v_norm_values` (`NORM_VALUE_ID` INT, `NORM_GROUP_ID` INT, `MEASURE_ID` INT, `NORM_MEAN` INT, `NORM_STD` INT, `REVERSE_SIGN` INT, `TASK_NAME` INT, `M_NAME` INT, `description` INT);


USE `trialdb`;

-- -----------------------------------------------------
-- View `trialdb`.`v_norm_values`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trialdb`.`v_norm_values`;
USE `trialdb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `trialdb`.`v_norm_values` AS select `n`.`NORM_VALUE_ID` AS `NORM_VALUE_ID`,`n`.`NORM_GROUP_ID` AS `NORM_GROUP_ID`,`n`.`MEASURE_ID` AS `MEASURE_ID`,`n`.`NORM_MEAN` AS `NORM_MEAN`,`n`.`NORM_STD` AS `NORM_STD`,`n`.`REVERSE_SIGN` AS `REVERSE_SIGN`,coalesce(`t`.`TASK_NAME`, SUBSTRING_INDEX(SUBSTRING_INDEX(`n`.`COMBINED_MEASURE_NAME`, '_', 1), ' ', -1)) AS `TASK_NAME`,coalesce(concat(`t`.`TASK_NAME`,'_',`m`.`MEASURE_NAME`),`n`.`COMBINED_MEASURE_NAME`) AS `M_NAME`,coalesce(`m`.`MEASURE_DESC`,`n`.`NORM_VALUE_NAME`) AS `description` from ((`trialdb`.`t_norm_values` `n` left join `trialdb`.`t_measures` `m` on((`m`.`MEASURE_ID` = `n`.`MEASURE_ID`))) left join `trialdb`.`t_tasks` `t` on((`m`.`TASK_ID` = `t`.`TASK_ID`)));


ALTER TABLE `trialdb`.`t_norm_groups` 
CHANGE COLUMN `NORM_NAME` `NORM_GROUP_NAME` VARCHAR(45) NOT NULL ,
ADD COLUMN `NORM_GROUP_N` INT(11) NULL DEFAULT NULL AFTER `NORM_GROUP_NAME`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
