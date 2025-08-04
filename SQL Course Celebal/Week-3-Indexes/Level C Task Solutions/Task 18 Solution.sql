-- Task 18 : Find Weighted Average Cost of Employees Month-on-Month in a Business Unit (BU)

-- Create and use the database
CREATE DATABASE BUCostDB;
USE BUCostDB;

-- Create table for storing monthly cost data
CREATE TABLE BU_EmployeeCost 
(
    BU_Name VARCHAR(50),        	
    MonthYear DATE,            
    CostPerEmployee DECIMAL(10,2),  
    Headcount INT              
);

-- Insert sample data
INSERT INTO BU_EmployeeCost (BU_Name, MonthYear, CostPerEmployee, Headcount) VALUES
('Tech', '2024-01-01', 50000, 10),
('Tech', '2024-01-01', 70000, 5),
('Tech', '2024-02-01', 60000, 12),
('HR', '2024-01-01', 40000, 6),
('HR', '2024-02-01', 45000, 8),
('Sales', '2024-01-01', 55000, 7),
('Sales', '2024-02-01', 53000, 10);

-- Calculate weighted average cost per month per BU
SELECT BU_Name,DATE_FORMAT(MonthYear, '%Y-%m') AS Month,
    -- Total cost = cost per employee × headcount
    ROUND(SUM(CostPerEmployee * Headcount) / SUM(Headcount), 2) AS Weighted_Avg_Cost

FROM BU_EmployeeCost
GROUP BY BU_Name, DATE_FORMAT(MonthYear, '%Y-%m')
ORDER BY BU_Name, Month;
