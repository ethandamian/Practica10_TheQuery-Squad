/*
 Script para la creación de la base de datos de El Zoologico de Huitziltepec
 */
DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;


------------------------------------- Tablas con llaves primarias ----------------------------------

CREATE TABLE Servicio(
	IDServicio SERIAL,
	TipoServicio VARCHAR(20)
);


-- RESTRICCIONES DE DOMINIO Servicio
ALTER TABLE Servicio ADD CONSTRAINT servicio_d1
CHECK(TipoServicio IN ('Baño', 'Tienda', 'Comida'));
ALTER TABLE Servicio ALTER COLUMN TipoServicio SET NOT NULL;

-- LLAVES Servicio 
ALTER TABLE Servicio ADD CONSTRAINT servicio_pk
PRIMARY KEY (IDServicio);

-- COMMENT DE Servicio
COMMENT ON TABLE Servicio IS 'Tabla que contiene la informacion de los servicios';
COMMENT ON COLUMN Servicio.IDServicio IS 'Identificador del servicio';
COMMENT ON COLUMN Servicio.TipoServicio IS 'Tipo de servicio';
COMMENT ON CONSTRAINT servicio_d1 ON Servicio IS 'El tipo de servicio debe ser baño, tienda o comida';
COMMENT ON CONSTRAINT servicio_pk ON Servicio IS 'IDServicio es la llave primaria';


CREATE TABLE Veterinario(
	RFCVeterinario VARCHAR(13),
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	Salario DECIMAL,
	Especialidad VARCHAR(50)
);


-- RESTRICCIONES DE DOMINIO Veterinario

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d1
CHECK ( RFCVeterinario <> '' 
	AND (LENGTH(RFCVeterinario) = 13 OR LENGTH(RFCVeterinario) = 12)
	AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Veterinario ALTER COLUMN RFCVeterinario SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d2
CHECK(Nombre <> ''
	AND Nombre ~ '.*[a-zA-Z].*');
ALTER TABLE Veterinario ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno ~ '.*[a-zA-Z].*');

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno ~ '.*[a-zA-Z].*');

ALTER TABLE Veterinario ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d5
CHECK(Calle <> '');
ALTER TABLE Veterinario ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d6
CHECK(Colonia <> '');
ALTER TABLE Veterinario ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d7
CHECK(Estado <> ''
	AND Estado ~ '[a-zA-Z]*');
ALTER TABLE Veterinario ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d8
CHECK(Genero <> ''
	AND Genero ~ '[a-zA-Z]*');
ALTER TABLE Veterinario ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d9
CHECK(Salario > 0);
ALTER TABLE Veterinario ALTER COLUMN Salario SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d10
CHECK(Especialidad <> ''
	AND Especialidad ~ '[a-zA-Z]*');
ALTER TABLE Veterinario ALTER COLUMN Especialidad SET NOT NULL;


--LLAVES Veterinario
ALTER TABLE Veterinario ADD CONSTRAINT veterinario_pk
PRIMARY KEY(RFCVeterinario);

-- COMMENTS DE Veterinario 

COMMENT ON TABLE Veterinario IS 'Tabla Veterinario';
COMMENT ON COLUMN Veterinario.RFCVeterinario IS 'RFC del Veterinario';
COMMENT ON COLUMN Veterinario.Nombre IS 'Nombre del Veterinario';
COMMENT ON COLUMN Veterinario.ApellidoPaterno IS 'Apellido Paterno del Veterinario';
COMMENT ON COLUMN Veterinario.ApellidoMaterno IS 'Apellido Materno del Veterinario';
COMMENT ON COLUMN Veterinario.Calle IS 'La calle donde vive el Veterinario';
COMMENT ON COLUMN Veterinario.NumInterior IS 'Numero Interior de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.NumExterior IS 'Numero Exterior de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.Colonia IS 'La colonia de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.Estado IS 'El Estado de la direccion donde vive el Veterinario';
COMMENT ON COLUMN Veterinario.FechaInicioContrato IS 'Fecha cuando inicio el contrato de el Veterinario';
COMMENT ON COLUMN Veterinario.FechaFinContrato IS 'Fecha cuando finalizo el contrato de el Veterinario';
COMMENT ON COLUMN Veterinario.FechaNacimiento IS 'Fecha de nacimiento del Veterinario';
COMMENT ON COLUMN Veterinario.Genero IS 'Género del Veterinario';
COMMENT ON COLUMN Veterinario.Salario IS 'Salario del Veterinario';
COMMENT ON COLUMN Veterinario.Especialidad IS 'Especialidad del Veterinario';
COMMENT ON CONSTRAINT veterinario_d1 ON Veterinario IS 
'Restriccion para RFC:Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT veterinario_d2 ON Veterinario IS
'Restriccion para Nombre: Debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d3 ON Veterinario IS
'Restriccion para el Apellido Paterno: Debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d4 ON Veterinario IS
'Restriccion para el Apellido Materno: Debe contener solo letras';
COMMENT ON CONSTRAINT checkApe ON Veterinario IS
'El Veterinario puede no tener apellido paterno o materno';
COMMENT ON CONSTRAINT veterinario_d5 ON Veterinario IS
'Restriccion para Calle: No debe ser la cadena vacia';
COMMENT ON CONSTRAINT veterinario_d6 ON Veterinario IS
'Restriccion para Colonia: No debe ser la cadena vacia';
COMMENT ON CONSTRAINT veterinario_d7 ON Veterinario IS
'Restriccion para Estado: No debe ser la cadena vacia y debe contener solo letras';

COMMENT ON CONSTRAINT veterinario_d8 ON Veterinario IS
'Restriccion para Genero: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d9 ON Veterinario IS
'Restriccion para Salario: Debe ser mayor a 0';
COMMENT ON CONSTRAINT veterinario_d10 ON Veterinario IS
'Restriccion para Especialidad: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_pk ON Veterinario IS
'Llave primaria de Veterinario';




CREATE TABLE Proveedor(
	RFCProveedor VARCHAR(13),
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT ,
	NumExterior INT ,
	Colonia VARCHAR(50),
	Estado VARCHAR(50) ,
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	FrecuenciaServicio INT,
	CostoServicio INT
);


-- RESTRICCIONES DE DOMINIO Proveedor

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d1
CHECK ( RFCProveedor <> '' 
	AND (LENGTH(RFCProveedor) = 13 OR LENGTH(RFCProveedor) = 12)
	AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Proveedor ALTER COLUMN RFCProveedor SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d2
CHECK(Nombre <> ''
	AND Nombre ~ '[a-zA-Z]*');
ALTER TABLE Proveedor ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno ~ '[a-zA-Z]*');

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno ~ '[a-zA-Z]*');

ALTER TABLE Proveedor ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d5
CHECK(Calle <> '');
ALTER TABLE Proveedor ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d6
CHECK(Colonia <> '');
ALTER TABLE Proveedor ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d7
CHECK(Estado <> ''
	AND Estado ~ '[a-zA-Z]*');
ALTER TABLE Proveedor ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d8
CHECK(Genero <> ''
	AND Genero ~ '[a-zA-Z]*');
ALTER TABLE Proveedor ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d9
CHECK(FrecuenciaServicio > 0);
ALTER TABLE Proveedor ALTER COLUMN FrecuenciaServicio SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d10
CHECK(CostoServicio > 0);
ALTER TABLE Proveedor ALTER COLUMN CostoServicio SET NOT NULL;


--LLAVES Proovedor
ALTER TABLE Proveedor ADD CONSTRAINT proveedor_pk
PRIMARY KEY(RFCProveedor);


