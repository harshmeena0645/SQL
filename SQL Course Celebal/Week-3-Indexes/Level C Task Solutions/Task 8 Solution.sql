-- Task 8: Pivot the Occupation column in OCCUPATIONS to display names under each occupation

-- Create a new database
CREATE DATABASE OccupationDB;
USE OccupationDB;

-- Create the OCCUPATIONS table
CREATE TABLE OCCUPATIONS 
(
    Name VARCHAR(50),          -- Name of the person
    Occupation VARCHAR(20)     -- Job: Doctor, Professor, Singer, or Actor
);

-- Insert sample data
INSERT INTO OCCUPATIONS (Name, Occupation) VALUES
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashley', 'Professor'),
('Ketty', 'Professor'),
('Christeen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');

-- Pivot the table using JOINs and ROW_NUMBER()
-- Outer SELECT to fetch and order final pivoted result
SELECT * FROM (

    -- First part: Use LEFT JOIN with Doctor as the base table
    SELECT 
        d.Name AS Doctor,             -- Doctor column
        p.Name AS Professor,          -- Professor column
        s.Name AS Singer,             -- Singer column
        a.Name AS Actor,              -- Actor column
        COALESCE(d.rn, p.rn, s.rn, a.rn) AS sort_order  -- Sort key from any available row number
    FROM (
        -- Get Doctor names with row numbers in alphabetical order
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Doctor'
    ) d
    LEFT JOIN (
        -- Get Professor names with row numbers
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Professor'
    ) p ON d.rn = p.rn
    LEFT JOIN (
        -- Get Singer names with row numbers
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Singer'
    ) s ON d.rn = s.rn
    LEFT JOIN (
        -- Get Actor names with row numbers
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Actor'
    ) a ON d.rn = a.rn

    -- UNION with second part: RIGHT JOIN with Professor as the base table
    UNION

    SELECT 
        d.Name AS Doctor,
        p.Name AS Professor,
        s.Name AS Singer,
        a.Name AS Actor,
        COALESCE(d.rn, p.rn, s.rn, a.rn) AS sort_order
    FROM (
        -- Doctors again for RIGHT JOIN
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Doctor'
    ) d
    RIGHT JOIN (
        -- Professors again for RIGHT JOIN base
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Professor'
    ) p ON d.rn = p.rn
    LEFT JOIN (
        -- Singers again
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Singer'
    ) s ON p.rn = s.rn
    LEFT JOIN (
        -- Actors again
        SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
        FROM OCCUPATIONS WHERE Occupation = 'Actor'
    ) a ON p.rn = a.rn

) AS pivoted

-- Final ordering by row index to maintain correct row alignment
ORDER BY pivoted.sort_order;
