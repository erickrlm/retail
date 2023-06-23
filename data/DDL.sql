-- SQL Server 17
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'retail')
BEGIN
    CREATE DATABASE retail;
END;
GO


-- Table #1 product"
USE retail;
IF OBJECT_ID(N'dbo.product', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.product 
        (id_prod INT NOT NULL PRIMARY KEY,
        id_cat INT NOT NULL); 
END;
GO

-- Table #2 "sales"
IF OBJECT_ID(N'dbo.sales', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.sales 
        (id_cte VARCHAR(10) NOT NULL,
        id_prod INT NOT NULL
        FOREIGN KEY (id_prod) REFERENCES product(id_prod)); 
END;
GO

-- Table #3 "offers"
IF OBJECT_ID(N'dbo.offers', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.offers 
        (id_offer INT NOT NULL PRIMARY KEY,
        offer_desc VARCHAR(10) NOT NULL); 
END;
GO