COMMENT ON TABLE Proveedor IS 'Tabla que contiene la informacion de los proveedores de insumos';
COMMENT ON COLUMN Proveedor.RFCProveedor IS 'El RFC del proveedor';
COMMENT ON COLUMN Proveedor.Nombre IS 'El nombre del proveedor';
COMMENT ON COLUMN Proveedor.ApellidoPaterno IS 'El apellido paterno del proveedor';
COMMENT ON COLUMN Proveedor.ApellidoMaterno IS 'El apellido materno del proveedor';
COMMENT ON COLUMN Proveedor.Calle IS 'La calle donde vive el proveedor';
COMMENT ON COLUMN Proveedor.NumInterior IS 'El numero interior del lugar donde vive el preveedor';
COMMENT ON COLUMN Proveedor.NumExterior IS 'El numero exterior del lugar donde vive el proveedor';
COMMENT ON COLUMN Proveedor.Colonia IS 'La colonia donde vive el proveedor';
COMMENT ON COLUMN Proveedor.Estado IS 'El estado donde vive el proveedor';
COMMENT ON COLUMN Proveedor.FechaInicioContrato IS 'La fecha de inicio de contrato del proveedor';
COMMENT ON COLUMN Proveedor.FechaFinContrato IS 'La fecha del fin del contrato del proveedor';
COMMENT ON COLUMN Proveedor.FechaNacimiento IS 'La fecha de nacimiento del proveedor';
COMMENT ON COLUMN Proveedor.Genero IS 'El genero del proveedor';
COMMENT ON COLUMN Proveedor.FrecuenciaServicio IS 'La frecuencia en que el proveedor ofrece servicio';
COMMENT ON COLUMN Proveedor.CostoServicio IS 'El costo del servicio del proveedor';
COMMENT ON CONSTRAINT proveedor_d1 ON Proveedor IS 'El RFC debe ser no nulo, debe tener 4 letras mayusculas, 6 numeros y despues de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT proveedor_d2 ON Proveedor IS 'El nombre debe ser no nulo y solo contener letras';
COMMENT ON CONSTRAINT proveedor_d3 ON Proveedor IS 'El apellido paterno debe ser no nulo, no debe ser la cadena vacia y solo contener letras';
COMMENT ON CONSTRAINT proveedor_d4 ON Proveedor IS 'El apellido materno debe ser no nulo, no debe ser la cadena vacia y solo contener letras';
COMMENT ON CONSTRAINT proveedor_d5 ON Proveedor IS 'El nombre de la calle no debe ser nulo y no debe ser la cadena vacia';
COMMENT ON CONSTRAINT proveedor_d6 ON Proveedor IS 'El nombre de la colonia no debe ser nulo y no debe ser la cadena vacia';
COMMENT ON CONSTRAINT proveedor_d7 ON Proveedor IS 'El nombre del estado no debe ser nulo, no debe ser la cadena vacia, solo debe tener letras';
COMMENT ON CONSTRAINT proveedor_d8 ON Proveedor IS 'El nombre del genero no debe ser nulo, no debe ser la cadena vacia y solo debe tener letras';
COMMENT ON CONSTRAINT proveedor_d9 ON Proveedor IS 'La frecuencia de servicio debe der mayor a 0 y no nulo';
COMMENT ON CONSTRAINT proveedor_d10 ON Proveedor IS 'El costo de servicio debe der mayor a 0 y no nulo';
COMMENT ON CONSTRAINT proveedor_pk ON Proveedor IS 'El RFC del proveedor es la llave primaria';


CREATE TABLE Bioma(
	IDBioma SERIAL,
	TipoBioma VARCHAR(50),
	CantidadJaulas INT
);


-- RESTRICCIONES DE DOMINIO Bioma
ALTER TABLE Bioma ADD CONSTRAINT bioma_d1
 CHECK (
		TipoBioma IN (
			'desierto',
			'pastizales',
			'franja costera',
			'aviario',
			'bosque templado',
			'bosque tropical')
	);
ALTER TABLE Bioma ALTER COLUMN TipoBioma SET NOT NULL;

ALTER TABLE Bioma ADD CONSTRAINT bioma_d2
CHECK(CantidadJaulas >= 0); 
ALTER TABLE Bioma ALTER COLUMN CantidadJaulas SET NOT NULL;

-- LLAVES Bioma
ALTER TABLE Bioma ADD CONSTRAINT bioma_pk
PRIMARY KEY (IDBioma);

COMMENT ON TABLE Bioma IS 'Tabla que contiene la informacion de los biomas';
COMMENT ON COLUMN Bioma.IDBioma IS 'El identificador del bioma';
COMMENT ON COLUMN Bioma.TipoBioma IS 'El tipo de bioma';
COMMENT ON COLUMN Bioma.CantidadJaulas IS 'La cantidad de jaulas que hay en el bioma';
COMMENT ON CONSTRAINT bioma_d1 ON Bioma IS 'El tipo de bioma debe ser  desierto, pastizales, franja costera, aviario, bosque templado o bosque tropical';
COMMENT ON CONSTRAINT bioma_d2 ON Bioma IS 'La cantidad de jaulas debe ser mayor o igual a 0';
COMMENT ON CONSTRAINT bioma_pk ON Bioma IS 'IDBioma es la llave primaria';





