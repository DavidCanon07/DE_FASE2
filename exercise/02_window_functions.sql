-- consulta base(X)

select
	id_cliente,
	id_fecha,
	ventas,
	lag(ventas) over ( order by id_fecha) as venta_anterior
from fact_ventas


--venta anterior del cliente
select
	id_cliente,
	id_fecha,
	ventas,
	lag(ventas) over (partition by id_cliente order by id_fecha) as venta_anterior
from fact_ventas

