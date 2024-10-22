--https://bitbucket.org/genomicepidemiology/pycodamath/src/master/src/pycodamath/pycoda.py
CREATE OR REPLACE FUNCTION destilled.aitchison_mean(input_array DOUBLE PRECISION[])
RETURNS DOUBLE PRECISION[] AS
$$
declare
  alpha double precision := 1.;
  cls_const double precision := 1.;
  i integer;
  N integer;
  norm double precision := 0;
  back double precision[];
  x double precision;
BEGIN
  N := array_length(input_array, 1);
  for i in 1..N loop
    x := exp(destilled.psi(input_array[i] + alpha));
      back[i] := x;
    norm := norm + x;
  end loop;
  for i in 1..N loop
      back[i] := cls_const * back[i] / norm;
  end loop;
  return back;
END;
$$
LANGUAGE plpgsql;
