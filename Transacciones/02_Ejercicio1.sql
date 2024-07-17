--Ejercicio1: Realizar una venta dentro de la base de datos norwin 
--utilizando transacciones y store procedures

create  or alter proc sp_nueva_Venta
@CustomerID nvarchar(5),
@EmployeeID int,
@OrderDate datetime,
@RequiredDate datetime,
@ShippedDate datetime,
@ShipVia int,
@Freight money = null,
@ShipName nvarchar(40) = null,
@ShipAddress nvarchar(60) =null,
@ShipCity nvarchar(15) = null,
@ShipRegion nvarchar(15) = null,
@ShipPostalCode nvarchar(15) = null,
@ShipCountry nvarchar(15) =  null,
@ProductID int, 
@UnitPrice money,
@Quantity smallint,
@Discount real
AS
begin
	Begin Transaction 
	
	begin try
	--Insertar en la tabla order
	INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID,
            @EmployeeID, 
            @OrderDate, 
            @RequiredDate, 
            @ShippedDate, 
            @ShipVia, 
            @Freight, 
            @ShipName, 
            @ShipAddress, 
            @ShipCity, 
            @ShipRegion, 
            @ShipPostalCode, 
            @ShipCountry);

			--Obtener el id insertado de la orden
			Declare @ordenid int
			set @ordenid = SCOPE_IDENTITY();

			--Insertar en detalle_orden el producto
			--obtener el precio del producto  a insertar
			DECLARE @precioVenta money

			Select @precioVenta = UnitPrice from Products 
			where ProductID = @ProductID
	end try
	begin catch

	end catch

end;
go