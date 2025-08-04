USE AdventureWorks2022;

-- Drop if it already exists
DROP PROCEDURE IF EXISTS InsertOrderDetails;
GO

-- Create procedure to insert order details with validation and stock adjustment
CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT,
    @Discount FLOAT = 0
AS
BEGIN
    DECLARE @Stock INT, @ReorderPoint INT, @DefaultPrice MONEY

    -- Fetch stock, reorder level, and default price for the product
    SELECT @Stock = p.SafetyStockLevel, @ReorderPoint = p.ReorderPoint, @DefaultPrice = p.ListPrice
    FROM Production.Product p WHERE p.ProductID = @ProductID;

    -- Check if enough stock is available
    IF @Stock < @Quantity
    BEGIN
        PRINT 'Not enough stock to place the order. Aborting.'
        RETURN;
    END

    -- If UnitPrice not provided, use default from product table
    IF @UnitPrice IS NULL
        SET @UnitPrice = @DefaultPrice;

    -- Insert new order detail record
    INSERT INTO Sales.SalesOrderDetail (SalesOrderID, ProductID, UnitPrice, OrderQty, UnitPriceDiscount)
    VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount);

    -- Check if insert was successful
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Failed to place the order. Please try again.';
        RETURN;
    END

    -- Subtract ordered quantity from stock level
    UPDATE Production.Product
    SET SafetyStockLevel = SafetyStockLevel - @Quantity
    WHERE ProductID = @ProductID;

    -- Notify if updated stock is below reorder level
    IF EXISTS (
        SELECT 1 FROM Production.Product
        WHERE ProductID = @ProductID AND SafetyStockLevel < ReorderPoint
    )
    BEGIN
        PRINT 'Warning: Stock dropped below reorder level!';
    END
END;
