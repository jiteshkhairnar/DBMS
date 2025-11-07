-- Step 1: Create tables
CREATE TABLE Library (
    Lib_ID INT PRIMARY KEY,
    Book_Name VARCHAR(100),
    Author_Name VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Library_Audit (
    Lib_ID INT,
    Book_Name VARCHAR(100),
    Author_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Operation VARCHAR(20),
    Operation_Date DATETIME
);

-- Step 2: Insert some sample data
INSERT INTO Library VALUES
(1, 'DBMS', 'Navathe', 500),
(2, 'Operating System', 'Galvin', 600),
(3, 'Computer Networks', 'Tanenbaum', 700);

-- Step 3: Trigger for UPDATE
DELIMITER $$

CREATE TRIGGER trg_library_update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    VALUES (OLD.Lib_ID, OLD.Book_Name, OLD.Author_Name, OLD.Price, 
            'UPDATE', NOW());
END $$

-- Step 4: Trigger for DELETE
CREATE TRIGGER trg_library_delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    VALUES (OLD.Lib_ID, OLD.Book_Name, OLD.Author_Name, OLD.Price, 
            'DELETE', NOW());
END $$

DELIMITER ;

-- Step 5: Test UPDATE
UPDATE Library 
SET Price = 550 
WHERE Lib_ID = 1;

-- Step 6: Test DELETE
DELETE FROM Library 
WHERE Lib_ID = 2;

-- Step 7: Check audit records
SELECT * FROM Library_Audit;