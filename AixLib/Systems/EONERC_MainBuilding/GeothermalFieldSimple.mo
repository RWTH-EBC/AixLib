within AixLib.Systems.EONERC_MainBuilding;
model GeothermalFieldSimple "Geothermal probe"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Temperature T_start = 285.15
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization"));




  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=
        T_ground)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={94,-290})));

  HydraulicModules.Throttle throttle(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    allowFlowReversal=allowFlowReversal,
    final T_amb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.028,
    d=0.125,
    length=5,
    final Kv=160,
    pipe3(length=10))                annotation (Placement(transformation(
        extent={{-30,30},{30,-30}},
        rotation=270,
        origin={2,-50})));
  HydraulicModules.Pump pump(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    allowFlowReversal=allowFlowReversal,
    final T_amb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.028,
    kIns=0.01,
    d=0.125,
    length=40,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per(
            motorCooledByFluid=false), addPowerToMedium=false)),
    pipe3(length=80)) annotation (Placement(transformation(
        extent={{-40,40},{40,-40}},
        rotation=90,
        origin={0,-200})));
  Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=allowFlowReversal,
    allowFlowReversal2=allowFlowReversal,
    m1_flow_nominal=12,
    m2_flow_nominal=10,
    dp1_nominal=14000,
    dp2_nominal=48000,
    tau1=2,
    tau2=2,
    energyDynamics=energyDynamics,
    T1_start=T_start,
    T2_start=T_start,
    redeclare Fluid.MixingVolumes.MixingVolume vol1,
    redeclare Fluid.MixingVolumes.MixingVolume vol2,
    tau_C=10,
    dT_nom=4,
    Q_nom=300000)                          annotation (Placement(transformation(
        extent={{21,22},{-21,-22}},
        rotation=0,
        origin={0,-117})));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation (Dialog(tab = "Dynamics"));
  parameter Modelica.SIunits.Temperature T_amb "Ambient temperature";
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final V=V,
    nPorts=2) annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=180,
        origin={5,-287})));
  parameter Modelica.SIunits.Volume V=15000 "Volume";
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(final G=G)
           annotation (Placement(transformation(extent={{44,-300},{64,-280}})));
  parameter Modelica.SIunits.ThermalConductance G
    "Constant thermal conductance of material";
  HydraulicModules.BaseClasses.HydraulicBus busThrottle "Bus on secondary side"
    annotation (Placement(transformation(extent={{-128,-110},{-108,-90}}),
        iconTransformation(extent={{-136,-64},{-102,-24}})));
  HydraulicModules.BaseClasses.HydraulicBus busPump
    annotation (Placement(transformation(extent={{-128,-152},{-108,-132}}),
        iconTransformation(extent={{-136,-142},{-102,-98}})));
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,-262})));
  parameter Modelica.SIunits.Temperature T_ground=285.15
    "Fixed temperature of ground far away";
equation

  connect(dynamicHX.port_b1, pump.port_a2) annotation (Line(points={{-21,-130.2},
          {-22,-130.2},{-22,-130},{-24,-130},{-24,-160}},
                                                  color={0,127,255}));
  connect(pump.port_b1, dynamicHX.port_a1) annotation (Line(points={{24,-160},{22.2,
          -160},{22.2,-130.2},{21,-130.2}},      color={0,127,255}));
  connect(thermalConductor.port_b, fixedTemperature.port)
    annotation (Line(points={{64,-290},{84,-290}},           color={191,0,0}));
  connect(thermalConductor.port_a, vol.heatPort) annotation (Line(points={{44,-290},
          {32,-290},{32,-287},{18,-287}}, color={191,0,0}));
  connect(throttle.hydraulicBus, busThrottle) annotation (Line(
      points={{-28,-50},{-116,-50},{-116,-100},{-118,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pump.hydraulicBus, busPump) annotation (Line(
      points={{40,-200},{-118,-200},{-118,-142}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(pump.port_b2, vol.ports[1]) annotation (Line(points={{-24,-240},{-24,-274},
          {7.6,-274}}, color={0,127,255}));
  connect(pump.port_a1, vol.ports[2]) annotation (Line(points={{24,-240},{24,-266},
          {2.4,-266},{2.4,-274}}, color={0,127,255}));
  connect(boundary.ports[1], pump.port_b2) annotation (Line(points={{-50,-262},{
          -44,-262},{-44,-260},{-24,-260},{-24,-240}}, color={0,127,255}));
  connect(port_a, throttle.port_a1)
    annotation (Line(points={{-100,0},{-16,0},{-16,-20}}, color={0,127,255}));
  connect(throttle.port_b2, port_b)
    annotation (Line(points={{20,-20},{20,0},{100,0}}, color={0,127,255}));
  connect(throttle.port_b1, dynamicHX.port_a2) annotation (Line(points={{-16,
          -80},{-20,-80},{-20,-103.8},{-21,-103.8}}, color={0,127,255}));
  connect(throttle.port_a2, dynamicHX.port_b2) annotation (Line(points={{20,-80},
          {20,-92},{20,-103.8},{21,-103.8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-320},
            {120,0}}),                                          graphics={
        Rectangle(
          extent={{-120,2},{120,-328}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,-156},{70,-316}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,-288},{62,-296}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,-178},{62,-182}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,-230},{62,-236}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,-156},{-62,-316}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{62,-156},{72,-316}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{56,-144},{48,-324}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{50,-144},{48,-22},{100,-22},{100,-8}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-54,-324},{-46,-144}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,-316},{54,-324}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-21,20},{21,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={49,-118},
          rotation=180),
        Line(
          points={{4,-4},{-16,16}},
          color={0,0,0},
          thickness=0.5,
          origin={54,-102},
          rotation=180),
        Line(
          points={{18,16},{-4,-4}},
          color={0,0,0},
          thickness=0.5,
          origin={46,-102},
          rotation=180),
        Line(
          points={{-100,-6},{-100,-20},{-52,-20},{-52,-144}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-8,4},{12,-8},{12,4},{-8,-8},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-50,-36},
          rotation=270),
        Rectangle(
          extent={{-17,58},{17,-58}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={0,-73},
          rotation=90),
        Line(
          points={{-19,-30},{15,86}},
          color={0,0,0},
          thickness=0.5,
          origin={28,-71},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-320},{120,0}})));
end GeothermalFieldSimple;
