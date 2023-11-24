-- I) Un trigger que se encargue de invertir el apellido paterno con el apellido materno de los proveedores.


-- Crear la función que se ejecutará cuando se active el trigger
CREATE OR REPLACE FUNCTION invertirApellidos()
RETURNS TRIGGER AS $$
DECLARE 
	variable_temporal VARCHAR(50);
BEGIN
    -- Verificar si es una operación de inserción (NEW es not NULL)
    IF TG_OP = 'INSERT' THEN
		variable_temporal:= NEW.ApellidoPaterno;
        NEW.ApellidoPaterno = NEW.ApellidoMaterno;
        NEW.ApellidoMaterno = variable_temporal; 
    ELSIF TG_OP = 'UPDATE' THEN
        -- Intercambiar el ApellidoPaterno con el ApellidoMaterno
        NEW.ApellidoPaterno = OLD.ApellidoMaterno;
        NEW.ApellidoMaterno = OLD.ApellidoPaterno;
    END IF;
    
    -- Devolver la nueva fila modificada
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que se activará antes de la inserción o actualización en la tabla Proveedor
CREATE TRIGGER trigger_invertir_apellidos
BEFORE INSERT OR UPDATE
ON Proveedor
FOR EACH ROW
EXECUTE FUNCTION invertirApellidos();


--Al momento de hacer insert los apellidos se cambian

/*Ejemplo de uso con la operacion update

SELECT *
FROM Proveedor
WHERE RFCProveedor='HIWE5598269MS';

UPDATE Proveedor SET ApellidoPaterno = 'Ewbanke' WHERE RFCProveedor ='HIWE5598269MS';

*Se intercambian los apellidos

*/


-- ii) Un trigger que se encargue de contar las personas que asisten a un evento, y agregarlo como atributo en
--evento. Cada vez que se inserte, se debera actualizar el campo.

-- Crear una función que se ejecutará cuando se active el trigger
CREATE OR REPLACE FUNCTION actualizar_contador()
RETURNS TRIGGER AS $$
BEGIN
  -- Incrementar el contador de personas que asisten al evento
  UPDATE Evento
  SET contador_asistentes = contador_asistentes + 1
  WHERE IdEvento = NEW.IdEvento;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que se activará después de insertar en la tabla Visitar
CREATE TRIGGER trigger_actualizar_contador
AFTER INSERT ON Visitar
FOR EACH ROW
EXECUTE FUNCTION actualizar_contador();

ALTER TABLE Evento ADD COLUMN contador_asistentes INT DEFAULT 0;

--Al insertarse filas en cierto evento el atributo de ese evento se incrementa

