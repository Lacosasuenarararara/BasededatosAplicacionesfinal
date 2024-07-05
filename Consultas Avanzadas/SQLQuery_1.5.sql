--Consultas Avanzadas
use Northwind
select * from Products

--Seleccionar cuantos productos tiene cada categoria
select CategoryID,count(*) 
from Products 
group by CategoryID

select CategoryID,count(*) 
from Products 

select CategoryID from Products

select COUNT(*) from Products

select c.CategoryName, count(*) AS  'Numero de Productos' 
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName;

--Consultar para mostrar todos los productos junto con sus categorias y sus precios
select c.CategoryName, p.ProductName, p.UnitPrice from Categories as c
join Products as p
on c.CategoryID = p.CategoryID

--Consulta para mostrar los nombres de los productos y los nombres de sus proveedores
select p.ProductName as 'Nombre del Producto', s.CompanyName as 'Nombre del proveedor' 
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
order by s.CompanyName;

--Seleccionar las ordenes de compra mostrando los nombres de los productos y sus importes
SELECT od.OrderID as 'Numero de orden', p.ProductName as 'Nombre del producto', (od.Quantity * od.UnitPrice) as 'Importe'
from [Order Details] as od
inner join Products as p 
on od.ProductID = p.ProductID
where (od.Quantity * od.UnitPrice) <= 15000
order by 'Importe' DESC

--Mostrar las ordenes de compra y los nombres de los empleados que las realizaron
SELECT o.OrderID as 'Numero de Orden', CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre completo'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
where YEAR(OrderDate) in ('1996', '1999');

--Seleccionar las ordenes mostrando los clientes a las que se les hicieron, las cantidades
--Vendidas y los nombres de los productos
-------------------------------------------------------------------------------------------------
--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
select o.OrderID as  'Numero de orden'
,o.OrderDate as 'Fecha de orden' ,
c.CompanyName as 'Nombre cliente', 
CONCAT(e.FirstName,' ', e.LastName) as 'Nombre empleado' 
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID ;

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
select p.ProductName as 'Nombre producto', 
s.CompanyName as 'Nombre del proveedor',
p.UnitPrice as 'Precio unitario'
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID;
------------------------------------------------
select P.ProductName,s.CompanyName,p.UnitPrice
from(
    SELECT SupplierID,ProductName,UnitPrice 
    FROM Products
) AS P
INNER JOIN 
Suppliers as s
on p.SupplierID = s.SupplierID;
-----------------------------------------------
select P.ProductName,s.CompanyName,p.UnitPrice
from(
    SELECT SupplierID,ProductName,UnitPrice 
    FROM Products
) AS P
INNER JOIN 
(
   select SupplierID, CompanyName from Suppliers
)AS s
on p.SupplierID = s.SupplierID;

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
select c.CompanyName as 'Nombre Cliente', 
o.OrderID as 'Id_Pedido',
o.OrderDate as 'Fecha de Pedido',
year(o.OrderDate) as 'Año de compra',
MONTH(o.OrderDate) as 'Mes de compra',
day(o.OrderDate) as 'Dia de compra'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID;
------------------
select c.CompanyName, o.OrderID, o.OrderDate
from(
    SELECT CustomerID, OrderID, OrderDate 
    FROM Orders
) AS o
INNER JOIN 
(
   select CustomerID, CompanyName from Customers
)AS c
on o.CustomerID = c.CustomerID;

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el territorio del empleado para cada empleado.
select CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio'
from EmployeeTerritories as et
INNER JOIN Employees as e
on et.EmployeeID = e.EmployeeID
INNER JOIN Territories as t
on t.TerritoryID  = et.TerritoryID;
--------------------------------------------------------
select CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio'
from (
    select TerritoryID, EmployeeID from EmployeeTerritories
) as et
INNER JOIN ( 
    select EmployeeID, FirstName, LastName, Title from Employees
) as e
on et.EmployeeID = e.EmployeeID
INNER JOIN (
    select TerritoryID,TerritoryDescription from Territories
) as t
on t.TerritoryID  = et.TerritoryID;

------------------Ejercicio de reto-------------------:
--Seleccionar todas las ordenes mostrando el empleado que la realizo, el cliente al que se le vendio, 
--nombre de los productos,sus categorias, el precio que se vendio las unidades vendidas y
-- el importe de enero de 1997 a feb de 1998 
select CONCAT(FirstName, ' ', LastName) as 'Empleado',
c.CompanyName as 'Cliente', p.ProductName as 'Nombre del producto',
ca.CategoryName as 'Categoria', od.UnitPrice as 'Precio',
od.Quantity as 'Cantidad', (od.UnitPrice * Quantity) as 'Importe'
from Employees as e
INNER JOIN orders as o
on e.EmployeeID = o.EmployeeID
INNER JOIN Customers as c
on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] as od
on o.OrderID = od.OrderID
INNER JOIN Products as p
on p.ProductID = od.ProductID
INNER JOIN Categories as ca
on ca.CategoryID = p.CategoryID
where o.OrderDate between '1997-01-01' and '1998-02-28'
and ca.CategoryName in('Beverages')
order by c.CompanyName

--Cuanto dinero he vendido de la categoria beverages
select sum(od.UnitPrice * od.Quantity) from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
INNER JOIN orders as o
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1998-02-28'
and c.CategoryName in('Beverages')

--Funciones
--Is null
select * from empleados
where fecha is null;

--datepart
SELECT datepart(year, '2024')