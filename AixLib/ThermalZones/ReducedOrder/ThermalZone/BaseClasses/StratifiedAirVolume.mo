within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses;
model StratifiedAirVolume
  "Vertically stratified moist air volume for swimming halls with downward air distribution"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer nLay(min=1) = 2
    "Total number of air layers (layer 1 is the lowest layer, layer nLay the top layer)";
  parameter Boolean useExternalTop=false
    "If true, the top layer is not modelled here but by an external volume (e.g. the air volume of the RC model). It is connected via portsTop, TTop and X_wTop"
    annotation (Evaluate=true);
  parameter Modelica.Units.SI.Area AFloor "Floor area of the hall";
  parameter Modelica.Units.SI.Length hLay[nLay]
    "Height of each air layer, from bottom to top (including the external top layer)";
  parameter Integer nPorts(min=0) = 0 "Number of external fluid ports";
  parameter Integer layPort[nPorts](each min=1) = fill(nLay, nPorts)
    "Layer each external fluid port is connected to (1: lowest layer). Ports assigned to an external top layer are not connected inside this model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate through the layers, used for regularization";
  parameter Real kappaStab(unit="kg/(s.m2)", min=0) = 1e-3
    "Specific mass exchange between two layers if the stratification is stable (lighter air above heavier air). Uncalibrated placeholder"
    annotation (Dialog(group="Vertical exchange"));
  parameter Real kappaMix(unit="kg/(s.m2)", min=0) = 0.01
    "Specific mass exchange between two layers if the stratification is unstable (heavier air above lighter air). Uncalibrated placeholder, strongly influences the magnitude of the stratification"
    annotation (Dialog(group="Vertical exchange"));
  parameter Modelica.Units.SI.Density dRhoSmooth(min=1e-9) = 1e-4
    "Density difference over which the exchange switches smoothly between kappaStab and kappaMix"
    annotation (Dialog(group="Vertical exchange"));

  final parameter Integer nOwn=if useExternalTop then nLay - 1 else nLay
    "Number of layers modelled in this model";

  Modelica.Fluid.Interfaces.FluidPorts_a ports[nPorts](redeclare each package
      Medium = Medium) "External fluid ports"
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));
  Modelica.Fluid.Interfaces.FluidPorts_a portsTop[2](redeclare each package
      Medium = Medium) if useExternalTop
    "Ports to the external top layer: [1] direct connection (through-flow and return flow of the exchange), [2] outlet of the exchange flow towards the top layer"
    annotation (Placement(transformation(extent={{-110,60},{-90,100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[nOwn]
    "Heat ports of the layers (sensible plus latent heat exchange)"
    annotation (Placement(transformation(extent={{90,-40},{110,40}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow[nOwn](each final quantity="MassFlowRate",
      each final unit="kg/s") "Water mass flow rate added to each layer"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TTop(final unit="K", displayUnit="degC")
    if useExternalTop "Air temperature of the external top layer"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_wTop(final unit="kg/kg")
    if useExternalTop "Water mass fraction of the external top layer"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput TLay[nOwn](each final unit="K",
      each displayUnit="degC") "Air temperature of each layer"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput X_wLay[nOwn](each final unit="kg/kg")
    "Water mass fraction of each layer"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol[nOwn](
    redeclare each final package Medium = Medium,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final m_flow_nominal=m_flow_nominal,
    final V={AFloor*hLay[i] for i in 1:nOwn},
    final nPorts={nPortsLay[i] for i in 1:nOwn})
    "Mixing volumes of the air layers"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaExc[nOwn]
    "Heat exchanged between neighbouring layers"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));

  AixLib.Fluid.Movers.FlowControlled_m_flow movTop(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true) if useExternalTop
    "Exchange flow from the top own layer towards the external top layer. The return flow runs through the direct connection portsTop[1]"
    annotation (Placement(transformation(extent={{-40,60},{-60,80}})));

protected
  Modelica.Blocks.Routing.RealPassThrough TTopPas
    "Temperature of the external top layer (or default value)";
  Modelica.Blocks.Routing.RealPassThrough X_wTopPas
    "Water mass fraction of the external top layer (or default value)";
  Modelica.Blocks.Sources.Constant TTopDef(k=Medium.T_default)
    if not useExternalTop "Default temperature if there is no external top layer";
  Modelica.Blocks.Sources.Constant X_wTopDef(k=Medium.X_default[1])
    if not useExternalTop "Default water mass fraction if there is no external top layer";
  Modelica.Blocks.Sources.RealExpression mExcTopSig(y=mExcTop)
    if useExternalTop "Exchange mass flow rate to the external top layer";

  final parameter Integer nPortsExt[nOwn]={sum({if layPort[j] == i then 1 else 0
      for j in 1:nPorts}) for i in 1:nOwn} "Number of external ports per layer";
  final parameter Integer nPortsLay[nOwn]={nPortsExt[i] + (if i > 1 then 1 else 0)
       + (if i < nOwn then 1 else 0) + (if useExternalTop and i == nOwn then 2
       else 0) for i in 1:nOwn}
    "Number of ports of each layer volume (link to lower layer first, then external ports, then link to upper layer or the two ports to the external top layer)";
  final parameter Integer idxPort[nPorts]={sum({if layPort[k] == layPort[j] then 1
       else 0 for k in 1:j}) + (if layPort[j] > 1 then 1 else 0) for j in 1:
      nPorts} "Index of each external port in its layer volume";

  Medium.ThermodynamicState state[nOwn] "Thermodynamic state of each layer";
  Medium.ThermodynamicState stateTop
    "Thermodynamic state of the external top layer";
  Modelica.Units.SI.Density rho[nOwn] "Density of each layer";
  Modelica.Units.SI.Density rhoTop "Density of the external top layer";
  Modelica.Units.SI.SpecificEnthalpy h[nOwn]
    "Specific enthalpy of the moist air of each layer";
  Modelica.Units.SI.MassFraction Xw[nOwn] "Water mass fraction of each layer";
  Modelica.Units.SI.MassFlowRate mExc[max(nOwn - 1, 0)]
    "Exchange mass flow rate for each interface between layer k and k+1";
  Modelica.Units.SI.MassFlowRate mExcTop
    "Exchange mass flow rate between the top own layer and the external top layer";
  Modelica.Units.SI.MassFlowRate mWatExc[nOwn]
    "Water mass flow rate added to each layer by the vertical exchange";
  Modelica.Units.SI.HeatFlowRate QExc[nOwn]
    "Heat flow rate added to each layer by the vertical exchange";

initial equation
  assert(abs(sum(hLay)) > 0, "Layer heights must be positive.");
  assert(Medium.nXi > 0,
    "StratifiedAirVolume requires a moist air medium (nXi > 0).");
  assert(nOwn >= 1,
    "StratifiedAirVolume needs at least one layer of its own. With useExternalTop=true, nLay must be at least 2.");

equation
  // external ports
  for j in 1:nPorts loop
    if layPort[j] <= nOwn then
      connect(ports[j], vol[layPort[j]].ports[idxPort[j]]);
    end if;
  end for;

  // links between layers: through-flow follows from the mass balance
  for k in 1:nOwn - 1 loop
    connect(vol[k].ports[nPortsLay[k]], vol[k + 1].ports[1]);
  end for;

  // link to the external top layer
  // Conditional components may only be used in connect statements, hence
  // the pass-through blocks for the inputs of the external top layer.
  if useExternalTop then
    connect(vol[nOwn].ports[nPortsLay[nOwn] - 1], portsTop[1]);
    connect(vol[nOwn].ports[nPortsLay[nOwn]], movTop.port_a);
    connect(movTop.port_b, portsTop[2]);
    connect(mExcTopSig.y, movTop.m_flow_in);
    connect(TTop, TTopPas.u);
    connect(X_wTop, X_wTopPas.u);
  else
    connect(TTopDef.y, TTopPas.u);
    connect(X_wTopDef.y, X_wTopPas.u);
  end if;

  stateTop = Medium.setState_pTX(
    p=vol[nOwn].p,
    T=TTopPas.y,
    X={X_wTopPas.y});
  rhoTop = Medium.density(stateTop);
  mExcTop = if useExternalTop then AFloor*(kappaStab + (kappaMix - kappaStab)*0.5
    *(1 + Modelica.Math.tanh((rhoTop - rho[nOwn])/dRhoSmooth))) else 0;

  // layer properties
  for i in 1:nOwn loop
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
  for k in 1:nOwn - 1 loop
    mExc[k] = AFloor*(kappaStab + (kappaMix - kappaStab)*0.5*(1 + Modelica.Math.tanh((
      rho[k + 1] - rho[k])/dRhoSmooth)));
  end for;

  for i in 1:nOwn loop
    mWatExc[i] = (if i < nOwn then mExc[min(i, max(nOwn - 1, 1))]*(Xw[min(i + 1,
      nOwn)] - Xw[i]) else 0) + (if i > 1 then mExc[max(i - 1, 1)]*(Xw[max(i - 1,
      1)] - Xw[i]) else 0);
    QExc[i] = (if i < nOwn then mExc[min(i, max(nOwn - 1, 1))]*(h[min(i + 1,
      nOwn)] - h[i]) else 0) + (if i > 1 then mExc[max(i - 1, 1)]*(h[max(i - 1,
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
<h4>External top layer</h4>
<p>
With <code>useExternalTop=true</code> the top layer is not modelled here but by an
external volume, for example the air volume of the RC model of a thermal zone. The
top own layer is connected to it by the direct connection <code>portsTop[1]</code>
(through-flow and return flow) and by an exchange flow driven by a mover
(<code>portsTop[2]</code>), which transports heat and moisture with the air.
The inputs <code>TTop</code> and <code>X_wTop</code> are needed for the density of the
external layer. Ports with <code>layPort</code> equal to <code>nLay</code> are then not
connected inside this model and must be connected to the external volume.
</p>
<h4>Assumptions and limitations</h4>
<ul>
<li>Hydrostatic pressure differences between the layers are neglected.</li>
<li><code>kappaStab</code> and <code>kappaMix</code> are uncalibrated placeholders. The
literature (Kaluza and Fiedler, 2020, 2021) does not give values. Sensitivity runs with
the swimming hall example show that <code>kappaStab</code> has practically no influence
there, while <code>kappaMix</code> governs the magnitude of the stratification: the
differences between the layers scale roughly with <code>1/kappaMix</code> if the
stratification is close to neutral.</li>
<li>Radiative exchange between layers and surfaces is not modelled.</li>
<li>The vertical exchange between the own layers is modelled for moist air with
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
