-- listar la información de los artistas y sus albumes
select *
from "Artist", "Album"
where "Artist"."ArtistId" = "Album"."ArtistId"
order by "Artist"."ArtistId";

select *
from "Artist" as A
inner join "Album" as B on A."ArtistId" = B."ArtistId";

-- listar la información de las canciones, albumes y artistas
select Ar."Name", Al."Title", T."Name"
from (("Artist" as Ar
inner join "Album" as Al on Ar."ArtistId" = Al."ArtistId")
inner join "Track" as T on T."AlbumId" = Al."AlbumId")
order by Ar."Name";

-- listar el identificador de factura en los cuales se hayan comprado las canciones con identificador 635 y 662
select A."InvoiceId"
from "InvoiceLine" as A
inner join "InvoiceLine" as B on (A."InvoiceId" = B."InvoiceId")
where A."TrackId" = 635 and B."TrackId" = 662;

-- listar nombre y apellido de los clientes y nombre y apellido del empleado a quién le reporta
select Emp."FirstName", Emp."LastName", Jef."FirstName", Jef."LastName"
from "Employee" as Emp
inner join "Employee" as Jef on (Emp."ReportsTo" = Jef."EmployeeId");

-- listar los artitas de las canciones que ha comprado Alexandre Rocha
select distinct "FirstName", "LastName"
from "Artist" natural join "Album" join "Track" using("AlbumId") join "InvoiceLine" using("TrackId") natural join "Invoice" natural join "Customer"
where "Artist"."Name" in ('Nirvana', 'Deep Purple');

select distinct "Customer"."FirstName", "Customer"."LastName"
from "Artist" natural join "Album" join "Track" using ("AlbumId") join "InvoiceLine" using ("TrackId") natural join "Invoice" natural join "Customer"
where "Artist"."Name" = 'Nirvana' or "Artist"."Name" = 'Deep Purple';

SELECT DISTINCT "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" LIKE 'Nirvana' OR "Artist"."Name" LIKE 'Deep%';

SELECT DISTINCT "Artist"."Name"
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "InvoiceLine" NATURAL JOIN "Invoice" NATURAL JOIN "Customer"
WHERE "FirstName" = 'Alexandre' AND "LastName" = 'Rocha';

-- listar los artistas de las canciones que ha comprado Alexandre Rocha
select distinct "Artist"."Name"
from "Artist" natural join "Album" join "Track" using("AlbumId") natural join "InvoiceLine" natural join "Invoice" natural join "Customer"
where "Customer"."FirstName" = 'Alexandre' and "Customer"."LastName" = 'Rocha';

SELECT DISTINCT "Artist"."Name"
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "InvoiceLine" NATURAL JOIN "Invoice" NATURAL JOIN "Customer"
WHERE "FirstName" = 'Alexandre' AND "LastName" = 'Rocha';

-- listar el nombre de las canciones 
select distinct "TrackId", "Name"
from "Track" join "InvoiceLine" using("TrackId") order by "Name"

-- listar el nombre de las canciones y género de las canciones compradas por el cliente Daan Peeters, pero sólo de los géneros
-- con nombre Rock, Metal o Blues
select "Track"."Name", "Genre"."Name"
from "Track" join "Genre" using("GenreId") natural join "InvoiceLine" natural join "Invoice" natural join "Customer"
where "Customer"."FirstName" = 'Daan' and "Customer"."LastName" = 'Peeters' and "Genre"."Name" in ('Rock', 'Metal', 'Blues');

-- Listar la informaci�n de los artistas y sus albumes (cartesiano)
SELECT "Artist"."ArtistId", "Name", "AlbumId", "Title"
FROM "Artist", "Album"
WHERE "Artist"."ArtistId" = "Album"."ArtistId";

-- listar el nombre de las canciones que han sido compradas
select "Track"."Name"
from "Track" join "InvoiceLine" using("TrackId")

-- listar el nombre de las canciones que no han sido compradas
select "Track"."Name"
from "Track" left outer join "InvoiceLine" using("TrackId")
where "InvoiceLineId" is null

