-- Una funcion que reciba el identificador de veterinarios y regrese la edad del mismo.

CREATE OR REPLACE FUNCTION obtener_edad_veterinario(id_veterinario character varying)
RETURNS integer AS $$
DECLARE
    edad integer;
BEGIN
    SELECT EXTRACT(YEAR FROM AGE(NOW(), fechanacimiento)) INTO edad
    FROM veterinario
    WHERE rfcveterinario = id_veterinario;

    RETURN edad;
END;
$$ LANGUAGE plpgsql;

SELECT obtener_edad_veterinario('XRLH017039DDI');
SELECT obtener_edad_veterinario('DFRI0797275VI');
SELECT obtener_edad_veterinario('KDXO0616156NB');
