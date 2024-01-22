within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
function powerInt "Computes the power x^n for the real x and the integer n."
  extends Modelica.Icons.Function;
  input Real x "base";
  input Integer n "exponent";
  output Real y "result";

protected
  Integer t;
  Integer e "dummy for n to allow for assignment";
  Real z "dummy for x to allow for assignment";

algorithm
  e := n;
  z := x;
  y := 1;
  while e <> 0 loop
    t := mod(e, 2);
//     Modelica.Utilities.Streams.print("n: " + String(e) + " t: " + String(t) + " x: "
//        + String(z) + " y: " + String(y));
    e := integer(e*0.5)
      "rounds real towards -inf and produces integer (in contrast to floor function)";

    if t == 1 then
      y := y*z;
    end if;

    if e <> 0 then
      z := z*z;
    end if;
  end while;
  annotation (Documentation(info="<html><p>
  \"A simple implementation of <i>Algorithm A</i> from section
  <i>4.6.3</i> of TAOCP\" as taken from:
</p>
<p>
  <a href=
  \"http://alvaro-videla.com/2014/03/the-power-algorithm.html\">http://alvaro-videla.com/2014/03/the-power-algorithm.html</a>
</p>
<p>
  \"There’s a very well known algorithm for calculation powers, that is
  <i>x to the power of n</i> or simply: <code>x^n</code>. Donald Knuth
  presents the algorithm in section 4.6.3 <i>Evaluation of Powers</i>
  of TAOCP.\"
</p>
<ul>
  <li>2017-11-14 by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));
end powerInt;