CREATE TABLE Alimento(
	IDInsumoAlimento SERIAL,
	Nombre VARCHAR(50),
	Cantidad INT,
	FechaCaducidad DATE,
	Refrigeracion BOOL,
	TipoAlimento VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Alimento
ALTER TABLE Alimento ADD CONSTRAINT alimento_d1
CHECK (Nombre <> ''
	AND Nombre ~ '[a-zA-Z]*');
ALTER TABLE Alimento ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Alimento ADD CONSTRAINT alimento_d2
CHECK(Cantidad >= 0);
ALTER TABLE Alimento ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT alimento_d3
CHECK(FechaCaducidad > CURRENT_DATE);
ALTER TABLE Alimento ALTER COLUMN FechaCaducidad SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Refrigeracion SET NOT NULL;

ALTER TABLE Alimento ADD CONSTRAINT alimento_d4
CHECK(TipoAlimento <> '');
ALTER TABLE Alimento ALTER COLUMN TipoAlimento SET NOT NULL;

--LLAVES Alimento
ALTER TABLE Alimento ADD CONSTRAINT alimento_pk
PRIMARY KEY(IDInsumoAlimento);


COMMENT ON TABLE Alimento IS 'Tabla que contiene la informacion de los alimentos';
COMMENT ON COLUMN Alimento.IDInsumoAlimento IS 'Identificador del alimento';
COMMENT ON COLUMN Alimento.Nombre IS 'Nombre del alimento';
COMMENT ON COLUMN Alimento.Cantidad IS 'Cantidad disponible del alimento';
COMMENT ON COLUMN Alimento.FechaCaducidad IS 'Fercha de caducidad del alimento';
COMMENT ON COLUMN Alimento.Refrigeracion IS 'Si el alimento requiere refrigeracion o no';
COMMENT ON COLUMN Alimento.TipoAlimento IS 'Tipo de alimento';
COMMENT ON CONSTRAINT alimento_d1 ON Alimento IS 'El nombre del alimento es no nulo, no puede ser la cadena vacia y debe contener letras';
COMMENT ON CONSTRAINT alimento_d2 ON Alimento IS 'La cantidad disponible del alimento debe ser mayor o igual a 0 y no nulo';
COMMENT ON CONSTRAINT alimento_d3 ON Alimento IS 'La fecha de caducidad debe ser despues de la fecha actual';
COMMENT ON CONSTRAINT alimento_d4 ON Alimento IS 'El tipo de alimeto debe ser no nulo y distinto de la cadena vacia';
COMMENT ON CONSTRAINT alimento_pk ON Alimento IS 'El IDInsumoAlimento es la llave primaria';



CREATE TABLE Visitante(
	IDVisitante SERIAL,
	Genero VARCHAR(50),
	Nombre VARCHAR(50),
	Paterno VARCHAR(50),
	Materno VARCHAR(50),
	FechaNacimiento DATE
);

-- RESTRICCIONES DE DOMINIO Visitante
ALTER TABLE Visitante ADD CONSTRAINT visitante_d1
CHECK (Genero <> ''
	AND Genero ~ '[a-zA-Z]*');
ALTER TABLE Visitante ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Visitante ADD CONSTRAINT visitante_d2
CHECK (Nombre <> ''
	   AND Nombre ~ '[a-zA-Z]*');
ALTER TABLE Visitante ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Visitante ADD CONSTRAINT visitante_d3
 CHECK (Paterno <> ''
		AND Paterno ~ '[a-zA-Z]*');

ALTER TABLE Visitante ADD CONSTRAINT visitante_d4
 CHECK (Materno <> ''
		AND Materno ~ '[a-zA-Z]*');

ALTER TABLE Visitante ADD CONSTRAINT checkApe
CHECK (
		(
			Paterno IS NOT NULL
			OR Materno IS NOT NULL
		)
	);

ALTER TABLE Visitante ALTER COLUMN FechaNacimiento SET NOT NULL;

-- LLAVES Visitante
ALTER TABLE Visitante ADD CONSTRAINT visitante_pk
PRIMARY KEY(IDVisitante);

-- COMMENT DE Visitante
COMMENT ON TABLE Visitante IS 'Tabla Visitante';
COMMENT ON COLUMN Visitante.IDVisitante IS 'Columna id del Visitante';
COMMENT ON COLUMN Visitante.Genero IS 'Genero del Visitante';
COMMENT ON COLUMN Visitante.Nombre IS 'Nombre del Visitante';
COMMENT ON COLUMN Visitante.Paterno IS 'Apellido Paterno del Visitante';
COMMENT ON COLUMN Visitante.Materno IS 'Apellido Materno del Visitante';
COMMENT ON COLUMN Visitante.FechaNacimiento IS 'Fecha de Nacimiento del Visitante';

COMMENT ON CONSTRAINT visitante_d1 ON Visitante IS 
'Restriccion en Genero: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d2 ON Visitante IS
'Restriccion en Nombre: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d3 ON Visitante IS
'Restriccion en Paterno: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d4 ON Visitante IS
'Restriccion en Materno: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT checkApe ON Visitante IS
'Restriccion en Apellidos: El Visitante puede no tener apellido paterno o materno';
COMMENT ON CONSTRAINT visitante_pk ON Visitante IS
'Llave primaria de Visitante';


CREATE TABLE Medicina(
	IDInsumoMedicina SERIAL,
	Nombre VARCHAR(350),
	Cantidad INT,
	FechaCaducidad DATE,
	Refrigeracion BOOL,
	Lote INT,
	Laboratorio VARCHAR(150)
);


-- RESTRICCIONES DE DOMINIO Medicina
ALTER TABLE Medicina ADD CONSTRAINT medicina_d1
CHECK(Nombre <> '');
ALTER TABLE Medicina ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN FechaCaducidad SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Refrigeracion SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Lote SET NOT NULL;

ALTER TABLE Medicina ADD CONSTRAINT medicina_d2
CHECK(Laboratorio <> '');
ALTER TABLE Medicina ALTER COLUMN Laboratorio SET NOT NULL;

-- LLAVES Medicina
ALTER TABLE Medicina ADD CONSTRAINT medicina_pk
PRIMARY KEY(IDInsumoMedicina);

--COMMENT Medicina

COMMENT ON TABLE Medicina IS 'Tabal que contiene la informacion de las medicinas';
COMMENT ON COLUMN Medicina.IDInsumoMedicina IS 'Identificador de la medicina' ;
COMMENT ON COLUMN Medicina.Nombre IS 'Nombre de la medicina';
COMMENT ON COLUMN Medicina.Cantidad IS 'Cantidad de cada medicina' ;
COMMENT ON COLUMN Medicina.FechaCaducidad IS 'Fecha de caducidad de la medicina' ;
COMMENT ON COLUMN Medicina.Refrigeracion IS 'Booleano que indica si la medicina necesita estar en refrigeracion';
COMMENT ON COLUMN Medicina.Lote IS 'Lote de la medicina';
COMMENT ON COLUMN Medicina.Laboratorio IS 'Laboratorio de la medicina';

COMMENT ON CONSTRAINT medicina_d1 ON Medicina IS 'El nombre de la medicina no puede ser igual a la cadena vacia';
COMMENT ON CONSTRAINT medicina_d2 ON Medicina IS 'El nombre del laboratorio no puesde ser igual a la cadena vacia';
COMMENT ON CONSTRAINT medicina_pk ON Medicina IS 'IDInsumoMedicina es la llave primaria';



CREATE TABLE Jaula(
	IDJaula SERIAL
);

-- LLAVES Jaula
ALTER TABLE Jaula ADD CONSTRAINT jaula_pk
PRIMARY KEY(IDJaula);

--COMMENT DE Jaula
COMMENT ON TABLE Jaula IS 'Tabla Jaula';
COMMENT ON COLUMN Jaula.IDJaula IS 'Columna ID de la Jaula';
COMMENT ON CONSTRAINT jaula_pk ON Jaula IS
'Llave primaria de Jaula';

-----------------------------------TABLAS CON LLAVES FORANEAS -------------------------------------

CREATE TABLE Cuidador(
	RFCCuidador VARCHAR(13),
	IDBioma SERIAL,
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	DiasTrabajo INT,
	HorarioLaboral TIME,
	Salario DECIMAL
);




-- RESTRICCIONES DE DOMINIO Cuidador

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d1
CHECK ( RFCCuidador <> '' 
	AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)
	AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Cuidador ALTER COLUMN RFCCuidador SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d2
CHECK(Nombre <> ''
	AND Nombre ~ '[a-zA-Z]*');
ALTER TABLE Cuidador ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno ~ '[a-zA-Z]*');

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno ~ '[a-zA-Z]*');

ALTER TABLE Cuidador ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d5
CHECK(Calle <> '');
ALTER TABLE Cuidador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d6
CHECK(Colonia <> '');
ALTER TABLE Cuidador ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d7
CHECK(Estado <> ''
	AND Estado ~ '[a-zA-Z]*');
ALTER TABLE Cuidador ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d8
CHECK(Genero <> ''
	AND Genero ~ '[a-zA-Z]*');
ALTER TABLE Cuidador ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d9
CHECK(DiasTrabajo > 0
	AND DiasTrabajo < 30);
ALTER TABLE Cuidador ALTER COLUMN DiasTrabajo SET NOT NULL;	
	
ALTER TABLE Cuidador ALTER COLUMN HorarioLaboral SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d11
CHECK(Salario > 0);
ALTER TABLE Cuidador ALTER COLUMN Salario SET NOT NULL;
 



--LLAVES Cuidador
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_pk
PRIMARY KEY(RFCCuidador);

ALTER TABLE Cuidador ADD CONSTRAINT idbioma_pk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician Comentarios Cuidador


COMMENT ON TABLE Cuidador IS 'Tabla que contiene a los cuidadores del zoologico';
COMMENT ON COLUMN Cuidador.rfccuidador IS 'Identificador del cuidador';
COMMENT ON COLUMN Cuidador.idbioma  IS 'Identificador del bioma en donde trabaja el cuidador';
COMMENT ON COLUMN Cuidador.nombre  IS 'Nombre del cuidador';
COMMENT ON COLUMN Cuidador.apellidopaterno IS 'Nombre paterno del cuidador';
COMMENT ON COLUMN Cuidador.apellidomaterno IS 'Nombre materno del cuidador';
COMMENT ON COLUMN Cuidador.calle IS 'Calle del domicilio del cuidador';
COMMENT ON COLUMN Cuidador.numinterior IS 'Numero interior del domicilio del cuidador';
COMMENT ON COLUMN Cuidador.numexterior  IS 'Numero exterior del domicilio del cuidador';
COMMENT ON COLUMN Cuidador.colonia IS 'Colonia del domicilio del cuidador';
COMMENT ON COLUMN Cuidador.estado  IS 'Estado del domicilio del cuidador';
COMMENT ON COLUMN Cuidador.fechainiciocontrato IS 'Fecha en la que inicio el contrato como cuidador';
COMMENT ON COLUMN Cuidador.fechafincontrato IS  'Fecha en que finalizara el contrato como cuidador';
COMMENT ON COLUMN Cuidador.genero IS 'Genero del cuidador';
COMMENT ON COLUMN Cuidador.diastrabajo IS 'Dias en los que un cuidador trabaja';
COMMENT ON COLUMN Cuidador.horariolaboral IS 'Horario laboral del cuidador';
COMMENT ON COLUMN Cuidador.salario IS 'Salario del cuidador';
COMMENT ON CONSTRAINT cuidador_d1 ON Cuidador IS 'Restriccion CHECK para rfc del cuidador debe tener el formato en RFC y contener 13 o 12 caracteres y no debe ser nulo';
COMMENT ON CONSTRAINT cuidador_d2 ON Cuidador IS 'Restriccion CHECK para el nombre del cuidador, verifica que contiene letras y no debe ser nulo';
COMMENT ON CONSTRAINT cuidador_d3 ON Cuidador IS 'Restriccion CHECK para el apellido paterno del cuidador, verifica que contenga letras y debe ser no nulo';
COMMENT ON CONSTRAINT cuidador_d4 ON Cuidador IS 'Restriccion CHECK para el apellido paterno del cuidador, verifica que contenga letras y debe ser no nulo';
COMMENT ON CONSTRAINT checkApe ON Cuidador IS 'Restriccion CHECK para apellido materno y paterno que no permite que sean nulos';
COMMENT ON CONSTRAINT cuidador_d5 ON Cuidador IS 'Restriccion CHECK para la calle del cuidador, no deba ser nula';
COMMENT ON CONSTRAINT cuidador_d6 ON Cuidador IS 'Restriccion CHECK para que la colonia no sea nula';
COMMENT ON CONSTRAINT cuidador_d7 ON Cuidador IS 'Restriccion CHECK para que el estado contenga letras y no sea nulo';
COMMENT ON CONSTRAINT cuidador_d8 ON Cuidador IS 'Restriccion CHECK para que el genero contenga letras y sea no nulo';
COMMENT ON CONSTRAINT cuidador_d9 ON Cuidador IS 'Restriccion CKECK para que los dias de trabajo sean mayores a 0 y menores a 30';
COMMENT ON CONSTRAINT cuidador_d11 ON Cuidador IS 'Restriccion CHECK para que el salario sea mayor a 0';
COMMENT ON CONSTRAINT cuidador_pk ON Cuidador IS 'La llave primaria de cuidador que es su RFC';
COMMENT ON CONSTRAINT idbioma_pk ON Cuidador IS 'La llave idbioma que hacer r	encia a la tabla bioma ';

