CREATE DATABASE StudentResultDB;
USE StudentResultDB;

-- Create STUDENT table
CREATE TABLE STUDENT (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50),
  department VARCHAR(30),
  age INT
);

-- Create RESULT table
CREATE TABLE RESULT (
  student_id INT,
  subject VARCHAR(50),
  marks INT,
  FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

-- Insert sample students
INSERT INTO STUDENT VALUES
(1, 'Amit Patil', 'IT', 20),
(2, 'Sneha Joshi', 'Comp', 21),
(3, 'Raj Verma', 'IT', 22),
(4, 'Tina Shah', 'ENTC', 20);

-- Insert sample results
INSERT INTO RESULT VALUES
(1, 'DBMS', 75),
(1, 'OOP', 80),
(2, 'DBMS', 90),
(2, 'OOP', 85),
(3, 'DBMS', 60),
(3, 'OOP', 70),
(4, 'DBMS', 88),
(4, 'OOP', 82);

-- 1️⃣ Students who scored more than average marks (single-row subquery)
SELECT student_name
FROM STUDENT
WHERE student_id IN (
  SELECT student_id
  FROM RESULT
  WHERE marks > (SELECT AVG(marks) FROM RESULT)
);

-- 2️⃣ Students whose marks = maximum marks in DBMS (single-row subquery)
SELECT s.student_name, r.marks
FROM STUDENT s
JOIN RESULT r ON s.student_id = r.student_id
WHERE r.subject = 'DBMS'
AND r.marks = (SELECT MAX(marks) FROM RESULT WHERE subject = 'DBMS');

-- 3️⃣ Students whose marks > all students from IT dept (multi-row subquery with ALL)
SELECT s.student_name, r.marks
FROM STUDENT s
JOIN RESULT r ON s.student_id = r.student_id
WHERE r.marks > ALL (
  SELECT r2.marks
  FROM RESULT r2
  JOIN STUDENT s2 ON r2.student_id = s2.student_id
  WHERE s2.department = 'IT'
);

-- 4️⃣ Students not enrolled in any result record (NOT IN)
SELECT *
FROM STUDENT
WHERE student_id NOT IN (SELECT student_id FROM RESULT);

-- 5️⃣ Subjects where "Sneha Joshi" scored > 80 marks (nested subquery)
SELECT subject
FROM RESULT
WHERE student_id = (
  SELECT student_id FROM STUDENT WHERE student_name = 'Sneha Joshi'
)
AND marks > 80;
