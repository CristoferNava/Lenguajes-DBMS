-- Listar los diferentes identificadores de proveedores de los cuales se tienen 
-- productos con el atributo discontinued igual a __discontinued__
select distinct supplier_id 
from products
where discontinued = __discontinued__;

-- Listar el identificador, nombre de compañía, nombre de contacto, título del 
-- contacto y país de los clientes cuyo título de contacto sea
-- __contacttitle1__ o __contacttitle2__ y su país sea __country1__ o __country2__
select customer_id, company_name, contact_name, contact_title, country 
from customers 
where contact_title in (__contacttitle1__, __contacttitle2__) and country in (__country1__, __country2__);

-- Listar los identificadores de productos y los precios unitarios de los 
-- diferentes productos comprados en las ordenes con identificadores
-- diferentes a __orderid1__, __orderid2__, __orderid3__,  __orderid4__
select distinct product_id, unit_price 
from order_details 
where order_id not in (__orderid1__, __orderid2__, __orderid3__, __orderid4__);
 
-- Listar todas las ordenes del cliente con identificador igual a __customerid__
select *
from orders
where customer_id = __customerid__;

-- Listar el nombre de producto e identificador de categoría de todos los productos 
-- que en la cantidad por unidad contengan la subcadena __quantityperunit__
-- y que su valor discontinuado sea __discontinued__
select product_name, category_id
from products
where quantity_per_unit like __quantityperunit__ and discontinued = __discontinued__;