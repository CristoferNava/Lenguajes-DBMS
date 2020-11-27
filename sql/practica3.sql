Listar el mes (renombrar mes), anio (renombrar ani) y cantidad de ordenes (renombrar cor) 
realizadas por el cliente con nombre de compania __companyname__ (mes y anio con respecto a la 
fecha de orden) (por ejemplo, __companyname__ : 'Around the Horn' - Esquema (3 columnas): 
[ani, cor, mes], 10 renglon(es) (Primer Tuppla: | 1996 | 1 | 11 |). 
Llave validacion: Nw==
select distinct extract(year from order_date) as anio, count(orders.order_id) as cor, extract(month from order_date) as mes 
from orders natural join customers
where company_name = 'Around the Horn'
group by orders.order_id
order by anio

Listar el nombre (renombrar nom), apellido (renombrar ape), fecha de nacimiento (renombrar fdn) 
de todos los empleados que su mes de nacimiento sea __month__ (por ejemplo, __month__ : 
1 - Esquema (3 columnas): [ape, fdn, nom], 2 renglon(es) (Primer Tuppla: | callahan | 1958-01-09 | laura |). 
Llave validacion: Mg==
select first_name as nom, last_name as ape, birth_date as fdn
from employees
where extract(month from birth_date) = 01


Listar el nombre de producto (renombar pro), nombre de categoria (renombrar cat) y el estado 
(renombrar est, si su descontinuado es 1 colocar 'No vigente', si es 0 colocar 'Vigente') de las 
categorias con nombre __name1__ o __name2__ (por ejemplo, __name1__ : 'Beverages', __name2__ : 'Produce' - Esquema (3 columnas): [cat, est, pro], 
17 renglon(es) (Primer Tuppla: | beverages | no vigente | chai |). Llave validacion: NA==
select product_name as pro, category_name as cat, case when discontinued = 0 then 'Vigente' else 'No vigente' end
from products
natural join categories
where category_name in ('Beverages', 'Produce')
order by cat

Listar el identificador de empleado (renombrar eid), el identificador de cliente (renombrar cno) 
y cantidad de veces que el empleado a atendido ordenes al cliente (renombrar nat) 
(por ejemplo, - Esquema (3 columnas): [cno, eid, nat], 819 renglon(es) 
(Primer Tuppla: | alfki | 1 | 2 |). Llave validacion: OA==