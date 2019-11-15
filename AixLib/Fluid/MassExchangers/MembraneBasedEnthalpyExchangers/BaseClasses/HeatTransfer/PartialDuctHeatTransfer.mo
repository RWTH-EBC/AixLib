within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
partial model PartialDuctHeatTransfer
  "partial model for rectangular duct heat transfer models"
  extends PartialFlowHeatTransfer;

  parameter Integer nWidth(min=1) "number of parallel segments in width direction";

  parameter Modelica.SIunits.Length[n] heights "height of duct";
  parameter Modelica.SIunits.Length[n] widths "width of duct";

  Real[n] aspectRatios "aspect ratio between duct height and width";
  parameter Boolean UWT
    "true if UWT (uniform wall temperature) boundary conditions";
  parameter Boolean local
    "true if local nusslet number or false if average shall be calculated";
  parameter Boolean rectangularDuct
    "true if rectangular duct is used for Sherwood number calculation, else flat gap is used.";

  Modelica.SIunits.CoefficientOfHeatTransfer[n] alphas;

  // Variables
  Modelica.SIunits.ThermalConductivity[n] lambdas "thermal conductivity of medium";
  Modelica.SIunits.Density[n] rhos "density of medium";
  Modelica.SIunits.DynamicViscosity[n] mus "dynamic viscosity of medium";
  Real[n] Prs "Prandtl number";
  Real[n] Res "Reynolds number";
  Real[n] Nus "Nusselt number";
  Modelica.SIunits.Area[n] crossSections "cross section of duct";
  Real[n] zsStern "dimensionless length";

equation

  rhos = Medium.density(states);
  mus = Medium.dynamicViscosity(states);
  lambdas = Medium.thermalConductivity(states);
  Prs = Medium.prandtlNumber(states);

  for i in 1:n loop
    crossSections[i] = heights[i]*(widths[i]/nWidth);
    aspectRatios[i] = heights[i]/widths[i];
    zsStern[i] = (sum(lengths)/sqrt(crossSections[i]))/max(0.001,Res[i]*Prs[i]);
    if rectangularDuct then
      Res[i] =
        Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
          rho=rhos[i],
          mu=mus[i],
          v=vs[i],
          D=crossSections[i]);
      Nus[i] = NusseltNumberMuzychka(
              Re=Res[i],
              Pr=Prs[i],
              aspectRatio=aspectRatios[i],
              zStern=zsStern[i],
              UWT=UWT,
              local=local,
              gamma=0.1);
      alphas[i] = (Nus[i]*lambdas[i])/sqrt(crossSections[i]);
    else
      Res[i] =
        Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
          rho=rhos[i],
          mu=mus[i],
          v=vs[i],
          D=2*heights[i]);
      Nus[i] = NusseltNumberStephan(
              Re=Res[i],
              Pr=Prs[i],
              length=lengths[i],
              dimension=2*heights[i]);
      alphas[i] = (Nus[i]*lambdas[i])/(2*heights[i]);
    end if;
  end for;

  annotation (Documentation(info="<html>
<p>This model calculates the convective heat transfer coefficient <i>&alpha;</i> using the nusselt number correlation for rectangular air ducts by Muzychka and Yovanovich [1] (see function NusseltNumberMuzychka).</p>
<p>The air density, dynamic viscosity, thermal conductivity and Prandtl number are calculated as state variables. The Reynolds number is calculated using the density, dynmaic viscosity, flow velocity and the duct&apos;s cross section as characteristic length. The cross section is calculated using the duct&apos;s height and width.</p>
<p>The convective heat transfer coefficient is calculated as follows.</p>
<p align=\"center\"><i>&alpha; = (Nu &lambda; ) &frasl; &radic;A<sub>cross-section</sub> </i></p>
<p><br><br><br><br>[1]: Muzychka, Y. S.; Yovanovich, M. M. : <i>Laminar Forced Convection Heat Transfer in the Combined Entry Region of Non-Circular Ducts</i> ; Transactions of the ASME; Vol. 126; February 2004</p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation.</li>
</ul>
</html>"));
end PartialDuctHeatTransfer;
