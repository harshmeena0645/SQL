-- Task 1: Group tasks into projects based on continuous dates

-- Create a new database and use it
CREATE DATABASE ProjectDB;
USE ProjectDB;

-- Create a table to store task info
CREATE TABLE Projects
 (
    Task_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE
 );

-- Insert task data into Projects table
INSERT INTO Projects (Task_ID, Start_Date, End_Date)
VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');


-- Step 1: Add row numbers to tasks based on start date order
WITH NumberedTasks AS 
(
    SELECT *, ROW_NUMBER() OVER (ORDER BY Start_Date) AS rn
    FROM Projects
),

-- Step 2: Create a group identifier using (Start_Date - row number)
-- This helps to group continuous tasks into the same project
GroupedTasks AS
(
    SELECT *, DATE_SUB(Start_Date, INTERVAL rn DAY) AS grp
    FROM NumberedTasks
),

-- Step 3: Group tasks using the group identifier and find project start/end
ProjectsGrouped AS 
(
    SELECT MIN(Start_Date) AS Project_Start,
		   MAX(End_Date) AS Project_End,
		   DATEDIFF(MAX(End_Date), MIN(Start_Date)) AS Duration
    FROM GroupedTasks
    GROUP BY grp
)

-- Step 4: Get final output sorted by duration and project start date
SELECT Project_Start, Project_End
FROM ProjectsGrouped
ORDER BY Duration, Project_Start;

