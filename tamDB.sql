-- Creacion de la base de datos
create database TijuanaArtisanMixology
go

-- Seleccion de base de datos
use TijuanaArtisanMixology
go

-- Tabla de Clientes
create table Clientes (
id_cliente int primary key,                         -- Llave primaria: identificador unico del cliente
nombre varchar (100) not null,                      -- Restriccion de entidad: NOT NULL asegura que siempre haya nombre
correo varchar (100) unique not null,               -- Restriccion de entidad: NOT NULL y UNIQUE para evitar duplicados
telefono varchar (20),
preferencia_bebidas varchar (100),
puntos_acumulados int default 0,                    -- Restriccion de dominio: valor por defecto de 0
fecha_registro date default getdate()               -- Restriccion de dominio: fecha automatica del sistema
)
go

-- Tabla de Ingredientes
create table Ingredientes (
id_ingredientes int primary key,                    -- Llave primaria
nombre_ingrediente varchar(100) not null,           -- Restriccion de entidad
stock int check (stock >= 0),                       -- Restriccion de dominio: no se permiten valores negativos
unidad_medida varchar (20),
costo_unitario float check (costo_unitario >= 0)    -- Restriccion de dominio
)
go

-- Tabla del Menú
create table Menu (
id_bebida int primary key,                          -- Llave primaria
nombre_bebida varchar(100) not null,                -- Restriccion de entidad
id_ingredientes int,                                -- Llave foranea referenciando a Ingredientes
precio float check (precio >= 0),                   -- Restriccion de dominio
popularidad int default 0,                          -- Restriccion de dominio: valor por defecto
foreign key (id_ingredientes) references Ingredientes(id_ingredientes)  -- Restriccion referencial
)
go

-- Tabla de Pedidos
create table Pedidos (
id_pedido int primary key,                          -- Llave primaria
id_cliente int,                                     -- Llave foranea referenciando a Clientes
detalles_pedido varchar (255),
total_consumo float check (total_consumo >= 0),     -- Restriccion de dominio
forma_pago varchar (50),
fecha_pedido datetime default getdate(),            -- Restriccion de dominio
foreign key (id_cliente) references Clientes(id_cliente)  -- Restriccion referencial
)
go

-- Tabla de Personal
create table Personal (
id_mesero int primary key,                          -- Llave primaria
nombre varchar(100) not null,                       -- Restriccion de entidad
turno varchar(20),
id_pedido int,                                      -- Llave foranea referenciando a Pedidos
total_pedidos_atendidos int default 0,              -- Restriccion de dominio
desempeno int check (desempeno between 1 and 10),   -- Restriccion de dominio: valores validos entre 1 y 10
foreign key (id_pedido) references Pedidos (id_pedido)  -- Restriccion referencial
)
go


-- Insercion de los datos
-- Clientes
insert into Clientes values (1, 'Aleluyo Manito', 'aleluyo@example.com', '6641000001', 'Tequila Sunrise', 120, default)
insert into Clientes values (2, 'Charlie Fenti', 'charlie@example.com', '6641000002', 'Whisky Sour', 95, default)
insert into Clientes values (3, 'Omar S. Diddy', 'omar@example.com', '6641000003', 'Vodka Tonic', 210, default)
insert into Clientes values (4, 'Saul Jarambe', 'saul@example.com', '6641000004', 'Mojito', 180, default)
insert into Clientes values (5, 'Emilio Epstein', 'emilio@example.com', '6641000005', 'Cuba', 300, default)
go

-- Ingredientes
insert into Ingredientes values (1, 'Ron Blanco', 1000, 'ml', 1.20)
insert into Ingredientes values (2, 'Limon', 300, 'g', 0.50)
insert into Ingredientes values (3, 'Azucar', 500, 'g', 0.30)
insert into Ingredientes values (4, 'Vodka', 800, 'ml', 1.40)
insert into Ingredientes values (5, 'Menta', 100, 'g', 0.70)
go

-- Menu
insert into Menu values (1, 'Mojito Clasico', 1, 85.0, 8)
insert into Menu values (2, 'Whisky Sour', 2, 90.0, 6)
insert into Menu values (3, 'Vodka Tonic', 4, 70.0, 9)
insert into Menu values (4, 'Daiquiri', 3, 80.0, 7)
insert into Menu values (5, 'Piña Colada', 5, 95.0, 5)
go

-- Pedidos
insert into Pedidos values (1, 1, '2 Mojito Clasico', 170.0, 'Efectivo', default)
insert into Pedidos values (2, 3, '1 Vodka Tonic', 70.0, 'Tarjeta', default)
insert into Pedidos values (3, 5, '1 Old Fashioned', 100.0, 'Efectivo', default)
insert into Pedidos values (4, 2, '1 Whisky Sour', 90.0, 'Tarjeta', default)
go

