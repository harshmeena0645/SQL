--Task - Week 8: Stored Procedure to Populate Time Dimension Table for a Full Calendar Year

CREATE DATABASE DateWarehouse;
GO

USE DateWarehouse;
GO

--Create the TimeDimension table
-- This table will hold detailed attributes for each day
CREATE TABLE TimeDimension (
    SKDate INT PRIMARY KEY,                    -- Surrogate key in YYYYMMDD format
    KeyDate DATE,                              -- Actual date
    CalendarDay INT,                           -- Day of the month (1-31)
    CalendarMonth INT,                         -- Month (1-12)
    CalendarQuarter INT,                       -- Quarter of the year (1-4)
    CalendarYear INT,                          -- Year (e.g., 2020)
    DayNameLong VARCHAR(20),                   -- Full name of the weekday (e.g., Monday)
    DayNameShort VARCHAR(10),                  -- Short name of the weekday (e.g., Mon)
    DayNumberOfWeek INT,                       -- Weekday number (1=Sunday, 7=Saturday by default in SQL Server)
    DayNumberOfYear INT,                       -- Day number in the year (1–366)
    DaySuffix VARCHAR(5),                      -- Suffix (1st, 2nd, 3rd, etc.)
    FiscalWeek INT,                            -- Week number of the year
    FiscalPeriod INT,                          -- Month as fiscal period
    FiscalQuarter INT,                         -- Quarter as fiscal quarter
    FiscalYear INT,                            -- Fiscal year (same as calendar year here)
    FiscalYearPeriod VARCHAR(10)               -- Combination of year and month (e.g., 202001)
);


--Create a stored procedure to populate the table
-- Input: Any date from the target year
-- Output: TimeDimension table filled with all dates for that year

CREATE PROCEDURE PopulateTimeDimension
    @InputDate DATE
AS
BEGIN
    -- Extract the year from the input date
    DECLARE @Year INT = YEAR(@InputDate);

    -- Generate all dates of that year using a recursive CTE
    ;WITH DateSequence AS (
        SELECT CAST(CONCAT(@Year, '-01-01') AS DATE) AS DateValue
        UNION ALL
        SELECT DATEADD(DAY, 1, DateValue)
        FROM DateSequence
        WHERE DateValue < CONCAT(@Year, '-12-31')
    )

    -- Insert into TimeDimension in a single INSERT statement (as required)
    INSERT INTO TimeDimension (
        SKDate, KeyDate, CalendarDay, CalendarMonth, CalendarQuarter, CalendarYear,
        DayNameLong, DayNameShort, DayNumberOfWeek, DayNumberOfYear, DaySuffix,
        FiscalWeek, FiscalPeriod, FiscalQuarter, FiscalYear, FiscalYearPeriod
    )
    SELECT 
        CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')) AS SKDate,  -- Format: 20200714
        DateValue AS KeyDate,
        DAY(DateValue) AS CalendarDay,
        MONTH(DateValue) AS CalendarMonth,
        DATEPART(QUARTER, DateValue) AS CalendarQuarter,
        YEAR(DateValue) AS CalendarYear,
        DATENAME(WEEKDAY, DateValue) AS DayNameLong,
        LEFT(DATENAME(WEEKDAY, DateValue), 3) AS DayNameShort,
        DATEPART(WEEKDAY, DateValue) AS DayNumberOfWeek,
        DATEPART(DAYOFYEAR, DateValue) AS DayNumberOfYear,

        -- Generate day suffix (st, nd, rd, th)
        CASE 
            WHEN DAY(DateValue) IN (11,12,13) THEN CAST(DAY(DateValue) AS VARCHAR) + 'th'
            WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR), 1) = '1' THEN CAST(DAY(DateValue) AS VARCHAR) + 'st'
            WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR), 1) = '2' THEN CAST(DAY(DateValue) AS VARCHAR) + 'nd'
            WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR), 1) = '3' THEN CAST(DAY(DateValue) AS VARCHAR) + 'rd'
            ELSE CAST(DAY(DateValue) AS VARCHAR) + 'th'
        END AS DaySuffix,

        DATEPART(WEEK, DateValue) AS FiscalWeek,         -- Week of the year
        MONTH(DateValue) AS FiscalPeriod,                -- Treating month as fiscal period
        DATEPART(QUARTER, DateValue) AS FiscalQuarter,   -- Same as calendar quarter
        YEAR(DateValue) AS FiscalYear,                   -- Treating calendar year as fiscal year
        CAST(YEAR(DateValue) AS VARCHAR) +               -- Format: 202001, 202002...
            RIGHT('0' + CAST(MONTH(DateValue) AS VARCHAR), 2) AS FiscalYearPeriod
    FROM DateSequence
    OPTION (MAXRECURSION 366); -- Allows up to 366 rows (leap year support)
END;


--Call the procedure to populate dates for the input year
-- This will fill the table with all dates for year 2020
EXEC PopulateTimeDimension '2020-07-14';


--View some inserted records to verify the data
SELECT TOP 10 * FROM TimeDimension ORDER BY KeyDate;
