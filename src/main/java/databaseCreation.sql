CREATE TABLE Peliculas (
    id_pelicula SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    duracion_minutos INTEGER NOT NULL,
    genero VARCHAR(50) NOT NULL,
    clasificacion VARCHAR(10) NOT NULL,
    director VARCHAR(100),
    sinopsis TEXT NOT NULL,
    fecha_estreno DATE NOT NULL,
    popularidad INTEGER,
    activa BOOLEAN NOT NULL,
    fecha_baja DATE NOT NULL
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

CREATE TABLE Salas (
    id_sala SERIAL PRIMARY KEY,
    nombre_sala VARCHAR(50),
    capacidad INTEGER NOT NULL,
    tipo_sala VARCHAR(20) ,
    calidad_sonido VARCHAR(20),
    activa BOOLEAN NOT NULL
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

CREATE TABLE Empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    tipo_jornada VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(15) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    salario_hora DECIMAL(8,2) NOT NULL,
    activo BOOLEAN NOT NULL
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

CREATE TABLE Horarios_Semanales_Empleados (
    id_horario_semanal SERIAL PRIMARY KEY,
    -- monthNum INT (2) PRIMARY KEY,   -- We could add this if we anted to have data from more than one month in this table. And be able to differentiate what month this data is from.
    id_empleado BIGINT UNSIGNED NOT NULL,
    dia_semana INTEGER NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    horas_dia DECIMAL(4,2) NOT NULL,
    CONSTRAINT fk_empleados_1 FOREIGN KEY (id_empleado) REFERENCES cine (id_empleado)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

CREATE TABLE Registro_Horas_Mensual (
    id_registro SERIAL PRIMARY KEY,
    id_empleado BIGINT UNSIGNED NOT NULL,
    mes INTEGER NOT NULL,
    anyo INTEGER NOT NULL,
    horas_totales DECIMAL(6,2) NOT NULL,
    horas_extra DECIMAL(6,2) NOT NULL,
    CONSTRAINT fk_empleados_2 FOREIGN KEY (id_empleado) REFERENCES cine (id_empleado)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

-- M:M peliculas -> Salas Relation table
CREATE TABLE Proyecciones (
    id_proyeccion SERIAL PRIMARY KEY,
    id_pelicula BIGINT UNSIGNED NOT NULL,
    id_sala BIGINT UNSIGNED NOT NULL,
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP NOT NULL,
    precio_entrada DECIMAL(8,2) NOT NULL,
    asientos_disponibles INTEGER NOT NULL,
    CONSTRAINT fk_peliculas_2 FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    CONSTRAINT fk_salas_2 FOREIGN KEY (id_sala) REFERENCES salas (id_sala)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

-- A lo mejor sería necesario poner en fecha de inicio el día el mes y el año, o poner otro campo diferente o otros campos para poner el año

CREATE TABLE Asignaciones_Empleados_Proyecciones (
    id_asignacion SERIAL PRIMARY KEY,
    id_proyeccion BIGINT UNSIGNED NOT NULL,
    id_empleado BIGINT UNSIGNED NOT NULL,
    rol VARCHAR(50),
    CONSTRAINT fk_proyecciones_2 FOREIGN KEY (id_proyeccion) REFERENCES proyecciones (id_proyeccion),
    CONSTRAINT fk_empleados_3 FOREIGN KEY (id_empleado) REFERENCES cine (id_empleado)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE entradas (
    id_entrada SERIAL PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    hora_venta TIME NOT NULL,
    precio DECIMAL (7, 2) NOT NULL,
    cantidad_vendida INT (6) NOT NULL,
    id_proyeccion BIGINT UNSIGNED NOT NULL, -- I decided to have the foreign key as BIGINT because SERIAL is an abbreviation for BIGINT UNSIGNED NOT NULL AUTO_INCREMENT
                                      -- And to avoid possible errors, and make the database scalable, I think having the attributes that reference these PRIMARY KEYs
                                      -- as BIGINTs could be beneficial because of this reason.
    CONSTRAINT fk_proyecciones_1 FOREIGN KEY (id_proyeccion) REFERENCES Proyecciones (id_proyeccion)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


-- The 'Empleados' that are being referenced by these INSERTs have not been previously inserted, and if that is not done previously,
-- the INSERT INTO these next tables will generate an error because of the references of the foreign keys.
-- This is probably because this data was extracted from a database that had been up and running for a while, and some of the employees were deleted,
-- and, the gaps in the primary key numbers stayed there. They could have been updated manually, because AUTO_INCREMENT does not handle this kind of update.


-- INSERTS for Empleados:
INSERT INTO empleados (nombre, puesto, tipo_jornada, email, telefono, fecha_contratacion, salario_hora, activo) VALUES
('Carlos Mendoza', 'Gerente', 'Jornada Completa', 'carlos.mendoza@cine.com', '600111222', '2023-01-01', 25.00, TRUE),
('Ana Rodriguez', 'Subgerente', 'Jornada Completa', 'ana.rodriguez@cine.com', '600222333', '2023-01-15', 20.00, TRUE),
('Miguel Torres', 'Proyeccionista Jefe', 'Jornada Completa', 'miguel.torres@cine.com', '600333444', '2023-02-01', 18.00, TRUE),
('Sofia Garcia', 'Proyeccionista', 'Jornada Completa', 'sofia.garcia@cine.com', '650443585', '2023-02-15', 16.00, TRUE),
('Maria González', 'Taquillero', 'Jornada Completa', 'maria.gonzalez@cine.com', '620555676', '2023-03-01', 14.00, TRUE),
('Pedro Sánchez', 'Cajero', 'Jornada Completa', 'pedro.sanchez@cine.com', '610666767', '2023-03-15', 14.00, TRUE),
('Carmen Vargas', 'Taquillero', 'Jornada Parcial', 'carmen.vargas@cine.com', '639777888', '2023-04-01', 14.00, TRUE),
('Raúl Jiménez', 'Cajero', 'Jornada Parcial', 'raul.jimenez@cine.com', '600888999', '2023-04-15', 14.00, TRUE),
('Roberto Díaz', 'Atención Cliente', 'Jornada Parcial', 'roberto.diaz@cine.com', '670999000', '2023-05-01', 13.00, TRUE),
('Patricia Ortega', 'Atención Cliente', 'Jornada Parcial', 'patricia.ortega@cine.com', '690060111', '2023-05-15', 13.00, TRUE),
('Eva Navarro', 'Limpieza', 'Jornada Parcial', 'eva.navarro@cine.com', '600111000', '2023-06-01', 12.00, TRUE),
('Alberto Silva', 'Limpieza', 'Jornada Parcial', 'alberto.silva@cine.com', '600222111', '2023-06-15', 12.00, TRUE),
('Andrea Molina', 'Atención Cliente', 'Jornada Completa', 'andrea.molina@cine.com', '603438292', '2023-07-01', 13.00, TRUE),
('Francisco Reyes', 'Limpieza', 'Jornada Completa', 'francisco.reyes@cine.com', '600414333', '2023-07-15', 12.00, TRUE),
('Teresa Herrera', 'Limpieza', 'Jornada Completa', 'teresa.herrera@cine.com', '600985414', '2023-08-01', 12.00, TRUE),
('Jorge Martin', 'Seguridad', 'Jornada Completa', 'jorge.martin@cine.com', '602666385', '2023-08-15', 15.00, TRUE),
('Sara López', 'Seguridad', 'Jornada Completa', 'sara.lopez@cine.com', '670734666', '2023-09-01', 15.00, TRUE);



-- Some of the employeeIds that are handled here are not in the employees table. So I will change them to match the one that do exist.
-- I understand that this might make sense if the employees have been introduced a long time ago, and some of them have been deleted,
-- and the numbers have not been updated. However, for inserting data for the first time in the database, this will prove problematic,
-- since the employee ids are of SERIAL type /Auto_increment

-- Carlos Mendoza - Gerente (Lunes a Viernes)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(1, 1, '10:00', '19:00', 9.0), (1, 2, '10:00', '19:00', 9.0), (1, 3, '10:00', '19:00', 9.0),
(1, 4, '10:00', '19:00', 9.0), (1, 5, '10:00', '18:00', 8.0);
-- Descanso: Sábado y Domingo

-- Ana Rodríguez - Subgerente (Martes a Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(2, 2, '11:00', '20:00', 9.0), (2, 3, '11:00', '20:00', 9.0), (2, 4, '11:00', '20:00', 9.0),
(2, 5, '11:00', '20:00', 9.0), (2, 6, '12:00', '16:00', 4.0);
-- Descanso: Domingo y Lunes

-- Miguel Torres - Proyeccionista Jefe (Lunes, Miércoles, Viernes, Sábado, Domingo)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(3, 1, '14:00', '23:00', 9.0), (3, 3, '14:00', '23:00', 9.0), (3, 5, '14:00', '23:00', 9.0),
(3, 6, '12:00', '21:00', 9.0), (3, 7, '12:00', '16:00', 4.0);
-- Descanso: Martes y Jueves

-- Sofia García - Proyeccionista (Martes, Jueves, Sábado, Domingo + Viernes tarde)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(4, 2, '16:00', '01:00', 9.0), (4, 4, '16:00', '01:00', 9.0), (4, 5, '18:00', '02:00', 8.0),
(4, 6, '14:00', '23:00', 9.0), (4, 7, '14:00', '19:00', 5.0);
-- Descanso: Lunes y Miércoles

-- María González - Taquillero (Lunes a Viernes)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(5, 1, '11:30', '20:30', 9.0), (5, 2, '11:30', '20:30', 9.0), (5, 3, '11:30', '20:30', 9.0),
(5, 4, '11:30', '20:30', 9.0), (5, 5, '11:30', '19:30', 8.0);
-- Descanso: Sábado y Domingo

-- Pedro Sánchez - Cajero (Martes a Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(6, 2, '12:00', '21:00', 9.0), (6, 3, '12:00', '21:00', 9.0), (6, 4, '12:00', '21:00', 9.0),
(6, 5, '12:00', '21:00', 9.0), (6, 6, '13:00', '17:00', 4.0);
-- Descanso: Domingo y Lunes

-- Carmen Vargas - Taquillero (Lunes, Miércoles, Viernes)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(7, 1, '15:00', '21:00', 6.0), (7, 3, '15:00', '21:00', 6.0), (7, 5, '16:00', '22:00', 6.0),
(7, 6, '12:00', '16:00', 4.0);
-- Descanso: Martes, Jueves, Domingo
-- Total: 22 horas

-- Raúl Jiménez - Cajero (Martes, Jueves, Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(8, 2, '17:00', '23:00', 6.0), (8, 4, '17:00', '23:00', 6.0), (8, 6, '14:00', '20:00', 6.0),
(8, 7, '15:00', '19:00', 4.0);
-- Descanso: Lunes, Miércoles, Viernes
-- Total: 22 horas

-- Roberto Díaz - Atención Cliente (Lunes, Miércoles, Viernes, Domingo)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(9, 1, '13:00', '18:00', 5.0), (9, 3, '13:00', '18:00', 5.0), (9, 5, '13:00', '18:00', 5.0),
(9, 7, '12:00', '17:00', 5.0);
-- Descanso: Martes, Jueves, Sábado
-- Total: 20 horas

-- Patricia Ortega - Atención Cliente (Martes, Jueves, Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(10, 2, '16:00', '22:00', 6.0), (10, 4, '16:00', '22:00', 6.0), (10, 6, '15:00', '21:00', 6.0);
-- Descanso: Lunes, Miércoles, Viernes, Domingo
-- Total: 18 horas (se ajustaría añadiendo 2 horas más)

-- Eva Navarro - Limpieza (Lunes a Viernes mañanas)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(11, 1, '08:00', '12:00', 4.0), (11, 2, '08:00', '12:00', 4.0), (11, 3, '08:00', '12:00', 4.0),
(11, 4, '08:00', '12:00', 4.0), (11, 5, '08:00', '12:00', 4.0);
-- Descanso: Sábado y Domingo
-- Total: 20 horas

-- Alberto Silva - Limpieza (Fines de semana)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(12, 6, '09:00', '19:00', 10.0), (12, 7, '09:00', '19:00', 10.0);
-- Descanso: Lunes a Viernes
-- Total: 20 horas

-- Andrea Molina - Atención Cliente (Lunes a Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(13, 1, '12:00', '20:00', 8.0), (13, 2, '12:00', '20:00', 8.0), (13, 3, '12:00', '20:00', 8.0),
(13, 4, '12:00', '20:00', 8.0), (13, 5, '12:00', '20:00', 8.0), (13, 6, '13:00', '17:00', 4.0);
-- Descanso: Domingo
-- Total: 44 horas (ligeramente superior, típico en retail/cine)

-- Francisco Reyes - Limpieza (Martes a Sábado)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(14, 2, '14:00', '23:00', 9.0), (14, 3, '14:00', '23:00', 9.0), (14, 4, '14:00', '23:00', 9.0),
(14, 5, '14:00', '23:00', 9.0), (14, 6, '15:00', '20:00', 5.0);
-- Descanso: Domingo y Lunes
-- Total: 41 horas

-- Teresa Herrera - Limpieza (Domingo a Jueves)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(15, 7, '10:00', '19:00', 9.0), (17, 1, '10:00', '19:00', 9.0), (15, 2, '10:00', '19:00', 9.0),
(15, 3, '10:00', '19:00', 9.0), (17, 4, '10:00', '18:00', 8.0);
-- Descanso: Viernes y Sábado
-- Total: 44 horas

-- Jorge Martín - Seguridad (Lunes a Viernes + Sábado mañana)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(16, 1, '15:00', '00:00', 9.0), (16, 2, '15:00', '00:00', 9.0), (16, 3, '15:00', '00:00', 9.0),
(16, 4, '15:00', '00:00', 9.0), (16, 5, '15:00', '00:00', 9.0), (16, 6, '12:00', '16:00', 4.0);
-- Descanso: Domingo
-- Total: 49 horas

-- Sara López - Seguridad (Martes a Domingo)
INSERT INTO Horarios_Semanales_Empleados (id_empleado, dia_semana, hora_entrada, hora_salida, horas_dia) VALUES
(17, 2, '18:00', '02:00', 8.0), (17, 3, '18:00', '02:00', 8.0), (17, 4, '18:00', '02:00', 8.0),
(17, 5, '18:00', '02:00', 8.0), (17, 6, '18:00', '02:00', 8.0), (17, 7, '16:00', '22:00', 6.0);
-- Descanso: Lunes
-- Total: 46 horas

-- I would need to create a PROCEDURE that I can call to calculate the horas_extra value correctly
-- In this procedure I would obtain the  entry and exit hours of the specified employee,
-- and I would obtain the hour, then convert it into an INT by adding +0 to it. And then I would have a conditional,
-- to make it so when we are working with morning exit hours, and night entry hours, I add 24 hours to the exit hour,
-- this way, 24 + exit_hour > entry_hour, and the difference between them would be the number of hours worked.
-- Example: exit_hour = 4 am -- entry_hour = 22 ; 24 + 4 -22 = 6 hours worked.
-- After that I would do actualWorkedHours - hoursWorked_fromWeeklyTable. The difference should be the extra hours.

--CREATE TABLE Registro_Horas_Mensual (
--    id_registro SERIAL PRIMARY KEY,
--    id_empleado BIGINT UNSIGNED NOT NULL,
--    mes INTEGER NOT NULL,
--    anyo INTEGER NOT NULL,
--    horas_totales DECIMAL(6,2) NOT NULL,
--    horas_extra DECIMAL(6,2) NULL,
--    CONSTRAINT fk_empleados_2 FOREIGN KEY (id_empledo) REFERENCES cine (id_empleados)
--)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


INSERT INTO Registro_Horas_Mensual (id_empleado, mes, anyo, horas_totales) VALUES
(1, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 1, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17));

-- February and next months until june (included) I will not insert them, since it feels like the data in the weekly hours table is from only one month.
-- But, if the month number was a part of the primary key, we could insert the data from other months here.
-- Another option would be to delete the data form the weekly table each month, and store the monthly data here. But again, in this case, we would not have the data yet.
INSERT INTO Registro_Horas_Mensual (id_empleado, mes, anyo, horas_totales) VALUES
(1, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 2, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17)),
-- March
(1, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 3, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17)),
-- April
(1, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 4, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17)),
-- May
INSERT INTO Registro_Horas_Mensual (id_empleado, mes, anyo, horas_totales) VALUES
(1, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 5, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17)),
-- June
(1, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 1)),
(2, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 2)),
(3, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 3)),
(4, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 4)),
(5, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 5)),
(6, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 6)),
(7, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 7)),
(8, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 8)),
(9, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 9)),
(10, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 10)),
(11, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 11)),
(12, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 12)),
(13, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 13)),
(14, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 14)),
(15, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 15)),
(16, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 16)),
(17, 6, 2024, 4 * (SELECT SUM(h.horas_dia) FROM Horarios_Semanales_Empleados h WHERE h.id_empleado = 17));


