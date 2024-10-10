CREATE TABLE Premio
(
	id_premio INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Pelicula_Premio
(
	id_pelicula INTEGER NOT NULL,
	id_premio INTEGER NOT NULL,
	anio INTEGER NOT NULL
);

CREATE TABLE Pelicula
(
	id_pelicula INTEGER NOT NULL PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	anio_estreno INTEGER NOT NULL,
	duracion_minutos INTEGER NOT NULL,
	clasif_edad VARCHAR(100) NOT NULL,
	id_director INTEGER NOT NULL
);

CREATE TABLE Pelicula_Genero
(
	id_pelicula INTEGER NOT NULL,
	id_genero INTEGER NOT NULL
);

CREATE TABLE Genero
(
	id_genero INTEGER NOT NULL PRIMARY KEY,
	genero VARCHAR(50) NOT NULL
);

CREATE TABLE Festival
(
	id_festival INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	anio INTEGER NOT NULL
);

CREATE TABLE Pelicula_Festival
(
	id_festival INTEGER NOT NULL,
	id_pelicula INTEGER NOT NULL
);

CREATE TABLE Director
(
	id_director INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	fecha_nac DATE NOT NULL
);

CREATE TABLE Director_Nacionalidad
(
	id_director INTEGER NOT NULL,
	id_nacionalidad INTEGER NOT NULL
);

CREATE TABLE Nacionalidad
(
	id_nacionalidad INTEGER NOT NULL PRIMARY KEY,
	nacionalidad VARCHAR(100) NOT NULL
);

CREATE TABLE Funcion
(
	id_funcion INTEGER NOT NULL PRIMARY KEY,
	fecha_hora TIMESTAMP NOT NULL,
	id_pelicula INTEGER NOT NULL,
	id_sala INTEGER NOT NULL
);

CREATE TABLE Sala
(
	id_sala INTEGER NOT NULL PRIMARY KEY,
	capacidad INTEGER NOT NULL,
	tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Empleado
(
	id_empleado INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
	dni VARCHAR(8) NOT NULL UNIQUE, --Los atributos "UNIQUE" no pueden repetirse
	id_funcion INTEGER NOT NULL,
	cargo VARCHAR(100) NOT NULL
);

CREATE TABLE Empleado_Turno
(
	id_empleado INTEGER NOT NULL,
	id_turno INTEGER NOT NULL
);

CREATE TABLE Turno
(
	id_turno INTEGER NOT NULL PRIMARY KEY,
	turno VARCHAR(60) NOT NULL
);

CREATE TABLE Telefono_Empleado
(
	id_telefono INTEGER NOT NULL PRIMARY KEY,
	telefono VARCHAR(20) NOT NULL,
	id_empleado INTEGER NOT NULL
);

CREATE TABLE Entrada
(
	id_entrada INTEGER NOT NULL PRIMARY KEY,
	precio_bruto FLOAT NOT NULL,
	descuento FLOAT NOT NULL,
	numero_asiento INTEGER NOT NULL,
	hora_compra TIMESTAMP NOT NULL,
	id_funcion INTEGER NOT NULL,
	id_cliente INTEGER NOT NULL
);

CREATE TABLE Cliente
(
	id_cliente INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
	dni VARCHAR(8) NOT NULL UNIQUE,
	correo VARCHAR(255) NOT NULL
);

CREATE TABLE Telefono_Cliente
(
	id_telefono INTEGER NOT NULL PRIMARY KEY,
	telefono VARCHAR(20) NOT NULL,
	id_cliente INTEGER NOT NULL
);

CREATE TABLE Detalle_Compra --La relacion entre Cliente y Producto
(
	id_detalle_compra INTEGER NOT NULL PRIMARY KEY,
	fecha_hora TIMESTAMP NOT NULL,
	cantidad INTEGER NOT NULL,
	id_cliente INTEGER NOT NULL,
	id_producto INTEGER NOT NULL
);

CREATE TABLE Producto
(
	id_producto INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	precio FLOAT NOT NULL
);

--Claves foraneas
ALTER TABLE Pelicula_Premio ADD CONSTRAINT fk_premio FOREIGN KEY (id_premio) REFERENCES Premio (id_premio);
ALTER TABLE Pelicula_Premio ADD CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula);

ALTER TABLE Pelicula ADD CONSTRAINT fk_director FOREIGN KEY (id_director) REFERENCES Director (id_director);

ALTER TABLE Pelicula_Genero ADD CONSTRAINT fk_genero FOREIGN KEY (id_genero) REFERENCES Genero (id_genero);
ALTER TABLE Pelicula_Genero ADD CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula);

