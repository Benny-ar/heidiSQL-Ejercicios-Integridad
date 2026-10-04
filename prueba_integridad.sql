DROP DATABASE IF EXISTS prueba_integridad;
CREATE DATABASE prueba_integridad;
USE prueba_integridad;

CREATE TABLE Oficinas (
    cod_ofic     INT          NOT NULL,
    descripcion  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (cod_ofic)
);

CREATE TABLE Empleados (
    cod_emp     INT          NOT NULL,
    nombre      VARCHAR(40)  NOT NULL,
    apellido    VARCHAR(40)  NOT NULL,
    tipo_doc    VARCHAR(10)  NOT NULL,
    num_doc     VARCHAR(20)  NOT NULL,
    categoria   VARCHAR(20)  NOT NULL,prueba_catalogo
    cod_ofic    INT          NOT NULL,

    PRIMARY KEY (cod_emp),
    CONSTRAINT ck_cod_emp CHECK (cod_emp BETWEEN 100 AND 1000),
    CONSTRAINT uk_tipo_num_doc UNIQUE (tipo_doc, num_doc),
    CONSTRAINT ck_categoria CHECK (categoria IN ('Senior', 'Semi Senior', 'Junior')),
    CONSTRAINT fk_empleados_oficinas 
        FOREIGN KEY (cod_ofic) REFERENCES Oficinas (cod_ofic)
);

INSERT INTO Oficinas VALUES 
(10, 'Operaciones'),
(15, 'Sistemas'),
(20, 'Contaduría');

-- Inserciones correctas
INSERT INTO Empleados VALUES 
(150, 'Juan',  'Pérez',   'DNI', '30111222', 'Senior',      10),
(200, 'Ana',   'García',  'DNI', '28999888', 'Semi Senior', 15),
(300, 'Luis',  'González','LC',  '12345678', 'Junior',      10);


-- 1) cod_emp fuera de rango (menor a 100)
INSERT INTO Empleados VALUES (50, 'Test', 'Fail', 'DNI', '11111111', 'Junior', 10);

-- 2) cod_emp fuera de rango (mayor a 1000)
INSERT INTO Empleados VALUES (1500, 'Test', 'Fail', 'DNI', '22222222', 'Junior', 10);

-- 3) tipo_doc + num_doc duplicados
INSERT INTO Empleados VALUES (400, 'Otro', 'Empleado', 'DNI', '30111222', 'Junior', 10);

-- 4) categoria inválida
INSERT INTO Empleados VALUES (500, 'Test', 'Fail', 'DNI', '33333333', 'Trainee', 10);

-- 5) cod_ofic que no existe en Oficinas
INSERT INTO Empleados VALUES (600, 'Test', 'Fail', 'DNI', '44444444', 'Junior', 99);