within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
function polynomialABCinverse
  "calculates the solution of x = f(y,z) defined by polynomial function z = c[1]*x^2 + c[2]*xy + c[3]*y^2 "
  extends Modelica.Icons.Function;
  input Real[3] c "coefficient vector";
  input Real y "variable 2";
  input Real z "variable 3";
  output Real x "result";

protected
  Real p2 "p/2 in the p-q-formula";
  Real q "q in the p-q-formula";
  Real r "root term sqrt(p2^2-q)";
algorithm
  p2 := (c[2]*y)/(2*c[3]);
  q := (c[1]*y*y-z)/c[3];
  if p2*p2 - q >= 0 then
   r := sqrt(p2*p2 - q);
   x := max(-p2 + r, -p2 - r);
  else
   x := -p2;
  end if;
  annotation (Documentation(revisions="<html><ul>
  <li>2017-11-16 by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  This function is used in the Zugabe.Fluid.Movers.Pump model. It
  depends on the correct order of the coefficients in c and the
  respective assignment of y and z. For the computation of n = f(Q,H),
  for example z must be assigned H and y = Q in m3/h. The result will
  be the pump speed in revolutions/min.
</p>
<p>
  Be aware that the function will not check if the result is a positive
  number. Negative results have no sensible physical meaning in this
  case. There are two solutions of quadratic polynomial that can be
  calculated with the so-called p-q-formula. The function will take the
  larger value of the two soutions as a result.
</p>
</html>"));
end polynomialABCinverse;
