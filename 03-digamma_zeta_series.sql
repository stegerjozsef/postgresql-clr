-- scipy/special/xsf/digamma.h
CREATE OR REPLACE FUNCTION destilled.digamma_zeta_series(x double precision, root double precision, rootval double precision)
returns double precision as 
$$
declare
  epsilon double precision := 2.220446049250313e-16;  -- destilled.calculate_epsilon() evaluates to this, speed up?
  res double precision;
  coeff double precision;
  term double precision;
  n integer;
begin
  res := rootval;
  coeff = -1.0;

  x = x - root;
  for n in 1..99 loop
    coeff = coeff * (-x);
    term := coeff * destilled.zeta(n + 1, root);
    res := res + term;
    if (abs(term) < epsilon * abs(res)) then
      exit;
    end if;
  end loop;
  return res;
end;
$$
LANGUAGE plpgsql;
