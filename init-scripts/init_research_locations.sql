SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `trialdb`.`t_research_location`;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO t_research_location (`LOCATION_NAME`)
VALUES ("Tel Aviv Lab");
INSERT INTO t_research_location (`LOCATION_NAME`)
VALUES ("Har-Hazofim Lab");
INSERT INTO t_research_location (`LOCATION_NAME`)
VALUES ("Open University Lab");
INSERT INTO t_research_location (`LOCATION_NAME`)
VALUES ("Field");