-- INSERTS for Peliculas:
INSERT INTO Peliculas (titulo, duracion_minutos, genero, clasificacion, director, fecha_estreno, popularidad, activa) VALUES
-- ESTRENOS MUY POPULARES
('Avatar 3: El Nuevo Mundo', 162, 'Ciencia Ficción', 'A', 'James Cameron', '2024-01-12', 95, true),
('Misión Imposible 8', 148, 'Acción', 'B', 'Christopher McQuarrie', '2024-01-18', 88, true),
('Super Mario Bros 2', 115, 'Animación', 'AA', 'Aaron Horvath', '2024-02-01', 92, true),
('Guardianes de la Galaxia 4', 136, 'Ciencia Ficción', 'A', 'James Gunn', '2024-02-08', 90, true),

-- ESTRENOS RECIENTES
('Duna: Parte Tres', 155, 'Ciencia Ficción', 'A', 'Denis Villeneuve', '2024-01-05', 85, true),
('Fast & Furious 11', 141, 'Acción', 'B', 'Louis Leterrier', '2023-12-20', 78, true),
('Wonka', 116, 'Musical', 'AA', 'Paul King', '2023-12-08', 82, true),
('Aquaman 2', 124, 'Acción', 'A', 'James Wan', '2023-12-15', 75, true),

