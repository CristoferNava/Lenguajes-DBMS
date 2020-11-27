Listar el nombre del producto (renombrar npr) y precio unitario (pun) de los productos mas caros (por ejemplo, - 
Esquema (2 columnas): [npr, pun], 1 renglon(es) (Primer Tuppla: | cote de blaye | 263.5 |). Llave validacion: NA==
SELECT product_name AS npr, unit_price AS pun
FROM products
WHERE unit_price =(SELECT MAX(unit_price) FROM products);
7924cea35aa12fe7869f7e39e5617746

Mostrar el nombre de producto (renombrar npr) y cantidad por unidad (renombrar cpu) de los 
productos pertenecientes a la categoria con nombre __categoryname__ (por ejemplo, __categoryname__ : 
Seafood - Esquema (2 columnas): [cpu, npr], 12 renglon(es) (Primer Tuppla: | 10 - 200 g glasses | nord-ost matjeshering |). 
Llave validacion: Mw==
SELECT quantity_per_unit as cpu, product_name as npr 
FROM products NATURAL JOIN categories
WHERE category_name = __categoryname__
order by cpu;
02ed0969f907860a63a0a84a6b5abb65

Listar el identificador de producto (renombrar pid) y la cantidad (renombrar can) 
que ha sido compradas de acuerdo a los registros en detalle de orden (considerar el atributo quantity) 
siempre y cuando el proudcto haya sido comprado mas de __sqty__ veces (por ejemplo, - __sqty__ : 100 - 
Esquema (2 columnas): [can, pid], 76 renglon(es) (Primer Tuppla: | 1016 | 21 |). 
Llave validacion: Mg==
SELECT SUM (quantity) as can, product_id AS pid 
FROM order_details 
GROUP BY (product_id) 
HAVING SUM (quantity) > __sqty__
97c2abcbf33d3b00f32991f1d00f6155

Listar la cantidad de compras atendidas (nombrar ncom) del empleado con identificador 
__employeeid__ en el año de la feca de orden sea __year__ 
(por ejemplo, - __employeeid__ : 4, __year__ = 1998 -Esquema (1 columnas): 
[ncom], 1 renglon(es) (Primer Tuppla: | 44 |). 
Llave validacion: MQ==
SELECT COUNT(*) AS ncom 
FROM orders 
NATURAL JOIN employees 
WHERE employee_id=__employeeid__ AND EXTRACT(YEAR FROM order_date)=__year_;
66ac950385f44946b28ed812225f6ac8

Listar el nombre de compania de cliente (renombrar nco), identificador de orden (oid) y total 
de cuenta (renombrar tot, considerar descuento, precio unitario y cantidad) (por ejemplo, 
- Esquema (3 columnas): [nco, oid, tot], 
830 renglon(es) (Primer Tuppla: | alfreds futterkiste | 10643 | 814.4999828338623 |). 
Llave validacion: NQ==
SELECT company_name AS nco, order_id AS oid, allC AS tot 
FROM orders 
NATURAL JOIN customers 
JOIN (SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS allC
      FROM order_details 
      GROUP BY (order_id)) AS alls USING (order_id) ORDER BY (company_name);
293780781acff81a3179eeb653d2b94b