CREATE DATABASE PayrollDB;
USE PayrollDB;

CREATE TABLE DEPARTMENT (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE EMPLOYEE (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  salary DECIMAL(10,2) CHECK (salary > 0),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

CREATE TABLE PAYROLL (
  pay_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT,
  month VARCHAR(20) CHECK (month IN 
    ('January','February','March','April','May','June',
     'July','August','September','October','November','December')),
  FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id)
);

INSERT INTO DEPARTMENT (dept_name) VALUES ('HR'), ('IT'), ('Accounts');
INSERT INTO EMPLOYEE (name, salary, dept_id) VALUES
('Amit', 30000, 1),
('Sneha', 45000, 2);
INSERT INTO PAYROLL (emp_id, month) VALUES
(1, 'January'),
(2, 'February');

CREATE VIEW emp_dept_salary AS
SELECT e.name AS Employee, d.dept_name AS Department, e.salary AS Salary
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id;

CREATE INDEX idx_emp_name ON EMPLOYEE(name);
CREATE VIEW SALARY AS SELECT * FROM PAYROLL;
SELECT * FROM emp_dept_salary;
SELECT * FROM SALARY