-- PELÍCULAS EN CARTELERA (2-3 MESES)
('The Marvels', 105, 'Ciencia Ficción', 'A', 'Nia DaCosta', '2023-11-10', 68, true),
('Los asesinos de la luna', 206, 'Drama', 'B', 'Martin Scorsese', '2023-10-20', 72, true),
('Five Nights at Freddys', 110, 'Terror', 'B15', 'Emma Tammi', '2023-10-27', 65, true),
('Napoleón', 158, 'Histórica', 'B', 'Ridley Scott', '2023-11-22', 70, true),

-- PELÍCULAS PRÓXIMAS A RETIRAR
('Oppenheimer', 180, 'Drama', 'B', 'Christopher Nolan', '2023-07-21', 60, true),
('Barbie', 114, 'Comedia', 'A', 'Greta Gerwig', '2023-07-21', 58, true),
('Blue Beetle', 127, 'Acción', 'A', 'Ángel Manuel Soto', '2023-08-18', 45, true),
('Meg 2: La fosa', 116, 'Acción', 'B', 'Ben Wheatley', '2023-08-04', 42, true),

-- PELÍCULAS ANTIGUAS (PRÓXIMAS A SALIR)
('John Wick 4', 169, 'Acción', 'C', 'Chad Stahelski', '2023-03-24', 35, true), -- If the films are old, and have already been retired, the 'activo' attribute should be False
('Ant-Man 3', 125, 'Ciencia Ficción', 'A', 'Peyton Reed', '2023-02-17', 30, true),
('Shazam 2', 130, 'Acción', 'A', 'David F. Sandberg', '2023-03-17', 28, true),
('Flash', 144, 'Acción', 'B', 'Andy Muschietti', '2023-06-16', 25, true);

