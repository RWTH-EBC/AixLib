within AixLib.Systems.EONERC_MainBuilding_old;
model HeatExchangerSystem
  "Heat exchanger between high and low temperature system"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  HydraulicModules_old.ThrottlePump throttlePump(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.03,
    d=0.1,
    length=5,
    Kv=63,
    redeclare
      HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per)),
    pipe4(length=15))
    annotation (Placement(transformation(extent={{-100,20},{-60,-20}})));
  Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=allowFlowReversal,
    allowFlowReversal2=allowFlowReversal,
    m1_flow_nominal=22.6,
    m2_flow_nominal=40.2,
    dp1_nominal=14000,
    dp2_nominal=48000,
    tau1=2,
    tau2=2,
    T1_start=T_start,
    T2_start=T_start,
    redeclare Fluid.MixingVolumes.MixingVolume vol1,
    redeclare Fluid.MixingVolumes.MixingVolume vol2,
    tau_C=10,
    dT_nom=50,
    Q_nom=256000)                          annotation (Placement(transformation(
        extent={{-21,22},{21,-22}},
        rotation=270,
        origin={-4,-1})));
  HydraulicModules_old.Admix admix(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.02,
    d=0.125,
    length=2,
    Kv=160,
    pipe2(length=5),
    pipe3(length=10),
    pipe4(length=15),
    redeclare
      HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per)))
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-150,10},{-130,30}}),
        iconTransformation(extent={{-150,10},{-130,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-150,-30},{-130,-10}}),
        iconTransformation(extent={{-150,-30},{-130,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{70,90},{90,110}}),
        iconTransformation(extent={{70,90},{90,110}})));
  Fluid.FixedResistances.PlugFlowPipe pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=0.125,
    dIns=0.01,
    kIns=0.03,
    final R=1/(pipe1.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe1.dh/2 +
        pipe1.dIns)/(pipe1.dh/2))),
    length=20,
    nPorts=1)                                  annotation (
      Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={120,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{110,90},{130,110}}),
        iconTransformation(extent={{110,90},{130,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{110,-110},{130,-90}}),
        iconTransformation(extent={{110,-108},{130,-88}})));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation (Dialog(tab="Initialization"));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={100,-28})));
  Modelica.Blocks.Sources.Constant const(k=admix.T_amb)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=270,
        origin={100,-52})));
  BaseClasses.TwoCircuitBus hxBus annotation (Placement(transformation(extent={
            {-32,86},{-6,114}}), iconTransformation(extent={{-22,90},{-2,110}})));
equation
  connect(throttlePump.port_b1, dynamicHX.port_a1) annotation (Line(points={{-60,-12},
          {-28,-12},{-28,20},{-17.2,20}},    color={0,127,255}));
  connect(throttlePump.port_a2, dynamicHX.port_b1) annotation (Line(points={{-60,12},
          {-30,12},{-30,-22},{-17.2,-22}},       color={0,127,255}));
  connect(admix.port_b2, dynamicHX.port_a2) annotation (Line(points={{40,-12},{20,
          -12},{20,-22},{9.2,-22}},  color={0,127,255}));
  connect(admix.port_a1, dynamicHX.port_b2) annotation (Line(points={{40,12},{20,
          12},{20,20},{9.2,20}},  color={0,127,255}));
  connect(admix.port_b1, port_b2) annotation (Line(points={{80,12},{80,100}},
                     color={0,127,255}));
  connect(pipe1.port_a, port_a3) annotation (Line(points={{120,10},{120,100}},
                         color={0,127,255}));
  connect(admix.port_a2, port_a2) annotation (Line(points={{80,-12},{80,-100}},
                                    color={0,127,255}));
  connect(port_b3, pipe1.ports_b[1]) annotation (Line(points={{120,-100},{120,-10}},
                      color={0,127,255}));
  connect(throttlePump.port_a1, port_a1) annotation (Line(points={{-100,-12},{
          -120,-12},{-120,-20},{-140,-20}}, color={0,127,255}));
  connect(throttlePump.port_b2, port_b1) annotation (Line(points={{-100,12},{
          -120,12},{-120,20},{-140,20}}, color={0,127,255}));
  connect(const.y,prescribedTemperature. T)
    annotation (Line(points={{100,-43.2},{100,-37.6}},
                                                     color={0,0,127}));
  connect(prescribedTemperature.port, pipe1.heatPort) annotation (Line(points={
          {100,-20},{100,0},{110,0},{110,1.77636e-15}}, color={191,0,0}));
  connect(throttlePump.hydraulicBus, hxBus.primBus) annotation (Line(
      points={{-80,-20},{-80,100},{-18.935,100},{-18.935,100.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admix.hydraulicBus, hxBus.secBus) annotation (Line(
      points={{60,20},{60,100.07},{-18.935,100.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {140,100}}), graphics={
        Rectangle(
          extent={{-140,100},{140,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,30},{20,-32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,-32},{20,30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-130,20},{-20,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-130,-20},{-20,-20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{120,90},{120,-88}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{80,90},{80,-90}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{80,20},{20,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{80,-20},{20,-20}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-8,4},{8,-4},{8,4},{-8,-4},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-60,20},
          rotation=180),
        Polygon(
          points={{76,-28},{84,-28},{80,-20},{76,-28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255}),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={80,-16},
          rotation=180),
        Ellipse(
          extent={{-68,-12},{-52,-28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={76,-20},
          rotation=270),
        Line(
          points={{-52,-20},{-60,-12}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-52,-20},{-60,-28}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-8,8},{8,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={80,-60},
          rotation=180),
        Line(
          points={{4,4},{-4,-4}},
          color={0,0,0},
          thickness=0.5,
          origin={76,-56},
          rotation=180),
        Line(
          points={{4,-4},{-4,4}},
          color={0,0,0},
          thickness=0.5,
          origin={84,-56},
          rotation=180),
        Rectangle(
          extent={{-20,30},{20,-32}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-60,-12},{-60,98}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{40,98},{40,-60},{70,-60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{82,-20},{92,-20},{92,52},{40,52}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-60,98},{40,98}},
          color={0,0,0},
          pattern=LinePattern.Dash)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,100}})));
end HeatExchangerSystem;
