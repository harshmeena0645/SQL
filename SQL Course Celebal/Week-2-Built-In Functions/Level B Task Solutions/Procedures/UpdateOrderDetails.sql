USE AdventureWorks2022;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS UpdateOrderDetails;
GO

-- Create a procedure to update order details, with optional parameters
CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT = NULL,
    @Discount FLOAT = NULL
AS
BEGIN
    -- Update only non-NULL input values; retain existing values using ISNULL
    UPDATE Sales.SalesOrderDetail
    SET 
        UnitPrice = ISNULL(@UnitPrice, UnitPrice),
        OrderQty = ISNULL(@Quantity, OrderQty),
        UnitPriceDiscount = ISNULL(@Discount, UnitPriceDiscount)
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;
END;