--Terminan Comentarios Cuidador


CREATE TABLE Animal(
	IDAnimal SERIAL,
	IDBioma SERIAL,
	IDJaula SERIAL,
	NombreAnimal VARCHAR(50),
	Sexo VARCHAR(50),
	Altura DECIMAL,
	Peso DECIMAL,
	Especie VARCHAR(50),
	Alimentacion VARCHAR(50)
);


-- RESTRICCIONES DE DOMINIO Animal
ALTER TABLE Animal ADD CONSTRAINT animal_d1
CHECK (NombreAnimal <> ''
		AND NombreAnimal ~ '[a-zA-Z]*');
ALTER TABLE Animal ALTER COLUMN NombreAnimal SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d2
CHECK (Sexo IN ('Macho', 'Hembra'));
ALTER TABLE Animal ALTER COLUMN Sexo SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d3
CHECK (Altura > 0);
ALTER TABLE Animal ALTER COLUMN Altura SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d4
CHECK (Peso > 0);
ALTER TABLE Animal ALTER COLUMN Peso SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d5
CHECK (Especie <> ''
		AND Especie ~ '[a-zA-Z]*');
ALTER TABLE Animal ALTER COLUMN Especie SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d7
CHECK (
		Alimentacion IN (
			'Carnivoro',
			'Herbivoro',
			'Omnivoro'));
ALTER TABLE Animal ALTER COLUMN Alimentacion SET NOT NULL;

-- LLAVES Animal
ALTER TABLE Animal ADD CONSTRAINT animal_pk
PRIMARY KEY(IDAnimal);

ALTER TABLE Animal ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Animal ADD CONSTRAINT idjaula_fk
FOREIGN KEY (IDJaula) REFERENCES Jaula (IDJaula)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician Comentarios de Animal

COMMENT ON TABLE Animal IS 'Tabla que almacena a todos los animales del Zoologico';
COMMENT ON COLUMN Animal.IDAnimal IS 'Identificador de animal';
COMMENT ON COLUMN Animal.IDBioma IS 'Identificador del bioma del animal';
COMMENT ON COLUMN Animal.IDJaula IS 'Identificador de la jaula del anumal';
COMMENT ON COLUMN Animal.NombreAnimal IS 'Nombre del animal';
COMMENT ON COLUMN Animal.Sexo IS 'Sexo del animal';
COMMENT ON COLUMN Animal.Altura IS 'Altura del animal';
COMMENT ON COLUMN Animal.Peso IS 'Peso del animal';
COMMENT ON COLUMN Animal.Especie IS 'Especie del animal';
COMMENT ON COLUMN Animal.Alimentacion IS 'Alimentacion del animal';
COMMENT ON CONSTRAINT animal_d1 ON Animal IS 'Restriccion CHECK que verifica que el nombre de un animal no sea nulo y contenga solamente letras';
COMMENT ON CONSTRAINT animal_d2 ON Animal IS 'Restriccion CHECK que verifica que el sexo de un animal sea macho o hembra';
COMMENT ON CONSTRAINT animal_d3 ON Animal IS 'Restriccion CHECK que verifica que la altura de un animal sea mayor a 0';
COMMENT ON CONSTRAINT animal_d4 ON Animal IS 'Restriccion CHECK que verifica que el peso del un animal sea mayor a 0';
COMMENT ON CONSTRAINT animal_d5 ON Animal IS 'Restriccion CHECK que verifica que la especie del animal solo contenga letras';
COMMENT ON CONSTRAINT animal_d7 ON Animal IS 'Restriccion CHECK que verifica que la alimentación del animal sea Carnivoro, Hervivoro o Omnivoro';
COMMENT ON CONSTRAINT animal_pk ON Animal IS 'Llave primaria de animal'; 
COMMENT ON CONSTRAINT idbioma_fk ON Animal IS 'Llave Foranea que hace referencia a la tabla bioma';
COMMENT ON CONSTRAINT idjaula_fk ON Animal IS 'Llave Foranea que hace referencia a la tabla Jaula';

--Terminan Comentarios de Animal

		


CREATE TABLE Evento(
	IDEvento SERIAL,
	TipoEvento VARCHAR(50),
	Fecha DATE,
	Capacidad INT
); 

-- RESTRICCIONES DE DOMINIO Evento
ALTER TABLE Evento ADD CONSTRAINT evento_d1
CHECK(TipoEvento <> ''
	AND TipoEvento IN (
		'social',
		'academico',
		'recaudacion de fondos',
		'infantil',
		'escolar',
		'dias festivos'));
ALTER TABLE Evento ALTER COLUMN TipoEvento SET NOT NULL;

ALTER TABLE Evento ALTER COLUMN Fecha SET NOT NULL;

ALTER TABLE Evento ADD CONSTRAINT evento_d2
CHECK(Capacidad > 0);

ALTER TABLE Evento ALTER COLUMN Capacidad SET NOT NULL;

--LLAVES Evento
ALTER TABLE Evento ADD CONSTRAINT evento_pk
PRIMARY KEY(IDEvento);


--COMMENT Evento
COMMENT ON TABLE Evento IS 'Tabla que contiene la informacion de los eventos';
COMMENT ON COLUMN Evento.IDEvento IS 'Identificador del evento';
COMMENT ON COLUMN Evento.TipoEvento IS 'Tipo de evento';
COMMENT ON COLUMN Evento.Fecha IS 'Fecha del evento';
COMMENT ON COLUMN Evento.Capacidad IS 'Capacidad del evento';

COMMENT ON CONSTRAINT evento_d1 ON Evento IS 'El tipo de evento debe ser no nulo y no debe ser la cadena vacia';
COMMENT ON CONSTRAINT evento_d2 ON Evento IS 'La capacidad debe ser mayor a 0 y no nulo';
COMMENT ON CONSTRAINT evento_pk ON Evento IS 'El IDEvento es la llave primaria';


CREATE TABLE Ticket(
	NumTicket SERIAL,
	IDVisitante SERIAL,
	Descuento INT,
	CostoUnitario DECIMAL,
	TipoServicio VARCHAR(50),
	Fecha DATE
);


-- RESTRICCIONES DE DOMINIO Ticket
ALTER TABLE Ticket ADD CONSTRAINT ticket_d1
CHECK (Descuento >= 0
	AND Descuento <= 100);
ALTER TABLE Ticket ALTER COLUMN Descuento SET NOT NULL;

ALTER TABLE Ticket ADD CONSTRAINT ticket_d2
CHECK (CostoUnitario > 0);
ALTER TABLE Ticket ALTER COLUMN CostoUnitario SET NOT NULL;

ALTER TABLE Ticket ADD CONSTRAINT ticket_d3
CHECK (TipoServicio IN ('baño', 'tienda', 'comida'));
ALTER TABLE Ticket ALTER COLUMN TipoServicio SET NOT NULL;

ALTER TABLE Ticket ALTER COLUMN Fecha SET NOT NULL;

--LLAVES Ticket
ALTER TABLE Ticket ADD CONSTRAINT ticket_pk
PRIMARY KEY(NumTicket);

