-- Task 2 : Find Students Whose Best Friend Got a Higher Salary

-- Create a database
CREATE DATABASE StudentSalaryDB;
USE StudentSalaryDB;


-- Create Students table
CREATE TABLE Students
 (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
 );

-- Create Friends table (each student has one best friend)
CREATE TABLE Friends
 (
    ID INT,
    Friend_ID INT
 );

-- Create Packages table to store salary offers
CREATE TABLE Packages
 (
    ID INT,
    Salary FLOAT
 );

-- Insert data into Students table
INSERT INTO Students VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Insert data into Friends table
INSERT INTO Friends VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Insert data into Packages table
INSERT INTO Packages VALUES
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);


-- Display Names of students whose best friend got a higher salary
SELECT S.Name
FROM Students S
JOIN Friends F ON S.ID = F.ID
JOIN Packages SP ON S.ID = SP.ID           -- Salary of the student
JOIN Packages FP ON F.Friend_ID = FP.ID    -- Salary of the friend
WHERE FP.Salary > SP.Salary                -- Only if friend's salary is higher
ORDER BY FP.Salary;