-- listar los identificadores, fechas de facturas y nombre de canción de las
-- facturas donde se compraron canciones del artista con nombre "The Rolling Stones"
-- en el rango de fechas del 2010 al 2012 (10 tuplas, 3 atributos)
select "Invoice"."InvoiceId", "Invoice"."InvoiceDate", "Track"."Name"
from "Artist" natural join "Album" join "Track" using("AlbumId") join "InvoiceLine" using("TrackId")
natural join "Invoice"
where "Artist"."Name" = 'The Rolling Stones' and "Invoice"."InvoiceDate"  between '2010-01-01' and '2012-12-31'

-- listar los diferentes países de los clientes que son atendidos por los empleados súbditos del
-- empleado con nombre Nancy y apellido Edwards (24 tuplas, 1 atributo)
select distinct "Customer"."Country"
from "Employee" as Jefe, "Employee" as Sub join "Customer" on ("Customer"."SupportRepId" = Sub."EmployeeId")
where Jefe."FirstName" = 'Nancy' and Jefe."LastName" = 'Edwards'

-- listar los nombres de los artistas registrados sin álbumes dados de alta (71 tuplas, 1 atributo)
select "Artist"."Name"
from "Artist" left outer join "Album" using("ArtistId")
where "Album"."AlbumId" is null

-- listar los nombres de los artistas que no tuvieron ventas en el año 2011 (160 tuplas, 1 atributo)
select distinct "Artist"."Name", "Invoice"."InvoiceDate"
from "Artist" natural join "Album" join "Track" using("AlbumId") join "InvoiceLine" using("TrackId")
join "Invoice" using("InvoiceId")
where "Invoice"."InvoiceDate" not between '2011-01-01' and '2011-12-31'

-- construcción de tablas
select "Title"
from "Album" natural join (select "ArtistId"
                           from "Artist"
                           where "Name" = 'Nirvana' or "Name" = 'Deep Purple') as nirvana;
                           
-- subconsultas no correlacionadas
-- la subconsulta sólo puede regresar un sólo atributo
select "Title"
from "Album"
where "ArtistId" in (select "ArtistId"
                     from "Artist"
                     where "Name" = 'Nirvana' or "Name" = 'Deep Purple')

-- listar el identificador de factura en los cuales se hayan comprado las canciones
-- con identificador 635 y 662
select distinct "InvoiceId"
from "InvoiceLine" as RI join "InvoiceLine" as RD using("InvoiceId")
where RI."TrackId" = 635 and RD."TrackId" = 662;

select distinct "InvoiceId"
from "InvoiceLine"
where "TrackId" = 635 and "InvoiceId" in (select distinct "InvoiceId"
                                          from "InvoiceLine"
                                          where "TrackId" = 662)
                                          
-- operaciones de conjuntos

-- recuperar los identificadores de factura de aquellas en las que se haya comprado
-- la canción con identificador 10 o 20
select distinct "InvoiceId"
from "InvoiceLine"
where "TrackId" in (10, 20)

select distinct "InvoiceId"
from "InvoiceLine"
where "TrackId" = 10
union
 select distinct "InvoiceId"
from "InvoiceLine"
where "TrackId" = 20 

-- listar el nombre y el apellido de todos los clientes y los empleados
select "FirstName", "LastName", 'Customer' as Tipo
from "Customer"  
union 
select "FirstName", "LastName", 'Employee' as Tipo
from "Employee"                                        
                        
-- regresando con repeticiones                       
select "FirstName", "LastName", 'Customer' as Tipo
from "Customer"  
union all
select "FirstName", "LastName", 'Employee' as Tipo
from "Employee"       

-- diferencia de conjuntos (except)
A = {a, b, c}
B = {a}
A - B = {b, c}
-- Listar los identificadores de artistas que no tienen albumes registrados
select "ArtistId"
from "Artist"
except
select distinct "ArtistId"
from "Album" 

-- listar los nombres de artistas que no tienen albumes registrados
select "Name"
from "Artist"
where "ArtistId" not in (select distinct "ArtistId"
                       from "Album")    
                       
-- usando subconsultasc correlacionadas
select "Name"
from "Artist" as a
where not exists (select 1 -- puede calcular 
                  from "Album"
                  where "ArtistId" = a."ArtistId") 
                  
-- Intersección (intersect)
-- Listar el identificador de factura en los cuales se hayan comprado las canciones
-- con identificador 635 y 662
select "InvoiceId"
from "InvoiceLine"
where "TrackId" = 635  
intersect
select "InvoiceId"
from "InvoiceLine"
where "TrackId" = 662 