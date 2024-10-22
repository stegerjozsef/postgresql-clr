-- evaluiates to 2.220446049250313e-16
CREATE OR REPLACE FUNCTION %%SCHEMA%%.calculate_epsilon()
RETURNS FLOAT8 AS
$$
DECLARE
    one FLOAT8 := 1.0;
    epsilon FLOAT8 := 1.0;
BEGIN
    WHILE one + epsilon / 2.0 > one LOOP
        epsilon := epsilon / 2.0;
    END LOOP;
    RETURN epsilon;
END;
$$
LANGUAGE plpgsql IMMUTABLE;
