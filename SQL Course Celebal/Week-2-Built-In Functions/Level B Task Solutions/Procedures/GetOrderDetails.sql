USE AdventureWorks2022;
-- Drop if it already exists
DROP PROCEDURE IF EXISTS GetOrderDetails;
GO

-- Now create the procedure
CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    -- Check if the order exists
    IF NOT EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE SalesOrderID = @OrderID)
    BEGIN
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR) + ' does not exist.';
        RETURN 1;
    END

    -- If exists, return the order details
    SELECT * 
    FROM Sales.SalesOrderDetail 
    WHERE SalesOrderID = @OrderID;
END;
