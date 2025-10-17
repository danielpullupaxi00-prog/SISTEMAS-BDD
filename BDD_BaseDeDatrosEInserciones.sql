-- Creacion de Base da Datos
CREATE DATABASE CentroMedicoDB;

-- Uso de Base de datos
USE  CentroMedicoDB;

-- Creacion de Tablas
-- 1. Tabla Especialidades
CREATE TABLE Especialidades (
    EspecialidadID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);
GO

-- 2. Tabla CentrosMedicos
CREATE TABLE CentrosMedicos (
    CentroID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    Direccion VARCHAR(150),
    Telefono VARCHAR(15)
);
GO

-- 3. Tabla Empleados (Basado en el diagrama)
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Cargo VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Telefono VARCHAR(15)
);
GO

-- 4. Tabla Medicos 
CREATE TABLE Medicos (
    MedicoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    EspecialidadID INT,
    CentroID INT NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Telefono VARCHAR(15),
    CONSTRAINT FK_Medicos_CentroID FOREIGN KEY (CentroID) REFERENCES CentrosMedicos(CentroID),
    CONSTRAINT FK_Medicos_EspecialidadID FOREIGN KEY (EspecialidadID) REFERENCES Especialidades(EspecialidadID) 
);
GO

-- 5. Tabla AsignacionEspecialidades
CREATE TABLE AsignacionEspecialidades (
    AsignacionID INT PRIMARY KEY IDENTITY(1,1),
    MedicoID INT NOT NULL,
    EspecialidadID INT NOT NULL,
    CONSTRAINT FK_Asignacion_MedicoID FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID),
    CONSTRAINT FK_Asignacion_EspecialidadID FOREIGN KEY (EspecialidadID) REFERENCES Especialidades(EspecialidadID),
    CONSTRAINT UQ_Asignacion_Medico_Especialidad UNIQUE (MedicoID, EspecialidadID)
);
GO

-- 6. Tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) UNIQUE,
    Telefono VARCHAR(15)
);
GO

-- 7. Tabla Consultas
CREATE TABLE Consultas (
    ConsultaID INT PRIMARY KEY IDENTITY(1,1),
    MedicoID INT NOT NULL,
    ClienteID INT NOT NULL,
    FechaConsulta DATETIME NOT NULL,
    Diagnostico VARCHAR(255),
    Tratamiento VARCHAR(255),
    CONSTRAINT FK_Consultas_MedicoID FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID),
    CONSTRAINT FK_Consultas_ClienteID FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
GO

SELECT * FROM INFORMATION_SCHEMA.TABLES;

INSERT INTO Especialidades (Nombre, Descripcion) VALUES
('Pediatr�a', 'Atenci�n m�dica integral para beb�s, ni�os y adolescentes.'),
('Cardiolog�a', 'Diagn�stico y tratamiento de enfermedades del coraz�n y sistema circulatorio.'),
('Dermatolog�a', 'Cuidado de la piel, pelo y u�as, y tratamiento de sus afecciones.'),
('Ginecolog�a', 'Salud del sistema reproductor femenino y mama.'),
('Odontolog�a', 'Diagn�stico, tratamiento y prevenci�n de enfermedades de la cavidad oral.');
GO

INSERT INTO CentrosMedicos (Nombre, Ciudad, Direccion, Telefono) VALUES
('Hospital Central', 'Quito', 'Av. Amazonas N25-10', '022987654'),
('Cl�nica del Valle', 'Guayaquil', 'Calle 10ma y Principal', '042345678'),
('Centro Salud Norte', 'Ambato', 'Av. Cevallos 1-20', '032112233'),
('Consultorio Luz', 'Quito', 'Eloy Alfaro 500', '022554433'),
('Hospital Metropolitano', 'Guayaquil', 'Av. 9 de Octubre 303', '042111000');
GO

