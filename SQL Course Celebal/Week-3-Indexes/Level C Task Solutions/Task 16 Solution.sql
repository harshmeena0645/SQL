-- Task 16: Swap Values of Two Columns Without Using a Third Variable or Table

-- Create and use the database
CREATE DATABASE SwapDB;
USE SwapDB;

-- Create a table with two columns to swap
CREATE TABLE SampleData (
    ID INT,
    ColumnA INT,
    ColumnB INT
);

-- Insert sample values
INSERT INTO SampleData (ID, ColumnA, ColumnB) VALUES
(1, 10, 20),
(2, 30, 40),
(3, 50, 60);

-- Swap values of ColumnA and ColumnB without using third column
UPDATE SampleData SET 
    ColumnA = ColumnA + ColumnB,     -- ColumnA = A + B
    ColumnB = ColumnA - ColumnB,     -- ColumnB = (A + B) - B = A
    ColumnA = ColumnA - ColumnB;     -- ColumnA = (A + B) - A = B

-- View the final swapped data
SELECT * FROM SampleData;
