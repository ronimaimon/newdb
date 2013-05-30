SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `trialdb`.`t_research_computer`;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO t_research_computer (`COMPUTER_DESC`)
VALUES ("Desktop");
INSERT INTO t_research_computer (`COMPUTER_DESC`)
VALUES ("Laptop");