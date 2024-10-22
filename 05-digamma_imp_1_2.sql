-- scipy/special/xsf/cephes/psi.h
CREATE OR REPLACE FUNCTION %%SCHEMA%%.digamma_imp_1_2(x double precision)
returns double precision as 
$$
declare
  psi_root1 double precision := 1569415565.0 / 1073741824.0;
  psi_root2 double precision := (381566830.0 / 1073741824.0) / 1073741824.0;
  psi_root3 double precision := 0.9016312093258695918615325266959189453125e-19;
  psi_Y double precision := 0.99558162689208984; -- f;
  psi_P double precision[] := array[-0.0020713321167745952, -0.045251321448739056, -0.28919126444774784,
                                    -0.65031853770896507,   -0.32555031186804491,  0.25479851061131551];
  psi_Q double precision[] := array[-0.55789841321675513e-6,
                                    0.0021284987017821144,
                                    0.054151797245674225,
                                    0.43593529692665969,
                                    1.4606242909763515,
                                    2.0767117023730469,
                                    1.0];
  g double precision;
  r double precision;
begin
  g := x - psi_root1;
  g := g - psi_root2;
  g := g - psi_root3;
  r := %%SCHEMA%%.polevl(x - 1.0, psi_P, 5) / %%SCHEMA%%.polevl(x - 1.0, psi_Q, 6);
  return g * psi_Y + g * r;
end;
$$
LANGUAGE plpgsql;
