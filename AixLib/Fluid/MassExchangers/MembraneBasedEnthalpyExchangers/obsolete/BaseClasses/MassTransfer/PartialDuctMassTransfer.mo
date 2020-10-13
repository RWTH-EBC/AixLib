within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.MassTransfer;
partial model PartialDuctMassTransfer
  "Base class for duct mass transfer correlation in terms of Sherwood number mass transfer in a rectangular duct for laminar flow"
  extends PartialMassTransfer;

  parameter Modelica.SIunits.Length[n] heightsDuct "heights of duct";
  parameter Modelica.SIunits.Length[n] widthsDuct "widths of duct";

  input Modelica.SIunits.Velocity[n] vs "mean velocities of fluid flow";

  input Modelica.SIunits.Length[n] lengths "lengths along flow path";

  Real[n] aspectRatios "aspect ratios between duct height and width";
  parameter Boolean UWT "true if UWT boundary conditions";
  parameter Real C1 "constant C1";
  parameter Real C2 "constant C2";
  parameter Real C3 "constant C3";
  parameter Real C4 "constant C4";

  Real[n] betas "convective mass transfer coefficients";

  Real[n] Ds(each unit="m2/s") "mass diffusivities of medium";
  Real[n] Omegas "Collision integrals";
  Modelica.SIunits.ThermalConductivity[n] lambdas "thermal conductivities of medium";
  Modelica.SIunits.Density[n] rhos "densities of medium";
  Modelica.SIunits.DynamicViscosity[n] mus "dynamic viscosities of medium";
  Real[n] Scs "Schmidt numbers";
  Real[n] Res "Reynolds numbers";
  Real[n] Shs "Sherwood numbers";
  Modelica.SIunits.Area[n] crossSections "cross section of duct";
  Real[n] zsStern "dimensionless lengths";

protected
  constant Modelica.SIunits.MolarMass M_air = 28.96;
  constant Modelica.SIunits.MolarMass M_steam = 18.02;
  constant Real sigma_air = 3.711;
  constant Real sigma_steam = 2.655;
  constant Real k_B(unit="J/K") = 1.38064852E-23 "Stefan-Boltzmann-Constant";
  constant Real eps_air = 78.6 * k_B;
  constant Real eps_steam = 363 * k_B;

equation
  rhos =  Medium.density(states);
  mus =  Medium.dynamicViscosity(states);
  lambdas =  Medium.thermalConductivity(states);

  for i in 1:n loop
    crossSections[i] = heightsDuct[i] * widthsDuct[i];
    aspectRatios[i] = heightsDuct[i]/widthsDuct[i];
    Res[i] =  Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      rho=rhos[i],
      mu=mus[i],
      v=vs[i],
      D=2*heightsDuct[i]);
    Omegas[i] = CollisionIntegral(
      T=Medium.temperature(states[i]),
      eps_1=eps_air,
      eps_2=eps_steam);
    Ds[i] = DiffusionCoefficient(
      M_1=M_air,
      M_2=M_steam,
      T=Medium.temperature(states[i]),
      p = 1,
      sigma_1=sigma_air,
      sigma_2=sigma_steam,
      Omega_D=Omegas[i]);
    Scs[i] =  mus[i]/(rhos[i] * Ds[i]);
    zsStern[i] = (sum(lengths)/sqrt(crossSections[i]))/max(0.001,Res[i] * Scs[i]);
    Shs[i] =  MassTransfer.SherwoodNumberMuzychka(
      Re=Res[i],
      Sc=Scs[i],
      aspectRatio=aspectRatios[i],
      zStern=zsStern[i],
      UWT=UWT,
      C1=C1,
      C2=C2,
      C3=C3,
      C4=C4,
      gamma=0.1);
    betas[i] =  (Shs[i] * rhos[i] * Ds[i])/sqrt(crossSections[i]);
  end for;

  annotation (Documentation(revisions="<html><ul>
  <li>April 23, 2019, by Martin Kremer:<br/>
    Changes function to model.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This model calculates the convective heat transfer coefficient
  <i>α</i> using the nusselt number correlation for rectangular air
  ducts by Muzychka and Yovanovich [1] and the analogy between heat and
  mass transfer (see function SherwoodNumberMuzychka).
</p>
<p style=\"text-align:center;\">
  <i>Sh = Nu , Sc = Pr</i>
</p>
<p>
  The air density, dynamic viscosity and thermal conductivity are
  calculated as state variables. The Schmidt number is calculated using
  the dynamic viscosity, density and the diffusion coefficient of water
  vapour into air. The Reynolds number is calculated using the density,
  dynamic viscosity, flow velocity and the duct's cross section as
  characteristic length. The cross section is calculated using the
  duct's height and width.
</p>
<p style=\"text-align:center;\">
  <i>Sc = μ ⁄ (ρ D )</i>
</p>
<p>
  The convective heat transfer coefficient is calculated as follows.
</p>
<p style=\"text-align:center;\">
  <i>β = (Sh ρ D ) ⁄ √A<sub>cross-section</sub></i>
</p>
<p>
  <br/>
  The diffusion coefficient of water vapour into air <i>D</i> is
  calculated using the function DiffusionCoefficient.
</p>
<p>
  <br/>
  <br/>
  <br/>
  [1]: Muzychka, Y. S.; Yovanovich, M. M. : <i>Laminar Forced
  Convection Heat Transfer in the Combined Entry Region of Non-Circular
  Ducts</i> ; Transactions of the ASME; Vol. 126; February 2004
</p>
</html>"), Icon(graphics={           Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder)}));
end PartialDuctMassTransfer;