ALTER TABLE Ticket ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante)
ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT Ticket
COMMENT ON TABLE Ticket IS 'Tabla que contiene la informacion de los tickets';
COMMENT ON COLUMN Ticket.NumTicket IS 'Identificador del ticket';
COMMENT ON COLUMN Ticket.IDVisitante IS 'Identificador del visitante';
COMMENT ON COLUMN Ticket.Descuento IS 'Descuento del ticket';
COMMENT ON COLUMN Ticket.CostoUnitario IS 'Costo unitario del ticket';
COMMENT ON COLUMN Ticket.TipoServicio IS 'Tipo de servicio del ticket';
COMMENT ON COLUMN Ticket.Fecha IS 'Fecha del ticket';

COMMENT ON CONSTRAINT ticket_d1 ON Ticket IS 'El descuento debe ser mayor o igual a 0 y menor o igual a 100 y no nulo';
COMMENT ON CONSTRAINT ticket_d2 ON Ticket IS 'El costo unitario debe ser mayor a 0 y no nulo';
COMMENT ON CONSTRAINT ticket_d3 ON Ticket IS 'El tipo de servicio debe ser baño, tienda o comida y no nulo';
COMMENT ON CONSTRAINT ticket_pk ON Ticket IS 'El NumTicket es la llave primaria';
COMMENT ON CONSTRAINT idvisitante_fk ON Ticket IS 'La llave foranea IDVisitante que hace referencia a la tabla Visitante';


CREATE TABLE ProveerMedicina(
	IDInsumoMedicina SERIAL,
	RFCProveedor VARCHAR(13)
);

-- RESTRICCIONES DE DOMINIO ProveerMedicina
ALTER TABLE ProveerMedicina ADD CONSTRAINT proveerMedicina_d1
 CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE ProveerMedicina ALTER COLUMN RFCProveedor SET NOT NULL;


-- LLAVES ProveerMedicina
ALTER TABLE ProveerMedicina ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ProveerMedicina ADD CONSTRAINT idinsumoMedicina_fk
FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina(IDInsumoMedicina) ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT ProveerMedicina

COMMENT ON TABLE ProveerMedicina IS 'Tabla de la relacion proveer Proveedor con Medicina';
COMMENT ON COLUMN ProveerMedicina.IDInsumoMedicina IS 'Identificador de la medicina';
COMMENT ON COLUMN ProveerMedicina.RFCProveedor IS 'Identificador del proveedor';

COMMENT ON CONSTRAINT proveerMedicina_d1 ON ProveerMedicina IS 'El RFC debe ser no nulo, debe tener 4 letras mayusculas, 6 numeros y despues de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT rfcProveedor_fk ON ProveerMedicina IS 'La llave foranea RFCProveedor que hace referencia a la tabla Proveedor';
COMMENT ON CONSTRAINT idinsumoMedicina_fk ON ProveerMedicina IS 'La llave foranea IDInsumoMedicina que hace referencia a la tabla Medicina';


CREATE TABLE Notificar(
	idEvento SERIAL,
	IDVisitante SERIAL,
	TipoNotificacion VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Notificar
ALTER TABLE Notificar ADD CONSTRAINT notificar_d1
CHECK (TipoNotificacion <> '');
ALTER TABLE Notificar ALTER COLUMN TipoNotificacion SET NOT NULL;

--LLAVES DE Notificar
ALTER TABLE Notificar ADD CONSTRAINT idevento_fk
FOREIGN KEY (idEvento) REFERENCES Evento(idEvento)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Notificar ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)
ON UPDATE CASCADE ON DELETE CASCADE;

COMMENT ON TABLE Notificar IS 'Tabla que contiene la informacion de las notificaciones que se hacen de los eventos a los clientes';
COMMENT ON COLUMN Notificar.idEvento IS 'Identificador del evento del que se notifica';
COMMENT ON COLUMN Notificar.IDVisitante IS 'Identificador del cliente al que se notifica';
COMMENT ON COLUMN Notificar.TipoNotificacion IS 'El tipo de la notificacion que recibe el cliente';
COMMENT ON CONSTRAINT notificar_d1 ON Notificar IS 'El tipo de notificacion es no nula y no debe ser la cadena vacia';
COMMENT ON CONSTRAINT idevento_fk ON Notificar IS 'La llave foranea idEvento que referencia la tabla Evento';
COMMENT ON CONSTRAINT idvisitante_fk ON Notificar IS 'La llave foranea IDVisitante que referencia la tabla Visitante';



CREATE TABLE Trabajar(
	RFCVeterinario VARCHAR(13),
	IDBioma SERIAL
);

-- RESTRICCIONES DE DOMINIO Trabajar
ALTER TABLE Trabajar ADD CONSTRAINT trabajar_d1
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Trabajar ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES Trabajar
ALTER TABLE Trabajar ADD CONSTRAINT rfcveterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Trabajar ADD CONSTRAINT idBioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENT Trabajar
COMMENT ON TABLE Trabajar IS 'Tabla de la relación Trabajar';
COMMENT ON COLUMN Trabajar.RFCVeterinario IS 'Identificador del veterinario que trabaja';
COMMENT ON COLUMN Trabajar.IDBioma IS 'Identificador del bioma en el que trabaja el veterinario';
COMMENT ON CONSTRAINT trabajar_d1 ON Trabajar IS 'El RFC debe ser no nulo, debe tener 4 letras mayusculas, 6 numeros y despues de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT rfcveterinario_fk ON Trabajar IS 'La llave foranea RFCVeterinario que hace referencia a la tabla Veterinario';
COMMENT ON CONSTRAINT idBioma_fk ON Trabajar IS 'La llave foranea IDBioma que hace referencia a la tabla Bioma';



CREATE TABLE DistribuirMedicina(
	IDInsumoMedicina SERIAL,
	IDBioma SERIAL
);

--LLAVES DistribuirMedicina
ALTER TABLE DistribuirMedicina ADD CONSTRAINT idinsumoMedicina_fk
FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina (IDInsumoMedicina)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE DistribuirMedicina ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician Comentarios DistribuirMedicina

COMMENT ON TABLE DistribuirMedicina IS 'Tabla de la relacion entre bioma y medicina';
COMMENT ON COLUMN DistribuirMedicina.IDInsumoMedicina  IS 'Identificador de Medicina';
COMMENT ON COLUMN DistribuirMedicina.IDBioma IS 'Identificador del bioma';
COMMENT ON CONSTRAINT idinsumoMedicina_fk ON DistribuirMedicina IS 'Llave foranea que hace referencia a la tabla Medicina';
COMMENT ON CONSTRAINT idbioma_fk ON DistribuirMedicina IS 'Llave foranea que hace referencia a la tabla bioma';

--Terminan Comentarios DistribuirMedicina


CREATE TABLE Cuidar (
	RFCCuidador VARCHAR(13),
	IDAnimal SERIAL,
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	DiasTrabajo INT,
	HorarioLaboral TIME,
	Salario DECIMAL,
	Genero VARCHAR(10),
	Sexo VARCHAR(10),
	Altura DECIMAL,
	Peso DECIMAL,
	Especie VARCHAR(50),
	NombreAnimal VARCHAR(50),
	Alimentacion VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Cuidar
ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d1
CHECK ( RFCCuidador <> '' 
	AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)
	AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Cuidar ALTER COLUMN RFCCuidador SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d2
CHECK(Nombre <> ''
	AND Nombre ~ '[a-zA-Z]*');
ALTER TABLE Cuidar ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno ~ '[a-zA-Z]*');

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno ~ '[a-zA-Z]*');

ALTER TABLE Cuidar ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);
ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d5
CHECK(Calle <> '');
ALTER TABLE Cuidar ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d6
CHECK(Colonia <> '');
ALTER TABLE Cuidar ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d7
CHECK(Estado <> ''
	AND Estado ~ '[a-zA-Z]*');
ALTER TABLE Cuidar ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d8
CHECK(Genero <> ''
	AND Genero ~ '[a-zA-Z]*');
ALTER TABLE Cuidar ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d9
CHECK(DiasTrabajo > 0
	AND DiasTrabajo < 30);
ALTER TABLE Cuidar ALTER COLUMN DiasTrabajo SET NOT NULL;	
	
ALTER TABLE Cuidar ALTER COLUMN HorarioLaboral SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d11
CHECK(Salario > 0);
ALTER TABLE Cuidar ALTER COLUMN Salario SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d12
CHECK (NombreAnimal <> ''
		AND NombreAnimal ~ '[a-zA-Z]*');
