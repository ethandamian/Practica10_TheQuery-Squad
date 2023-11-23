/*i. Un SP el cual se encarga de registrar un cliente, en este SP, debes introducir la informaci ́on del cliente y
se debe encargar de insertar en la tabla correspondiente, es importante que no permitan la inserci ́on de
n ́umeros o s ́ımbolos cuando sean campos relacionados a nombres.*/








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

 
 