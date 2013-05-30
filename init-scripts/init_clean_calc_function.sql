
DELIMITER //

CREATE PROCEDURE trialdb.clean_calc (
    IN task_run_id        INT,
    IN dynamic_condition  VARCHAR (1024),
    IN calculation_field  VARCHAR (30),
    IN calc_function      VARCHAR (30),
    IN stdev_range        VARCHAR (5)
) 
BEGIN
/*    DECLARE returned_value FLOAT;*/
    
    SET @dynamic_stmt = CONCAT('SELECT ',calc_function);
    SET @dynamic_stmt = CONCAT(@dynamic_stmt,'(?) FROM t_trial l INNER JOIN (SELECT AVG (rt) - (? * STD(rt)) AS lower_bound,  AVG (rt) + (? * STD(rt)) AS upper_bound   FROM t_trial t WHERE task_run_id = ? AND ? AND rt BETWEEN 150 AND 4000) r ON (l.rt BETWEEN r.lower_bound AND r.upper_bound) WHERE l.task_run_id = ? AND ?');

/*

    SET @dynamic_stmt = 'SELECT avg(?)
 FROM t_trial l
 INNER JOIN (SELECT AVG (rt) - (? * STD(rt)) AS lower_bound,
                    AVG (rt) + (? * STD(rt)) AS upper_bound   
               FROM t_trial t
              WHERE task_run_id = ?
                AND ?
                AND rt BETWEEN 150 AND 4000) r
    ON (l.rt BETWEEN r.lower_bound AND r.upper_bound)
 WHERE l.task_run_id = ?
   AND ?';
*/
    SELECT @dynamic_stmt FRom dual;
    PREPARE my_stmt 
       FROM @dynamic_stmt;
    
    EXECUTE my_stmt
      USING @calculation_field, 
            @stdev_range,
            @stdev_range,
            @task_run_id,
            @dynamic_condition,
            @task_run_id,
            @dynamic_condition;
    
    DEALLOCATE PREPARE my_stmt;
  
    /*RETURN @returned_value;*/
END
//