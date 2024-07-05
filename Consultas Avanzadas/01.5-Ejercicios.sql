--Consultas simples(consultas a una sola tabla)
use Northwind;

--Seleccionar todos los customers(Clientes)
select * from Customers;

--Proyecci�n 
select CustomerID,CompanyName,City,Country
from Customers

--Selecciona 10 registros de los clientes
select top 10 CustomerID,CompanyName,City,Country
from Customers

--Alias de Columna
--country as pais
--country pais
--country 'pais'
--country as 'pais'
--country as 'pais de las maravillas'

select CustomerID as 'numero cliente',CompanyName Nombreempresa,City as 'Ciudad',Country 'Pais'
from Customers

select * from Customers

--Alias de Tabla
select Customers.CustomerID,Customers.CompanyName,Customers.City,Customers.Country
from Customers

select c.CustomerID,c.CompanyName,c.City,c.Country
from Customers as c

select c.CustomerID,c.CompanyName,c.City,c.Country
from Customers  c

--Campo calculado

select *,(p.UnitPrice * p.UnitsInStock) as 'Costo Inventario'
from Products as p

select ProductName as 'Nombre Producto',UnitsInStock as 'Existencia'
,UnitPrice as 'Precio Unitario',
(p.UnitPrice * p.UnitsInStock) as 'Costo Inventario'
from Products as p


--Filtrar Datos
--Clausula where y operadores relacionales
/*
  < -- Menor que
  > -- Mayor que
  <= -- Menor o igual
  >= -- Mayor o igual
  <> -- Diferente
  != -- Diferente
  =  -- Igual a
*/

select * from Customers

--Seleccionar todos los clientes de alemania 
select *
from Customers
where Country = 'Germany'

--Seleccionar todos los productos que tengan un stock mayor a 20, mostrando solamente el nombre del producto
--el precio y la existencia 
select * from Products

select p.ProductName as 'Nombre del producto',p.UnitPrice as 'Producto', p.UnitsInStock as 'Existencia'
from Products as p
where p.UnitsInStock > 20
order by p.ProductName desc;

select p.ProductName as 'Nombre del producto',p.UnitPrice as 'Producto', p.UnitsInStock as 'Existencia'
from Products as p
where p.UnitsInStock > 20
order by 'Nombre del producto' desc;

--Seleccionar todos los clientes ordenados de forma ascendente por pais y dentro del pais ordenados de forma descendente 
--Por ciudad 

select c.CustomerID,c.Country as 'Pais',c.City as 'Ciudad'
from Customers as c
order by 'pais' asc, 'Ciudad' desc

select c.Country,c.City from Customers as c
where Country = 'Germany'
order by c.Country,c.City desc 

--Eliminar valores repetido en una consulta 

--seleccionar los paises de los clientes 
select  distinct Country from Customers
order by 1 asc

select count(distinct Country)
from Customers

--Selecciona todos los productos donde el precio es mayor o igual a 18
select * from Products as p
where p.UnitPrice >= 18.0


select * from Products as p
where p.UnitPrice <> 18.0

select * from Products as p
where p.UnitPrice != 18.0

--Operadores Logicos --

--seleccionar todos los productos que tengan un precio
-- entre 18 y 25 dolares

select * from Products as p
where p.UnitPrice >= 18 and p.UnitPrice <= 25

select * from Products as p
where p.UnitPrice between 18 and 25

--seleccionar todos los productos que no tengan un precio
-- entre 18 y 25 dolares

select * from Products as p
where p.UnitPrice not between 18 and 25

select * from Products as p
where not (p.UnitPrice >= 18 and p.UnitPrice <= 25)


--Seleccionar todos los productos donde el precio sea mayor
-- a 38 y su existencia sea mayor o igual a 22

select * from Products as p
where p.UnitPrice > 38 and p.UnitsInStock >= 22

--Seleccionar todos los clientes de alemania, mexico y francia
select * from Customers as c
 where c.Country = 'Germany' or c.Country = 'Mexico' or c.Country = 'France' 

 select * from Customers as c
 where c.Country in ('Germany', 'Mexico', 'France') 

--Seleccionar todos los clientes que no tengan region 
select * from Customers

select * from Customers as c
where c.Region is Null

select * from Customers as c
where c.Region is not Null

--Seleccionar todas las ordenes enviadas de julio de 1996
--a abril  de 1998 para los empleados Buchanan,Leverling y Davolio
select * from Orders

select getdate()

select * from Orders as o
where o.ShippedDate between '1996-07-01' and '1998-04-30'
and o.EmployeeID in (5,3,1)

select * from Employees

select e.LastName as 'Empleado',o.ShippedDate as 'Fecha de entrega' 
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShippedDate between '1996-07-01' and '1997-04-30'
and e.LastName in('Buchanan','Leverling',  'Davolio')

--Seleccionar solo los años de las ordenes de compra
select year(OrderDate) as año from Orders;

--Selecciona todas las ordenes de compra para 1996
select year(OrderDate ) as año from Orders 
where year(OrderDate) = '1996'

select OrderID as 'numero orden', OrderDate as 'Fecha orden',
year(OrderDate ) as año from Orders 
where OrderDate between '1996-01-01' and '1996-12-31'

