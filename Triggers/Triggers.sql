--Ejercicios Triggers 
Create database pruebatriggersg3;
go

use pruebatriggersg3;
go 

create table tabla1 
(
 id int not null primary key,
 nombre varchar(50) not null
);
go

--Triggers
----Triger que verifica  el evento que se ejecuto-----
---------Con insert--------------
create or alter trigger tg_verificar_inserccion
on tabla1
after insert
as
begin
	print 'Se ejecuto el evento insert en la tabla1'
end;

--Ejecucion---
insert into tabla1
values(1,'Nombre1')

-------Con delete------------
create or alter trigger tg_verificar_delete
on tabla1
after delete
as
begin
	print 'Se ejecuto el evento delete en la tabla1'
end;

--Ejecucion---
delete tabla1
where id=1

insert into tabla1
values(1,'Nombre1')

---Con update----------
create or alter trigger tg_verificar_update
on tabla1
after update
as
begin
	print 'Se ejecuto el evento update en la tabla1'
end;

----Ejecucion-----
update tabla1
set nombre= 'Nombre Nuevo'
where id = 1;

drop trigger tg_verificar_inserccion
drop trigger tg_verificar_delete
drop trigger tg_verificar_update
------------------------------------------------
create trigger verificar_contenido_inserted
on tabla1
after insert
as
begin
	--ver los datos de la tabla inserted
	select * from inserted;
end;

insert into tabla1
values(2,'Nombre2')

insert into tabla1
values(3,'Nombre3')

select * from tabla1

insert into tabla1
values(4,'Nombre4'), (5,'Nombre5')

----------Northwind-----
use Northwind;

create or alter trigger verificar_inserted_categories
on Categories
after insert
as
begin
	select categoryid,categoryname,[description] from inserted;
end;

insert into Categories(categoryname,[description])
values('CategoriaNueva','Prueba Triggers')
----------------Update-------------------
create or alter trigger verificar_update_categories
on Categories
after update
as
begin
	select categoryid,categoryname,[description] from inserted;
	select categoryid,categoryname,[description] from deleted;
end

select * from Categories

begin transaction
--Transaction confirmar= commit, Cancelar= rollback
update Categories
set categoryname = 'CategoriaOtra',
	[description] = 'Si esta bien'
where categoryid = 9

drop trigger verificar_update_categories
drop trigger verificar_inserted_categories

create or alter trigger verificar_inserted_deleted
on Categories
after insert, update, delete
as
begin
	if exists(select 1 from inserted) and not exists(select 1 from deleted)
	begin
		print 'Existen datos en la tabla inserted, se ejecuto un insert'
	end

	if exists(select 1 from deleted) and not exists(select 1 from inserted)
	begin
		print 'Existen datos en la tabla deleted, se ejecuto un delete'
	end
	else if exists(select 1 from deleted) and exists(select 1 from inserted)
	begin
		print 'Existen datos en las 2 tabla, se ejecuto un update'
	end
end;

insert into Categories(categoryname, [Description])
values('Categoria10', 'Pipon')

delete Categories
where categoryid = 9


select * from Categories

update Categories
set categoryname = 'CategoriaIgual',
	[description] = 'Si esta Correcto'
where categoryid = 10


drop trigger verificar_inserted_deleted
--------------------------------------------------
--Crear un trigger en la base de datos pruebatriggers, para la tabla empleados, este trigger debe evitar que se inserten
-- o modifiquen salarios mayores a 50000
use pruebatriggersg3;
go 

create table empleado
(
   id int not null primary key,
   nombre varchar(50) not null,
   salario money not null
);

create or alter trigger verificar_salario
on empleado
after insert, update
as 
begin
	if exists(select 1 from inserted) and not exists(select 1 from deleted)
	begin
		Declare @salarioNuevo money 
		set  @salarioNuevo = (select salario from inserted);

		if @salarioNuevo > 50000
		begin
			raiserror('El salario es mayor a 50000 y no esta permitido',16,1);
			rollback transaction;
		end
	end	
end;
