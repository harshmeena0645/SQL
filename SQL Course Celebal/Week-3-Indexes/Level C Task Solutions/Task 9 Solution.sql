-- Task 9 : Classify Binary Tree Node Types as Root, Inner, or Leaf

-- Create a new database
CREATE DATABASE BinaryTreeDB;
USE BinaryTreeDB;

-- Create the BST table
CREATE TABLE BST (
    N INT,    -- Node value
    P INT     -- Parent value
);

-- Insert sample data into the BST table
INSERT INTO BST (N, P) VALUES
(1, 2),
(3, 2),
(6, 8),
(9, 8),
(2, 5),
(8, 5),
(5, NULL);

-- Classify each node as Root, Inner, or Leaf
SELECT N,
		CASE 
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
		END AS NodeType
		FROM BST
ORDER BY N;
