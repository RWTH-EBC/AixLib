within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
partial model PartialDuctMassTransfer
  "partial model for rectangular duct mass transfer models"
  extends PartialFlowMassTransfer;

  parameter Integer nWidth(min=1) "number of parallel segments in width direction";

  parameter Modelica.SIunits.Length[n] heights "height of duct";
  parameter Modelica.SIunits.Length[n] widths "width of duct";

  Real[n] aspectRatios "aspect ratio between duct height and width";
  parameter Boolean UWT
    "true if UWT (uniform wall temperature) boundary conditions";
  parameter Boolean local
    "true if local Sherwood number or false if average shall be calculated";
  parameter Boolean rectangularDuct
    "true if rectangular duct is used for Sherwood number calculation, else flat gap is used.";

  Real[n] betas;

  // Variables
  Modelica.SIunits.ThermalConductivity[n] lambdas "thermal conductivity of medium";
  Modelica.SIunits.Density[n] rhos "density of medium";
  Modelica.SIunits.DynamicViscosity[n] mus "dynamic viscosity of medium";
  Real[n] Scs "Schmidt number";
  Real[n] Res "Reynolds number";
  Real[n] Shs "Shwerwood number";
  Modelica.SIunits.Area[n] crossSections "cross section of duct";
  Real[n] zsStern "dimensionless length";

protected
  constant Modelica.SIunits.MolarMass M_air = 28.96;
  constant Modelica.SIunits.MolarMass M_steam = 18.02;
  constant Real sigmaAir = 3.711 "distance of air molecules in Atom";
  constant Real sigmaSteam = 2.655 "distance of steam molecules in Atom";

  Real[n] omegas "collision integral";
  Modelica.SIunits.DiffusionCoefficient[n] Ds
    "diffusion coefficient for water vapour into air";

equation

  rhos = Medium.density(states);
  mus = Medium.dynamicViscosity(states);
  lambdas = Medium.thermalConductivity(states);

  for i in 1:n loop
    crossSections[i] = heights[i]*(widths[i]/nWidth);
    aspectRatios[i] = heights[i]/widths[i];
    omegas[i] = CollisionIntegral(
      T=Medium.temperature(states[i]));
    Ds[i] = DiffusionCoefficient(
      M_1=M_air,
      M_2=M_steam,
      T=Medium.temperature(states[i]),
      p = 1,
      sigma1=sigmaAir,
      sigma2=sigmaSteam,
      omega=omegas[i]);
    Scs[i] = mus[i]/(rhos[i]*Ds[i]);
    zsStern[i] = (sum(lengths)/sqrt(crossSections[i]))/max(0.001,Res[i]*Scs[i]);
    if rectangularDuct then
      Res[i] =
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      rho=rhos[i],
      mu=mus[i],
      v=vs[i],
      D=sqrt(crossSections[i]));
      Shs[i]=SherwoodNumberMuzychka(
        Re=Res[i],
        Sc=Scs[i],
        aspectRatio=aspectRatios[i],
        zStern=zsStern[i],
        UWT=UWT,
        local=local,
        gamma=0.1);
      betas[i] = (Shs[i]*rhos[i]*Ds[i])/sqrt(crossSections[i]);
    else
      Res[i] =
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
        rho=rhos[i],
        mu=mus[i],
        v=vs[i],
        D=2*heights[i]);
      Shs[i]=SherwoodNumberStephan(
        Re=Res[i],
        Sc=Scs[i],
        length=lengths[i],
        dimension=2*heights[i]);
      betas[i] = (Shs[i]*rhos[i]*Ds[i])/(2*heights[i]);
    end if;
  end for;

  annotation (Documentation(info="<html>
<p>This model calculates the convective mass transfer coefficient <i>&beta;</i> using the nusselt number correlation for rectangular air ducts by Muzychka and Yovanovich [1] and the analogy between heat and mass transfer (see function SherwoodNumberMuzychka).</p>
<p align=\"center\"><i>Sh = Nu , Sc = Pr</i></p>
<p>The air density, dynamic viscosity and thermal conductivity are calculated as state variables. The Schmidt number is calculated using the dynamic viscosity, density and the diffusion coefficient of water vapour into air. The Reynolds number is calculated using the density, dynamic viscosity, flow velocity and the duct&apos;s cross section as characteristic length. The cross section is calculated using the duct&apos;s height and width.</p>
<p align=\"center\"><i>Sc = &mu; &frasl; (&rho; D ) </i></p>
<p>The convective heat transfer coefficient is calculated as follows.</p>
<p align=\"center\"><i>&beta; = (Sh &rho; D ) &frasl; &radic;A<sub>cross-section</sub> </i></p>
<p><br>The diffusion coefficient of water vapour into air <i>D</i> is calculated using the function DiffusionCoefficient.</p>
<p><br><br><br>[1]: Muzychka, Y. S.; Yovanovich, M. M. : <i>Laminar Forced Convection Heat Transfer in the Combined Entry Region of Non-Circular Ducts</i> ; Transactions of the ASME; Vol. 126; February 2004</p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br>First implementation. </li>
</ul>
</html>"));
end PartialDuctMassTransfer;
