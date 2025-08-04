--Function to return date in YYYYMMDD format

USE AdventureWorks2022;

-- Drop if it already exists
DROP FUNCTION IF EXISTS fn_FormatDate_YYYYMMDD;


-- Create the function
CREATE FUNCTION fn_FormatDate_YYYYMMDD
(
    @InputDate DATETIME
)
RETURNS VARCHAR(8)
AS
BEGIN
    -- Format using style 112 => YYYYMMDD
    RETURN CONVERT(VARCHAR(8), @InputDate, 112);
END;

-- Output
SELECT dbo.fn_FormatDate_YYYYMMDD('2026-05-21 23:34:05.920') AS FormattedDate;

