-- scipy/special/xsf/cephes/digamma.h
CREATE OR REPLACE FUNCTION %%SCHEMA%%.digamma(x double precision)
returns double precision as 
$$
declare
  digamma_negroot double precision := -0.504083008264455409;
  digamma_negrootval double precision := 7.2897639029768949e-17;
begin
  if (abs(x - digamma_negroot) < 0.3) then
    return %%SCHEMA%%.digamma_zeta_series(x, digamma_negroot, digamma_negrootval);
  end if;
  return %%SCHEMA%%.psi(x);
end;
$$
LANGUAGE plpgsql;
