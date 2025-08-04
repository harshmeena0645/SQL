-- Task 20: Copy New Data from One Table to Another (No Indicator Column)

-- Create and use a database
CREATE DATABASE CopyDataDB;
USE CopyDataDB;

-- Create source table
CREATE TABLE SourceTable
 (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
 );

-- Create target table (same structure)
CREATE TABLE TargetTable (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
);

-- Insert sample data into source (includes both old and new)
INSERT INTO SourceTable VALUES 
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 55000);  -- ← New record

-- Insert old data into target (already copied earlier)
INSERT INTO TargetTable VALUES 
(1, 'Alice', 50000),
(2, 'Bob', 60000);


-- Insert only those rows from SourceTable that do NOT exist in TargetTable
INSERT INTO TargetTable (EmpID, Name, Salary)
SELECT s.EmpID, s.Name, s.Salary
FROM SourceTable s
WHERE NOT EXISTS
 (
    SELECT 1 
    FROM TargetTable t 
    WHERE t.EmpID = s.EmpID
);
