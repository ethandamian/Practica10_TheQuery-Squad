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

-- Una función que reciba el bioma y calcule el número de animales en ese bioma.
CREATE OR REPLACE FUNCTION obtener_numero_animales_bioma(bioma character varying)
RETURNS integer AS $$
DECLARE
    numero_animales integer;
BEGIN
    SELECT COUNT(*) INTO numero_animales
    FROM animal a
    WHERE a.idbioma in (select idbioma from bioma b where b.tipobioma = bioma);

    RETURN numero_animales;
END;
$$ LANGUAGE plpgsql;

SELECT obtener_numero_animales_bioma('aviario');
SELECT obtener_numero_animales_bioma('desierto'); -- 154
SELECT obtener_numero_animales_bioma('tundra'); -- 0