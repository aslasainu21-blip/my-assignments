DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE departments(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE location(
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE employees(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender ENUM('M','F'),
    age INT CHECK(age >= 18),
    hire_date DATE DEFAULT(CURRENT_DATE),
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

ALTER TABLE employees ADD COLUMN email VARCHAR(100);
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(200);
ALTER TABLE employees DROP COLUMN age;
ALTER TABLE employees CHANGE hire_date date_of_joining DATE;

RENAME TABLE departments TO Departments_Info;
RENAME TABLE location TO Locations;

TRUNCATE TABLE employees;

SHOW TABLES;
DESCRIBE employees;

SET SQL_SAFE_UPDATES = 0;

SELECT DISTINCT salary FROM Employees;

SELECT date_of_joining AS Employee_Date, salary AS Employee_Salary FROM Employees;

SELECT * FROM Employees 
WHERE salary > 50000 AND date_of_joining < '2016-01-01';

UPDATE Employees 
SET designation = 'Data Scientist' 
WHERE designation IS NULL OR designation = '';

SELECT * FROM Employees 
ORDER BY department_id ASC, salary DESC;

SELECT * FROM Employees 
WHERE YEAR(date_of_joining) = 2018 
LIMIT 5;

SELECT SUM(salary) AS Total_Salary 
FROM Employees 
WHERE department_id = (SELECT department_id FROM Departments WHERE department_name = 'Finance');

SELECT MIN(age) AS Min_Age FROM Employees;

SELECT location_id, MAX(salary) AS Max_Salary 
FROM Employees 
GROUP BY location_id;

SELECT designation, AVG(salary) AS Avg_Salary 
FROM Employees 
WHERE designation LIKE '%Analyst%' 
GROUP BY designation;

SELECT department_id, COUNT(*) AS Emp_Count 
FROM Employees 
GROUP BY department_id 
HAVING COUNT(*) < 3;

SELECT location_id, AVG(age) AS Avg_Age 
FROM Employees 
WHERE gender = 'F' 
GROUP BY location_id 
HAVING AVG(age) < 30;

SELECT e.employee_name, e.designation, d.department_name 
FROM Employees e 
INNER JOIN Departments d ON e.department_id = d.department_id;

SELECT d.department_name, COUNT(e.employee_id) AS Total_Employees 
FROM Departments d 
LEFT JOIN Employees e ON d.department_id = e.department_id 
GROUP BY d.department_name;

SELECT l.location_name, e.employee_name AS Employee_Name 
FROM Employees e 
RIGHT JOIN Locations l ON e.location_id = l.location_id;
