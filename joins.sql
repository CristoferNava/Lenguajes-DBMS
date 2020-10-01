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
