--Las transacciones son fundamentales para asegurar la consistencia
--y la integridad de los datos

--Transacciones:Es una unidad de trabajo que se ejecuta de manera 
--completamente existosa o no se ejecuta en absoluto

--Begin Transaction: Inicia una nueva transaccion
--Commit Transaction: Confirma todos los cambios realizados durante la transaccion
--RollBack Transaction: Revierte todos los cambios realizados durante la transaccion 

use Northwind;

select * from Categories

begin transaction --Priimero ejecutamos esto

insert into Categories(CategoryName,[Description])
values ('Categoria11', 'Los remediales')

rollback transaction

commit transaction
