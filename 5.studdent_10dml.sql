CREATE DATABASE StudentDB;
USE StudentDB;

-- Student Table
CREATE TABLE STUDENT (
  stud_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  dept VARCHAR(30)
);

-- Subject Table
CREATE TABLE SUBJECT (
  sub_id INT AUTO_INCREMENT PRIMARY KEY,
  sub_name VARCHAR(50)
);

-- Result Table
CREATE TABLE RESULT (
  stud_id INT,
  sub_id INT,
  marks INT,
  PRIMARY KEY (stud_id, sub_id),
  FOREIGN KEY (stud_id) REFERENCES STUDENT(stud_id),
  FOREIGN KEY (sub_id) REFERENCES SUBJECT(sub_id)
);

-- 1. Insert sample data
INSERT INTO STUDENT (name, dept) VALUES
('Amit', 'Computer'),
('Sneha', 'IT'),
('Raj', 'Computer');

INSERT INTO SUBJECT (sub_name) VALUES ('DBMS'), ('OS'), ('CN');

INSERT INTO RESULT VALUES
(1, 1, 85), (1, 2, 78), (1, 3, 90),
(2, 1, 40), (2, 2, 35), (2, 3, 42),
(3, 1, 90), (3, 2, 88), (3, 3, 92);

-- 2. Display total and average marks of each student
SELECT s.name, SUM(r.marks) AS Total, AVG(r.marks) AS Average
FROM STUDENT s JOIN RESULT r ON s.stud_id = r.stud_id
GROUP BY s.name;

-- 3. Show students who failed any subject (marks < 40)
SELECT DISTINCT s.name
FROM STUDENT s JOIN RESULT r ON s.stud_id = r.stud_id
WHERE r.marks < 40;

-- 4. Update marks for revaluation
UPDATE RESULT SET marks = marks + 5 WHERE marks BETWEEN 35 AND 39;

-- 5. Delete records of graduated students (example: dept='IT')
DELETE FROM STUDENT WHERE dept = 'IT';

-- 6. List toppers of each subject
SELECT sub_name, s.name, r.marks
FROM RESULT r
JOIN STUDENT s ON r.stud_id = s.stud_id
JOIN SUBJECT sb ON r.sub_id = sb.sub_id
WHERE r.marks = (
  SELECT MAX(marks) FROM RESULT WHERE sub_id = sb.sub_id
);

-- 7. Students with total marks above 80%
SELECT s.name, SUM(r.marks) AS Total
FROM STUDENT s JOIN RESULT r ON s.stud_id = r.stud_id
GROUP BY s.name
HAVING (SUM(r.marks) / (COUNT(r.sub_id)*100))*100 > 80;

-- 8. Number of students per department
SELECT dept, COUNT(*) AS No_of_Students
FROM STUDENT
GROUP BY dept;

-- 9. Students sorted by total marks
SELECT s.name, SUM(r.marks) AS Total
FROM STUDENT s JOIN RESULT r ON s.stud_id = r.stud_id
GROUP BY s.name
ORDER BY Total DESC;

-- 10. Students who passed all subjects (marks >= 40 in all)
SELECT s.name
FROM STUDENT s
WHERE s.stud_id NOT IN (
  SELECT stud_id FROM RESULT WHERE marks < 40
);