select OrderID as 'numero orden', OrderDate as 'Fecha orden',
year(OrderDate ) as año from Orders 
where year(OrderDate) = '1996' 

--Seleccionar todas las ordenes de compra mostrando el numero de orden, fecha de orden 
--año, mes y dia de 1996 y 1998
select OrderID as 'numero orden', OrderDate as 'Fecha orden',
year(OrderDate ) as año, MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'Dia'
from Orders 
where year(OrderDate) = '1996' or year(OrderDate) = '1998' 

select OrderID as 'numero orden', OrderDate as 'Fecha orden',
year(OrderDate ) as año, MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'Dia'
from Orders 
where year(OrderDate) in ('1996', '1998')

--Seleccionar todos los apellidos de los empleados que comiencen con D
select * from Employees
where LastName like 'D%'

--Seleccionar todos los emleados que su apellido comienden con un "DA"
select * from Employees
where LastName like 'Da%'

--Seleccionar todos los empleados que su apellido termine con a
select * from Employees
where LastName like '%A'

--Seleccionar todos los empleados que su apellido contenga la letra A
select * from Employees
where LastName like '%A%'

--Seleccionar todos los empleados que su apellido no contenga la letra A
select * from Employees
where LastName not like '%A%'

--Seleccionar todos los empleados que contengan en su apellido cualquier letra y una i
select * from Employees
where LastName like '%_i%'

select * from Employees
where LastName like '%__i%'

--Seleccionar todos los empleados donde su nombre contenga 3 caracteres 
-- antes la palabra li, despues un caracter y finalmente la letra D
select * from Employees
where LastName like '%___li_g%'

--Seleccionar los apellidos que comiencen con D o con L de los empleados
select * from Employees
where LastName like '[DL]%'

select * from Employees
where LastName like 'D%' or LastName like 'L%'

--Seleccionar todos los empleados que su apellido comiencen con una S o una C
select * from Employees
where LastName like '[SC]%'

--Seleccionar todos los empleados que en su apellido contengan una D o una L
select * from Employees
where LastName like '%[DL]%'

--Seleccionar todos los empleados donde su apellido contenga la letra entre la A y la F
select * from Employees
where LastName like '%[A-F]%'

--Seleccionar cuantos empleados en su apellido contienen las letras entre la A Y la F
select count(*) as 'Total de empleados' from Employees
where LastName like '%[A-F]%'

--Seleccionar todos los empleados en donde sus apellidos no terminen con CB
select * from Employees
where LastName like '[^CB]%'


--Seleccionar el total de ordenes enviadas a francia entre 1996 y 1998
select * from Orders
where ShipCountry = 'France'
and year(ShippedDate) between '1996' and '1998'

--Seleccionar el precio minimo de los productos 

select MIN(UnitPrice) from Products

--Seleccionar el precio maximo de los productos 

select Max(UnitPrice) from Products

--Seleccionar el nombre del producto, precio de aquel que sea mas caro
select top 1 ProductName,UnitPrice from Products
order by UnitPrice desc

--Seleccionar el monto total de todas las ordenes
select * from [Order Details]
select sum(UnitPrice * Quantity) as 'Total de Ventas'from [Order Details]

--Seleccionar el total de ventas realizada a los productos que no tienen descuento
select * from [Order Details]

select sum(UnitPrice * Quantity) as 'Total de Ventas'from [Order Details]
where Discount = 0

--Seleccionar el promedio de ventas para los productos
--Singaporean hokkien fried mee y mozzarella di giovanni

select * from Products
select avg(UnitPrice * Quantity) as 'Total de Ventas'from [Order Details]
where ProductID in (72,42)

select avg(UnitPrice * Quantity) as 'Total de Ventas'from [Order Details]
where ProductID  = 72 or  ProductID = 42

--Seleccionar el total de ventas para el cliente 14, chop-suey chine de 1996 a 1998 (Tarea)
select Sum(UnitPrice * Quantity) as 'Total de ventas'
from [Order Details] as od
JOIN Orders as o
on od.OrderID = o.OrderID
where CustomerID = 'Chops' and OrderDate between '1996' and '1998'



--Funciones de Agregado, Group by, Having 

--JOINS
--Seleccionar los datos de las tablas de categorias y de productos 

SELECT*
FROM Categories AS c
INNER JOIN Products as p
ON c.CategoryID = p.CategoryID

SELECT c.CategoryID as 'Nombre Categoria',
p.ProductName as 'Nombre Producto', 
p.UnitPrice as 'Precio Unitario',
p.UnitsInStock as 'Existencia',(p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
FROM Categories AS c
INNER JOIN Products as p
ON c.CategoryID = p.CategoryID

--Seleccionar los productos de la categoria Beverages 

SELECT c.CategoryID as 'Nombre Categoria',
p.ProductName as 'Nombre Producto', 
p.UnitPrice as 'Precio Unitario',
p.UnitsInStock as 'Existencia',(p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
FROM Categories AS c
INNER JOIN Products as p
ON c.CategoryID = p.CategoryID
where c.CategoryName = 'Beverages'
and p.UnitPrice > 20








