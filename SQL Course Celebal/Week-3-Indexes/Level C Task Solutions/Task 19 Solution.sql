-- Task 19: Find the Error in Average Salary Due to Missing 0 Key

-- Create and use database
CREATE DATABASE SalaryDB;
USE SalaryDB;

-- Create the EMPLOYEES table
CREATE TABLE EMPLOYEES (
    EmpID INT,
    Name VARCHAR(50),
    Salary INT       -- Monthly salary
);

-- Insert sample data
INSERT INTO EMPLOYEES (EmpID, Name, Salary) VALUES
(1, 'Alice', 1000),
(2, 'Bob', 2000),
(3, 'Charlie', 3000),
(4, 'David', 4050),
(5, 'Eve', 7500);

-- Compute actual and miscalculated average, then their difference
SELECT CEIL(AVG(Salary) - AVG(CAST(REPLACE(Salary, '0', '') AS UNSIGNED))) AS Average_Error
FROM EMPLOYEES;

-- REPLACE(Salary, '0', '') removes all 0s from the salary value (e.g., 4050 → 45)
    -- CEIL(...) rounds the difference up to the next whole number