ALTER TABLE Pelicula_Festival ADD CONSTRAINT fk_festival FOREIGN KEY (id_festival) REFERENCES Festival (id_festival);
ALTER TABLE Pelicula_Festival ADD CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula);

ALTER TABLE Director_Nacionalidad ADD CONSTRAINT fk_director FOREIGN KEY (id_director) REFERENCES Director (id_director);
ALTER TABLE Director_Nacionalidad ADD CONSTRAINT fk_nacionalidad FOREIGN KEY (id_nacionalidad) REFERENCES Nacionalidad (id_nacionalidad);

ALTER TABLE Funcion ADD CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula);
ALTER TABLE Funcion ADD CONSTRAINT fk_sala FOREIGN KEY (id_sala) REFERENCES Sala (id_sala);

ALTER TABLE Empleado ADD CONSTRAINT fk_funcion FOREIGN KEY (id_funcion) REFERENCES Funcion (id_funcion);

ALTER TABLE Empleado_Turno ADD CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado (id_empleado);
ALTER TABLE Empleado_Turno ADD CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES Turno (id_turno);

ALTER TABLE Telefono_Empleado ADD CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado (id_empleado);

ALTER TABLE Entrada ADD CONSTRAINT fk_funcion FOREIGN KEY (id_funcion) REFERENCES Funcion (id_funcion);
ALTER TABLE Entrada ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Telefono_Cliente ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Detalle_Compra ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);
ALTER TABLE Detalle_Compra ADD CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto);

--Valores de de prueba

INSERT INTO Director(id_director, nombre, fecha_nac)
(
	VALUES (1, 'James Cameron', '1954-08-16'),
		   (2, 'John Lasseter', '1957-01-12'),
		   (3, 'Pete Docter', '1968-10-09'),
		   (4, 'Hayao Miyazaki', '1941-01-05'),
		   (5, 'Shawn Levy', '1968-07-23')
);

INSERT INTO Premio(id_premio, nombre)
(
	VALUES (1, 'Globo de oro'),
		   (2, 'Premio Oscar'),
		   (3, 'Premio Goya'),
		   (4, 'Mainichi Film Award'),
		   (5, 'Premio Peoples Choice')
);

INSERT INTO Pelicula(id_pelicula, titulo, anio_estreno, duracion_minutos, clasif_edad, id_director)
(
	VALUES (1, 'Titanic', 1998, 194, 'MAYORES DE 13', 1),
		   (2, 'Cars', 2006, 107, 'PARA TODO PUBLICO', 2),
		   (3, 'Intensamente', 2015, 95, 'PARA TODO PUBLICO', 3),
           (4, 'Mi vecino Totoro', 1988, 86, 'PARA TODO PUBLICO', 4),  
		   (5, 'Free Guy', 2021, 115, 'MAYORES DE 13', 5)
);

INSERT INTO Pelicula_Premio(id_pelicula, id_premio, anio)
(
	VALUES (1, 2, 2015),
		   (2, 3, 2020),
		   (4, 4, 1989),
		   (5, 5, 2021)
);

INSERT INTO Genero(id_genero, genero)
(
	VALUES (1, 'Aventura'),
		   (2, 'Romance'),
		   (3, 'Infantil'),
		   (4, 'Comedia'),
		   (5, 'Accion')
);

INSERT INTO Pelicula_Genero(id_pelicula, id_genero)
(
	VALUES (1, 1),
		   (1, 2),
		   (2, 3),
		   (2, 4),
		   (3, 3),
		   (3, 4),
		   (4, 3),
		   (5, 4),
		   (5, 5)
);

INSERT INTO Festival(id_festival, nombre, anio)
(
	VALUES (1, '27º Festival Internacional de Cine de Punta del Este', 2025),
		   (2, '43º Festival Cinematográfico Internacional del Uruguay', 2025),
		   (3, '21ª EDICIÓN DE PIRIÁPOLIS DE PELÍCULA', 2024)
);

INSERT INTO Pelicula_Festival(id_festival, id_pelicula)
(
	VALUES (1, 1),
		   (1, 2),
		   (1, 3),
		   (2, 1),
		   (3, 1),
		   (3, 4),
	       (3, 5)
);

INSERT INTO Nacionalidad(id_nacionalidad, nacionalidad)
(
	VALUES (1, 'Estadounidense'),
		   (2, 'Canadiense'),
		   (3, 'Japones')
);

INSERT INTO Director_Nacionalidad(id_director, id_nacionalidad)
(
	VALUES (1, 2),
		   (2, 1),
	       (3, 1),
		   (4, 3),
		   (5, 2)
);

