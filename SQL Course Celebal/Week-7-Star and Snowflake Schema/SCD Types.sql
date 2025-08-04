--Task Week 7:- SCD Types using Stored Procedures

CREATE DATABASE SCD_Demo;
GO
USE SCD_Demo;
GO

-- Base dimension table
CREATE TABLE dim_customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    EffectiveDate DATE,
    ExpiryDate DATE,
    IsCurrent BIT,
    PreviousAddress NVARCHAR(255) -- For SCD Type 3 & 6
);

-- Staging table
CREATE TABLE stg_customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100)
);


-- SCD Type 0 — No changes allowed

CREATE PROCEDURE sp_scd_type_0
AS
BEGIN
    -- Only insert new customers; ignore existing ones
    INSERT INTO dim_customer (CustomerID, CustomerName, Address, City, EffectiveDate, ExpiryDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.Address, s.City, GETDATE(), NULL, 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END



-- SCD Type 1 — Overwrite old data

CREATE PROCEDURE sp_scd_type_1
AS
BEGIN
    MERGE dim_customer AS target
    USING stg_customer AS source
    ON target.CustomerID = source.CustomerID
    WHEN MATCHED THEN
        UPDATE SET 
            target.CustomerName = source.CustomerName,
            target.Address = source.Address,
            target.City = source.City
    WHEN NOT MATCHED THEN
        INSERT (CustomerID, CustomerName, Address, City, EffectiveDate, ExpiryDate, IsCurrent)
        VALUES (source.CustomerID, source.CustomerName, source.Address, source.City, GETDATE(), NULL, 1);
END



-- SCD Type 2 — Historical tracking using new row

CREATE PROCEDURE sp_scd_type_2
AS
BEGIN
    -- Expire old records
    UPDATE dim_customer
    SET ExpiryDate = GETDATE(), IsCurrent = 0
    WHERE EXISTS (
        SELECT 1
        FROM stg_customer s
        WHERE s.CustomerID = dim_customer.CustomerID
        AND (s.CustomerName <> dim_customer.CustomerName
             OR s.Address <> dim_customer.Address
             OR s.City <> dim_customer.City)
        AND dim_customer.IsCurrent = 1
    );

    -- Insert new version
    INSERT INTO dim_customer (CustomerID, CustomerName, Address, City, EffectiveDate, ExpiryDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.Address, s.City, GETDATE(), NULL, 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.CustomerID = d.CustomerID AND d.IsCurrent = 1
    WHERE d.CustomerID IS NULL 
          OR s.CustomerName <> d.CustomerName 
          OR s.Address <> d.Address 
          OR s.City <> d.City;
END



--SCD Type 3 — Limited history (1 previous value)

-- Source table
CREATE TABLE dbo.customer_source (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200)
);

-- Target table for SCD Type 3
CREATE TABLE dbo.customer_target_scd3 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    PreviousAddress VARCHAR(200)
);

-- Insert sample source data
INSERT INTO dbo.customer_source (CustomerID, Name, Address)
VALUES (1, 'Krishna', 'Nashik'), (2, 'Rohit', 'Pune');

-- Insert target data
INSERT INTO dbo.customer_target_scd3 (CustomerID, Name, Address, PreviousAddress)
VALUES (1, 'Krishna', 'Mumbai', NULL);



--SCD Type 3 — Limited history (1 previous value)
CREATE OR ALTER PROCEDURE sp_scd_type_3
AS
BEGIN
    MERGE dbo.customer_target_scd3 AS target
    USING dbo.customer_source AS source
    ON target.CustomerID = source.CustomerID
    WHEN MATCHED AND (
        target.Name <> source.Name OR
        target.Address <> source.Address
    ) THEN
        UPDATE SET
            target.PreviousAddress = target.Address,
            target.Address = source.Address,
            target.Name = source.Name

    WHEN NOT MATCHED BY TARGET THEN
        INSERT (CustomerID, Name, Address, PreviousAddress)
        VALUES (source.CustomerID, source.Name, source.Address, NULL);
END;



--SCD Type 4 — Current + Historical Table

-- Historical Table
CREATE TABLE dim_customer_history (
    CustomerID INT,
    CustomerName NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    ArchivedOn DATE
);

GO
CREATE PROCEDURE sp_scd_type_4
AS
BEGIN
    -- Archive changed rows
    INSERT INTO dim_customer_history (CustomerID, CustomerName, Address, City, ArchivedOn)
    SELECT d.CustomerID, d.CustomerName, d.Address, d.City, GETDATE()
    FROM dim_customer d
    INNER JOIN stg_customer s ON d.CustomerID = s.CustomerID
    WHERE s.Address <> d.Address OR s.City <> d.City;

    -- Update current dimension table
    UPDATE dim_customer
    SET 
        CustomerName = s.CustomerName,
        Address = s.Address,
        City = s.City
    FROM stg_customer s
    WHERE dim_customer.CustomerID = s.CustomerID;

    -- Insert new customers
    INSERT INTO dim_customer (CustomerID, CustomerName, Address, City, EffectiveDate, ExpiryDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.Address, s.City, GETDATE(), NULL, 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END


--SCD Type 6 — Combo of Type 1, 2, 3 (aka Hybrid)

CREATE PROCEDURE sp_scd_type_6
AS
BEGIN
    -- Step 1: Expire current record
    UPDATE dim_customer
    SET ExpiryDate = GETDATE(), IsCurrent = 0
    WHERE EXISTS (
        SELECT 1
        FROM stg_customer s
        WHERE s.CustomerID = dim_customer.CustomerID
        AND (s.Address <> dim_customer.Address OR s.City <> dim_customer.City)
        AND dim_customer.IsCurrent = 1
    );

    -- Step 2: Insert new version with previous address
    INSERT INTO dim_customer (CustomerID, CustomerName, Address, City, EffectiveDate, ExpiryDate, IsCurrent, PreviousAddress)
    SELECT 
        s.CustomerID, 
        s.CustomerName, 
        s.Address, 
        s.City, 
        GETDATE(), 
        NULL, 
        1,
        d.Address
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.CustomerID = d.CustomerID AND d.IsCurrent = 1
    WHERE d.CustomerID IS NULL 
        OR s.Address <> d.Address 
        OR s.City <> d.City;
END


    
--To run Each Procedure  
EXEC sp_scd_type_1; -- Replace 1 with 0, 2, 3, 4, or 6 accordingly
