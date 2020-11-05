-----------------------------
Listar el nombre de compania de los diferentes clientes que han sido atendidos por subditos del empleado con nombre __firstname__ y apellido __lastname__ (por ejemplo, __firstname__ : 'Steven' , __lastname__ : 'Buchanan' - Esquema (1 columnas): [company_name], 74 renglon(es) (Primer Tuppla: | alfreds futterkiste |). Llave validacion: OQ==
SELECT DISTINCT company_name
FROM customers NATURAL JOIN orders NATURAL JOIN (SELECT EMPl.employee_id
                                                  FROM employees AS EMPL
                                                   WHERE EMPL.reports_to = (select employee_id
                                                                        from employees
                                                                        where first_name=__firstname__ and last_name=__lastname__)) AS EM ORDER BY company_name
031ab106763e97a649814b093eb3ea9e
--------------------------------

--------------------------------
Listar el identificador de orden, nombre de compania cliente e identificador de empleado relacionado con las 
ordenes con fecha de orden __orderdate__ (por ejemplo, __orderdate__ : '1996-08-01' - 
Esquema (3 columnas): [company_name, employee_id, order_id], 2 renglon(es) 
(Primer Tuppla: | split rail beer & ale | 6 | 10271 |). Llave validacion: NA==

select orders.order_id, customers.company_name, employees.employee_id
from customers 
natural join orders 
join employees using(employee_id)
where orders.order_date = __orderdate__

84a256710b878577a31d4221c704d5b2
-------------------------------

------------------------------
Listar el nombre de producto y nombre de categoria de los productos de las categorias con 
nombre __cname1__ o __cname2__ (por ejemplo, __cname1__ : 'Seafood', __cname2__ : 'Condiments' - 
Esquema (2 columnas): [category_name, product_name], 24 renglon(es) 
(Primer Tuppla: | condiments | aniseed syrup |). Llave validacion: MQ==

select products.product_name, categories.category_name
from products
natural join categories
where categories.category_name in('Seafood', 'Condiments')

eb3031bfbf35de5d2b837f786f0255c4
--------------------------------

-------------------------------
Listar el nombre de producto, precio unitario de catalogo (renombrar como upList) y 
precio unitario en el que se ha vendido (en order_details, renombrar como upSale), 
siempre y cuando los precios difieran y la fecha de orden este en el 
rango __orderdate1__ y orderdate2__ 
(por ejemplo, __orderdate1__ : '1997-01-01' , __orderdate2__ : '1997-06-30' - 
Esquema (3 columnas): [product_name, uplist, upsale], 70 renglon(es) 
(Primer Tuppla: | alice mutton | 39 | 31.2 |). Llave validacion: OA==

select distinct products.product_name, products.unit_price as upList, 
       order_details.unit_price as upSale
from products
join order_details using(product_id)
join orders using(order_id)
where orders.order_date  between __orderdate1__ and __orderdate2__ and (products.unit_price != order_details.unit_price)
order by products.product_name

855f312488ba2d6db14e217c9c71a1cb
---------------------------------

-----------------------------------
Listar el numero de empleado, nombre y apellido de los subiditos del empleado con 
nombre __firstname__ y apellido __lastname__ (por ejemplo, __firstname__ = 'Andrew' , __lastname__ = 'Fuller' 
- Esquema (2 columnas): [first_name, last_name], 5 renglon(es) (Primer Tuppla: | janet | leverling |). 
Llave validacion: Ng==

SELECT EMPl.employee_id, EMPl.first_name, EMPl.last_name
FROM employees AS EMPL
WHERE EMPL.reports_to = (select employee_id
from employees
where first_name='Andrew' and last_name='Fuller')
order by EMPl.first_name

37597b9f7d8d2fe2cff6ba6bde5c7459
-------------------------------------

-----------------------------
Listar el nombre de producto y el precio de compra de los productos de las 
diferentes compras realizadas por el cliente cuya compania se llama __companyname__ 
(por ejemplo, __companyname__ : 'Alfreds Futterkiste' - Esquema (2 columnas): 
[product_name, unit_price], 11 renglon(es) (Primer Tuppla: | aniseed syrup | 10 |). 
Llave validacion: Nw==

select distinct products.product_name, products.unit_price
from products
join order_details using(product_id)
join orders using(order_id)
join customers using(customer_id)
where customers.company_name = 'Alfreds Futterkiste'
order by products.product_name

e2854b6764fff7aaa3f699dee0813453
---------------------------------

--------------------------------
Listar el nombre de companias de clientes en comun a los que han despachado ordenes 
los repartidores con nombre de compania __companyname1__ y __companyname2__ 
(por ejemplo, __companyname1__ : 'Speedy Express' , __companyname2__ : 'United Package' - 
Esquema (1 columnas): [company_name], 76 renglon(es) (Primer Tuppla: | alfreds futterkiste |). 
Llave validacion: MTA=

(
SELECT DISTINCT customers.company_name
FROM customers NATURAL JOIN orders JOIN shippers ON (ship_via = shipper_id)
WHERE shippers.company_name = 'Speedy Express'
INTERSECT
SELECT DISTINCT customers.company_name
FROM customers NATURAL JOIN orders JOIN shippers ON (ship_via = shipper_id)
WHERE shippers.company_name = 'United Package' 
)
order by company_name
d6956e222b6641c35e0094e826d2098a
----------------------------------------

----------------------------------
Listar el identificador de orden y de cliente, y el nombre de producto de todas 
las ordenes con fecha de orden __orderdate__ (por ejemplo, __orderdate__ : '1996-08-01' 
- Esquema (3 columnas): [customer_id, order_id, product_name], 3 renglon(es) 
(Primer Tuppla: | splir | 10271 | geitost |). Llave validacion: Mw==

SELECT order_id, customer_id, product_name
FROM customers NATURAL JOIN orders JOIN order_details USING (order_id) JOIN products USING (product_id)
WHERE order_date = '1996-08-01';
eb9a2feec640c860ca821d3773964ec8

--------------------------------
Listar el nombre de compania del cliente (renombrar as cus_compname), identificador 
de orden y nombre de compañia del repartidor (renombrar as ship_compname) asociado a 
la orden de aquellas con fecha de orden entre __orderdate1__ y __orderdate2__ 
(por ejemplo, __orderdate1__ : '1997-01-01' , __orderdate2__ : '1997-06-30' - 
Esquema (3 columnas): [cus_compname, order_id, ship_compname], 185 renglon(es) 
(Primer Tuppla: | antonio moreno taqueria | 10507 | speedy express |). Llave validacion: NQ==

select customers.company_name as cus_compname, orders.order_id, shippers.company_name as ship_compname
from customers
natural join orders
join shippers ON (ship_via = shipper_id)
where orders.order_date between '1997-01-01' and '1997-06-30'
ORDER BY customers.company_name;

a314d4418f249b03bce975a04c7500ce
-------------------------------------


-------------------
Listar el nombre de producto y de compania del proveedor de aquellos provedores 
cuyo pais es __country__ (por ejemplo, __country__ : 'USA' - Esquema (2 columnas): 
[company_name, product_name], 12 renglon(es) 
(Primer Tuppla: | bigfoot breweries | laughing lumberjack lager |).
 Llave validacion: Mg==

select products.product_name, suppliers.company_name
from products
natural join suppliers
where suppliers.country = 'USA'
order by products.product_name

3286e50728cdb87e5b975633847d09f8

--------