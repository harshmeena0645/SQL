-- Task 4: Contest Stats Aggregation from Screening Challenges

-- Create the Database
CREATE DATABASE ContestStatsDB;
USE ContestStatsDB;

-- 1. Contests Table
CREATE TABLE Contests
 (
    contest_id INT,
    hacker_id INT,
    name VARCHAR(50)
 );

INSERT INTO Contests VALUES
(66406, 17973, 'Rose'),
(66556, 79135, 'Angela'),
(94828, 80275, 'Frank');

-- 2. Colleges Table
CREATE TABLE Colleges
 (
    college_id INT,
    contest_id INT
 );

INSERT INTO Colleges VALUES
(11219, 66406),
(32473, 66556),
(56885, 94828);

-- 3. Challenges Table
CREATE TABLE Challenges
 (
    challenge_id INT,
    college_id INT
 );

INSERT INTO Challenges VALUES
(18765, 11219),
(47127, 11219),
(60292, 32473),
(72974, 56885);

-- 4. View_Stats Table
CREATE TABLE View_Stats
 (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
 );

INSERT INTO View_Stats VALUES
(47127, 26, 19),
(47127, 15, 14),
(18765, 43, 10),
(18765, 72, 13),
(75516, 35, 17),
(60292, 11, 10),
(72974, 41, 15),
(75516, 75, 11);

-- 5. Submission_Stats Table
CREATE TABLE Submission_Stats 
(
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

INSERT INTO Submission_Stats VALUES
(75516, 34, 12),
(47127, 27, 10),
(47127, 56, 18),
(75516, 74, 12),
(75516, 83, 8),
(72974, 99, 24),
(72974, 82, 14),
(47127, 28, 11);

-- 6. Display Contest Stats
SELECT 
    C.contest_id,
    C.hacker_id,
    C.name,
    SUM(S.total_submissions) AS total_submissions,
    SUM(S.total_accepted_submissions) AS total_accepted_submissions,
    SUM(V.total_views) AS total_views,
    SUM(V.total_unique_views) AS total_unique_views
FROM Contests C
JOIN Colleges Co ON C.contest_id = Co.contest_id
JOIN Challenges Ch ON Ch.college_id = Co.college_id
LEFT JOIN View_Stats V ON V.challenge_id = Ch.challenge_id
LEFT JOIN Submission_Stats S ON S.challenge_id = Ch.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING 
    SUM(S.total_submissions) IS NOT NULL OR
    SUM(S.total_accepted_submissions) IS NOT NULL OR
    SUM(V.total_views) IS NOT NULL OR
    SUM(V.total_unique_views) IS NOT NULL
ORDER BY C.contest_id;
