-- Create old roll call table
CREATE TABLE O_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Create new roll call table
CREATE TABLE N_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert sample data
INSERT INTO O_RollCall VALUES (1, 'Amit'), (2, 'Sneha');
INSERT INTO N_RollCall VALUES (2, 'Sneha'), (3, 'Rahul'), (4, 'Priya');

-- Create stored procedure
DELIMITER $$

CREATE PROCEDURE merge_rollcall()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE rno INT;
    DECLARE nm VARCHAR(50);

    -- Cursor to fetch new roll call data
    DECLARE cur CURSOR FOR SELECT roll_no, name FROM N_RollCall;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO rno, nm;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Check if record exists in O_RollCall
        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE roll_no = rno) THEN
            INSERT INTO O_RollCall VALUES (rno, nm);
        END IF;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;

-- Call the procedure
CALL merge_rollcall();

-- Check merged data
SELECT * FROM O_RollCall;
