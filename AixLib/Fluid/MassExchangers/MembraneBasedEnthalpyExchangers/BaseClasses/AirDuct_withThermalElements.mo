within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses;
model AirDuct_withThermalElements "model of the air duct"
  extends Interfaces.PartialTwoPortInterface(
    redeclare final package Medium = AixLib.Media.Air,
    port_a(h_outflow(start=h_outflow_start)),
    port_b(h_outflow(start=h_outflow_start)));

  extends AixLib.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true);

  parameter Modelica.SIunits.Time tau = 30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
     annotation (Dialog(tab = "Dynamics", group="Nominal condition"));
  parameter Integer nNodes = 2
    "number of discrete volumes (over length) in the air duct";
  parameter Integer nParallel = 2
    "number of parallel air ducts";

  // Advanced
  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  // Initialization
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

  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol[nNodes](
    redeclare each final package Medium = Medium,
    each nPorts=2,
    each V=m_flow_nominal*tau/rho_default,
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

  Modelica.Thermal.HeatTransfer.Components.Convection heaCon[nNodes]
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,52})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[
    nNodes] annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
  Utilities.MassTransfer.Convection masCon[nNodes] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={34,54})));
  Utilities.MassTransfer.MassPort massPorts[nNodes]
    annotation (Placement(transformation(extent={{28,88},{52,112}}),
        iconTransformation(extent={{14,72},{68,126}})));
  Utilities.MassTransfer.PrescribedMassFraction prescribedMassFraction[nNodes]
    annotation (Placement(transformation(extent={{82,12},{62,32}})));
  Utilities.MassTransfer.MassFlowSensor massFlowSensor[nNodes] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,22})));
  Modelica.Blocks.Sources.RealExpression massTransfer[nNodes](each y=200)
    annotation (Placement(transformation(extent={{-2,44},{18,64}})));
  Modelica.Blocks.Sources.RealExpression heatTransfer[nNodes](each y=200)
    annotation (Placement(transformation(extent={{-82,42},{-62,62}})));
  Modelica.Blocks.Sources.RealExpression adsorptionHeat[nNodes](each y=200)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,-60})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
  parameter Medium.ThermodynamicState sta_start=Medium.setState_pTX(
      T=T_start, p=p_start, X=X_start);
  parameter Modelica.SIunits.SpecificEnthalpy h_outflow_start = Medium.specificEnthalpy(sta_start)
    "Start value for outflowing enthalpy";

initial algorithm
  assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
          tau > Modelica.Constants.eps,
"The parameter tau, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau = " + String(tau) + "\n");
  assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
          tau > Modelica.Constants.eps,
"The parameter tau, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau = " + String(tau) + "\n");

equation
  connect(vol[nNodes].ports[2], port_b) annotation (Line(
      points={{3,0},{100,0}},
      color={0,127,255}));
  connect(port_a, preDro.port_a) annotation (Line(
      points={{-100,0},{-90,0},{-90,0},{-80,0},{-80,0},{-60,0}},
      color={0,127,255}));
  connect(preDro.port_b, vol[1].ports[1]) annotation (Line(
      points={{-40,0},{-1,0}},
      color={0,127,255}));

  for i in 1:nNodes-1 loop
    connect(vol[i].ports[2],vol[i+1].ports[1]);
  end for;
  connect(heaCon.fluid, vol.heatPort)
    annotation (Line(points={{-40,42},{-40,16},{-28,16},{-28,-10},{-9,-10}},
                                                            color={191,0,0}));
  connect(heaCon.solid, heatPorts)
    annotation (Line(points={{-40,62},{-40,100}},   color={191,0,0}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{-52,-30},
          {-28,-30},{-28,-10},{-9,-10}}, color={191,0,0}));
  connect(massPorts, masCon.solid)
    annotation (Line(points={{40,100},{40,74},{34,74},{34,64}},
                                                  color={0,140,72}));
  connect(vol.X_w, prescribedMassFraction.X) annotation (Line(points={{13,-6},{
          90,-6},{90,22},{84,22}},color={0,0,127}));
  connect(prescribedMassFraction.port, massFlowSensor.port_a) annotation (Line(
        points={{62.1,22.1},{55.9,22.1},{55.9,21.9}},    color={0,140,72}));
  connect(masCon.fluid, massFlowSensor.port_b)
    annotation (Line(points={{34,44},{34,22},{36,22}},
                                                 color={0,140,72}));
  connect(massFlowSensor.m_flow, vol.mWat_flow) annotation (Line(points={{46,32},
          {46,34},{-16,34},{-16,-18},{-11,-18}},
                                          color={0,0,127}));
  connect(massTransfer.y, masCon.Gc)
    annotation (Line(points={{19,54},{24,54}},  color={0,0,127}));
  connect(heatTransfer.y, heaCon.Gc)
    annotation (Line(points={{-61,52},{-50,52}},   color={0,0,127}));
  connect(adsorptionHeat.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-92,-49},
          {-92,-30},{-72,-30}},                                         color={0,
          0,127}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,90},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,90},{-100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{100,90},{100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash)}));
end AirDuct_withThermalElements;
