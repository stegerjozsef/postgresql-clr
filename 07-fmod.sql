CREATE OR REPLACE FUNCTION destilled.fmod (
   dividend double precision,
   divisor double precision
) RETURNS double precision
    LANGUAGE sql IMMUTABLE AS
'SELECT dividend - floor(dividend / divisor) * divisor';