INSERT INTO Salas (nombre_sala, capacidad, tipo_sala, calidad_sonido, activa) VALUES
('Sala 1 - IMAX', 280, 'IMAX', 'IMAX', true),
('Sala 2 - 4DX', 180, '4DX', 'Dolby 7.1', true),
('Sala 3 - ScreenX', 200, 'ScreenX', 'DTS:X', true),
('Sala 4 - 3D', 190, '3D', 'DTS', true);



-- INSERTS for Proyecciones:
INSERT INTO Proyecciones (id_pelicula, id_sala, fecha_hora_inicio, fecha_hora_fin, precio_entrada, asientos_disponibles) VALUES
(16, 3, '2025-10-03 20:15:00', '2025-10-03 22:59:00', 9.50, 200),
(1, 1, '2025-10-07 19:30:00', '2025-10-07 22:32:00', 13.50, 280),
(1, 2, '2025-10-08 15:00:00', '2025-10-08 18:02:00', 12.00, 180),
(2, 4, '2025-10-07 16:00:00', '2025-10-07 18:48:00', 10.00, 190),
(13, 3, '2025-10-06 16:00:00', '2025-10-06 19:20:00', 7.50, 200),
(5, 3, '2025-10-08 20:30:00', '2025-10-08 23:25:00', 9.50, 200),

