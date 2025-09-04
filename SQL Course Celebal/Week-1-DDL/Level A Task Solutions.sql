 USE AdventureWorks2022;
 



-- 9. List of customers who never placed an order
SELECT c.CustomerID, p.FirstName, p.LastName
FROM Sales.Customer c
JOIN Person.Person p ON p.BusinessEntityID = c.PersonID
WHERE c.CustomerID NOT IN (
    SELECT DISTINCT CustomerID FROM Sales.SalesOrderHeader
);



-- 11. Details of the first order in the system (by date)
SELECT TOP 1 *
FROM Sales.SalesOrderHeader
ORDER BY OrderDate ASC;



-- 13. For each order, get the OrderID and average quantity of items in that order
SELECT SalesOrderID, AVG(OrderQty) AS AverageQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;



-- 15. List all managers and how many employees report to them
SELECT Manager.BusinessEntityID AS ManagerID,
       p.FirstName + ' ' + p.LastName AS ManagerName,
       COUNT(e.BusinessEntityID) AS ReportCount
FROM HumanResources.Employee e
JOIN HumanResources.Employee Manager
  ON e.OrganizationNode.GetAncestor(1) = Manager.OrganizationNode
JOIN Person.Person p ON Manager.BusinessEntityID = p.BusinessEntityID
GROUP BY Manager.BusinessEntityID, p.FirstName, p.LastName
HAVING COUNT(e.BusinessEntityID) > 0;


-- 16. Orders with total quantity > 300
SELECT SalesOrderID, SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) > 300;



-- 19. Orders with TotalDue > 200
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 200;


-- 20. List of countries and total sales made in each country
SELECT cr.Name AS Country, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY cr.Name
ORDER BY TotalSales DESC;


-- 21. Customer Contact Name and number of orders placed
SELECT p.FirstName + ' ' + p.LastName AS ContactName, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY p.FirstName, p.LastName;


-- 22. Customer Contact Names who have placed more than 3 orders
SELECT p.FirstName + ' ' + p.LastName AS ContactName, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 3;


-- 23. Discontinued products ordered between 1/1/1997 and 1/1/1998
SELECT DISTINCT p.ProductID, p.Name
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE p.SellEndDate IS NOT NULL
  AND soh.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';


-- 24. Employee FirstName, LastName with Supervisor FirstName, LastName
SELECT 
    e1.BusinessEntityID AS EmployeeID,
    p1.FirstName AS EmployeeFirstName,
    p1.LastName AS EmployeeLastName,
    p2.FirstName AS SupervisorFirstName,
    p2.LastName AS SupervisorLastName
FROM HumanResources.Employee e1
JOIN HumanResources.Employee e2 ON e1.OrganizationNode.GetAncestor(1) = e2.OrganizationNode
JOIN Person.Person p1 ON e1.BusinessEntityID = p1.BusinessEntityID
JOIN Person.Person p2 ON e2.BusinessEntityID = p2.BusinessEntityID;


-- 25. Employee ID and total sales conducted by them
SELECT SalesPersonID AS EmployeeID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID;




-- 27. Managers with more than 4 direct reports
SELECT Manager.BusinessEntityID AS ManagerID, COUNT(e.BusinessEntityID) AS ReportCount
FROM HumanResources.Employee e
JOIN HumanResources.Employee Manager ON e.OrganizationNode.GetAncestor(1) = Manager.OrganizationNode
GROUP BY Manager.BusinessEntityID
HAVING COUNT(e.BusinessEntityID) > 4;

-- 28. Orders and their associated Product Names
SELECT sod.SalesOrderID, p.Name AS ProductName
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID;


-- 29. Orders placed by the best (most frequent) customer

-- Drop the temp table if it already exists
DROP TABLE IF EXISTS #BestCustomer;

-- Create temp table with the most frequent customer
SELECT TOP 1 CustomerID
INTO #BestCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY COUNT(*) DESC;

-- Get orders placed by that customer
SELECT soh.SalesOrderID, soh.OrderDate
FROM Sales.SalesOrderHeader soh
JOIN #BestCustomer bc ON soh.CustomerID = bc.CustomerID;


-- 30. Orders by customers who do not have a Fax number
SELECT soh.SalesOrderID, p.FirstName, p.LastName
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE c.PersonID NOT IN (
    SELECT BusinessEntityID FROM Person.PersonPhone WHERE PhoneNumberTypeID = 4
);


-- 31. Postal codes where the product 'Tofu' was shipped
SELECT DISTINCT a.PostalCode
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE p.Name LIKE '%Tofu%';


-- 32. Product names that were shipped to France
SELECT DISTINCT p.Name
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE cr.Name = 'France';


-- 33. Product names and categories for the supplier 'Specialty Biscuits, Ltd.'
SELECT p.Name AS ProductName, pc.Name AS Category
FROM Production.Product p
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE v.Name = 'Specialty Biscuits, Ltd.';


-- 34. Products that were never ordered
SELECT p.Name
FROM Production.Product p
WHERE p.ProductID NOT IN (
    SELECT DISTINCT ProductID FROM Sales.SalesOrderDetail
);


-- 35. Products with units in stock < 10 and units on order = 0
SELECT Name
FROM Production.Product
WHERE SafetyStockLevel < 10 AND ReorderPoint = 0;


-- 36. Top 10 countries by sales
SELECT TOP 10 cr.Name AS Country, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY cr.Name
ORDER BY TotalSales DESC;


-- 37. Number of orders taken by employees for customers with IDs between 'A' and 'AO'
-- Note: CustomerID is numeric. This question may be meant for Store names or Account numbers.
-- If AccountNumber is like 'AW00000001', we filter accordingly:
SELECT SalesPersonID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
WHERE c.AccountNumber BETWEEN 'AW00000001' AND 'AW000000AO'
GROUP BY SalesPersonID;


-- 38. Order date of the most expensive order
SELECT TOP 1 OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;


-- 39. Product name and total revenue from that product
SELECT p.Name AS ProductName, SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;


-- 40. SupplierID and number of products they offer
SELECT BusinessEntityID AS SupplierID, COUNT(ProductID) AS ProductCount
FROM Purchasing.ProductVendor
GROUP BY BusinessEntityID;


-- 41. Top 10 customers based on total spending
SELECT TOP 10 CustomerID, SUM(TotalDue) AS TotalSpent
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalSpent DESC;