-- Personal
insert into Personal values (1, 'Marcos Reyes', 'Tarde', 1, 45, 9)
insert into Personal values (2, 'Laura Soto', 'Noche', 2, 33, 8)
insert into Personal values (3, 'David Luna', 'Tarde', 3, 28, 7)
insert into Personal values (4, 'Ana López', 'Mañana', 4, 55, 10)
go

-- Actualizacion de registros
-- Actualizar puntos acumulados de un cliente
update Clientes
set Puntos_Acumulados = 350
where Nombre = 'Emilio Epstein'
go

-- Actualizar stock y costo de 'Ron Blanco'
update Ingredientes
set Stock = 800, Costo_Unitario = 1.30
where Nombre_Ingrediente = 'Ron Blanco'
go

-- Cambiar forma de pago de un pedido
update Pedidos
set Forma_Pago = 'Transferencia'
where Id_Pedido = 4
go

-- Eliminacion de registros
-- Eliminar un pedido específico
delete from Pedidos
where Id_Pedido = 2
go

-- Eliminar cliente 
delete from Clientes
where Nombre = 'Omar S. Diddy'
go

-- Eliminar bebida del menu
delete from Menu
where Nombre_Bebida = 'Daiquiri'
go

-- Consultas
-- Mostrar todos los clientes ordenados por puntos acumulados
select * from Clientes
order by Puntos_Acumulados desc
go

-- Consultar los pedidos junto con el nombre del cliente
select P.Id_Pedido, C.Nombre as Cliente, P.Detalles_Pedido, P.Total_Consumo
from Pedidos P
join Clientes C on P.Id_Cliente = C.Id_Cliente
go

-- Ver bebidas con precio mayor a 80
select Nombre_Bebida, Precio
from Menu
where Precio > 80
go

-- Consultar ingredientes con bajo stock (menor a 200)
select Nombre_Ingrediente, Stock
from Ingredientes
where Stock < 200
go

-- Modificaciones
-- Agregar columna de correo alternativo en clientes
alter table Clientes
add Correo_Alternativo varchar(100)
go

-- Cambiar tipo de dato de Total_Consumo a decimal
alter table Pedidos
alter column Total_Consumo decimal(10,2)
go

-- Eliminaciones
-- Eliminar tabla Menu 
drop table Menu
go

-- Eliminar tabla Personal
drop table Personal
go

-------------------------------------------------Unidad 2----------------------------------------------------------------------------------

-- 1. GETDATE
-- Muestra los pedidos realizados en la fecha actual del sistema
SELECT * 
FROM Pedidos
WHERE CAST(fecha_pedido AS date) = CAST(GETDATE() AS date);
GO

-- 2. FORMAT
-- Muestra el ID del pedido junto con la fecha formateada en un estilo legible (dd/MM/yyyy hh:mm am/pm)
SELECT id_pedido, FORMAT(fecha_pedido, 'dd/MM/yyyy hh:mm tt') AS FechaFormateada
FROM Pedidos;
GO

-- 3. CONCAT
-- Combina el nombre del cliente con su bebida favorita en una sola columna de texto
SELECT CONCAT(nombre, ' prefiere ', preferencia_bebidas) AS PreferenciaCliente
FROM Clientes;
GO

-- 4. CAST
-- Convierte el valor numérico del total de consumo en texto
SELECT CAST(total_consumo AS varchar) AS TotalComoTexto
FROM Pedidos;
GO

-- 5. Funciones Agregadas (COUNT)
-- Cuenta el número total de clientes registrados
SELECT COUNT(*) AS TotalClientes
FROM Clientes;
GO

-- 6. Agrupación (GROUP BY + SUM)
-- Muestra el total de consumo agrupado por cada forma de pago
SELECT forma_pago, SUM(total_consumo) AS TotalPorPago
FROM Pedidos
GROUP BY forma_pago;
GO

-- 7. WHERE con AND, OR, NOT y comparadores
-- Muestra los clientes que tienen más de 100 puntos y no prefieren la bebida 'Mojito'
SELECT * 
FROM Clientes
WHERE puntos_acumulados > 100 AND preferencia_bebidas <> 'Mojito';
GO

-- 8. BETWEEN, LIKE, IN, ISNULL, NOT NULL
-- Muestra clientes cuyo nombre contiene la letra 'a', tienen puntos entre 100 y 200, y un correo no nulo
SELECT * 
FROM Clientes
WHERE nombre LIKE '%a%'
  AND puntos_acumulados BETWEEN 100 AND 200
  AND correo IS NOT NULL;
GO

-- 9. JOINs
-- INNER JOIN: Muestra los pedidos junto al nombre del cliente que los realizó
SELECT P.id_pedido, C.nombre, P.total_consumo
FROM Pedidos P
INNER JOIN Clientes C ON P.id_cliente = C.id_cliente;
GO

