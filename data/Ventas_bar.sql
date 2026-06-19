CREATE TABLE dim_productos (
    id_producto     SERIAL PRIMARY KEY,
    nombre          VARCHAR(100),
    categoria       VARCHAR(50),
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE dim_clientes (
    id_cliente  SERIAL PRIMARY KEY,
    nombre      VARCHAR(100),
    ciudad      VARCHAR(50),
    segmento    VARCHAR(30)
);

CREATE TABLE dim_fecha (
    id_fecha    INTEGER PRIMARY KEY,
    fecha       DATE,
    anio        INTEGER,
    mes         INTEGER,
    dia         INTEGER,
    dia_semana  VARCHAR(20)
);

CREATE TABLE fact_ventas (
    id_venta    SERIAL PRIMARY KEY,
    id_producto INTEGER REFERENCES dim_productos(id_producto),
    id_cliente  INTEGER REFERENCES dim_clientes(id_cliente),
    id_fecha    INTEGER REFERENCES dim_fecha(id_fecha),
    cantidad    INTEGER,
    ventas      DECIMAL(10,2),
    costo       DECIMAL(10,2)
);

INSERT INTO dim_productos VALUES
(1,'Aguardiente Antioqueño','licores',28000),
(2,'Club Colombia','cervezas',5000),
(3,'Poker','cervezas',4500),
(4,'Ron Medellín','licores',35000),
(5,'Gaseosa Postobón','no_alcoholicas',3000),
(6,'Agua','no_alcoholicas',2000),
(7,'Chicharrón','comidas',15000),
(8,'Alitas BBQ','comidas',22000),
(9,'Tequila','licores',45000),
(10,'Vino tinto','vinos',38000);

INSERT INTO dim_clientes VALUES
(1,'Carlos Pérez','Bogotá','frecuente'),
(2,'María López','Medellín','ocasional'),
(3,'Juan Torres','Bogotá','frecuente'),
(4,'Ana Gómez','Cali','nuevo'),
(5,'Pedro Ruiz','Bogotá','frecuente'),
(6,'Laura Díaz','Barranquilla','ocasional'),
(7,'Sergio Castro','Bogotá','nuevo'),
(8,'Camila Mora','Medellín','frecuente');

INSERT INTO dim_fecha VALUES
(20240101,'2024-01-01',2024,1,1,'lunes'),
(20240115,'2024-01-15',2024,1,15,'lunes'),
(20240201,'2024-02-01',2024,2,1,'jueves'),
(20240215,'2024-02-15',2024,2,15,'jueves'),
(20240301,'2024-03-01',2024,3,1,'viernes'),
(20240315,'2024-03-15',2024,3,15,'viernes'),
(20240401,'2024-04-01',2024,4,1,'lunes'),
(20240415,'2024-04-15',2024,4,15,'lunes'),
(20240501,'2024-05-01',2024,5,1,'miercoles'),
(20240515,'2024-05-15',2024,5,15,'miercoles');

INSERT INTO fact_ventas (id_producto,id_cliente,id_fecha,cantidad,ventas,costo) VALUES
(1,1,20240101,3,84000,54000),
(2,1,20240101,6,30000,18000),
(3,2,20240115,4,18000,10000),
(4,3,20240201,2,70000,44000),
(5,4,20240201,5,15000,8000),
(1,5,20240215,2,56000,36000),
(8,5,20240215,3,66000,39000),
(2,6,20240301,8,40000,24000),
(9,7,20240301,1,45000,28000),
(10,8,20240315,2,76000,48000),
(7,1,20240401,4,60000,32000),
(3,2,20240401,6,27000,15000),
(1,3,20240415,4,112000,72000),
(4,4,20240501,1,35000,22000),
(8,5,20240501,5,110000,65000),
(2,6,20240515,10,50000,30000),
(9,1,20240515,2,90000,56000),
(10,3,20240515,1,38000,24000),
(5,7,20240515,3,9000,5000),
(6,8,20240101,4,8000,3000);