-- Task 6 : Manhattan Distance on a 2D Plane (SQL)

-- Create a new database
CREATE DATABASE LocationDB;
USE LocationDB;

-- Create the STATION table with columns for location data
CREATE TABLE STATION (
    ID INT,
    CITY VARCHAR(21),
    STATE VARCHAR(2),
    LAT_N FLOAT,        -- Northern latitude
    LONG_W FLOAT        -- Western longitude
);

-- Insert sample data into the STATION table
INSERT INTO STATION (ID, CITY, STATE, LAT_N, LONG_W) VALUES
(1, 'New York', 'NY', 40.7128, 74.0060),
(2, 'Los Angeles', 'CA', 34.0522, 118.2437),
(3, 'Chicago', 'IL', 41.8781, 87.6298),
(4, 'Houston', 'TX', 29.7604, 95.3698),
(5, 'Phoenix', 'AZ', 33.4484, 112.0740);


-- Calculate the Manhattan Distance between
-- (min LAT_N, min LONG_W) and (max LAT_N, max LONG_W)

	SELECT 
    -- Manhattan distance rounded to 4 decimal places
    ROUND(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),4) AS Manhattan_Distance
	FROM STATION;

