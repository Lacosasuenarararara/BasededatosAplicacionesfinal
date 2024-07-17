--Store procedure que visualice los resultados de cualquier tabla
--select * from[tabla]
use Northwind;

go
create or alter proc sp_Visualiza_Tabla
@Nombretabla varchar(50)
as 
begin
	declare @consulta varchar(50)
	set @consulta = 'select * from ' +  QUOTENAME(@Nombretabla);
	exec (@consulta);

	--Segunda forma exec sp_executesql @consulta
end;
go

exec sp_Visualiza_Tabla 'Customers'
----------------------------------------------------------------------------




