CREATE DATABASE LibraryDB1;
USE LibraryDB1;

-- Create tables
CREATE TABLE Borrower (
  Roll_no INT PRIMARY KEY,
  Name VARCHAR(50),
  DateOfIssue DATE,
  NameOfBook VARCHAR(50),
  Status CHAR(1)  -- 'I' = Issued, 'R' = Returned
);

CREATE TABLE Fine (
  Roll_no INT,
  Date_ DATE,
  Amt DECIMAL(10,2)
);

-- Sample data
INSERT INTO Borrower VALUES
(1, 'Amit', '2025-10-10', 'DBMS', 'I'),
(2, 'Sneha', '2025-10-20', 'OS', 'I');
COMMIT;

-- ✅ Stored Procedure to check fine and return book
DELIMITER $$

CREATE PROCEDURE ReturnBook(IN p_roll INT, IN p_book VARCHAR(50))
BEGIN
  DECLARE v_date DATE;
  DECLARE v_days INT;
  DECLARE v_fine DECIMAL(10,2) DEFAULT 0;
  DECLARE v_status CHAR(1);
  DECLARE not_found BOOL DEFAULT FALSE;

  -- Try to get borrower details
  SELECT DateOfIssue, Status INTO v_date, v_status
  FROM Borrower
  WHERE Roll_no = p_roll AND NameOfBook = p_book
  LIMIT 1;

  -- SET SQL_SAFE_UPDATES = 0;
  -- Calculate days since issued
  SET v_days = DATEDIFF(CURDATE(), v_date);

  -- Fine rules
  IF v_days <= 15 THEN
    SET v_fine = 0;
  ELSEIF v_days BETWEEN 16 AND 30 THEN
    SET v_fine = (v_days - 15) * 5;
  ELSE
    SET v_fine = (v_days - 30) * 50;
  END IF;

  -- Update status to Returned
  UPDATE Borrower
  SET Status = 'R'
  WHERE Roll_no = p_roll AND NameOfBook = p_book;

  -- Insert fine if any
  IF v_fine > 0 THEN
    INSERT INTO Fine VALUES (p_roll, CURDATE(), v_fine);
  END IF;

  -- Display results
  SELECT CONCAT('Book Returned Successfully! Days: ', v_days, ', Fine: Rs.', v_fine) AS Message;
  
END $$

DELIMITER ;

-- ✅ To run procedure:
CALL ReturnBook(1, 'DBMS');
