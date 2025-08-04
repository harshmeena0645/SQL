-- Task 11: Students Whose Best Friends Got Higher Packages

-- Create a new database
CREATE DATABASE StudentPlacementDB;
USE StudentPlacementDB;

-- Create Tables
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(100)
);

CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

-- Step 2: Insert Sample Data

-- Students Table
INSERT INTO Students VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Friends Table
INSERT INTO Friends VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Packages Table
INSERT INTO Packages VALUES
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);

-- Display students whose best friends got higher packages

SELECT s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages sp ON s.ID = sp.ID               -- Salary of student
JOIN Packages fp ON f.Friend_ID = fp.ID        -- Salary of best friend
WHERE fp.Salary > sp.Salary
-- Sort by best friend's salary
ORDER BY fp.Salary;
