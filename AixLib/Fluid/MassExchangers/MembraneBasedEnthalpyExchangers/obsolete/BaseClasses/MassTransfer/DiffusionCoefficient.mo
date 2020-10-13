within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.MassTransfer;
function DiffusionCoefficient
  "Calculates diffusion coefficient of medium using collision integral"
  input Modelica.SIunits.MolarMass M_1 "molar mass of component one";
  input Modelica.SIunits.MolarMass M_2 "molar mass of component two";
  input Modelica.SIunits.Temperature T "temperature in K";
  input Modelica.SIunits.Pressure p "pressure in atm";
  input Real sigma_1 "collision diameter component 1";
  input Real sigma_2 "collision diameter component 2";
  //input Real eps_1 "lennard-Jones potential component 1";
  //input Real eps_2 "lennard-Jones potential component 2";
  input Real Omega_D "CollisionIntegral";

  output Modelica.SIunits.DiffusionCoefficient D_12 "diffusion coefficient of component two in one";

  //constant Real N_A(unit="1/mol") = 6.02214857E23 "Avogardo-Constant";
  //constant Real k_B(unit="J/K") = 1.38064852E-23 "Stefan-Boltzmann-Constant";

  //Real Omega_D "collision integral";
protected
  Real Omega_12 "collision integral mixture";
  Real sigma_12;
  //Real eps_12;
algorithm

  sigma_12 :=(sigma_1 + sigma_2)/2;

  //Omega_D :=Functions.CollisionIntegral(T=T,eps_12=eps_12);

  Omega_12 :=sigma_12^2*Omega_D;

  //eps_12 :=(eps_1*eps_2)^(1/2);

  D_12 := 1.8583E-7 * T^(3/2)/(p*Omega_12) * (1/M_1 + 1/M_2)^(1/2);

  annotation (Documentation(revisions="<html><ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This function calculates the diffusion coefficient of water vapour
  into air using the collision integral.
</p>
<p style=\"text-align:center;\">
  <i>D = 1.8583 · 10 <sup>-7</sup> T <sup>1.5</sup> ⁄ (p Ω )
  (1/M<sub>air</sub> + 1/M<sub>steam</sub> ) <sup>0.5</sup></i>
</p>
</html>"));
end DiffusionCoefficient;
