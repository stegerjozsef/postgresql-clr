-- scipy/special/xsf/cephes/psi.h
CREATE OR REPLACE FUNCTION %%SCHEMA%%.psi_asy(x double precision)
returns double precision as 
$$
declare
  psi_A double precision[] := array[8.33333333333333333333E-2,  -2.10927960927960927961E-2, 7.57575757575757575758E-3,
                                    -4.16666666666666666667E-3, 3.96825396825396825397E-3,  -8.33333333333333333333E-3,
                                    8.33333333333333333333E-2];
  y double precision;
  z double precision;
begin
  if (x < 1.0e17) then
    z := 1.0 / (x * x);
    y := z * %%SCHEMA%%.polevl(z, psi_A, 6);
  else
    y := 0.0;
  end if;
  return ln(x) - (0.5 / x) - y;
end;
$$
LANGUAGE plpgsql;
