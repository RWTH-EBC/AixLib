within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function DiffusionCoefficient
  "calculates diffusion coefficient of substance 2 in substance 1"

  input Modelica.Units.SI.MolarMass M_1 "molar mass of component one";
  input Modelica.Units.SI.MolarMass M_2 "molar mass of component two";
  input Modelica.Units.SI.Temperature T "temperature in K";
  input Modelica.Units.SI.Pressure p "pressure in atm";
  input Real sigma1 "collision diameter component 1";
  input Real sigma2 "collision diameter component 2";
  //input Real eps_1 "lennard-Jones potential component 1";
  //input Real eps_2 "lennard-Jones potential component 2";
  input Real omega "CollisionIntegral";

  output Modelica.Units.SI.DiffusionCoefficient D_12
    "diffusion coefficient of component two in one";

protected
  Real omega12 "collision integral mixture";
  Real sigma12;

algorithm

  sigma12 :=(sigma1 + sigma2)/2;
  omega12 :=sigma12^2*omega;
  D_12 := 1.8583E-7 * T^(3/2)/(p*omega12) * (1/M_1 + 1/M_2)^(1/2);

  annotation (Documentation(info="<html><p>
  The function calculates the diffusion coefficient of a medium 1 into
  medium 2. Therefore the collision diameters of medium 1 and 2
  <i>σ<sub>1</sub>, σ<sub>2</sub></i> and the collision integral
  <i>Ω</i> are used as inputs.
</p>
<p style=\"text-align:center;\">
  <i>σ<sub>12</sub> = (σ<sub>1</sub> + σ<sub>2</sub>) ⁄ 2</i>
</p>
<p style=\"text-align:center;\">
  <i>Ω<sub>12</sub> = σ<sup>2</sup><sub>12</sub> Ω</i>
</p>
<p style=\"text-align:center;\">
  <i>D<sub>12</sub> = 1.8583 10<sup>(-7)</sup> T<sup>3 ⁄ 2</sup> ⁄ (p
  Ω<sub>12</sub>) √(1 ⁄ M<sub>1</sub> + 1 ⁄ M<sub>2</sub>)</i>
</p>
</html>", revisions="<html>
<ul>
  <li>June 15, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end DiffusionCoefficient;
