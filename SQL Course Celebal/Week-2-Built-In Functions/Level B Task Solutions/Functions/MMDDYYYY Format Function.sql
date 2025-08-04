--Function to return date in MM/DD/YYYY format

USE AdventureWorks2022;

-- Drop if it already exists
DROP FUNCTION IF EXISTS fn_FormatDate_MMDDYYYY;


-- Create the function
CREATE FUNCTION fn_FormatDate_MMDDYYYY
(
    @InputDate DATETIME
)
RETURNS VARCHAR(10)
AS
BEGIN
    -- Format style=> MM/DD/YYYY
    RETURN CONVERT(VARCHAR(10), @InputDate, 101);
END;

--output
SELECT dbo.fn_FormatDate_MMDDYYYY('2026-06-15 23:34:05.920') AS FormattedDate;