INSERT INTO Empleados (Nombre, Apellido, Cargo, Email, Telefono) VALUES
('Andr�s', 'Garc�a', 'Administrador', 'andres.g@hcentral.com', '0991234567'),
('Sof�a', 'P�rez', 'Secretaria', 'sofia.p@clinicavalle.com', '0987654321'),
('Javier', 'Rojas', 'Contador', 'javier.r@medicos.com', '0990001112'),
('M�nica', 'Salgado', 'Recepcionista', 'monica.s@luz.com', '0988776655'),
('Roberto', 'Vaca', 'Mensajero', 'roberto.v@hmetro.com', '0977665544');
GO

INSERT INTO Medicos (Nombre, Apellido, EspecialidadID, CentroID, Email, Telefono) VALUES
('Elena', 'Vargas', 1, 1, 'e.vargas@hcentral.com', '0992003001'), -- Pediatr�a (1) en Hospital Central (1)
('Carlos', 'S�nchez', 2, 2, 'c.sanchez@clinicavalle.com', '0983004002'), -- Cardiolog�a (2) en Cl�nica del Valle (2)
('Ana', 'L�pez', 3, 3, 'a.lopez@cns.com', '0974005003'), -- Dermatolog�a (3) en Centro Salud Norte (3)
('Ricardo', 'D�az', 4, 1, 'r.diaz@hcentral.com', '0995006004'), -- Ginecolog�a (4) en Hospital Central (1)
('Paola', 'Mora', 5, 5, 'p.mora@hmetro.com', '0986007005'); -- Odontolog�a (5) en Hospital Metropolitano (5)
GO


-- Asignaci�n principal
INSERT INTO AsignacionEspecialidades (MedicoID, EspecialidadID) VALUES
(1, 1), -- Elena Vargas (Pediatr�a)
(2, 2), -- Carlos S�nchez (Cardiolog�a)
(3, 3), -- Ana L�pez (Dermatolog�a)
(4, 4), -- Ricardo D�az (Ginecolog�a)
(5, 5); -- Paola Mora (Odontolog�a)
GO

INSERT INTO Clientes (Nombre, Apellido, Correo, Telefono) VALUES
('Juan', 'Mart�nez', 'juan.martinez@mail.com', '0991112233'),
('Mar�a', 'Torres', 'maria.torres@mail.com', '0982223344'),
('Pedro', 'Castro', 'pedro.castro@mail.com', '0973334455'),
('Laura', 'Herrera', 'laura.herrera@mail.com', '0964445566'),
('Fernando', 'Acosta', 'fernando.acosta@mail.com', '0995556677');
GO

-- Usaremos la funci�n GETDATE() para la fecha actual
INSERT INTO Consultas (MedicoID, ClienteID, FechaConsulta, Diagnostico, Tratamiento) VALUES
(1, 1, GETDATE(), 'Revisi�n pedi�trica anual', 'Vacunas de refuerzo'), -- Elena Vargas (1) atiende a Juan Mart�nez (1)
(2, 2, DATEADD(day, -5, GETDATE()), 'Hipertensi�n arterial', 'Prescripci�n de beta-bloqueantes'), -- Carlos S�nchez (2) atiende a Mar�a Torres (2)
(3, 3, DATEADD(day, -10, GETDATE()), 'Dermatitis al�rgica', 'Crema t�pica de corticoesteroides'), -- Ana L�pez (3) atiende a Pedro Castro (3)
(4, 4, GETDATE(), 'Control prenatal (Primer trimestre)', 'Suplementos vitam�nicos'), -- Ricardo D�az (4) atiende a Laura Herrera (4)
(5, 5, DATEADD(day, -2, GETDATE()), 'Caries en molar', 'Obturaci�n con resina compuesta'); -- Paola Mora (5) atiende a Fernando Acosta (5)
GO

-- 1. Tabla Especialidades
SELECT * FROM Especialidades;

-- 2. Tabla CentrosMedicos
SELECT * FROM CentrosMedicos;

-- 3. Tabla Empleados
SELECT * FROM Empleados;

-- 4. Tabla Medicos
SELECT * FROM Medicos;

-- 5. Tabla AsignacionEspecialidades
SELECT * FROM AsignacionEspecialidades;

-- 6. Tabla Clientes
SELECT * FROM Clientes;

-- 7. Tabla Consultas
SELECT * FROM Consultas;