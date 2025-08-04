-- Task 13: Find Ratio of Cost and Revenue for a Business Unit (BU) Month on Month

-- Create and use the database
CREATE DATABASE BU_Analysis;
USE BU_Analysis;

-- Create the simulation table for BU cost and revenue per month
CREATE TABLE BU_Financials
 (
    BU_Name VARCHAR(50),          -- Business Unit Name
    MonthYear DATE,               -- Transaction month (we’ll extract YEAR-MONTH)
    Cost DECIMAL(12,2),           -- Monthly cost
    Revenue DECIMAL(12,2)         -- Monthly revenue
 );

-- Insert sample records 
INSERT INTO BU_Financials (BU_Name, MonthYear, Cost, Revenue) VALUES
('Tech', '2024-01-01', 500000, 900000),
('Tech', '2024-02-01', 520000, 950000),
('HR', '2024-01-01', 150000, 300000),
('HR', '2024-02-01', 160000, 280000),
('Sales', '2024-01-01', 400000, 800000),
('Sales', '2024-02-01', 420000, 700000);

-- Display BU-wise, month-wise cost/revenue ratio
SELECT 
    BU_Name,
    DATE_FORMAT(MonthYear, '%Y-%m') AS Month,      -- Format as Year-Month
    SUM(Cost) AS Total_Cost,
    SUM(Revenue) AS Total_Revenue,

    -- Cost-to-Revenue Ratio
    ROUND(SUM(Cost) / NULLIF(SUM(Revenue), 0), 2) AS Cost_Revenue_Ratio

FROM BU_Financials
GROUP BY BU_Name, DATE_FORMAT(MonthYear, '%Y-%m')
ORDER BY BU_Name, Month;   -- Use the alias 'Month' from SELECT
