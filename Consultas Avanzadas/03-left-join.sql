
--Crear base de datos para demostrar el uso del left join

create database pruebajoins;

--Utilizamos la bade se datos
use pruebajoins;

--Crear tabla categorias 
create table categoria(
    categoriaid int not null identity(1,1),
    nombre varchar(50) not null default 'No categoria',
    CONSTRAINT pk_categoria
    PRIMARY KEY(categoriaid)
);

create table producto(
    productoid int not null identity(1,1),
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    CONSTRAINT pk_producto
    PRIMARY KEY(productoid),
    CONSTRAINT unico_nombre
    UNIQUE(nombre),
    CONSTRAINT fk_producto_categoria
    FOREIGN KEY(categoriaid)
    REFERENCES categoria(categoriaid)
);

--Agregar registros a la tabla categoria
insert into categoria(nombre)
values('LB'),
      ('Lacteos'),
      ('Ropa'),
      ('Bebidas'),
      ('Carnes Frias');

--Agregar registros a la tabla  productos
insert into producto(nombre, existencia, precio, categoriaid)
VALUES('REFRIGERADOR', 3,10000.0,1),
      ('ESTUFA', 3,9000.04,1),
      ('CREMA', 2,10.50,2),
      ('YOGURT',3,13.45,2);

SELECT * FROM producto

--Reiniciar los identity
DBCC CHECKIDENT(tblname,RESEED, 0)

--INNER JOIN
SELECT * FROM producto as p
INNER JOIN categoria as c
on p.categoriaid = c.categoriaid

-- Consulta utilizando LEFT JOIN
SELECT * FROM categoria as c
LEFT JOIN producto as p
on c.categoriaid = p.categoriaid
--Seleccionar todas las categorias que no tienen asigando productos
SELECT c.categoriaid, c.nombre FROM categoria as c
LEFT JOIN producto as p
on c.categoriaid = p.categoriaid
where p.productoid is null;

SELECT * FROM categoria as c
LEFT JOIN producto as p
on c.categoriaid = p.categoriaid
where p.productoid is not null;

---- Consulta utilizando RIGTH JOIN
SELECT *
FROM producto as p
RIGHT JOIN categoria as c
on p.categoriaid = c.categoriaid ;

SELECT *
FROM producto as p
LEFT JOIN categoria as c
on p.categoriaid = c.categoriaid ;

-----FULL JOIN ------------
SELECT *
FROM producto as p
FULL JOIN categoria as c
on p.categoriaid = c.categoriaid ;

SELECT *
FROM producto as p
FULL JOIN categoria as c
on p.categoriaid = c.categoriaid ;

--EJERCICIO
--1.CREAR UNA BASE DE DATOS LLAMADA EJERCICIO JOINS 
create database ejerciciojoins;
use ejerciciojoins;

--2.Crear una tabla que se llame empleados tomando como base la tabla employees de nortwind(No tomar todos los campos)
--3.LLenar la tabla con una consulta a la tabla employees
select * from Northwind.dbo.Employees;

select top 0 employeeid as 'empleadoid',
    CONCAT(FirstName, ' ', LastName) as 'NombreCompleto',
    title as 'Titulo',
    HireDate as 'Fechacontratacion'
into ejerciciojoins.dbo.empleados
from Northwind.dbo.Employees; 

insert into ejerciciojoins.dbo.empleados(NombreCompleto,Titulo,Fechacontratacion)
select 
    CONCAT(FirstName, ' ', LastName) as 'NombreCompleto',
    title as 'Titulo',
    HireDate as 'Fechacontratacion'
from Northwind.dbo.Employees;
  

select * from empleados
--4.Agregar nuevos datos a la tabla empleados por lo menos 2


--5.Actualizar la tabla empleados con los nuevos registros, la cual se llenaran en una nueva tabla llamasa dim_producto




