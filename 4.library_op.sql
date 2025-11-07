CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Book Table
CREATE TABLE BOOK (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(50),
  author VARCHAR(50)
);

-- Member Table
CREATE TABLE MEMBER (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

-- Issue Table
CREATE TABLE ISSUE (
  issue_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT,
  member_id INT,
  issue_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES BOOK(book_id),
  FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

-- 1. Insert sample data
INSERT INTO BOOK (title, author) VALUES
('DBMS', 'Korth'),
('OS', 'Silberschatz'),
('C Programming', 'Dennis'),
('Networks', 'Tanenbaum');

INSERT INTO MEMBER (name) VALUES ('Amit'), ('Sneha'), ('Raj');

INSERT INTO ISSUE (book_id, member_id, issue_date, return_date) VALUES
(1, 1, '2025-11-01', NULL),
(2, 2, '2025-11-02', '2025-11-10'),
(3, 1, '2025-11-03', NULL);

-- 2. Books issued to a particular member
SELECT b.title 
FROM BOOK b, ISSUE i, MEMBER m
WHERE b.book_id=i.book_id AND m.member_id=i.member_id AND m.name='Amit';

-- 3. Books by a specific author
SELECT * FROM BOOK WHERE author='Korth';

-- 4. Update return date of a book
UPDATE ISSUE SET return_date='2025-11-08' WHERE issue_id=1;

-- 5. Delete a lost book
DELETE FROM BOOK WHERE title='Networks';

-- 6. Count of books issued per member
SELECT m.name, COUNT(i.book_id) AS Total
FROM MEMBER m LEFT JOIN ISSUE i ON m.member_id=i.member_id
GROUP BY m.name;

-- 7. Books available (not issued)
SELECT * FROM BOOK WHERE book_id NOT IN (SELECT book_id FROM ISSUE WHERE return_date IS NULL);

-- 8. Members who never issued a book
SELECT * FROM MEMBER WHERE member_id NOT IN (SELECT member_id FROM ISSUE);

-- 9. Books issued in current month
SELECT b.title, i.issue_date
FROM BOOK b JOIN ISSUE i ON b.book_id=i.book_id
WHERE MONTH(i.issue_date)=MONTH(CURDATE());

-- 10. Most frequently issued book
SELECT b.title, COUNT(i.book_id) AS Times
FROM BOOK b JOIN ISSUE i ON b.book_id=i.book_id
GROUP BY b.title ORDER BY Times DESC LIMIT 1;    