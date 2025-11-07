CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Department Table
CREATE TABLE DEPARTMENT (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(50)
);

-- Employee Table
CREATE TABLE EMPLOYEE (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  status VARCHAR(10) DEFAULT 'Active',
  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

-- Payroll Table (with ON DELETE CASCADE)
CREATE TABLE PAYROLL (
  emp_id INT,
  salary DECIMAL(10,2),
  PRIMARY KEY (emp_id),
  FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id) ON DELETE CASCADE
);

-- 1. Insert sample data
INSERT INTO DEPARTMENT (dept_name) VALUES ('IT'), ('HR'), ('Accounts');

INSERT INTO EMPLOYEE (name, dept_id) VALUES
('Amit', 1), ('Sneha', 2), ('Raj', 1), ('Tina', 3);

INSERT INTO PAYROLL VALUES
(1, 50000), (2, 40000), (3, 60000), (4, 45000);

-- 2. Employees with salary above 45000
SELECT e.name, p.salary
FROM EMPLOYEE e JOIN PAYROLL p ON e.emp_id = p.emp_id
WHERE p.salary > 45000;

-- 3. Update salary (10% increment)
UPDATE PAYROLL SET salary = salary * 1.10;

-- 4. Delete record of resigned employee (Raj)
DELETE FROM EMPLOYEE WHERE name = 'Raj';

-- 5. Total salary paid per department
SELECT d.dept_name, SUM(p.salary) AS Total_Salary
FROM DEPARTMENT d
JOIN EMPLOYEE e ON d.dept_id = e.dept_id
JOIN PAYROLL p ON e.emp_id = p.emp_id
GROUP BY d.dept_name;

-- 6. Employees working in IT department
SELECT e.name
FROM EMPLOYEE e JOIN DEPARTMENT d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 7. Department with maximum employees
SELECT d.dept_name, COUNT(e.emp_id) AS Total
FROM DEPARTMENT d
JOIN EMPLOYEE e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY Total DESC
LIMIT 1;

-- 8. Highest and lowest paid employee
SELECT e.name, p.salary
FROM EMPLOYEE e JOIN PAYROLL p ON e.emp_id = p.emp_id
WHERE p.salary = (SELECT MAX(salary) FROM PAYROLL)
   OR p.salary = (SELECT MIN(salary) FROM PAYROLL);

-- 9. Average salary per department
SELECT d.dept_name, AVG(p.salary) AS Avg_Salary
FROM DEPARTMENT d
JOIN EMPLOYEE e ON d.dept_id = e.dept_id
JOIN PAYROLL p ON e.emp_id = p.emp_id
GROUP BY d.dept_name;
