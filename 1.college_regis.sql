CREATE DATABASE College;
USE College;

CREATE TABLE STUDENT (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50) UNIQUE,
  age INT CHECK (age >= 18)
);

CREATE TABLE COURSE (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(50)
);

CREATE TABLE ENROLLMENT (
  enroll_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
  FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

INSERT INTO STUDENT (name, email, age) VALUES
('Amit', 'amit@gmail.com', 20),
('Sneha', 'sneha@gmail.com', 19);

INSERT INTO COURSE (course_name) VALUES
('DBMS'), ('OS'), ('CN');

INSERT INTO ENROLLMENT (student_id, course_id) VALUES
(1, 1), (2, 2);

CREATE VIEW student_course_view AS
SELECT s.name AS Student_Name, c.course_name AS Course_Name
FROM STUDENT s
JOIN ENROLLMENT e ON s.student_id = e.student_id
JOIN COURSE c ON e.course_id = c.course_id;

CREATE INDEX idx_course_name ON COURSE(course_name);
CREATE VIEW STUD AS SELECT * FROM STUDENT;

SELECT * FROM student_course_view;
SELECT * FROM STUD;
