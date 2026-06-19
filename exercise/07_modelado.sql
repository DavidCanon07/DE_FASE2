
create table dim_mesero (
	id_mesero serial4 NOT NULL,
	nombre varchar(100) not NULL,
	turno varchar(50) not NULL,
	anios_experiencia numeric(10, 2) NULL,
	CONSTRAINT dim_meseros_pkey PRIMARY KEY (id_mesero)
);


insert into dim_mesero(nombre, turno, anios_experiencia)
values
	('Juan', 'día', 5),
	('David', 'Noche', 3),
	('Alberto', 'día', 2),
	('Jordi', 'Noche', 0.5),
	('Leonardo', 'día', 8);
	
select nombre, turno, anios_experiencia from dim_mesero;

alter table fact_ventas 
add column id_mesero int;

alter table fact_ventas  
add constraint dim_meseros_ventas_pkey
foreign key (id_mesero)
references dim_mesero(id_mesero)

-- Responde en un comentario SQL: ¿por qué usarías surrogate key (SERIAL) en lugar de el nombre del mesero como PK?
-- R//Usaría el serial o PK debido a que no se repite por otro lado los nombre si se pueden repetir