ALTER TABLE Cuidar ALTER COLUMN NombreAnimal SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d13
CHECK (Sexo IN ('Macho', 'Hembra'));
ALTER TABLE Cuidar ALTER COLUMN Sexo SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d14
CHECK (Altura > 0);
ALTER TABLE Cuidar ALTER COLUMN Altura SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d15
CHECK (Peso > 0);
ALTER TABLE Cuidar ALTER COLUMN Peso SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d16
CHECK (Especie <> ''
		AND Especie ~ '[a-zA-Z]*');
ALTER TABLE Cuidar ALTER COLUMN Especie SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d18
CHECK (
		Alimentacion IN (
			'Carnivoro',
			'Herbivoro',
			'Omnivoro'));
ALTER TABLE Cuidar ALTER COLUMN Alimentacion SET NOT NULL;

-- LLAVES Cuidar
ALTER TABLE Cuidar ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador (RFCCuidador)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Cuidar ADD CONSTRAINT idanimal_fk
FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal)
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENTS Cuidar
COMMENT ON TABLE Cuidar IS 'Tabla que contiene la informacion de los cuidadores y los animales que cuidan';
COMMENT ON COLUMN Cuidar.RFCCuidador IS 'Identificador del cuidador';
COMMENT ON COLUMN Cuidar.IDAnimal IS 'Identificador del animal';
COMMENT ON COLUMN Cuidar.Nombre IS 'Nombre del cuidador';
COMMENT ON COLUMN Cuidar.ApellidoPaterno IS 'Apellido paterno del cuidador';
COMMENT ON COLUMN Cuidar.ApellidoMaterno IS 'Apellido materno del cuidador';
COMMENT ON COLUMN Cuidar.Calle IS 'Calle del domicilio del cuidador';
COMMENT ON COLUMN Cuidar.NumInterior IS 'Numero interior del domicilio del cuidador';
COMMENT ON COLUMN Cuidar.NumExterior IS 'Numero exterior del domicilio del cuidador';
COMMENT ON COLUMN Cuidar.Colonia IS 'Colonia del domicilio del cuidador';
COMMENT ON COLUMN Cuidar.Estado IS 'Estado del domicilio del cuidador';
COMMENT ON COLUMN Cuidar.FechaInicioContrato IS 'Fecha en la que inicio el contrato como cuidador';
COMMENT ON COLUMN Cuidar.FechaFinContrato IS  'Fecha en que finalizara el contrato como cuidador';
COMMENT ON COLUMN Cuidar.FechaNacimiento IS 'Fecha de nacimiento del cuidador';
COMMENT ON COLUMN Cuidar.Genero IS 'Genero del cuidador';
COMMENT ON COLUMN Cuidar.DiasTrabajo IS 'Dias en los que un cuidador trabaja';
COMMENT ON COLUMN Cuidar.HorarioLaboral IS 'Horario laboral del cuidador';
COMMENT ON COLUMN Cuidar.Salario IS 'Salario del cuidador';
COMMENT ON COLUMN Cuidar.NombreAnimal IS 'Nombre del animal';

COMMENT ON CONSTRAINT cuidar_d1 ON Cuidar IS 'El RFC debe ser no nulo, debe tener 4 letras mayusculas, 6 numeros y despues de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT cuidar_d2 ON Cuidar IS 'Restriccion CHECK para el nombre del cuidador, verifica que contiene letras y no debe ser nulo';
COMMENT ON CONSTRAINT cuidar_d3 ON Cuidar IS 'Restriccion CHECK para el apellido paterno del cuidador, verifica que contenga letras y debe ser no nulo';
COMMENT ON CONSTRAINT cuidar_d4 ON Cuidar IS 'Restriccion CHECK para el apellido paterno del cuidador, verifica que contenga letras y debe ser no nulo';
COMMENT ON CONSTRAINT checkApe ON Cuidar IS 'Restriccion CHECK para apellido materno y paterno que no permite que sean nulos';
COMMENT ON CONSTRAINT cuidar_d5 ON Cuidar IS 'Restriccion CHECK para la calle del cuidador, no deba ser nula';
COMMENT ON CONSTRAINT cuidar_d6 ON Cuidar IS 'Restriccion CHECK para que la colonia no sea nula';
COMMENT ON CONSTRAINT cuidar_d7 ON Cuidar IS 'Restriccion CHECK para que el estado contenga letras y no sea nulo';
COMMENT ON CONSTRAINT cuidar_d8 ON Cuidar IS 'Restriccion CHECK para que el genero contenga letras y sea no nulo';
COMMENT ON CONSTRAINT cuidar_d9 ON Cuidar IS 'Restriccion CHECK para que los dias de trabajo sean mayor a 0 y menor a 30 y sea no nulo';
COMMENT ON CONSTRAINT cuidar_d11 ON Cuidar IS 'Restriccion CHECK para que el salario sea no nulo y mayor a 0';
COMMENT ON CONSTRAINT cuidar_d12 ON Cuidar IS 'Restriccion CHECK para que el nombreAnimal contenga letras, sea no vacio y no nulo';
COMMENT ON CONSTRAINT cuidar_d13 ON Cuidar IS 'Restriccion CHECK para que el sexo sea macho o hembra y no nulo';
COMMENT ON CONSTRAINT cuidar_d14 ON Cuidar IS 'Restriccion CHECK para que la altura sea mayor a 0 y no nulo';
COMMENT ON CONSTRAINT cuidar_d15 ON Cuidar IS 'Restriccion CHECK para que el peso sea mayor a 0 y no nulo';
COMMENT ON CONSTRAINT cuidar_d16 ON Cuidar IS 'Restriccion CHECK para que la especie contenga letras, sea no vacio y no nulo';
COMMENT ON CONSTRAINT cuidar_d18 ON Cuidar IS 'Restriccion CHECK para que la alimentacion sea carnivoro, herbivoro u omnivoro y no nulo';

COMMENT ON CONSTRAINT rfcCuidador_fk ON Cuidar IS 'La llave foranea rfcCuidador que referencia a la tabla Cuidador';
COMMENT ON CONSTRAINT idanimal_fk ON Cuidar IS 'La llave foranea idanimal que referencia a la tabla Animal';


 


CREATE TABLE Comprar(
	IDVisitante SERIAL,
	IDServicio SERIAL
);

--LLAVES Comprar
ALTER TABLE Comprar ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Comprar ADD CONSTRAINT idservicio_fk
FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
ON UPDATE CASCADE ON DELETE CASCADE;

COMMENT ON TABLE Comprar IS 'Tabla que contiene la informacion de los identificadores de los clientes y servicios al ser comprados';
COMMENT ON COLUMN Comprar.IDVisitante IS 'Identificador del cliente que compra';
COMMENT ON COLUMN Comprar.IDServicio IS 'Identificador del servicio que es comprado';
COMMENT ON CONSTRAINT idvisitante_fk ON Comprar IS 'La llave foranea idVisitante que referencia a la tabla IDVisitante';
COMMENT ON CONSTRAINT idservicio_fk ON Comprar IS 'La llave foranea IDServicio que referencia a la tabla Servicio';




CREATE TABLE ProveerAlimento(
	IDInsumoAlimento SERIAL,
	RFCProveedor VARCHAR(13)
);

-- LLAVES ProveerAlimento
ALTER TABLE ProveerAlimento ADD CONSTRAINT idinsumoAlimento_fk
FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ProveerAlimento ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor) ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT ProveerAlimento

COMMENT ON TABLE ProveerAlimento IS 'Tabla de la relacion entre Alimento y Proveedor';
COMMENT ON COLUMN ProveerAlimento.IDInsumoAlimento IS 'Identificador del alimento';
COMMENT ON COLUMN ProveerAlimento.RFCProveedor IS 'RFC del proveedor';

COMMENT ON CONSTRAINT idinsumoAlimento_fk ON ProveerAlimento IS 'La llave foranea IDInsumoAlimento que referencia la tabla Alimento';
COMMENT ON CONSTRAINT rfcProveedor_fk ON ProveerAlimento IS 'La llave foranea RFCProveedor que referencia la tabla Proveedor';


CREATE TABLE DistribuirAlimento(
	IDInsumoAlimento SERIAL,
	IDBioma SERIAL
	
);