-- Week 2: Oct 8 - Oct 14
(7, 4, '2025-10-09 13:00:00', '2025-10-09 15:16:00', 9.50, 190),
(13, 1, '2025-10-09 16:30:00', '2025-10-09 19:50:00', 7.50, 280),
(10, 1, '2025-10-09 18:45:00', '2025-10-09 22:31:00', 13.50, 280),
(10, 1, '2025-10-12 20:45:00', '2025-10-13 00:31:00', 10.00, 280),
(11, 2, '2025-11-09 00:00:00', '2025-10-09 02:10:00', 12.00, 180),
(14, 1, '2025-10-14 13:00:00', '2025-10-14 15:14:00', 8.00, 280),
(13, 3, '2025-11-10 17:30:00', '2025-11-10 20:50:00', 9.50, 200),

-- Week 3: Oct 15 - Oct 21
(14, 1, '2025-10-15 14:45:00', '2025-10-15 16:59:00', 9.50, 280),
(13, 2, '2025-10-15 17:30:00', '2025-10-15 20:50:00', 8.00, 180),
(10, 3, '2025-10-16 19:45:00', '2025-10-16 23:31:00', 9.50, 200),
(16, 1, '2025-10-16 21:30:00', '2025-10-17 00:14:00', 10.00, 280),
(14, 2, '2025-10-17 16:15:00', '2025-10-17 18:29:00', 7.50, 180),
(15, 3, '2025-10-17 22:15:00', '2025-10-18 00:42:00', 10.00, 200),
(13, 1, '2025-10-18 18:00:00', '2025-10-18 21:20:00', 8.00, 280),
(16, 2, '2025-10-19 20:30:00', '2025-10-19 23:14:00', 9.50, 180),
(14, 3, '2025-10-20 15:45:00', '2025-10-20 17:59:00', 7.50, 200),
(15, 1, '2025-10-21 13:30:00', '2025-10-21 15:57:00', 8.00, 280),
(13, 2, '2025-10-21 19:15:00', '2025-10-21 22:35:00', 10.00, 180),
(16, 3, '2025-10-21 22:45:00', '2025-10-22 01:29:00', 9.50, 200),

