-- Task 14: Show Headcounts of Sub Band and Percentage of Headcount
            -- Without using JOIN, SUBQUERY, or INNER QUERY

-- Create and use database
CREATE DATABASE HR_Headcount;
USE HR_Headcount;

-- Create table to store employee sub-band info
CREATE TABLE Employees (
    EmpID INT,               -- Employee ID
    Name VARCHAR(100),       -- Employee Name
    SubBand VARCHAR(10)      -- Employee SubBand (e.g., SB1, SB2)
);

-- Insert sample employee records
INSERT INTO Employees (EmpID, Name, SubBand) VALUES
(1, 'Alice', 'SB1'),
(2, 'Bob', 'SB1'),
(3, 'Charlie', 'SB2'),
(4, 'David', 'SB2'),
(5, 'Eve', 'SB2'),
(6, 'Frank', 'SB3'),
(7, 'Grace', 'SB3'),
(8, 'Heidi', 'SB3');

-- Dsiplay headcount and percentage by SubBand
SELECT 
    SubBand,                            -- SubBand name
    COUNT(*) AS Headcount,              -- Number of employees in the SubBand
    ROUND(100.0 * COUNT(*) / COUNT(*) OVER(), 2) AS Percentage  -- % of total
FROM Employees
GROUP BY SubBand;