-- LLAVES DistribuirAlimento
ALTER TABLE DistribuirAlimento ADD CONSTRAINT idinsumoAlimento_fk
FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE DistribuirAlimento ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician Comentarios para distribuirAlimento

COMMENT ON TABLE DistribuirAlimento IS 'Tabla de la relacion entre bioma ya alimento';
COMMENT ON COLUMN DistribuirAlimento.IDInsumoAlimento  IS 'Identificador del alimento';
COMMENT ON COLUMN DistribuirAlimento.IDBioma IS 'Identificador del bioma';
COMMENT ON CONSTRAINT idinsumoAlimento_fk ON DistribuirAlimento IS 'Llave foranea que hace referencia a la tabla Alimento';
COMMENT ON CONSTRAINT idbioma_fk ON DistribuirAlimento IS 'Llave foranea que hace referencia a la tabla bioma';

--Terminan COmentarios para distribuirAlimento




CREATE TABLE Tener(
	IDBioma SERIAL,
	IDServicio SERIAL
	
);

-- LLAVES Tener
ALTER TABLE Tener ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Tener ADD CONSTRAINT idservicio_fk
FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENT DE Tener
COMMENT ON TABLE Tener IS 'Tabla de relacion Tener';
COMMENT ON COLUMN Tener.IDBioma IS 'Columna Id de Bioma';
COMMENT ON COLUMN Tener.IDServicio IS 'Columna ID de Servicio';
COMMENT ON CONSTRAINT idbioma_fk ON Tener IS
'Llave foranea IDBioma referenciada de la tabla Bioma';
COMMENT ON CONSTRAINT idservicio_fk ON Tener IS
'Llve foranea IDServicio referenciada de la tabla Servicio';

CREATE TABLE Atender(
	IDAnimal SERIAL,
	IndicacionesMedicas Text,
	RFCVeterinario VARCHAR(13)
	
);

-- RESTRICCIONES DE DOMINIO Atender
ALTER TABLE Atender ADD CONSTRAINT atender_d1
CHECK (IndicacionesMedicas <> ''
		AND IndicacionesMedicas ~ '[a-zA-Z]*');
ALTER TABLE Atender ALTER COLUMN IndicacionesMedicas SET NOT NULL;

ALTER TABLE Atender ADD CONSTRAINT atender_d2
CHECK (RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Atender ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES Atender
ALTER TABLE Atender ADD CONSTRAINT idanimal_fk
FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal) ON UPDATE CASCADE ON DELETE CASCADE ;

ALTER TABLE Atender ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario (RFCVeterinario) ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT de Atender

COMMENT ON TABLE Atender IS 'Tabla de la relacion Atender';
COMMENT ON COLUMN Atender.IDAnimal IS 'Columna id del animal';
COMMENT ON COLUMN Atender.IndicacionesMedicas IS 'Indicaciones Medicas dadas por el veterinario';
COMMENT ON COLUMN Atender.RFCVeterinario IS 'RFC del veterinario';

COMMENT ON CONSTRAINT atender_d1 ON Atender IS 'Las indicaciones medicas no pueden ser la cadena vacia y tienen que ser solo letras';
COMMENT ON CONSTRAINT atender_d2 ON Atender IS 'El rfc del veterinario no puede ser la cadena vacia, la longitud del rfc tiene que ser 12 o 13, debe tener 4 letras mayusculas, 6 numeros y despues de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT idanimal_fk ON Atender IS 'Llave foranea IDAnimal referenciada de la tabla Animal';
COMMENT ON CONSTRAINT rfcVeterinario_fk ON Atender IS 'Llave foranea RFCVeterinario referenciada de la tabla Veterinario';


------------------------------Telefonos y correos -------------------------------------

CREATE TABLE TelefonoVisitante(
	IDVisitante SERIAL,
	Telefono CHAR(10)
	
);

-- RESTRICCIONES DE DOMINIO TelefonoVisitante
ALTER TABLE TelefonoVisitante ADD CONSTRAINT telefonoVisitante_d1
CHECK(Telefono SIMILAR TO '[0-9]{10}');
ALTER TABLE TelefonoVisitante ALTER COLUMN Telefono SET NOT NULL;

-- LLAVES TelefonoVisitante
ALTER TABLE TelefonoVisitante ADD CONSTRAINT telefonoVisitante_pk
PRIMARY KEY(IDVisitante, Telefono);

ALTER TABLE TelefonoVisitante ADD CONSTRAINT idVisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)
ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT TelefonoVisitante
COMMENT ON TABLE TelefonoVisitante IS 'Tabla que contiene los telefonos de los visitantes';
COMMENT ON COLUMN TelefonoVisitante.IDVisitante IS 'Identificador del visitante al cual le pertenece el telefono';
COMMENT ON COLUMN TelefonoVisitante.Telefono IS 'Telefono asociado a algun visitante';

COMMENT ON CONSTRAINT telefonoVisitante_d1 ON TelefonoVisitante IS 'El telefono debe estar conformado por numeros y no ser nulo';
COMMENT ON CONSTRAINT telefonoVisitante_pk ON TelefonoVisitante IS 'El TelefonoVisitante es la llave primaria';
COMMENT ON CONSTRAINT idVisitante_fk On TelefonoVisitante IS 'El IDVisitante es llave foranea que referencia a la tabla Visitante';




CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoProveedor
ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_d1
CHECK(Telefono SIMILAR TO '[0-9]');
ALTER TABLE TelefonoProveedor ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_d2
CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoProveedor ALTER COLUMN RFCProveedor SET NOT NULL;

-- LLAVES TelefonoProveedor
ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_pk
PRIMARY KEY(RFCProveedor, Telefono);

ALTER TABLE TelefonoProveedor ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor) ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT de TelefonoProveedor

COMMENT ON TABLE TelefonoProveedor IS 'Tabla que contiene los telefonos de los proveedores';
COMMENT ON COLUMN TelefonoProveedor.RFCProveedor IS 'RFC del proveedor al cual le pertenece el telefono';
COMMENT ON COLUMN TelefonoProveedor.Telefono IS 'Telefono asociado a algun proveedor';

COMMENT ON CONSTRAINT telefonoProveedor_d1 ON TelefonoProveedor IS 'El telefono debe estar conformado por numeros y no ser nulo';
COMMENT ON CONSTRAINT telefonoProveedor_d2 ON TelefonoProveedor IS 'El RFC del proveedor debe empezar con 4 letras mayusculas, 6 numeros y de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT telefonoProveedor_pk ON TelefonoProveedor IS 'El RFCProveedor y el telefono son llaves primarias';
COMMENT ON CONSTRAINT rfcProveedor_fk On TelefonoProveedor IS 'El RFCProveedor es llave foranea que referencia a la tabla Proveedor';



CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoProveedor
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_d1
CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoProveedor ALTER COLUMN RFCProveedor SET NOT NULL;	

ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_d2
CHECK(Correo ~* '^.+@.+$');
ALTER TABLE CorreoProveedor ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoProveedor
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_pk
PRIMARY KEY(RFCProveedor, Correo);

ALTER TABLE CorreoProveedor ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor)
ON UPDATE CASCADE ON DELETE CASCADE;

COMMENT ON TABLE CorreoProveedor IS 'Tabla que contiene los correos de los proveedores';
COMMENT ON COLUMN CorreoProveedor.RFCProveedor IS 'Identificador del proveedor al que le pertenece el correo';
COMMENT ON COLUMN CorreoProveedor.Correo IS 'El correo asociado a algun proveedor';
COMMENT ON CONSTRAINT correoProveedor_d1 ON CorreoProveedor IS 'El RFC del proveedor debe empezar con 4 letras mayusculas, 6 numeros y de 2 a 3 letras o numeros';
COMMENT ON CONSTRAINT correoProveedor_d2 ON CorreoProveedor IS 'El correo debe contener % y un punto';
COMMENT ON CONSTRAINT correoProveedor_pk ON CorreoProveedor IS 'el RFCProveedor y Correo son llaves primarias';
COMMENT ON CONSTRAINT rfcProveedor_fk ON CorreoProveedor IS 'El RFCProveedor es llave foranea que referencia a la tabla Proveedor';



CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoVeterinario
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_d1
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoVeterinario ALTER COLUMN RFCVeterinario SET NOT NULL;	

ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_d2
CHECK(Correo ~* '^.+@.+$');
ALTER TABLE CorreoVeterinario ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoVeterinario
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_pk
PRIMARY KEY(RFCVeterinario, Correo);

