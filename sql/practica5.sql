-- Mostrar el nombre (renombrar nomb), apellido (renombrar apel) y cantidad de ordenes 
-- atendidas (renombrar cord) de los empleados que atendieron mas del promedio de 
-- ordenes atendidas por todos los empleados en el año 1997 (por ejemplo, - 
-- Esquema (3 columnas): [apel, cord, nomb], 4 renglon(es) (Primer Tuppla: | callahan | 54 | laura |). Llave validacion: Mw==
SELECT DISTINCT employees.last_name as apel, COUNT (order_id) as cord, employees.first_name as nomb
FROM employees NATURAL JOIN orders 
WHERE EXTRACT(YEAR FROM order_date) = '1997'
GROUP BY nomb, apel
HAVING COUNT (order_id) >= (SELECT COUNT (order_id)/(SELECT COUNT(employee_id) FROM employees)
                            FROM employees NATURAL JOIN orders 
                            WHERE EXTRACT(YEAR FROM order_date) = '1997') 
c2933c59915af3cc7a7d9654ab2b9297

-- Mostrar el listado del pais de los clientes (renombrar pais) y la cantidad de clientes (renombrar ccli) 
-- pertenecientes a cada pais (por ejemplo, - Esquema (2 columnas): [ccli, pais], 
-- 21 renglon(es) (Primer Tuppla: | 1 | ireland |). Llave validacion: MQ==
SELECT DISTINCT COUNT(customer_id) OVER(PARTITION BY country) AS ccli, country AS pais 
FROM customers
ORDER BY ccli
7ba58e115905ac28e5b8af6790793675

-- Listar el nombre de los productos (renombrar npro) y la cantidad de clientes que lo compran (renombrar ccom). 
-- Mostrar solamente las que tienen 20 clientes o mas que los compran (por ejemplo, 
-- Esquema (2 columnas): [ccom, npro], 46 renglon(es) (Primer Tuppla: | 20 | uncle bobs organic dried pears |). 
-- Llave validacion: Mg==
SELECT DISTINCT COUNT(DISTINCT customer_id) as ccom, products.product_name as npro
FROM orders NATURAL JOIN order_details JOIN products USING (product_id)
GROUP BY product_name
HAVING COUNT (DISTINCT customer_id) >= 20
ORDER BY ccom asc;
ef10eca59329bed3f9ec6e412eb115fa