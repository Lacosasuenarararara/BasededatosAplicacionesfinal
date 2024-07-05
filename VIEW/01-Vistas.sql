create database vistaspractica;

use vistaspractica

--Crear una vista de la siguiente consulta
CREATE VIEW view_categorias_productos 
as
    select c.CategoryName As 'Nombre Categoria', 
    p.ProductName as 'Nombre Producto', 
    p.UnitPrice as 'Precio', 
    p.UnitsInStock as 'Existencia'
    from 
    Northwind.dbo.Categories AS c
    inner join Northwind.dbo.Products As p
    on c.CategoryID = p.CategoryID;

select *,(precio*existencia) as 'PrecioInventario' 
from view_categorias_productos
where [nombre categoria] in('Beverages','Condiments')
order by[nombre categoria] desc;

--Seleccionar la suma del precio del inventario agrupado por categoria 
select [Nombre Categoria],SUM(Precio * Existencia) as 'Suma'
from view_categorias_productos
GROUP by [Nombre Categoria]


