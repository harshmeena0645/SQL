-- Task 15: Find Top 5 Employees According to Salary (Without Using ORDER BY)

-- Create and use database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Create table for employee salary data
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO Employees (EmpID, Name, Salary) VALUES
(1, 'krishna', 70000),
(2, 'prasad', 85000),
(3, 'gokul', 95000),
(4, 'ROHIT', 90000),
(5, 'SUSHANT', 99000),
(6, 'Aditya', 60000),
(7, 'Pankaj', 78000),
(8, 'Tejas', 88000);



-- Top 5 Salaries without using ORDER BY
SELECT EmpID, Name, Salary
FROM (SELECT EmpID, Name, Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk  -- Rank by salary
FROM Employees) AS ranked
WHERE rnk <= 5;

