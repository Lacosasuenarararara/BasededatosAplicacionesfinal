create database repasojoins;

use repasojoins

create table proveedor(
    provid int not null identity(1,1),
    nombre varchar(50)not null,
    limite_credito money not NULL,
    constraint pk_proveedor
    primary key(provid)
);

create table producto(
    prodid int not null identity(1,1),
    nombre varchar(100) not null,
    existencia int not null,
    precio money not NULL,
    proveedor int,
    constraint pk_producto
    primary key(prodid),
    constraint fk_prioducto_proveedor
    foreign key(proveedor)
    REFERENCES proveedor(provid)
);

--insertar datos en las tablas
INSERT into proveedor(nombre, limite_credito)
values('Proveedor1', 100000),
      ('Proveedor2', 200000),
      ('Proveedor3', 300000),
      ('Proveedor4', 400000),
      ('Proveedor5', 500000);


insert into producto(nombre,existencia,precio,proveedor)
VALUES('Producto1',34,45.6,1),
      ('Producto2',34,45.6,1),
      ('Producto3',34,45.6,2),
      ('Producto4',34,45.6,3);

select * from proveedor;
select * from producto;

--Consultas INNER JOIN
--Seleccionar todos los productos que tienen proveedor
SELECT pr.nombre as 'Nombre_Producto', pr.precio as [Precio],
pr.existencia as [Existencia], p.nombre as 'Proveedor'
from proveedor as [p]
inner join 
producto as [pr]
on p.provid = pr.proveedor;

--Consulta LEFT JOIN
--Mostrar todos los proveedores y sus respectivos productos
SELECT pr.prodid , pr.nombre as 'Nombre_Producto', pr.precio as [Precio],
pr.existencia as [Existencia], p.provid, p.nombre as 'Proveedor'
from proveedor as [p]
left join 
producto as [pr]
on p.provid = pr.proveedor;

update proveedor
set nombre = 'Proveedor6'
where provid = 5;

update proveedor
set nombre = 'Proveedor5'
where provid = 5;

insert into proveedor(nombre,limite_credito)
values('proveedor6',45000);

--Se elimina un registro
delete from proveedor 
where provid = 7

--Utilizando RIGTH JOIN
SELECT pr.prodid , pr.nombre as 'Nombre_Producto', pr.precio as [Precio],
pr.existencia as [Existencia], p.provid, p.nombre as 'Proveedor'
from proveedor as [p]
right join 
producto as [pr]
on p.provid = pr.proveedor;

insert into producto(nombre,precio,existencia,proveedor)
values('producto5',78.8,'22',null)

--FULL JOIN
SELECT pr.prodid , pr.nombre as 'Nombre_Producto', pr.precio as [Precio],
pr.existencia as [Existencia], p.provid, p.nombre as 'Proveedor'
from proveedor as [p]
FULL join 
producto as [pr]
on p.provid = pr.proveedor;

--Seleccionar todos los proveedores que no tienen asignado productos
SELECT  p.provid as 'Numero de proveedor', p.nombre as 'Proveedor'
from proveedor as [p]
LEFT join 
producto as [pr]
on p.provid = pr.proveedor
where pr.prodid is null;

--Seleccionar todos los productos que no tienen proveedor
SELECT  pr.nombre,pr.precio,pr.existencia
from proveedor as [p]
Right join 
producto as [pr]
on p.provid = pr.proveedor
where p.provid is null;


