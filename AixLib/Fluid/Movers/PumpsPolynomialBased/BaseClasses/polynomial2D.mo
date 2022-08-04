within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
function polynomial2D
  "computes the polynomial in two variables a and b: sum_ij( c[i, j] * a^i * b^j ) where c is the coefficient matrix."
  extends Modelica.Icons.Function;
  import pow = AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.powerInt;
  input Real c[:,:] "coefficient matrix";
  input Real a "variable 1";
  input Real b "variable 2";
  output Real y "result";

algorithm
  y := 0;
  for i in 1:size(c, 1) loop
    for j in 1:size(c, 2) loop
      if c[i,j] <> 0 then
        y := y + c[i,j] * pow(a,i-1) * pow(b,j-1);
      end if;
    end for;
  end for;
  annotation (Documentation(info="<html><h4>
  History
</h4>
<p>
  In the original pump model the functions for pump pressure head,
  speed and electrical power consumption have been integrated directly
  as functions with hard coded coefficients. They were computed from
  volume flow rate, speed or pressure head. For example:
</p>
<p>
  <img src=
  \"modelica://Zugabe/Resources/Images/equations/equation-dnpNDYbm.png\"
  alt=\"H = f(Q, n)=sum(c(i,j)*Q^i*n^j)\">
</p>
<p>
  In the process of collecting all pump specific data into a single
  record the functions aproach has been discontinued. This generic
  function can now be used to compute the polynomial using two
  variables a and b and a matrix of coefficients c.
</p>
</html>"));
end polynomial2D;