-- Week 4 & End of Month: Oct 22 - Oct 31
(14, 1, '2025-10-22 15:00:00', '2025-10-22 17:14:00', 9.50, 280),
(15, 2, '2025-10-23 17:15:00', '2025-10-23 19:42:00', 8.00, 180),
(16, 3, '2025-10-24 19:30:00', '2025-10-24 22:14:00', 9.50, 200),
(10, 1, '2025-10-25 21:00:00', '2025-10-26 00:46:00', 10.00, 280),
(13, 2, '2025-10-26 16:45:00', '2025-10-26 20:05:00', 7.50, 180),
(15, 3, '2025-10-27 20:15:00', '2025-10-27 22:42:00', 9.50, 200),
(14, 1, '2025-10-28 14:15:00', '2025-10-28 16:29:00', 8.00, 280),
(16, 2, '2025-10-29 18:45:00', '2025-10-29 21:29:00', 10.00, 180),
(13, 3, '2025-10-30 21:45:00', '2025-10-31 01:05:00', 9.50, 200),
(10, 1, '2025-10-31 19:00:00', '2025-10-31 22:46:00', 9.50, 280);

CREATE TABLE entradas (
    id_entrada SERIAL PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    hora_venta TIME NOT NULL,
    precio DECIMAL (7, 2) NOT NULL,
    cantidad_vendida INT (6) NOT NULL,
    id_proyeccion BIGINT UNSIGNED NOT NULL, -- I decided to have the foreign key as BIGINT because SERIAL is an abbreviation for BIGINT UNSIGNED NOT NULL AUTO_INCREMENT
                                      -- And to avoid possible errors, and make the database scalable, I think having the attributes that reference these PRIMARY KEYs
                                      -- as BIGINTs could be beneficial because of this reason.
    CONSTRAINT fk_proyecciones_1 FOREIGN KEY (id_proyeccion) REFERENCES Proyecciones (id_proyeccion)
)Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

