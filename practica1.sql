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