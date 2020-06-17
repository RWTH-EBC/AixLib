within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
function polynomialABC
  "calculates polynomial function of form z = c[1]*x^2 + c[2]*xy + c[3]*y^2 "
  extends Modelica.Icons.Function;
  input Real[3] c "coefficient vector";
  input Real x "variable 1";
  input Real y "variable 2";
  output Real z "result";
algorithm
  z := c[1]*x*x + c[2]*x*y + c[3]*y*y;
  annotation (Documentation(revisions="<html><ul>
  <li>2017-11-16 by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  This function is used in the Zugabe.Fluid.Movers.Pump model. It
  depends on the correct order of the coefficients in c and the
  respective assignment of x and y. For the computation of H = f(Q,n),
  for example x must be assigned n and y = Q in m3/h. The result will
  be the pump pressure head in m.
</p>
<p>
  Be aware that the function will not check if the result is a positive
  number. Negative results have no sensible physical meaning in this
  case.
</p>
</html>"));
end polynomialABC;
