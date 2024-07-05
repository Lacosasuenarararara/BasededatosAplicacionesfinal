--Store Procedure(Parametros de salida)
-- crear store procedure que calcule el area de un circulo

create or alter proc sp_calcular_area_circulo
@radio float, --Parametro de entrada
@area float output --parametro de salida
AS
begin
	set @area = PI() * @radio * @radio
end;
go

--Ejecucion
declare @resultado float
exec sp_calcular_area_circulo @radio = 22.3, @area = @resultado output

print 'El valor del area es: ' + cast(@resultado as varchar);
go

--1. Obtener el nombre de un empleado dado
create or alter proc sp_obtener_informacion_empleado
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin	

	if @employeeid <> -1
	begin
	select @nombre = FirstName,@apellido = LastName 
	from Employees
	where EmployeeID = @employeeid
	end
	else
	begin
	 print ('El valor del empleado no es valido')
	end
end
go
------Ejecucion-----
declare @firstName as nvarchar(10), @lastName nvarchar(20)
exec sp_obtener_informacion_empleado @employeeid = 1, @nombre = @firstName output, @apellido = @lastName output

print('El nombre es: ' + @firstName)
print('El apellido es: ' + @lastName)

--Ejecucion 2
declare @firstName as nvarchar(10), @lastName nvarchar(20)
exec sp_obtener_informacion_empleado
@nombre = @firstName output, @apellido = @lastName output

print('El nombre es: ' + @firstName)
print('El apellido es: ' + @lastName)

--Verificar si el employeeid introducido existe
select * from Employees

create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

----------Ejecucion------
declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2 @employeeid = 8,
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)

--2.Realizar un store Procedure que guarde en una variable de salida el total de compras que ha realizado 
--un cliente dado en un rango de fechas
create or alter proc sp_ventas_por_cliente
@customersid nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal(10,2) output
as
begin
select @total = sum(od.UnitPrice*od.Quantity) 
from [Order Details] as od
inner join Orders as o
on od.OrderID = o.OrderID
where CustomerID = @customersid AND
OrderDate between @fechainicial AND @fechafinal
end

