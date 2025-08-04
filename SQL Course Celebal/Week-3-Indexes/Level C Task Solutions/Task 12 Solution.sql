-- Task 12: Cost Ratio by Job Family – India vs International

-- Create and use the database
CREATE DATABASE JobFamilyDB;
USE JobFamilyDB;

-- Create the main table
CREATE TABLE JobFamilyCosts (
    JobFamily VARCHAR(100),     
    Location VARCHAR(20),       
    Cost DECIMAL(12,2)          
);

-- Insert sample data
INSERT INTO JobFamilyCosts (JobFamily, Location, Cost) VALUES
('Software Engineering', 'India', 500000),
('Software Engineering', 'International', 1500000),
('Data Science', 'India', 400000),
('Data Science', 'International', 600000),
('HR', 'India', 300000),
('HR', 'International', 200000);


-- Calculate cost ratio (percentage) for India and International
SELECT 
    JobFamily,  -- Job category

    -- Cost share percentage from India
    ROUND(100 * SUM(CASE WHEN Location = 'India' THEN Cost ELSE 0 END) / SUM(Cost),2) AS India_Percent,

    -- Cost share percentage from International
    ROUND(100 * SUM(CASE WHEN Location = 'International' THEN Cost ELSE 0 END) / SUM(Cost),2) AS International_Percent

FROM JobFamilyCosts
GROUP BY JobFamily;
