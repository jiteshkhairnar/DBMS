-- Create table (if not already created)
CREATE TABLE Student (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    TotalMarks INT
);

-- Sample data
INSERT INTO Student VALUES
(1, 'Amit', 1200),
(2, 'Sneha', 950),
(3, 'Rahul', 860),
(4, 'Priya', 700);

-- Create the stored procedure
DELIMITER $$

CREATE PROCEDURE proc_Grade(IN rno INT)
BEGIN
    DECLARE marks INT;
    DECLARE grade VARCHAR(30);

    -- Get the marks of the given student
    SELECT TotalMarks INTO marks FROM Student WHERE Roll_no = rno;

    -- Decide grade
    IF marks BETWEEN 990 AND 1500 THEN
        SET grade = 'Distinction';
    ELSEIF marks BETWEEN 900 AND 989 THEN
        SET grade = 'First Class';
    ELSEIF marks BETWEEN 825 AND 899 THEN
        SET grade = 'Higher Second Class';
    ELSE
        SET grade = 'Pass/Fail';
    END IF;

    -- Display result
    SELECT CONCAT('Roll No: ', rno, ', Grade: ', grade) AS Result;
END $$

DELIMITER ;

-- Call the procedure
CALL proc_Grade(2);
