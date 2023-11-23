/*i. Un SP el cual se encarga de registrar un cliente, en este SP, debes introducir la informaci ́on del cliente y
se debe encargar de insertar en la tabla correspondiente, es importante que no permitan la inserci ́on de
n ́umeros o s ́ımbolos cuando sean campos relacionados a nombres.*/

CREATE OR REPLACE PROCEDURE registrarVisitante
(nombre VARCHAR, paterno VARCHAR, materno VARCHAR,
genero VARCHAR, nacimiento DATE)
AS $$
BEGIN
	IF nombre ~ '[0-9!@#$%^&*()_+=\[\]{};:,.<>?]' OR 
	   paterno ~ '[0-9!@#$%^&*()_+=\[\]{};:,.<>?]' OR
	   materno ~ '[0-9!@#$%^&*()_+=\[\]{};:,.<>?]'
	THEN
		RAISE EXCEPTION 'No se pudo realizar la inserción. El nombre o apellidos ingresados no son válidos';
	ELSE
		IF nacimiento >= CURRENT_DATE
		THEN
			RAISE EXCEPTION 'La fecha de nacimiento ingresada no es válida';
		ELSE
			INSERT INTO Visitante (genero, nombre, paterno, materno, fechanacimiento)
			VALUES (genero, nombre, paterno, materno, nacimiento);
			RAISE NOTICE 'El visitante ha sido registrado correctamente';
		END IF;
	END IF;
END;
$$
Language plpgsql;

select * from visitante;

CALL registrarVisitante ('Jimin', 'Park', 'Chimmy', 'Masculino', '1995-10-13');-- Se permite
CALL registrarVisitante ('Jimin', 'Kim', 'Chimmy', 'Masculino', '2023-12-31');-- No se permite porque la fecha es futura
CALL registrarVisitante ('Jim@in', 'Kim', 'Chimmy', 'Masculino', '2023-12-31');-- No se permite porque el nombre tiene un caracter no valido.







/* ii. Un SP que se encargue de eliminar un proveedor a traves de su id, en este SP, se debera eliminar todas
las referencias del proveedor de las demas tablas.*/


CREATE OR REPLACE PROCEDURE eliminarProveedor(IN RFCProveedorBuscado VARCHAR(13)) AS 
$$
BEGIN
  -- Verifica si el RFC del proveedor existe en la tabla Proveedor
  IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE RFCProveedor = RFCProveedorBuscado) THEN
    RAISE EXCEPTION 'El proveedor con RFC % no existe en la base de datos', RFCProveedorBuscado
    USING hint = 'Verifica que el RFC ingresado sea el correcto';
   
  ELSE
  	 -- Elimina de Proveedor, por el mantenimiento de llaves foraneas, las tablas que contengan
  	-- a ese Proveedor se eliminaran tambien
    DELETE FROM Proveedor WHERE RFCProveedor = RFCProveedorBuscado;
   	
  END IF;
	 
     
END;
$$
LANGUAGE plpgsql;

-- Obtenemos la informacion de la tabla proveedor con un RFC que si existe 
SELECT * FROM Proveedor WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM ProveerMedicina WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM ProveerAlimento WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM TelefonoProveedor WHERE RFCProveedor = 'VUBY765283CP6';

-- Llamamos al SP con ese RFC
CALL eliminarProveedor('VUBY765283CP6');

-- Verificamos que no se encuentre en la tabla Proveedor o en cualquiera donde se encuentra el RFC
SELECT * FROM Proveedor WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM ProveerMedicina WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM ProveerAlimento WHERE RFCProveedor = 'VUBY765283CP6';
SELECT * FROM TelefonoProveedor WHERE RFCProveedor = 'VUBY765283CP6';

 
 
