--Declaracion de variables
use Northwind; 

DECLARE @x int 
SET @x=10
PRINT 'El valor de x es: ' + CAST(@x as VARCHAR)
IF @x >=0
 BEGIN
    PRINT 'El numero es positivo'
    END
ELSE
 BEGIN
    PRINT 'El numero es negativo'
    END
DECLARE @i as INT
SET @i=1
WHILE(@i<=10)
BEGIN
    PRINT CAST(@i as VARCHAR)
    set @i=@i+1
END

--Crear un sp
CREATE PROCEDURE procedure_ciclo
AS
BEGIN
    DECLARE @i as INT
    SET @i=1
    WHILE(@i<=10)
    BEGIN
        PRINT CAST(@i as VARCHAR)
        set @i=@i+1
    END
END;
------------------------------
DECLARE @ii int=1

while @ii <=2
BEGIN
EXEC procedure_ciclo
set @ii=@ii + 1
END

--Realizar un sp que sume dos numeros cualquiera y que imprima el resultado
CREATE PROCEDURE sp_suma1
AS
  BEGIN
    DECLARE @sum INT
    set @sum = 4+5

    print 'la suma es: ' + CAST(@sum as VARCHAR)
    END

EXEC sp_suma1

-----------------------------------
ALTER PROCEDURE sp_suma1
@n1 as INT,
@n2 as INT
AS
  BEGIN
    DECLARE @sum INT
    set @sum = @n1 + @n2

    print 'la suma es: ' + CAST(@sum as VARCHAR)
    END


EXEC sp_suma1 5,8
--Tarea realizar un sp que muestre todas las ventas realizadas por cliente para un año cualquiera

select c.CompanyName as 'Nombre del Cliente', 
Sum(od.Quantity * od.UnitPrice) as 'Total' 
from customers as c
INNER JOIN orders as o 
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
where DATEPART(YEAR,o.OrderDate) = 1996
GROUP BY c.CompanyName;


CREATE OR ALTER PROC sp_ventasporcliente
   --Parametros
   @year as int 
AS   
BEGIN
   select c.CompanyName as 'Nombre del Cliente', 
    Sum(od.Quantity * od.UnitPrice) as 'Total' 
    from customers as c
    INNER JOIN orders as o 
    ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] as od
    on od.OrderID = o.OrderID
    where DATEPART(YEAR,o.OrderDate) = @year
    GROUP BY c.CompanyName

END;

--Ejecutar sp
EXEC sp_ventasporcliente 1997

execute sp_ventasporcliente 1996

exec sp_ventasporcliente @year = 1998

--Ejercicio1: Realizar un store procedure que muestre un reporte de ventas por cliente y producto(agrupado),de un rango de fecha.
select c.CompanyName as 'Nombre del Cliente', 
Sum(od.Quantity * od.UnitPrice) as 'Total' 
from customers as c
INNER JOIN orders as o 
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
where DATEPART(YEAR,o.OrderDate) = 1996
GROUP BY c.CompanyName;



--Ejercicio2: Realizar un store procedure que inserte un cliente nuevo
CREATE OR ALTER PROC agregar_cliente
--Parametros de entrada
    @CustomerID nchar(5) ,
    @CompanyName nvarchar(40),
    @ContactName nvarchar(30) =  null,
    @ContactTitle nvarchar(30) =  null,
    @Address nvarchar(60) =  null,
    @City nvarchar(15) =  null,
    @Region nvarchar(15) =  null,
    @PostalCode nvarchar(10) =  null,
    @Country nvarchar(15) =  null,
    @Phone nvarchar(24) =  null,
    @Fax nvarchar(24) =  null
AS
BEGIN
    INSERT INTO [dbo].[Customers]
           ([CustomerID]
           ,[CompanyName]
           ,[ContactName]
           ,[ContactTitle]
           ,[Address]
           ,[City]
           ,[Region]
           ,[PostalCode]
           ,[Country]
           ,[Phone]
           ,[Fax])
     VALUES (@CustomerID
           ,@CompanyName
           ,@ContactName
           ,@ContactTitle
           ,@Address
           ,@city
           ,@Region
           ,@PostalCode
           ,@Country
           ,@Phone
           ,@Fax)
END;
GO

select * from Customers

--Agrega el cliente
begin TRANSACTION
exec agregar_cliente
    @CustomerID = 'GTIG3' ,
    @CompanyName = 'Patito de Huele',
    @ContactName = 'Edith campos',
    @ContactTitle = 'Tutora',
    @Address = 'calle del infierno',
    @City = 'Tula',
    @Region = 'Sur',
    @PostalCode = '42800',
    @Country = 'Mexico',
    @Phone = '33-345678'

--Seleccionamos nuestro cliente que agregamos recientemente
select * from Customers
where CustomerID = 'GTIG3'

----1.-Realizar un SP que permita visualizar lo vendido a los clientes mostrando el nombre del cliente y en un año variable



--2.-Crear un SP que inserte un product
select * from Products
CREATE OR ALTER PROC agregar_product
      @ProductName nvarchar(40),
      @SupplierID int,
      @CategoryID int,
      @QuantityPerUnit nvarchar(20),
      @UnitPrice money,
      @UnitsInStock smallint,
      @UnitsOnOrder smallint,
      @ReorderLevel smallint,
      @Discontinued bit
AS
BEGIN
    INSERT INTO [dbo].[Products]
           ([ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
    VALUES (@ProductName 
            ,@SupplierID 
            ,@CategoryID 
            ,@QuantityPerUnit 
            ,@UnitPrice 
            ,@UnitsInStock
            ,@UnitsOnOrder 
            ,@ReorderLevel
            ,@Discontinued )
END;
GO

select * from Products

--Agrega el producto 
exec agregar_product
    @ProductName = 'vaso',
    @SupplierID =  '4',
    @CategoryID = '3',
    @QuantityPerUnit = '344',
    @UnitPrice = '56',
    @UnitsInStock= '233',
    @UnitsOnOrder = '3',
    @ReorderLevel = '0',
    @Discontinued = '0'


