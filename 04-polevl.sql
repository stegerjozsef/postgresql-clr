CREATE OR REPLACE FUNCTION destilled.polevl(x double precision, coef DOUBLE PRECISION[], N integer)
returns double precision as 
$$
declare
  ans double precision;
  i integer;
begin
  ans:=coef[1];
  for i in 1..N loop
    ans:=ans*x+coef[i+1];
  end loop;
  return ans;
end;
$$
LANGUAGE plpgsql;
