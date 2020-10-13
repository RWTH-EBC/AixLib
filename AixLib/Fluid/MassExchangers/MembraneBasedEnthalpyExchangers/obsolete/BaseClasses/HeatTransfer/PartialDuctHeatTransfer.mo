within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.HeatTransfer;
partial model PartialDuctHeatTransfer
  "Base class for duct heat transfer correlation in terms of Nusselt number heat transfer in a rectangular duct for laminar flow"
  extends Modelica.Fluid.Interfaces.PartialHeatTransfer;

  parameter Modelica.SIunits.Length[n] heightsDuct "heights of duct";
  parameter Modelica.SIunits.Length[n] widthsDuct "widths of duct";

  input Modelica.SIunits.Velocity[n] vs
    "Mean velocities of fluid flow in segments";

  input Modelica.SIunits.Length[n] lengths "Lengths along flow path";

  Real[n] aspectRatios "aspect ratios between duct height and width";
  parameter Boolean UWT "true if UWT boundary conditions";
  parameter Real C1 "constant C1";
  parameter Real C2 "constant C2";
  parameter Real C3 "constant C3";
  parameter Real C4 "constant C4";

  Modelica.SIunits.CoefficientOfHeatTransfer[n] alphas "convective heat flow coefficients";

  Modelica.SIunits.ThermalConductivity[n] lambdas "thermal conductivities of medium";
  Modelica.SIunits.Density[n] rhos "densities of medium";
  Modelica.SIunits.DynamicViscosity[n] mus "dynamic viscosities of medium";
  Real[n] Prs "Prandtl numbers";
  Real[n] Res "Reynolds numbers";
  Real[n] Nus "Nusselt numbers";
  Modelica.SIunits.Area[n] crossSections "cross section of duct";
  Real[n] zsStern "dimensionless lengths";

equation
  rhos = Medium.density(states);
  mus = Medium.dynamicViscosity(states);
  lambdas = Medium.thermalConductivity(states);
  Prs = Medium.prandtlNumber(states);

  for i in 1:n loop
    aspectRatios[i] = heightsDuct[i]/widthsDuct[i];
    crossSections[i] = heightsDuct[i] * widthsDuct[i];
    Res[i] = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      rho=rhos[i],
      mu=mus[i],
      v=vs[i],
      D=2*heightsDuct[i]);
    zsStern[i] = (lengths[i]/sqrt(crossSections[i]))/(max(0.001,Res[i]) * Prs[i]);
    Nus[i] = NusseltNumberMuzychka(
      Re=Res[i],
      Pr=Prs[i],
      aspectRatio=aspectRatios[i],
      zStern=zsStern[i],
      UWT=UWT,
      C1=C1,
      C2=C2,
      C3=C3,
      C4=C4,
      gamma=0.1);
    alphas[i] = (Nus[i] * lambdas[i])/sqrt(crossSections[i]);
  end for;

  annotation (Documentation(info="<html><p>
  This model calculates the convective heat transfer coefficient
  <i>α</i> using the nusselt number correlation for rectangular air
  ducts by Muzychka and Yovanovich [1] (see function
  NusseltNumberMuzychka).
</p>
<p>
  The air density, dynamic viscosity, thermal conductivity and Prandtl
  number are calculated as state variables. The Reynolds number is
  calculated using the density, dynmaic viscosity, flow velocity and
  the duct's cross section as characteristic length. The cross section
  is calculated using the duct's height and width.
</p>
<p>
  The convective heat transfer coefficient is calculated as follows.
</p>
<p style=\"text-align:center;\">
  <i>α = (Nu λ ) ⁄ √A<sub>cross-section</sub></i>
</p>
<p>
  <br/>
  <br/>
  <br/>
  <br/>
  [1]: Muzychka, Y. S.; Yovanovich, M. M. : <i>Laminar Forced
  Convection Heat Transfer in the Combined Entry Region of Non-Circular
  Ducts</i> ; Transactions of the ASME; Vol. 126; February 2004
</p>
<ul>
  <li>April 23, 2019, by Martin Kremer:<br/>
    Changes function to model.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"), Icon(graphics={           Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder)}));
end PartialDuctHeatTransfer;
