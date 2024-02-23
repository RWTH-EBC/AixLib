within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses;
model AirDuct "model of the air duct"
  extends Interfaces.PartialTwoPortInterface(
    redeclare package Medium = AixLib.Media.Air,
    port_a(h_outflow(start=h_outflow_start),p(start=p_a_start)),
    port_b(h_outflow(start=h_outflow_start),p(start=p_b_start)));

  extends AixLib.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true);

  // General
  parameter Integer nNodes = 2
    "number of discrete volumes (over length) in the air duct";
  parameter Integer nParallel = 2
    "number of parallel air ducts";
  parameter Integer nWidth(min=1) = 1
    "number of segments in width direction";

  // Geometry
  parameter Modelica.Units.SI.Length lengthDuct
    "length in flow direction of duct" annotation (Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Length widthDuct "width of duct"
    annotation (Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Length heightDuct "height of duct"
    annotation (Dialog(tab="Geometry"));
  parameter Boolean couFloArr=true
    "true: counter-flow arrangement; false: quasi-counter-flow arrangement"
     annotation(Dialog(tab="Geometry"));

  // Heat and Mass transfer
  parameter Boolean uniWalTem
    "true if uniform wall temperature, else uniform wall heat flux"
     annotation(Dialog(tab="Heat and Mass transfer"));
  parameter Boolean local
    "true if local Nusselt/Sherwood number, else average"
     annotation(Dialog(tab="Heat and Mass transfer"));
  parameter Boolean recDuct
    "true if rectangular duct is used for Nusselt/Sherwood number calculation, 
    else flat gap is used."
     annotation(Dialog(tab="Heat and Mass transfer"));

  // Advanced
  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  // Initialization
  parameter Medium.AbsolutePressure p_a_start=Medium.p_default
      "Start value of pressure at port a"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Start value of pressure at port b"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_start = Medium.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.Temperature T_start = Medium.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.MassFraction X_start[Medium.nX](
    final quantity=Medium.substanceNames) = Medium.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
    final quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  // Variables
  Modelica.Units.SI.Length[nNodes] lengths={i*(lengthDuct/((nNodes + 1)*nNodes/
      2)) for i in 1:nNodes} "length of segements in flow direction";
  Modelica.Units.SI.Area[nNodes] croSecs=fill(heightDuct*widthDuct, nNodes)
    "cross section of duct segments";
  Modelica.Units.SI.Velocity[nNodes] vs={port_a.m_flow/Medium.density(states[i])
      /croSecs[i] for i in 1:nNodes}/nParallel "velocity in air duct segments";
  Modelica.Units.SI.PartialPressure[nNodes] ps={vol[i].p*vol[i].X_w*(Ms[i]/
      M_steam) for i in 1:nNodes};
  Modelica.Units.SI.MolarMass[nNodes] Ms={1/(vol[i].X_w/M_steam + (1 - vol[i].X_w)
      /M_air) for i in 1:nNodes};

  Medium.ThermodynamicState[nNodes] states={Medium.setState_pTX(
    vol[i].p,
    vol[i].T,
    vol[i].Xi) for i in 1:nNodes};

  Modelica.Units.SI.SpecificEnthalpy dhAds=adsorptionEnthalpy.dhAds
    "adsorption enthalpy";

  // Inputs
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouSens if not couFloArr
    "coefficient for heat transfer reduction due to cross-flow portion";
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouLats if not couFloArr
    "coefficient for mass transfer reduction due to cross-flow portion";

  // Heat and mass transfer models
  model HeatTransfer = BaseClasses.HeatTransfer.LocalDuctConvectiveHeatFlow;

  model MassTransfer = BaseClasses.MassTransfer.LocalDuctConvectiveMassFlow;

  HeatTransfer heatTransfer(
    redeclare package Medium=Medium,
    n=nNodes,
    nWidth=nWidth,
    lengths=lengths,
    states=states,
    surfaceAreas={lengths[i] * widthDuct for i in 1:nNodes},
    vs=vs,
    heights=fill(heightDuct,nNodes),
    widths=fill(widthDuct,nNodes),
    nParallel=nParallel,
    uniWalTem=uniWalTem,
    local=local,
    recDuct=recDuct,
    coeCroCous=coeCroCouSenInts);

  MassTransfer massTransfer(
    redeclare package Medium=Medium,
    n=nNodes,
    nWidth=nWidth,
    lengths=lengths,
    states=states,
    surfaceAreas={lengths[i] * widthDuct for i in 1:nNodes},
    vs=vs,
    ps=ps,
    heights=fill(heightDuct,nNodes),
    widths=fill(widthDuct,nNodes),
    nParallel=nParallel,
    uniWalTem=uniWalTem,
    local=local,
    recDuct=recDuct,
    coeCroCous=coeCroCouLatInts);


  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol[nNodes](
    redeclare each final package Medium = Medium,
    each nPorts=2,
    each V=lengthDuct/nNodes*widthDuct*heightDuct,
    each final allowFlowReversal=allowFlowReversal,
    each final mSenFac=1,
    each final m_flow_nominal=m_flow_nominal,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final use_C_flow=false) "Volume for fluid stream"
    annotation (Placement(transformation(extent={{-9,0},{11,-20}})));

  AixLib.Fluid.FixedResistances.PressureDrop preDro(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearizeFlowResistance,
    final homotopyInitialization=homotopyInitialization,
    final dp_nominal=dp_nominal) "Flow resistance"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow[nNodes]
     annotation (Placement(transformation(extent={{-62,-40},{-42,-20}})));
  Utilities.MassTransfer.MassPort massPorts[nNodes]
    annotation (Placement(transformation(extent={{28,88},{52,112}}),
        iconTransformation(extent={{14,72},{68,126}})));
  Modelica.Blocks.Sources.RealExpression Q_flow[nNodes](y=heatTransfer.heatPorts.Q_flow
         - massTransfer.massPorts.m_flow*dhAds)
     annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,origin={-86,-60})));
  Modelica.Blocks.Sources.RealExpression mWat_flow[nNodes](
    y=massTransfer.massPorts.m_flow)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-22,-62})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
  parameter Medium.ThermodynamicState sta_start=Medium.setState_pTX(
      T=T_start, p=p_start, X=X_start);
  parameter Modelica.Units.SI.SpecificEnthalpy h_outflow_start=
      Medium.specificEnthalpy(sta_start) "Start value for outflowing enthalpy";
  constant Modelica.Units.SI.MolarMass M_steam=0.01802 "Molar mass of steam";
  constant Modelica.Units.SI.MolarMass M_air=0.028949 "Molar mass of dry air";

  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouSenInts
    "coefficient for heat transfer reduction due to cross-flow portion";
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouLatInts
    "coefficient for heat transfer reduction due to cross-flow portion";

  BaseClasses.HeatTransfer.AdsorptionEnthalpy
    adsorptionEnthalpy(
    F=5E-6,
    n=2,
    v_0=5.5E-5,
    T=senTem.T,
    phi=senRelHum.phi)
    annotation (Placement(transformation(extent={{-66,42},{-46,62}})));
  Sensors.TemperatureTwoPort senTem(
    redeclare final package Medium=Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Sensors.RelativeHumidityTwoPort senRelHum(
    redeclare final package Medium=Medium,
    final m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

equation
  if couFloArr then
    coeCroCouSenInts = fill(1,nNodes);
    coeCroCouLatInts = fill(1,nNodes);
  end if;
  connect(coeCroCouSens,coeCroCouSenInts);
  connect(coeCroCouLats,coeCroCouLatInts);

  connect(heatPorts, heatTransfer.heatPorts);
  connect(massPorts, massTransfer.massPorts);
  connect(port_a, preDro.port_a) annotation (Line(
      points={{-100,0},{-90,0},{-90,0},{-80,0},{-80,0},{-60,0}},
      color={0,127,255}));
  connect(preDro.port_b, vol[1].ports[1]) annotation (Line(
      points={{-40,0},{-1,0}},
      color={0,127,255}));

  for i in 1:nNodes-1 loop
    connect(vol[i].ports[2],vol[i+1].ports[1]);
  end for;
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{-42,-30},
          {-28,-30},{-28,-10},{-9,-10}}, color={191,0,0}));
  connect(Q_flow.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-86,-49},{-86,-30},{-62,-30}}, color={0,0,127}));
  connect(mWat_flow.y, vol.mWat_flow)
    annotation (Line(points={{-22,-51},{-22,-18},{-11,-18}}, color={0,0,127}));
  connect(vol[nNodes].ports[2], senTem.port_a)
    annotation (Line(points={{3,0},{30,0}},       color={0,127,255}));
  connect(senTem.port_b, senRelHum.port_a)
    annotation (Line(points={{50,0},{60,0}}, color={0,127,255}));
  connect(senRelHum.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,90},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,90},{-100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{100,90},{100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash)}), Documentation(info="<html><p>
  This model provides the definition of the air duct in a parallel
  membrane enthalpy exchanger. It is based on the <a href=
  \"AixLib.Fluid.Interfaces.PartialTwoPortInterface\">PartialTwoPortInterface</a>
  model.
</p>
<p>
  This model defines the geometry of the air duct, as well as the
  convective heat and mass transfer processes in the air duct. The
  model can be discretized in flow direction using finite volumes.
</p>
</html>", revisions="<html>
<ul>
  <li>November 23, 2018, by Martin Kremer:<br/>
    Changing adsorption enthalpy dhAds from parameter to input for
    usage of adsorption enthalpy model.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First Implementation
  </li>
</ul>
</html>"));
end AirDuct;
