-- Creacion de la base de datos
create database TijuanaArtisanMixology
go

-- Seleccion de base de datos
use TijuanaArtisanMixology
go

-- Tabla de clientes
create table Clientes (
id_cliente int primary key,
nombre varchar (100) not null,
correo varchar (100) unique not null,
telefono varchar (20),
preferencia_bebidas varchar (100),
puntos_acumulados int default 0,
fecha_registro date default getdate()
)

-- Tabla de ingredientes
create table Ingredientes (
id_ingredientes int primary key,
nombre_ingrediente varchar(100) not null,
stock int check (stock >= 0),
unidad_medida varchar (20),
costo_unitario float check (costo_unitario >= 0)
)

-- Tabla del menu
create table Menu (
id_bebida int primary key,
nombre_bebida varchar(100) not null,
id_ingredientes int,
precio float check (precio >= 0),
popularidad int default 0,
foreign key (id_ingredientes) references Ingredientes(id_ingredientes)
)

-- Tabla de pedidos
create table Pedidos (
id_pedido int primary key,
id_cliente int,
detalles_pedido varchar (255),
total_consumo float check (total_consumo >= 0),
forma_pago varchar (50),
fecha_pedido datetime default getdate(),
foreign key (id_cliente) references Clientes(id_cliente)
)

-- Tabla de personal
create table Personal (
id_mesero int primary key,
nombre varchar(100) not null,
turno varchar(20),
id_pedido int,
total_pedidos_atendidos int default 0,
desempeno int check (desempeno between 1 and 10),
foreign key (id_pedido) references Pedidos (id_pedido)
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
