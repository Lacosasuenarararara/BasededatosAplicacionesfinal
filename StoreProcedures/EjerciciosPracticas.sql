CREATE DATABASE AlmacenDeDatos;
USE AlmacenDeDatos;

Create TABLE Suppliers (
    SupplierId INT IDENTITY(1,1) PRIMARY KEY,
    SupplierDB int not null,
    CompanyName VARCHAR(40),
    Country VARCHAR(15),
    Address VARCHAR(60),
    City VARCHAR(15)
);


CREATE TABLE Customers (
    ClientId INT IDENTITY(1,1) PRIMARY KEY,
    ClientDB int not null,
    CompanyName VARCHAR(40),
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    Country VARCHAR(15)
);

CREATE TABLE Employees (
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeDB Int not null,
    FullName VARCHAR(110),
    Title VARCHAR(30),
    HireDate DATE,
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    Country VARCHAR(15)
);


CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductDB Int not null,
    ProductName VARCHAR(40),
    CategoryName VARCHAR(15)
);

CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT,
    EmployeeId INT,
    OrderDate DATE,
    FOREIGN KEY (ClientId) REFERENCES Customers(ClientId),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);

CREATE TABLE Ventas (
    VentaId INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT,
    ProductId INT,
    EmployeeId INT,
    SupplierId INT,
    Quantity INT,
    UnitPrice Money,
    FOREIGN KEY (ClientId) REFERENCES Customers(ClientId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId),
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId)
);


--Insertar o actualizar registros en las tablas

-- Para la tabla Products
CREATE PROCEDURE sp_InsertOrUpdateProducto
    @ProductDB INT,
    @ProductName VARCHAR(40),
    @CategoryName VARCHAR(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE ProductDB = @ProductDB)
    BEGIN
        UPDATE Products
        SET ProductName = @ProductName,
            CategoryName = @CategoryName
        WHERE ProductDB = @ProductDB;
    END
    ELSE
    BEGIN
        INSERT INTO Products (ProductDB, ProductName, CategoryName)
        VALUES (@ProductDB, @ProductName, @CategoryName);
    END
END;

-- Para la tabla Suppliers
CREATE PROCEDURE sp_InsertOrUpdateSupplier 
    @SupplierDB INT,
    @CompanyName VARCHAR(40),
    @Country VARCHAR(15),
    @Address VARCHAR(60),
    @City VARCHAR(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Suppliers WHERE SupplierDB = @SupplierDB)
    BEGIN
        UPDATE Suppliers
        SET CompanyName = @CompanyName,
            Country = @Country,
            Address = @Address,
            City = @City
        WHERE SupplierDB = @SupplierDB;
    END
    ELSE
    BEGIN
        INSERT INTO Suppliers (SupplierDB, CompanyName, Country, Address, City)
        VALUES (@SupplierDB, @CompanyName, @Country, @Address, @City);
    END
END;

-- Para la tabla Customers
CREATE PROCEDURE sp_InsertOrUpdateCustomer 
    @ClientDB INT,
    @CompanyName VARCHAR(40),
    @Address VARCHAR(60),
    @City VARCHAR(15),
    @Region VARCHAR(15),
    @Country VARCHAR(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE ClientDB = @ClientDB)
    BEGIN
        UPDATE Customers
        SET CompanyName = @CompanyName,
            Address = @Address,
            City = @City,
            Region = @Region,
            Country = @Country
        WHERE ClientDB = @ClientDB;
    END
    ELSE
    BEGIN
        INSERT INTO Customers (ClientDB, CompanyName, Address, City, Region, Country)
        VALUES (@ClientDB, @CompanyName, @Address, @City, @Region, @Country);
    END
END;

-- Para la tabla Employees
CREATE PROCEDURE sp_InsertOrUpdateEmployee 
    @EmployeeDB INT,
    @FullName VARCHAR(110),
    @Title VARCHAR(30),
    @HireDate DATE,
    @Address VARCHAR(60),
    @City VARCHAR(15),
    @Region VARCHAR(15),
    @Country VARCHAR(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeDB = @EmployeeDB)
    BEGIN
        UPDATE Employees
        SET FullName = @FullName,
            Title = @Title,
            HireDate = @HireDate,
            Address = @Address,
            City = @City,
            Region = @Region,
            Country = @Country
        WHERE EmployeeDB = @EmployeeDB;
    END
    ELSE
    BEGIN
        INSERT INTO Employees (EmployeeDB, FullName, Title, HireDate, Address, City, Region, Country)
        VALUES (@EmployeeDB, @FullName, @Title, @HireDate, @Address, @City, @Region, @Country);
    END
END;

--Crear un procedimiento almacenado para actualizar la tabla Ventas
CREATE PROCEDURE sp_UpdateVentas
    @VentaId INT,
    @ClientId INT,
    @ProductId INT,
    @EmployeeId INT,
    @SupplierId INT,
    @Quantity INT,
    @UnitPrice MONEY
AS
BEGIN
    UPDATE Ventas
    SET ClientId = @ClientId,
        ProductId = @ProductId,
        EmployeeId = @EmployeeId,
        SupplierId = @SupplierId,
        Quantity = @Quantity,
        UnitPrice = @UnitPrice
    WHERE VentaId = @VentaId;
END;

-- Crear un procedimiento almacenado para visualizar cuántas órdenes se han hecho por año y país
CREATE PROCEDURE sp_CountOrdersByYearAndCountry
AS
BEGIN
    SELECT 
        YEAR(o.OrderDate) AS 'Año',
        c.Country AS 'País',
        COUNT(*) AS 'TotalOrdenes'
    FROM Orders o
    JOIN Customers c ON o.ClientId = c.ClientId
    GROUP BY YEAR(o.OrderDate), c.Country
    ORDER BY 'Año', c.Country;
END;

exec sp_CountOrdersByYearAndCountry 
--Crear un procedimiento almacenado para obtener el total de ventas agrupado por proveedor y un rango de fechas
ALTER TABLE Ventas
ADD OrderDate DATE;

CREATE PROCEDURE sp_TotalSalesBySupplierAndDateRange
    @StartDate varchar,
    @EndDate varchar
AS
BEGIN
    SELECT 
        s.CompanyName AS 'Proveedor',
		v.OrderDate AS 'Fecha',
        SUM(v.Quantity * v.UnitPrice) AS 'Totalventas'
    FROM Ventas v
    JOIN Suppliers s ON v.SupplierId = s.SupplierId
    WHERE v.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY s.CompanyName;
END;