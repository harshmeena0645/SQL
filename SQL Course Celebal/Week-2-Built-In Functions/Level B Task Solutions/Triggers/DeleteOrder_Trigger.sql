USE AdventureWorks2022;
--List existing triggers on the table
SELECT t.name AS TriggerName, s.name AS SchemaName
FROM sys.triggers t
JOIN sys.objects o ON t.parent_id = o.object_id
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE o.name = 'SalesOrderHeader';

--Drop the trigger 
DROP TRIGGER IF EXISTS Sales.uSalesOrderHeader;ahi

DROP TRIGGER IF EXISTS Sales.trg_DeleteSalesOrder;

--create your trigger
CREATE TRIGGER trg_DeleteSalesOrder
ON Sales.SalesOrderHeader
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM Sales.SalesOrderDetail
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);

    DELETE FROM Sales.SalesOrderHeader
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);
END;