-- INSERTS for Entradas:
INSERT INTO entradas (fecha_venta, hora_venta, precio, cantidad_vendida, id_proyeccion) VALUES
-- Week 1: Oct 1 - Oct 7
('2025-10-03', '20:15:00', 9.50, 45, 1),
('2025-10-07', '16:00:00', 10.00, 70, 4),
('2025-10-03', '20:15:00', 9.50, 55, 1),
('2025-10-06', '16:00:00', 7.50, 30, 5),
('2025-10-08', '20:30:00', 9.50, 85, 6),
('2025-10-06', '16:00:00', 7.50, 60, 5),
('2025-10-07', '16:00:00', 10.00, 75, 4),

-- Week 2: Oct 8 - Oct 14
('2025-10-09', '13:00:00', 9.50, 50, 7),
('2025-10-08', '20:30:00', 9.50, 40, 6),
('2025-10-09', '16:30:00', 7.50, 25, 8),
('2025-10-12', '20:45:00', 10.00, 65, 10),
('2025-10-08', '15:00:00', 12.00, 35, 3),
('2025-10-12', '20:45:00', 10.00, 68, 10),
('2025-10-09', '16:30:00', 7.50, 55, 8),
('2025-10-09', '13:00:00', 9.50, 70, 7),
('2025-10-14', '13:00:00', 8.00, 40, 12),
('2025-10-12', '20:45:00', 10.00, 95, 10),
('2025-10-09', '13:00:00', 9.50, 50, 7),

-- Week 3: Oct 15 - Oct 21
('2025-10-15', '14:45:00', 9.50, 48, 14),
('2025-10-15', '17:30:00', 8.00, 75, 15),
('2025-10-16', '19:45:00', 9.50, 52, 16),
('2025-10-16', '21:30:00', 10.00, 60, 17),
('2025-10-17', '16:15:00', 7.50, 40, 18),
('2025-10-17', '22:15:00', 10.00, 65, 19),
('2025-10-18', '18:00:00', 8.00, 35, 20),
('2025-10-19', '20:30:00', 9.50, 80, 21),
('2025-10-20', '15:45:00', 7.50, 58, 22),
('2025-10-21', '13:30:00', 8.00, 32, 23),
('2025-10-21', '19:15:00', 10.00, 90, 24),
('2025-10-21', '22:45:00', 9.50, 45, 25),

-- Week 4 & End of Month: Oct 22 - Oct 31
('2025-10-22', '15:00:00', 9.50, 50, 26),
('2025-10-23', '17:15:00', 8.00, 60, 27),
('2025-10-24', '19:30:00', 9.50, 55, 28),
('2025-10-25', '21:00:00', 10.00, 70, 29),
('2025-10-26', '16:45:00', 7.50, 38, 30),
('2025-10-27', '20:15:00', 9.50, 62, 31),
('2025-10-28', '14:15:00', 8.00, 45, 32),
('2025-10-29', '18:45:00', 10.00, 88, 33),
('2025-10-30', '21:45:00', 9.50, 50, 34),
('2025-10-31', '19:00:00', 9.50, 60, 35);






-- SELECTS:

SELECT e.nombre, (r.horas_totales * e.salario_hora) AS salario_mensual from empleados e INNER JOIN registro_horas_mensual r ON e.id_empleado = r.id_empleado;

SELECT DISTINCT e.nombre, e.puesto, e.tipo_jornada, r.horas_totales, (r.horas_totales * e.salario_hora) AS salario_mensual FROM empleados e
INNER JOIN registro_horas_mensual r ON e.id_empleado = r.id_empleado   ORDER BY e.puesto, e.tipo_jornada, salario_mensual DESC,  r.horas_totales;

Podamos borrar un empleado, insertar un empleado, y update un empleado por id.