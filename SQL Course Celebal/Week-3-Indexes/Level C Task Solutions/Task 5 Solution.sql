-- Task 5: Daily Submissions Summary by Hackers

-- Create the database
CREATE DATABASE HackerContestDB;
USE HackerContestDB;

-- Create the Hackers table
CREATE TABLE Hackers
 (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(50)
 );

-- Create the Submissions table
CREATE TABLE Submissions
 (
    submission_date DATE,
    submission_id INT,
    hacker_id INT,
    score INT
 );

-- Insert data into Hackers
INSERT INTO Hackers VALUES
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

-- Step 5: Insert data into Submissions
INSERT INTO Submissions VALUES
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 42769, 79722, 25),
('2016-03-02', 44364, 79722, 60),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 45),
('2016-03-05', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-05', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);

SELECT S.submission_date, H.hacker_id, H.name
FROM (
    SELECT 
        submission_date,
        hacker_id,
        COUNT(*) AS submission_count
    FROM Submissions
    GROUP BY submission_date, hacker_id
) AS S
JOIN (
    SELECT 
        submission_date,
        MIN(hacker_id) AS hacker_id
    FROM (
        SELECT 
            submission_date,
            hacker_id,
            COUNT(*) AS submission_count,
            RANK() OVER (PARTITION BY submission_date ORDER BY COUNT(*) DESC, hacker_id ASC) AS rnk
        FROM Submissions
        GROUP BY submission_date, hacker_id
    ) ranked
    WHERE rnk = 1
    GROUP BY submission_date
) AS MaxSubmitter
ON S.submission_date = MaxSubmitter.submission_date AND S.hacker_id = MaxSubmitter.hacker_id
JOIN Hackers H ON H.hacker_id = S.hacker_id
GROUP BY S.submission_date, H.hacker_id, H.name
ORDER BY S.submission_date;