INSERT INTO Sala(id_sala, capacidad, tipo)
(
	VALUES (1, 150, '3D'),
		   (2, 150, '2D'),
		   (3, 200, '3D'),
		   (4, 200, '2D'),
		   (5, 200, '3D')
);

INSERT INTO Funcion(id_funcion, fecha_hora, id_pelicula, id_sala)
(
	VALUES (1, '2024-09-28 16:00', 1, 2),
		   (2, '2024-10-22 14:00', 2, 2),
		   (3, '2024-11-20 15:00', 3, 1),
		   (4, '2024-11-20 15:00', 5, 4),
		   (5, '2024-11-22 16:00', 4, 5)
);

INSERT INTO Empleado(id_empleado, nombre, dni, cargo, id_funcion)
(
	VALUES (1, 'Pancho', '55648397', 'Portero', 2),   
		   (2, 'Maria', '77483925', 'Proyeccionista', 1),
		   (3, 'Marco', '47758846', 'Acomodador', 3),
		   (4, 'Pepe', '36451243', 'Conserje', 4),
		   (5, 'Javier', '84537483', 'Portero', 5)
);

INSERT INTO Turno(id_turno, turno)
(
	VALUES (1, 'Matutino'),
		   (2, 'Vespertino'),
		   (3, 'Nocturno')
);

INSERT INTO Empleado_Turno(id_empleado, id_turno)
(
	VALUES (1, 2),
		   (2, 1),
		   (3, 1),
		   (4, 3),
		   (5, 2)
);

INSERT INTO Telefono_Empleado(id_telefono, telefono, id_empleado)
(
	VALUES (1, '099 594 334', 1),
		   (2, '095 334 566', 2),
		   (3, '098 234 345', 2),
		   (4, '092 475 272', 3),
		   (5, '097 234 211', 4),
		   (6, '092 457 226', 5)
);

INSERT INTO Cliente(id_cliente, nombre, dni, correo)
(
	VALUES (1, 'Javier', '74739274', 'javiermartinez@gmail.com'),
		   (2, 'Luca', '58387463', 'luddnt@gmail.com'),
		   (3, 'Michael', '63455363', 'michaelrivera@gmail.com'),
		   (4, 'Martin', '64728465', 'martinmartinez@gmail.com'),
		   (5, 'Roberto', '47574732', 'robertosalvatierra@gmail.com')
);

INSERT INTO Entrada(id_entrada, precio_bruto, descuento, numero_asiento, hora_compra, id_funcion, id_cliente)
(
	VALUES (1, 200, 0, 78, '2024-09-28 12:00', 1, 2),
	       (2, 200, 10, 34, '2024-09-28 15:00', 1, 1), 
	       (3, 200, 10, 67, '2024-09-28 15:00', 1, 1),
		   (4, 150, 0, 36, '2024-10-22 13:30', 2, 1),
		   (5, 300, 0, 98, '2024-11-20 10:00', 3, 3),
		   (6, 250, 0, 130, '2024-11-20 12:50', 4, 4),
		   (7, 150, 20, 44, '2024-11-22 15:55', 5, 5),
	       (8, 150, 20, 45, '2024-11-22 15:55', 5, 5),
	       (9, 150, 20, 46, '2024-11-22 15:55', 5, 5)
);

INSERT INTO Telefono_Cliente(id_telefono, telefono, id_cliente)
(
	VALUES (1, '094 828 454', 1),
		   (2, '098 384 556', 2),
	       (3, '095 234 664', 2),
		   (4, '+52 3444 6759', 3),
		   (5, '094 552 555', 4),
		   (6, '095 473 777', 5),
	       (7, '096 334 224', 5)
);

INSERT INTO Producto(id_producto, nombre, tipo, precio)
(
	VALUES (1, 'Doritos', 'Comida', 50),
		   (2, 'Fanta 1.25L', 'Bebida', 70),
		   (3, 'Palomitas S', 'Comida', 50),
		   (4, 'Palomitas L', 'Comida', 80),
		   (5, 'Fanta 1.5L', 'Bebida', 70)
);

INSERT INTO Detalle_Compra(id_detalle_compra, fecha_hora, cantidad, id_cliente, id_producto)
(
	VALUES (1, '2024-08-09 14:00', 2, 3, 1),
		   (2, '2024-07-20 13:00', 5, 1, 4),
		   (3, '2024-07-20 13:00', 3, 1, 1),
		   (4, '2024-06-20 15:00', 1, 1, 1),
		   (5, '2024-11-22 15:50', 3, 5, 5),
		   (6, '2024-11-22 15:50', 3, 5, 3)
);

--Consultas predefinidas

