--Actualice los precios de los productos y guardarlos en una tabla de historicos_precios
--tabla id,id producto modificado,precio anterior, precio nuevo, fecha de modificacion
use Northwind

--Crear un store procedure que elimine una orden, orderdetail, actualizar el stock del producto

select * from Orders
select * from [Order Details]
select * from Products

create or alter proc spu_EliminarOrden 
@OrderID INT
AS
BEGIN
    -- Iniciar transacción
    BEGIN TRANSACTION;

	begin try
	-- Actualizar el stock del producto
	update p
	set p.UnitsinStock = p.UnitsinStock + od.Quantity
	from [Order Details] as od
	inner join Products as p
	on od.ProductID = p.ProductID
	where od.OrderID = @OrderID;


    -- Eliminar detalles de la orden
    DELETE FROM [Order Details]
    WHERE OrderID = @OrderID;

    -- Eliminar la orden
	DELETE FROM Orders
    WHERE OrderID = @OrderID;
     	COMMIT TRANSACTION 
	 end try
     begin catch
     ROLLBACK TRANSACTION;
	 Declare @mensajeError nvarchar(max)
	 set @mensajeError = ERROR_MESSAGE()
	 print @mensajeError
	 end catch;
     
END;

EXEC spu_EliminarOrden @OrderID = 10252;