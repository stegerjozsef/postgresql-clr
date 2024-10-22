-- scipy/special/xsf/cephes/zeta.h
CREATE OR REPLACE FUNCTION destilled.zeta(x double precision, q double precision)
returns double precision as 
$$
declare
  MACHEP double precision := 1.11022302462515654042E-16; -- scipy/special/xsf/cephes/const.h
  i integer;
  s double precision;
  a double precision;
  b double precision;
  w double precision;
  k double precision;
  t double precision;
  zeta_A double precision[] := array[
            12.0,
            -720.0,
            30240.0,
            -1209600.0,
            47900160.0,
            -1.8924375803183791606e9, /*1.307674368e12/691 */
            7.47242496e10,
            -2.950130727918164224e12,  /*1.067062284288e16/3617 */
            1.1646782814350067249e14,  /*5.109094217170944e18/43867 */
            -4.5979787224074726105e15, /*8.028576626982912e20/174611 */
            1.8152105401943546773e17,  /*1.5511210043330985984e23/854513 */
            -7.1661652561756670113e18  /*1.6938241367317436694528e27/236364091 */
        ];
begin
  if (x = 1.0) then
    return 'Infinity'::double precision;
  end if;

  if (x < 1.0) then
    -- set_error("zeta", SF_ERROR_DOMAIN, NULL);
    return 'NaN'::double precision;
  end if;

  if (q <= 0.0) then
    if (q = floor(q)) then
      -- set_error("zeta", SF_ERROR_SINGULAR, NULL);
      return 'Infinity'::double precision;
    end if;
    if (x != floor(x)) then
      -- goto domerr; /* because q^-x not defined */
      return 'NaN'::double precision;
    end if;
  end if;

/* Asymptotic expansion
 * https://dlmf.nist.gov/25.11#E43
 */
  if (q > 1e8) then
    return (1 / (x - 1) + 1 / (2 * q)) * pow(q, 1 - x);
  end if;
/* Euler-Maclaurin summation formula */

  s := pow(q, -x);
  a := q;
  i := 0;
  b := 0.0;
  while ((i < 9) or (a <= 9.0)) loop
    i := i + 1;
    a := a + 1.0;
    b := pow(a, -x);
    s := s + b;
    if (abs(b / s) < MACHEP) then
      return s;
    end if;
  end loop;

  w := a;
  s := s + b * w / (x - 1.0);
  s := s - 0.5 * b;
  a := 1.0;
  k := 0.0;
  for i in 1..12 loop
    a := a * (x + k);
    b := b / w;
    t := a * b / zeta_A[i];
    s := s + t;
    t := abs(t / s);
    if (t < MACHEP) then
      return s;
    end if;
    k := k + 1.0;
    a := a * (x + k);
    b := b / w;
    k := k + 1.0;
  end loop;
  return s;
end;
$$
LANGUAGE plpgsql;
