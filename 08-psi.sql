-- scipy/special/xsf/cephes/psi.h
CREATE OR REPLACE FUNCTION destilled.psi(x double precision)
returns double precision as 
$$
declare
  y double precision := 0.0;
  r double precision;
  i integer;
  n integer;
  SCIPY_EULER double precision := 0.577215664901532860606512090082402431; -- scipy/special/xsf/cephes/const.h
begin
  if (x = 'NaN'::double precision) then
    return x;
  elsif (x = 'Infinity'::double precision) then
    return x;
  elsif (x = '-Infinity'::double precision) then
    return 'NaN'::double precision;
  elsif (x = 0) then
    -- raise notice 'psi singular'
    return 'Infinity'::double precision;  --            return std::copysign(std::numeric_limits<double>::infinity(), -x);
  elsif (x < 0.0) then
    /* argument reduction before evaluating tan(pi * x) */
    r := destilled.fmod(x, 1.);
    if (r = 0.0) then
      --raise notice 'psi singular'
      return 'NaN'::double precision;
    end if;
    y := -PI() / tan(PI() * r);
    x := 1.0 - x;
  end if;

  /* check for positive integer up to 10 */
  if ((x <= 10.0) AND (x = floor(x))) then
    n := cast(x as integer);
    for i in 1..(n-1) loop
      y := y + 1.0 / i;
    end loop;
    y := y - SCIPY_EULER;
    return y;
  end if;

  /* use the recurrence relation to move x into [1, 2] */
  if (x < 1.0) then
    y := y- 1.0 / x;
    x := x + 1.0;
  elsif (x < 10.0) then
    while (x > 2.0) loop
      x := x- 1.0;
      y := y + 1.0 / x;
    end loop;
  end if;

  if ((1.0 <= x) AND (x <= 2.0)) then
    y := y + destilled.digamma_imp_1_2(x);
    return y;
  end if;
  y := y+destilled.psi_asy(x);
  return y;
end;
$$
LANGUAGE plpgsql;
