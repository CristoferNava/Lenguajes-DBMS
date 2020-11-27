-- Listar los clientes que son del país Brazil y no tienen compañía registrada.
select * from "Customer" where "Country" = 'Brazil' and "Company" is null;

-- Listar los títulos de canciones que no contienen la palabra rock.
select * from "Track" where not ("Name"  like '% Rock %' or "Name" like '% rock %');

-- Listar los clientes que son del país Brazil o Argentina.
select * from "Customer" where "Country" in ('Brazil', 'Argentina');

-- Listar todas las facturas con fecha de factura del año 2009 excepto las del mes de mayo.
select * from "Invoice" where ("InvoiceDate" between '2009-01-01' and '2009-12-31') and not ("InvoiceDate" between '2009-05-01' and '2009-05-31');

-- Listar todos los empleados que no le reportan a ningún otro empleado.
select * from "Employee" where "ReportsTo" is null;

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

-- listar los artistas de las canciones que ha comprado Alexandre Rocha
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
                       
-- usando subconsultas correlacionadas
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

-- Operaciones aritméticas
-- Mostrar los subtotales de todos los detalles de factura
select "UnitPrice" * "Quantity" as subtotal
from "InvoiceLine"                                              
                 
-- Mostrar el nombre de la canción y su duración en milisegundos y segundos
select "Name", "Milliseconds", "Milliseconds" / 1000.0 as seconds
from "Track" 

-- Cambiar a valor negativo el precio unitario de las canciones y mostrar el nombre
select "Name", -"UnitPrice"
from "Track"    

-- Mostrar el nombre de las canciones y su precio unitario con incremento del 15%
select "Name", "UnitPrice" + "UnitPrice" * 0.15
from "Track"  

-- Mostrar el nombre de las canciones y su precio unitario con descuento del 15%
select "Name", "UnitPrice" - "UnitPrice" * 0.15
from "Track"                                                              
                                          
-- Manipulación de cadenas
-- Listar los nombres y apellidos de los empleados
select "FirstName" || ' ' || "LastName" as FullName
from "Employee"                                          
 
-- Listar los titulos de albumes (en mayúsculas) del artista con nombre 'nirvana'
select upper("Title")
from "Album"
where "ArtistId" = (select "ArtistId"
                  from "Artist"
                  where lower("Name") = lower('NIRVANA'))   
                  
select "Title"
from "Album"
where "ArtistId" = (select "ArtistId"
                  from "Artist"
                  where "Name" = trim(' Nirvana '))  
                  
select "Title"
from "Album"
where "ArtistId" = (select "ArtistId"
                  from "Artist"
                  where "Name" = trim(both ' ' from ' Nirvana '))   
                  
-- Listar la inicial del primer nombre seguida de un punto y el apellido de los clientes
select substring("FirstName" from 1 for 1) || '. ' || "LastName" as fullname
from "Customer" 

-- Overlaps, si hay fechas con empalme regresa true, de lo contrario false
select ('01-Jan-2020'::DATE, '31-Dec-2020'::DATE) overlaps ('31-Dec-2020'::DATE, '31-Jan-2021'::DATE)

-- listar todas las facturas del año 2009
select *
from "Invoice"
where "InvoiceDate" between '2009-01-01' and '2009-12-31'

-- haciendo uso de track
select *
from "Invoice"
where extract(year from "InvoiceDate") = 2009

-- mostrar un listado aplicado a las canciones con el siguiente descuento de acuerdo
-- a su género siendo 15% para rock, 10% para metal, y 5% para el resto
select "Track"."Name", "Genre"."Name", "UnitPrice", (case
                                                        when "Genre"."Name" = 'Rock' then "UnitPrice" * 0.85
                                                        when "Genre"."Name" = 'Rock' then "UnitPrice" * 0.85
                                                        else "UnitPrice" * 0.95
                                                      end) as disc
from "Track" join "Genre" using ("GenreId")

-- funciones de agregación
-- mostrar la cantidad de canciones registradas
select count(*) -- cuenta todo lo no null
from "Track"

select count("Composer")
from "Track"

-- listar el total vendido en todas las facturas
select sum("Total")
from "Invoice"

-- Listar el promedio de totales de las facturas
select avg("Total")
from "Invoice"

-- Grupos
-- Listar nombre de artista y cantidad de albumes que tiene registrados
-- siempre y cuando tenga más de 5 albums
select "Name", count(*)
from "Album" natural join "Artist"
group by "ArtistId", "Name" -- evita que haya artistas repetidos
having count(*) > 5
order by "Name";

-- Número de albums que tiene cada artista
select "Name", count(*)
from "Album" natural join "Artist"
group by "ArtistId", "Name" 
order by "Name"

-- Número de canciones que tien cada album
select "Title", count(*)
from "Album" natural join "Track"
group by "AlbumId" 
order by "Title"

-- Listar el nombre de artista y cantidad de albums registrados, y cantidad de 
-- canciones registradas    
SELECT "Artist"."ArtistId","Name", CASE WHEN T_album IS NULL THEN 0 ELSE T_album END AS ta, CASE WHEN T_track IS NULL THEN 0 ELSE T_track END AS tt
FROM "Artist" LEFT OUTER JOIN
(SELECT "ArtistId", T_album, T_track
FROM (SELECT "ArtistId", COUNT(*) AS T_album
FROM "Album"
GROUP BY "ArtistId") AS alb
NATURAL JOIN
(SELECT "ArtistId", COUNT(*) AS T_track
FROM "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
GROUP BY "ArtistId") AS tra) AS summary ON "Artist"."ArtistId" = summary."ArtistId"
ORDER BY "ArtistId";

-- Listar el identificador de factura, el total y la proporción de total al acumulado de ventas
SELECT "InvoiceId", "Total", "Total" / (SELECT SUM("Total") AS tt FROM "Invoice") AS paporte
FROM "Invoice"
ORDER BY "InvoiceId";

-- Listar el identificador de factura, identificador de canción, precio unitario, total acumulado, y total de la factura
SELECT "InvoiceId", "TrackId", SUM("UnitPrice" * "Quantity") OVER (PARTITION BY "InvoiceId" ORDER BY "InvoiceId", "TrackId") AS Acu,
                               SUM("UnitPrice" * "Quantity") OVER (PARTITION BY "InvoiceId") AS Total
from "InvoiceLine";