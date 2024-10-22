--https://bitbucket.org/genomicepidemiology/pycodamath/src/master/src/pycodamath/pycoda.py
CREATE OR REPLACE FUNCTION %%SCHEMA%%.clr(input_array DOUBLE PRECISION[], forceshift boolean)
RETURNS DOUBLE PRECISION[] AS
$$
declare
  back double precision[];
  x double precision;
  i integer;
  N integer;
  accu double precision := 0;
  tmp double precision[];
begin
  if input_array @> array[0.::double precision] or forceshift then
    tmp := %%SCHEMA%%.aitchison_mean(input_array);
  else
    tmp := input_array;
  end if;
  N := array_length(tmp, 1);
  for i in 1..N loop
    x := ln(tmp[i]);
    back[i] := x;
    accu := accu + x;
  end loop;
  accu := accu / N;
  for i in 1..N loop
    back[i] := back[i] - accu;
  end loop;
  return back;
END;
$$
LANGUAGE plpgsql;