--Calcular el precio total de las entradas que compro un cliente en especifico
SELECT Cliente.id_cliente, SUM(precio_bruto * (100 - descuento) / 100) FROM Entrada, Cliente
	WHERE Entrada.id_entrada = Cliente.id_cliente AND
		  Cliente.id_cliente = 2
	GROUP BY Cliente.id_cliente;

--Ver los productos que compro un cliente especifico
SELECT Cliente.id_cliente, Cliente.nombre, Producto.id_producto, Producto.nombre, Detalle_Compra.fecha_hora, Detalle_Compra.cantidad FROM Cliente, Producto, Detalle_Compra
	WHERE Cliente.id_cliente = Detalle_Compra.id_cliente AND
		  Detalle_Compra.id_producto = Producto.id_producto AND
		  Cliente.id_cliente = 1;

--Calcular el monto total de los productos que compro cada cliente en la misma fecha
SELECT Cliente.id_cliente, Detalle_Compra.fecha_hora, SUM(Producto.precio * Detalle_Compra.cantidad) FROM Cliente, Producto, Detalle_Compra
	WHERE Cliente.id_cliente = Detalle_Compra.id_cliente AND
		  Detalle_Compra.id_producto = Producto.id_producto
	GROUP BY Cliente.id_cliente, Detalle_Compra.fecha_hora --Group by es para separar los resultados de las funciones de agregacion en filas
	ORDER BY Detalle_Compra.fecha_hora DESC; --"ORDER BY" indica como se ordena el resultado de la consulta, en este caso, de la compra mas reciente a la mas antigua

--Ver los cargos y turnos de cada empleado
SELECT Empleado.id_empleado, Empleado.nombre, Empleado.cargo, Turno.turno FROM Empleado, Empleado_Turno, Turno
	WHERE Empleado.id_empleado = Empleado_Turno.id_empleado AND
		  Empleado_Turno.id_turno = Turno.id_turno;

--Ver para que pelicula es una entrada especifica
SELECT Entrada.id_entrada, Entrada.numero_asiento, Funcion.id_pelicula FROM Funcion, Entrada
	WHERE Entrada.id_funcion = Funcion.id_funcion AND
		  Entrada.id_entrada = 1;

--Ver las entradas que compro un cliente especifico
SELECT Cliente.id_cliente, Entrada.id_entrada, Entrada.precio_bruto, Entrada.descuento, Entrada.id_funcion FROM Cliente, Entrada
	WHERE Cliente.id_cliente = Entrada.id_cliente AND
		  Cliente.id_cliente = 1;

--Ver puntos acumulados por clientes frecuentes
SELECT Cliente.id_cliente, Cliente.nombre, COUNT(Entrada.id_entrada) FROM Cliente, Entrada
	WHERE Cliente.id_cliente = Entrada.id_cliente
	GROUP BY Cliente.id_cliente
	ORDER BY count DESC; --La funcion count crea una nueva columna llamada "count" y luego "ORDER BY ___ DESC" indica que se debe ordenar de mayor a menor segun el valor de "count"

--Ver los productos vendidos en un dia especifico
SELECT Producto.id_producto, Producto.nombre, Detalle_Compra.fecha_hora FROM Producto, Detalle_Compra
	WHERE Producto.id_producto = Detalle_Compra.id_producto AND 
		  Detalle_Compra.fecha_hora BETWEEN '2024-08-09 00:00' AND '2024-08-09 23:59'
	ORDER BY Detalle_Compra.fecha_hora DESC;

--Ver los productos vendidos en un mes especifico
SELECT Producto.id_producto, Producto.nombre, Detalle_Compra.fecha_hora FROM Producto, Detalle_Compra
	WHERE Producto.id_producto = Detalle_Compra.id_producto AND 
		  Detalle_Compra.fecha_hora BETWEEN '2024-08-01 00:00' AND '2024-08-31 23:59'
	ORDER BY Detalle_Compra.fecha_hora DESC;

--Ver las peliculas mas visitadas
SELECT Pelicula.id_pelicula, Pelicula.titulo, COUNT(Entrada.id_entrada) FROM Funcion, Entrada, Pelicula
	WHERE Entrada.id_funcion = Funcion.id_funcion AND
		  Funcion.id_pelicula = Pelicula.id_pelicula
	GROUP BY Pelicula.id_pelicula
	ORDER BY count DESC;

--Ver las salas mas ocupadas
SELECT Funcion.id_sala, COUNT(Entrada.id_entrada) FROM Funcion, Entrada
	WHERE Entrada.id_funcion = Funcion.id_funcion
	GROUP BY Funcion.id_sala
	ORDER BY count DESC;

--Ver los horarios mas concurridos
SELECT hora_compra, COUNT(id_entrada) FROM Entrada
	GROUP BY hora_compra
	ORDER BY count DESC;