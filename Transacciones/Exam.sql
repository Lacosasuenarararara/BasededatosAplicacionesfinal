--Actualice los precios de los productos y guardarlos en una tabla de historicos_precios
--tabla id,id producto modificado,precio anterior, precio nuevo, fecha de modificacion
use Northwind
create procedure sp_act_productos
@idproducto int, @precioN money
as 
begin
declare @precioA money;
begin transaction;

select @precioA=UnitPrice from Products where ProductID=@idproducto;
update Products set UnitPrice=@precioN where ProductID=@idproducto;

insert into preciosHistoricos(producto_id, precioA, precioV, fechaM)
values(@idproducto, @precioA, @precioN, GETDATE());
commit transaction;
end;

exec  sp_act_productos @idproducto=1, @precioN=25;
select*from products;


create table preciosHistoricos(
id int identity(1,1) primary key,
producto_id int not null,
precioA money not null,
precioV money not null,
fechaM datetime not null default getdate(),
foreign key (producto_id) references products(ProductID)
);

select p.productID as 'ID producto', p.unitPrice as 'Precio', ph.precioA as 'Precio Anterior', ph.precioV as 'Precio Nuevo', ph.fechaM as 'Fecha' from products as p
inner join preciosHistoricos as ph
on p.ProductID=ph.id

insert into  preciosHistoricos values
update products set UnitPrice='20' where ProductID='1';


insert into pedido values(@idpedido, @idproducto, @cantidad)
update product set existencia=@nuevaCantidad where idprod=@idproducto


drop table  preciosHistoricos

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