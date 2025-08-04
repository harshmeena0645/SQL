USE AdventureWorks2022;

-- Drop trigger if it exists
DROP TRIGGER IF EXISTS trg_CheckStockBeforeInsert;
GO

-- Create INSTEAD OF INSERT trigger on SalesOrderDetail
CREATE TRIGGER trg_CheckStockBeforeInsert
ON Sales.SalesOrderDetail
INSTEAD OF INSERT
AS
BEGIN
    -- Step 1: Check for insufficient stock
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN Production.Product p ON i.ProductID = p.ProductID
        WHERE i.OrderQty > p.SafetyStockLevel
    )
    BEGIN
        RAISERROR('Insufficient stock to place order. Order cancelled.', 16, 1);
        RETURN;
    END

    -- Step 2: Insert order details (include required fields)
    INSERT INTO Sales.SalesOrderDetail (
        SalesOrderID,
        CarrierTrackingNumber,
        OrderQty,
        ProductID,
        SpecialOfferID,
        UnitPrice,
        UnitPriceDiscount,
        rowguid,
        ModifiedDate
    )
    SELECT
        SalesOrderID,
        CarrierTrackingNumber,
        OrderQty,
        ProductID,
        SpecialOfferID,
        UnitPrice,
        UnitPriceDiscount,
        NEWID(),
        GETDATE()
    FROM INSERTED;

    -- Step 3: Reduce SafetyStockLevel (used as proxy for stock)
    UPDATE p
    SET p.SafetyStockLevel = p.SafetyStockLevel - i.OrderQty
    FROM Production.Product p
    JOIN INSERTED i ON p.ProductID = i.ProductID;
END;


INSERT INTO Sales.SalesOrderDetail (
    SalesOrderID,
    CarrierTrackingNumber,
    OrderQty,
    ProductID,
    SpecialOfferID,
    UnitPrice,
    UnitPriceDiscount
)
VALUES (50001, 'TRK00123', 2, 707, 1, 20.00, 0.00);
