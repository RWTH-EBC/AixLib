within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses;
model StratifiedAirVolume
  "Vertically stratified moist air volume for swimming halls with downward air distribution"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer nLay(min=1) = 2
    "Number of air layers (layer 1 is the lowest layer, layer nLay the top layer)";
  parameter Modelica.Units.SI.Area AFloor "Floor area of the hall";
  parameter Modelica.Units.SI.Length hLay[nLay]
    "Height of each air layer, from bottom to top";
  parameter Integer nPorts(min=0) = 0 "Number of external fluid ports";
  parameter Integer layPort[nPorts](each min=1) = fill(nLay, nPorts)
    "Layer each external fluid port is connected to (1: lowest layer)";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate through the layers, used for regularization";
  parameter Real kappaStab(unit="kg/(s.m2)", min=0) = 1e-3
    "Specific mass exchange between two layers if the stratification is stable (lighter air above heavier air). Uncalibrated placeholder"
    annotation (Dialog(group="Vertical exchange"));
  parameter Real kappaMix(unit="kg/(s.m2)", min=0) = 0.1
    "Specific mass exchange between two layers if the stratification is unstable (heavier air above lighter air)"
    annotation (Dialog(group="Vertical exchange"));
  parameter Modelica.Units.SI.Density dRhoSmooth(min=1e-9) = 1e-4
    "Density difference over which the exchange switches smoothly between kappaStab and kappaMix"
    annotation (Dialog(group="Vertical exchange"));

  Modelica.Fluid.Interfaces.FluidPorts_a ports[nPorts](redeclare each package
      Medium = Medium) "External fluid ports"
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[nLay]
    "Heat ports of the layers (sensible plus latent heat exchange)"
    annotation (Placement(transformation(extent={{90,-40},{110,40}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow[nLay](each final quantity="MassFlowRate",
      each final unit="kg/s") "Water mass flow rate added to each layer"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealOutput TLay[nLay](each final unit="K",
      each displayUnit="degC") "Air temperature of each layer"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput X_wLay[nLay](each final unit="kg/kg")
    "Water mass fraction of each layer"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol[nLay](
    redeclare each final package Medium = Medium,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final m_flow_nominal=m_flow_nominal,
    final V={AFloor*hLay[i] for i in 1:nLay},
    final nPorts={nPortsLay[i] for i in 1:nLay})
    "Mixing volumes of the air layers"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaExc[nLay]
    "Heat exchanged between neighbouring layers"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));

protected
  final parameter Integer nPortsExt[nLay]={sum({if layPort[j] == i then 1 else 0
      for j in 1:nPorts}) for i in 1:nLay}
    "Number of external ports per layer";
  final parameter Integer nPortsLay[nLay]={nPortsExt[i] + (if i > 1 then 1 else 0)
       + (if i < nLay then 1 else 0) for i in 1:nLay}
    "Number of ports of each layer volume (link to lower layer first, then external ports, link to upper layer last)";
  final parameter Integer idxPort[nPorts]={sum({if layPort[k] == layPort[j] then 1
       else 0 for k in 1:j}) + (if layPort[j] > 1 then 1 else 0) for j in 1:
      nPorts} "Index of each external port in its layer volume";

  Medium.ThermodynamicState state[nLay]
    "Thermodynamic state of each layer";
  Modelica.Units.SI.Density rho[nLay] "Density of each layer";
  Modelica.Units.SI.SpecificEnthalpy h[nLay]
    "Specific enthalpy of the moist air of each layer";
  Modelica.Units.SI.MassFraction Xw[nLay] "Water mass fraction of each layer";
  Modelica.Units.SI.MassFlowRate mExc[max(nLay - 1, 0)]
    "Exchange mass flow rate for each interface between layer k and k+1";
  Modelica.Units.SI.MassFlowRate mWatExc[nLay]
    "Water mass flow rate added to each layer by the vertical exchange";
  Modelica.Units.SI.HeatFlowRate QExc[nLay]
    "Heat flow rate added to each layer by the vertical exchange";

initial equation
  assert(abs(sum(hLay)) > 0, "Layer heights must be positive.");
  assert(Medium.nXi > 0,
    "StratifiedAirVolume requires a moist air medium (nXi > 0).");

equation
  // external ports
  for j in 1:nPorts loop
    connect(ports[j], vol[layPort[j]].ports[idxPort[j]]);
  end for;

  // links between layers: through-flow follows from the mass balance
  for k in 1:nLay - 1 loop
    connect(vol[k].ports[nPortsLay[k]], vol[k + 1].ports[1]);
  end for;

  // layer properties
  for i in 1:nLay loop
    Xw[i] = vol[i].Xi[1];
    state[i] = Medium.setState_pTX(
      p=vol[i].p,
      T=vol[i].T,
      X=vol[i].Xi);
    rho[i] = Medium.density(state[i]);
    h[i] = Medium.specificEnthalpy(state[i]);
    TLay[i] = vol[i].T;
    X_wLay[i] = Xw[i];
    connect(heatPort[i], vol[i].heatPort);
    connect(heaExc[i].port, vol[i].heatPort);
    heaExc[i].Q_flow = QExc[i];
    vol[i].mWat_flow = mWat_flow[i] + mWatExc[i];
  end for;

  // vertical exchange: layer k (lower) and k+1 (upper)
  // unstable if the upper layer is heavier than the lower layer
  for k in 1:nLay - 1 loop
    mExc[k] = AFloor*(kappaStab + (kappaMix - kappaStab)*0.5*(1 + Modelica.Math.tanh((
      rho[k + 1] - rho[k])/dRhoSmooth)));
  end for;

  for i in 1:nLay loop
    mWatExc[i] = (if i < nLay then mExc[min(i, max(nLay - 1, 1))]*(Xw[min(i + 1,
      nLay)] - Xw[i]) else 0) + (if i > 1 then mExc[max(i - 1, 1)]*(Xw[max(i - 1,
      1)] - Xw[i]) else 0);
    QExc[i] = (if i < nLay then mExc[min(i, max(nLay - 1, 1))]*(h[min(i + 1,
      nLay)] - h[i]) else 0) + (if i > 1 then mExc[max(i - 1, 1)]*(h[max(i - 1,
      1)] - h[i]) else 0);
  end for;

  annotation (
    defaultComponentName="stratAir",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,80},{80,40}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,40},{80,-20}},
          lineColor={0,0,0},
          fillColor={255,220,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-20},{80,-80}},
          lineColor={0,0,0},
          fillColor={170,210,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Vertically stratified moist air volume, intended for swimming halls with
downward air distribution (supply air at the top, extract air near the floor).
The hall is divided into <code>nLay</code> layers (layer 1 is the lowest, layer
<code>nLay</code> the top layer). Each layer is an ideally mixed
<a href=\"modelica://AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir\">
AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir</a>.
</p>
<h4>Vertical transport</h4>
<ul>
<li>
<b>Through-flow:</b> The layers are connected in series by fluid connections.
The mass flow rate between two layers results from the mass balance of the
external ports (<code>layPort</code> assigns each port to a layer). With supply
air in the top layer and extract air in the lowest layer, the supply air flows
downwards through all layers.
</li>
<li>
<b>Buoyancy-driven exchange:</b> Between two neighbouring layers an additional
exchange mass flow rate of <code>AFloor*kappa</code> is applied, with <code>kappa</code>
switching smoothly (width <code>dRhoSmooth</code>) from <code>kappaStab</code> (lighter
air above heavier air, stable) to <code>kappaMix</code> (heavier air above lighter
air, unstable). The density includes the influence of temperature and humidity.
Heat and moisture are exchanged accordingly.
</li>
<li>
<b>Induction</b> by supply air jets is neglected.
</li>
</ul>
<h4>Assumptions and limitations</h4>
<ul>
<li>Hydrostatic pressure differences between the layers are neglected.</li>
<li><code>kappaStab</code> is an uncalibrated placeholder. The literature
(Kaluza and Fiedler, 2020, 2021) does not give a value.</li>
<li>Radiative exchange between layers and surfaces is not modelled.</li>
<li>The vertical exchange is modelled for moist air with
<code>Medium.nXi &gt; 0</code> only. Water that is exchanged between layers
is assumed to carry no additional mass of dry air.</li>
</ul>
</html>", revisions="<html>
<ul>
<li>November 10, 2026, by Leander Waerder:<br/>
First implementation for issue
<a href=\"https://github.com/RWTH-EBC/AixLib/issues/1649\">#1649</a>.
</li>
</ul>
</html>"));
end StratifiedAirVolume;
