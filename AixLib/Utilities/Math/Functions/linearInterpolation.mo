within AixLib.Utilities.Math.Functions;
function linearInterpolation "function for linear interpolation"
input Real x         "Independent variable";
  input Real y_1[:,2] "Interpolation data";
  output Real y        "Dependent variable";
protected
  Integer i "iteration counter";
  Integer n = size(y_1,1) "Number of interpolation points";
  Real p "linear gradient of interpolation";

algorithm

  assert(x>=y_1[1,1], "Independent variable must be greater than or equal to "+String(y_1[1,1]));
  assert(x<=y_1[n,1], "Independent variable must be less than or equal to "+String(y_1[n,1]));
  i := 1;
  while x>=y_1[i+1,1] loop
    i := i + 1;
  end while;
  p := (x-y_1[i,1])/(y_1[i+1,1]-y_1[i,1]);
  y := p*y_1[i+1,2]+(1-p)*y_1[i,2];

  annotation (Documentation(info="<html><p>
  This function interpolates values linearly between two fulcrums.
</p>
</html>", revisions="<html>
<ul>
  <li>November 13, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end linearInterpolation;
