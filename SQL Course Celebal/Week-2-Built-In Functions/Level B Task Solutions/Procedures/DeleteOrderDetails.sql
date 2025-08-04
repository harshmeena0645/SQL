USE AdventureWorks2022;

 -- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS DeleteOrderDetails;
GO

-- Now create the procedure
CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    -- Validate parameters
    IF NOT EXISTS (
        SELECT 1 
        FROM Sales.SalesOrderDetail 
        WHERE SalesOrderID = @OrderID AND ProductID = @ProductID
    )
    BEGIN
        PRINT 'Invalid OrderID or ProductID.';
        RETURN -1;
    END

    -- Delete the order detail
    DELETE FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;
END;
