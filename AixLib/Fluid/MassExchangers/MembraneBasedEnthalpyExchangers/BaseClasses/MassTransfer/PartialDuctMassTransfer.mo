within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
partial model PartialDuctMassTransfer
  "partial model for rectangular duct mass transfer models"
  extends PartialFlowMassTransfer;

  parameter Integer nWidth(min=1) "number of parallel segments in width direction";

  parameter Modelica.Units.SI.Length[n] heights "height of duct";
  parameter Modelica.Units.SI.Length[n] widths "width of duct";

  Real[n] aspRats "aspect ratio between duct height and width";
  parameter Boolean uniWalTem
    "true if uniform wall temperature boundary conditions";
  parameter Boolean local
    "true if local Sherwood number or false if average shall be calculated";
  parameter Boolean recDuct
    "true if rectangular duct is used for Sherwood number calculation, else flat gap is used.";

  Real[n] kCons;

  // Variables
  Modelica.Units.SI.ThermalConductivity[n] lambdas
    "thermal conductivity of medium";
  Modelica.Units.SI.Density[n] rhos "density of medium";
  Modelica.Units.SI.DynamicViscosity[n] mus "dynamic viscosity of medium";
  Real[n] Scs "Schmidt number";
  Real[n] Res "Reynolds number";
  Real[n] Shs "Shwerwood number";
  Modelica.Units.SI.Area[n] croSecs "cross section of duct";
  Real[n] zSterns "dimensionless length";

protected
  constant Modelica.Units.SI.MolarMass M_air=28.96;
  constant Modelica.Units.SI.MolarMass M_steam=18.02;
  constant Real sigmaAir = 3.711 "distance of air molecules in Atom";
  constant Real sigmaSteam = 2.655 "distance of steam molecules in Atom";

  Real[n] omegas "collision integral";
  Modelica.Units.SI.DiffusionCoefficient[n] Ds
    "diffusion coefficient for water vapour into air";

equation

  rhos = Medium.density(states);
  mus = Medium.dynamicViscosity(states);
  lambdas = Medium.thermalConductivity(states);

  for i in 1:n loop
    croSecs[i] = heights[i]*(widths[i]/nWidth);
    aspRats[i] = heights[i]/widths[i];
    omegas[i] =Functions.CollisionIntegral(T=Medium.temperature(states[i]));
    Ds[i] =Functions.DiffusionCoefficient(
      M_1=M_air,
      M_2=M_steam,
      T=Medium.temperature(states[i]),
      p=1,
      sigma1=sigmaAir,
      sigma2=sigmaSteam,
      omega=omegas[i]);
    Scs[i] = mus[i]/(rhos[i]*Ds[i]);
    zSterns[i] = (sum(lengths)/sqrt(croSecs[i]))/max(0.001,Res[i]*Scs[i]);
    if recDuct then
      Res[i] =
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      rho=rhos[i],
      mu=mus[i],
      v=vs[i],
      D=sqrt(croSecs[i]));
      Shs[i]=Functions.SherwoodNumberMuzychka(
        Re=Res[i],
        Sc=Scs[i],
        aspRat=aspRats[i],
        zStern=zSterns[i],
        uniWalTem=uniWalTem,
        local=local,
        gamma=0.1);
      kCons[i] = (Shs[i]*rhos[i]*Ds[i])/sqrt(croSecs[i]);
    else
      Res[i] =
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
        rho=rhos[i],
        mu=mus[i],
        v=vs[i],
        D=2*heights[i]);
      Shs[i]=Functions.SherwoodNumberStephan(
        Re=Res[i],
        Sc=Scs[i],
        length=lengths[i],
        dimension=2*heights[i]);
      kCons[i] = (Shs[i]*rhos[i]*Ds[i])/(2*heights[i]);
    end if;
  end for;

  annotation (Documentation(info="<html><p>
  This model calculates the convective mass transfer coefficient
  <i>β</i> using the nusselt number correlation for rectangular air
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
  The diffusion coefficient of water vapour into air <i>D</i> is
  calculated using the function DiffusionCoefficient.
</p>
<h4>
  References
</h4>
<p>
  [1]: Muzychka, Y. S.; Yovanovich, M. M. : <i>Laminar Forced
  Convection Heat Transfer in the Combined Entry Region of Non-Circular
  Ducts</i> ; Transactions of the ASME; Vol. 126; February 2004
</p>
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PartialDuctMassTransfer;