-- LEFT JOIN: Muestra todos los clientes y los pedidos si existen (clientes sin pedidos también aparecerán)
SELECT C.nombre, P.id_pedido
FROM Clientes C
LEFT JOIN Pedidos P ON C.id_cliente = P.id_cliente;
GO

-- 10. SUM, COUNT, AVG, MIN, MAX
-- Muestra estadísticas de los pedidos: total, promedio, mínimo y máximo consumo
SELECT 
  SUM(total_consumo) AS Total,
  AVG(total_consumo) AS Promedio,
  MIN(total_consumo) AS Minimo,
  MAX(total_consumo) AS Maximo
FROM Pedidos;
GO

-- 11. GROUP BY
-- Muestra el total de consumo agrupado por cliente
SELECT id_cliente, SUM(total_consumo) AS TotalPorCliente
FROM Pedidos
GROUP BY id_cliente;
GO

/*-----------------------------------------------Unidad 3----------------------------------------------------------------------------------*/
--Roles usuario

--Creacion de vistas

--Respaldo

--Transacciones
-------------------------------------------------Unidad 4----------------------------------------------------------------------------------
/*		PROCEDIMIENTOS ALMACENADOS		*/

-- A)
-- Crear procedimiento almacenado
CREATE PROCEDURE Consultar AS
BEGIN -- Mostrar todos los clientes ordenados por puntos acumulados
	SELECT * FROM Clientes ORDER BY Puntos_Acumulados DESC
END;
go

-- Ejecutar procedimiento almacenado
EXEC Consultar;
go


-- B)
-- Modificar procedimiento almacenado 
ALTER PROCEDURE Consultar 
	@ID INT
AS
BEGIN -- Mostrar el cliente, puntos acumulados y total de pedidos realizados respecto al id 
	SELECT C.id_cliente AS '#', C.nombre AS Cliente, C.puntos_acumulados AS Puntos, COUNT(P.id_cliente) AS "Pedidos realizados"
	FROM Clientes C INNER JOIN Pedidos P ON C.id_cliente = P.id_cliente
	WHERE C.id_cliente = @ID
	GROUP BY C.id_cliente, C.nombre, C.puntos_acumulados
END;
go

-- Ejecutar procedimiento almacenado con parámetro
EXEC Consultar @ID = 2;
go

-- Eliminar procedimiento almacenado
DROP PROCEDURE Consultar;
go

-- C)
-- Crear procedimiento almacenado mediante transacciones
ALTER PROCEDURE RealizarPedido
    @id_cliente int,
	@id_pedido int,
    @detalles_pedido varchar(255),
    @total_consumo float,
    @forma_pago varchar(50),
    @id_mesero int,
	@puntos_otorgados int output -- Devolver puntos que obtuvo el cliente por consumo
as
BEGIN
-- Registra un nuevo pedido, actualiza los puntos del cliente según el consumo y asigna el pedido al mesero
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar el pedido
        INSERT INTO Pedidos VALUES (@id_pedido,@id_cliente, @detalles_pedido, @total_consumo, @forma_pago,default);

        -- Asignar el pedido al mesero
        UPDATE Personal SET id_pedido = @id_pedido, total_pedidos_atendidos = total_pedidos_atendidos + 1
        WHERE id_mesero = @id_mesero;

		-- Calcular puntos a otorgar y actualizarlo:
		--  (1 punto por cada $10)
        SET @puntos_otorgados = floor(@total_consumo / 10.0); -- Se redondea el número resultante

        UPDATE Clientes SET puntos_acumulados = puntos_acumulados + @puntos_otorgados
        WHERE id_cliente = @id_cliente;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
		SET @puntos_otorgados = -1; -- Asignar número como error
    END CATCH

END
go

-- Ejecutar
DECLARE @puntos int;
EXEC RealizarPedido
    @id_cliente = 2,
    @id_pedido = 5,
    @detalles_pedido = '2 frappes y 1 smoothie',
    @total_consumo = 86.50,
    @forma_pago = 'Efectivo',
    @id_mesero = 1,
    @puntos_otorgados = @puntos output;

SELECT @puntos AS PuntosOtorgados;




/*		DISPARADOR		*/

-- Aplicado a la tabla Menu después de insertar
CREATE TRIGGER actualizarStock ON Menu
AFTER INSERT AS
BEGIN -- Actualizar el stock del ingrediente utilizado cuando se insertó
    UPDATE Ingredientes SET stock = stock - 1
    FROM Ingredientes I INNER JOIN inserted ins -- Tabla temporal
	ON I.id_ingredientes = ins.id_ingredientes
    WHERE i.stock >= 1;
END
go


SELECT nombre_ingrediente, stock FROM Ingredientes WHERE id_ingredientes = 2    -- Verificar stock antiguo
INSERT INTO Menu VALUES (6, 'Margarita', 2, 90.0, 7);                           -- Activar disparador
SELECT nombre_ingrediente, stock FROM Ingredientes WHERE id_ingredientes = 2    -- Verificar stock nuevo
