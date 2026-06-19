--consulta base (X)
select
    f.mes,
    v.ventas as ventas_del_mes,
    SUM(v.ventas) over (order by f.mes) as ventas_acumuladas
from dim_fecha f
join fact_ventas v on v.id_fecha = f.id_fecha

-- Acumulado de ventas por mes

with ventas_mes as(
	select
		df.mes,
		SUM(fv.ventas) as ventas_del_mes
	from dim_fecha df
	join fact_ventas fv on fv.id_fecha = df.id_fecha 
	group by df.mes 
)

select
	vm.mes,
	vm.ventas_del_mes,
	SUM(vm.ventas_del_mes) over (order by vm.mes) as ventas_acumuladas
from ventas_mes vm