ALTER TABLE CorreoVeterinario ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario)
ON UPDATE CASCADE ON DELETE CASCADE;


--Inician Comentarios CorreoVeterinario

COMMENT ON TABLE CorreoVeterinario IS 'Tabla que contiene los correos de los veterinarios';
COMMENT ON COLUMN CorreoVeterinario.RFCVeterinario IS 'Identificador del veterinario';
COMMENT ON COLUMN CorreoVeterinario.Correo IS 'Correo del veterinario';
COMMENT ON CONSTRAINT correoVeterinario_d1 ON CorreoVeterinario IS 'Restriccion CHECK que verifica que el RFC sea no nulo y tenga el formato de RFC, debe contener 12 o 13 caracteres';
COMMENT ON CONSTRAINT correoVeterinario_d2 ON CorreoVeterinario IS 'Restriccion CKECK de correo veterinario que verifica el formato del correo';
COMMENT ON CONSTRAINT correoVeterinario_pk ON CorreoVeterinario IS 'Llave primaria de CorreoVeterinario';
COMMENT ON CONSTRAINT rfcVeterinario_fk ON CorreoVeterinario IS 'Llave foranea de CorreoVeterinario que hace referencia a Veterinario';
--Terminan Comentarios CorreoVeterinario



CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoVeterinario
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_d1
CHECK(Telefono SIMILAR TO '[0-9]{10}');
ALTER TABLE TelefonoVeterinario ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_d2
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoVeterinario ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES TelefonoVeterinario
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_pk
PRIMARY KEY(RFCVeterinario, Telefono);

ALTER TABLE TelefonoVeterinario ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario) 
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENTS DE TelefonoVeterinario
COMMENT ON TABLE TelefonoVeterinario IS 'Tabla que contiene los telefonos de los Veterinarios';
COMMENT ON COLUMN TelefonoVeterinario.RFCVeterinario IS 'Identificador(RFC) del Veterinario';
COMMENT ON COLUMN TelefonoVeterinario.Telefono IS 'El telefono del Veterinario';
COMMENT ON CONSTRAINT telefonoVeterinario_d1 ON TelefonoVeterinario IS 
'Restriccion para el telefono: La cadena solo puede contener numeros';
COMMENT ON CONSTRAINT telefonoVeterinario_d2 ON TelefonoVeterinario IS 
'Restriccion para RFC: Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT telefonoVeterinario_pk ON TelefonoVeterinario IS
'Llave primaria de TelefonoVeterinario';
COMMENT ON CONSTRAINT rfcVeterinario_fk ON TelefonoVeterinario IS
'Lave foranea de TelefonoVeterinario, referenciada de la tabla Veterinario';



CREATE TABLE CorreoCuidador(
	RFCCuidador VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoCuidador
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_d1
CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoCuidador ALTER COLUMN RFCCuidador SET NOT NULL;	

ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_d2
CHECK(Correo ~* '^.+@.+$');
ALTER TABLE CorreoCuidador ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoCuidador
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_pk
PRIMARY KEY(RFCCuidador, Correo);

ALTER TABLE CorreoCuidador ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador(RFCCuidador)
ON UPDATE CASCADE ON DELETE CASCADE;

--COMENTS DE CorreoCuidador
COMMENT ON TABLE CorreoCuidador IS 'Tabla que contiene el correo del cuidador';
COMMENT ON COLUMN CorreoCuidador.RFCCuidador IS 'RFC del Cuidador';
COMMENT ON COLUMN CorreoCuidador.Correo IS 'Correo del Cuidador';

COMMENT ON CONSTRAINT correoCuidador_d1 ON CorreoCuidador IS
'Restriccion para RFC: Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT correoCuidador_d2 ON CorreoCuidador IS
'Restriccion para Correo: Tiene que ser de la forma [caracteres]@[caracteres].[dominio]';
COMMENT ON CONSTRAINT correoCuidador_pk ON CorreoCuidador IS
'Llave primaria de CorreoCuidador';
COMMENT ON CONSTRAINT rfcCuidador_fk ON CorreoCuidador IS
'Llave foranea de CorreoCuidador referenciada de la tabla Cuidador';



CREATE TABLE TelefonoCuidador(
	RFCCuidador VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoCuidador
ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_d1
CHECK(Telefono SIMILAR TO '[0-9]{10}');
ALTER TABLE TelefonoCuidador ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_d2
CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoCuidador ALTER COLUMN RFCCuidador SET NOT NULL;

-- LLAVES TelefonoCuidador
ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_pk
PRIMARY KEY(RFCCuidador, Telefono);

ALTER TABLE TelefonoCuidador ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador(RFCCuidador)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician COmentarios TelefonoCuidador

COMMENT ON TABLE TelefonoCuidador IS 'Tabla que almaceno todos los telefonos de los cuidadores';
COMMENT ON COLUMN TelefonoCuidador.RFCCuidador IS 'Identificador del cuidador';
COMMENT ON COLUMN TelefonoCuidador.Telefono IS 'Telefono del cuidador';
COMMENT ON CONSTRAINT telefonoCuidador_d1 ON TelefonoCuidador IS 'Restriccion CHECK que verifica que todos los caracteres de un telefono sean digitos';
COMMENT ON CONSTRAINT telefonoCuidador_d2 ON TelefonoCuidador IS 'Restriccion CHECK que verifica que un rfc tenga el formato correcto y que solo tenga una longitud de 13 o 12 caracteres';
COMMENT ON CONSTRAINT telefonoCuidador_pk ON TelefonoCuidador IS 'Llave primaria para la tabla TelefonoCuidador';
COMMENT ON CONSTRAINT rfcCuidador_fk ON TelefonoCuidador IS 'Llave foranea de TelefonoCuidador que hace referencia a la tabla cuidador';

--Terminan Comentarios de TelefonoCuidador

CREATE TABLE CorreoVisitante (
	IDVisitante SERIAL,
	Correo VARCHAR(50)
);

--RESTRICCIONES DE DOMINIO CorreoVisitante
ALTER TABLE CorreoVisitante ADD CONSTRAINT correoVisitante_d1
CHECK(Correo ~* '^.+@.+$' AND Correo <> '');


-- LLAVES CorreoVisitante
ALTER TABLE CorreoVisitante ADD CONSTRAINT correoVisitante_pk
PRIMARY KEY(IdVisitante, Correo);

ALTER TABLE CorreoVisitante ADD CONSTRAINT idVisitante_fk
FOREIGN KEY(IDVisitante) REFERENCES Visitante(IDVisitante)
ON UPDATE CASCADE ON DELETE CASCADE;

--Inician comentarios de Correo Visitante
COMMENT ON TABLE CorreoVisitante IS 'Tabla que contiene los correos de los visitantes';
COMMENT ON COLUMN CorreoVisitante.IDVisitante IS 'Identificador del visitante';
COMMENT ON COLUMN CorreoVisitante.Correo IS 'Correo del visitante';
COMMENT ON CONSTRAINT correoVisitante_d1 ON CorreoVisitante IS 'Restriccion CHECK que verifica que la entrada tenga el formato de un correo';
COMMENT ON CONSTRAINT correoVisitante_pk ON CorreoVisitante IS 'Correo del visitante como llave primaria';
COMMENT ON CONSTRAINT idVisitante_fk ON CorreoVisitante IS 'llave foranea del correo del visitante';
--Terminan comentarios de Correo Visitante

CREATE TABLE Visitar(
	IDEvento SERIAL,
	IDVisitante SERIAL
);

-- LLAVES Visitar
ALTER TABLE Visitar ADD CONSTRAINT idEvento_fk
FOREIGN KEY (IDEvento) REFERENCES Evento(IDEvento) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Visitar ADD CONSTRAINT idVisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante) ON UPDATE CASCADE ON DELETE CASCADE;

--COMMENT Visitar

COMMENT ON TABLE Visitar IS 'Tabla que relaciona la asistencia de un Visitante con algun Evento';
COMMENT ON COLUMN Visitar.IDEvento IS 'Identificador del evento';
COMMENT ON COLUMN Visitar.IDVisitante IS 'Identificador del visitante';

COMMENT ON CONSTRAINT idEvento_fk ON Visitar IS 'Llave foranea idEvento que referencia la tabla Evento';
COMMENT ON CONSTRAINT idVisitante_fk ON Visitar IS 'Llave foranea IDVisitante que referencia la tabla Visitante';







