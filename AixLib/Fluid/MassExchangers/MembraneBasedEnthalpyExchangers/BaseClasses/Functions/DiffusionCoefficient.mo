within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function DiffusionCoefficient
  "calculates diffusion coefficient of substance 2 in substance 1"

  input Modelica.SIunits.MolarMass M_1 "molar mass of component one";
  input Modelica.SIunits.MolarMass M_2 "molar mass of component two";
  input Modelica.SIunits.Temperature T "temperature in K";
  input Modelica.SIunits.Pressure p "pressure in atm";
  input Real sigma1 "collision diameter component 1";
  input Real sigma2 "collision diameter component 2";
  //input Real eps_1 "lennard-Jones potential component 1";
  //input Real eps_2 "lennard-Jones potential component 2";
  input Real omega "CollisionIntegral";

  output Modelica.SIunits.DiffusionCoefficient D_12
    "diffusion coefficient of component two in one";

protected
  Real omega12 "collision integral mixture";
  Real sigma12;

algorithm

  sigma12 :=(sigma1 + sigma2)/2;
  omega12 :=sigma12^2*omega;
  D_12 := 1.8583E-7 * T^(3/2)/(p*omega12) * (1/M_1 + 1/M_2)^(1/2);

  annotation (Documentation(info="<html>
<p>The function calculates the diffusion coefficient of a medium 1 into medium 2. Therefore the collision diameters of medium 1 and 2 <i>&sigma;<sub>1</sub>, &sigma;<sub>2</sub></i> 
and the collision integral <i>&Omega;</i> are used as inputs.</p>
<p align=\"center\"><i>&sigma;<sub>12</sub> = (&sigma;<sub>1</sub> + &sigma;<sub>2</sub>) &frasl; 2</i></p>
<p align=\"center\"><i>&Omega;<sub>12</sub> = &sigma;<sup>2</sup><sub>12</sub> &Omega;</i></p>
<p align=\"center\"><i>D<sub>12</sub> = 1.8583 10<sup>(-7)</sup> T<sup>3 &frasl; 2</sup> &frasl; (p &Omega;<sub>12</sub>) &radic;(1 &frasl; M<sub>1</sub> + 1 &frasl; M<sub>2</sub>)</i></p>
</html>", revisions="<html>
<ul>
<li>June 15, 2018, by Martin Kremer:<br/>First implementation. </li>
</ul>
</html>"));
end DiffusionCoefficient;
