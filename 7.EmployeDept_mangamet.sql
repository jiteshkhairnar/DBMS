CREATE DATABASE EmpDeptDB;
USE EmpDeptDB;

-- Create Department table
CREATE TABLE DEPARTMENT (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50),
  location VARCHAR(50)
);

-- Create Employee table
CREATE TABLE EMPLOYEE (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  salary DECIMAL(10,2),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

-- Insert sample departments
INSERT INTO DEPARTMENT VALUES
(1, 'IT', 'Pune'),
(2, 'HR', 'Mumbai'),
(3, 'Accounts', 'Nashik'),
(4, 'Sales', 'Delhi');

-- Insert sample employees
INSERT INTO EMPLOYEE VALUES
(101, 'Amit', 50000, 1),
(102, 'Sneha', 45000, 2),
(103, 'Raj', 55000, 1),
(104, 'Tina', 40000, 3),
(105, 'Karan', 35000, NULL); -- Not assigned to any dept

-- 1️⃣ INNER JOIN – Employees with their department names
SELECT e.emp_name, e.salary, d.dept_name
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d ON e.dept_id = d.dept_id;

-- 2️⃣ LEFT JOIN – All employees (even without department)
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
LEFT JOIN DEPARTMENT d ON e.dept_id = d.dept_id;

-- 3️⃣ RIGHT JOIN – All departments (even without employees)
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
RIGHT JOIN DEPARTMENT d ON e.dept_id = d.dept_id;

-- 4️⃣ FULL OUTER JOIN (not directly supported in MySQL)
-- Use UNION of LEFT and RIGHT JOIN
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
LEFT JOIN DEPARTMENT d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
RIGHT JOIN DEPARTMENT d ON e.dept_id = d.dept_id;

-- 5️⃣ CROSS JOIN – Cartesian product (all combinations)
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
CROSS JOIN DEPARTMENT d;

-- 6️⃣ JOIN with WHERE condition – Employee names with department location
SELECT e.emp_name, d.location
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id
WHERE d.location = 'Pune';

-- 7️⃣ Employees working in departments located in “Nashik”
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id
WHERE d.location = 'Nashik';

-- 8️⃣ Department-wise total salary using JOIN and aggregation
SELECT d.dept_name, SUM(e.salary) AS Total_Salary
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
