-- Task 3 : Find all symmetric pairs from Functions table

-- Create the database
CREATE DATABASE SymmetricPairsDB;
USE SymmetricPairsDB;

-- Create the Functions table
CREATE TABLE Functions
 (
    X INT,
    Y INT
 );

-- Insert sample data
INSERT INTO Functions VALUES
(20, 20),
(20, 20),
(20, 21),
(23, 22),
(22, 23),
(21, 20);

-- Find symmetric pairs
SELECT DISTINCT F1.X, F1.Y
FROM Functions F1
JOIN Functions F2
ON F1.X = F2.Y AND F1.Y = F2.X  -- check for reverse pair
WHERE F1.X <= F1.Y                -- avoid duplicate output (e.g. show only 20 21 not 21 20)
ORDER BY F1.X;
