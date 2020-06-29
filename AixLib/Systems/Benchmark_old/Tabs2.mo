within AixLib.Systems.Benchmark_old;
model Tabs2 "Concrete core activation"
  import SI=Modelica.SIunits;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Initial or guess value of output (= state)";

    parameter SI.Area area "Area of activated concrete";
    parameter SI.Length thickness "Thickness of aactivated concrete";
    parameter SI.SpecificHeatCapacity cp = 0.278 "Specific heat capacity of concrete";
    parameter SI.Density rho = 2100 "Density of activated concrete";
    parameter Real alpha = 10 "Heat transfer coefficient concrete to air";

  parameter Modelica.SIunits.Length length=100 "Pipe length";
  parameter Modelica.SIunits.Length dh=0.032
    "Hydraulic diameter (assuming a round cross section area)";
  parameter Real R=0.002
    "Thermal resistance per unit length from fluid to boundary temperature";

  Fluid.FixedResistances.PlugFlowPipe pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=dh,
    dIns=0.001,
    kIns=0.05,
    length=length,
    R=R,
    nPorts=1)
             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,52})));

  HydraulicModules_old.Pump pump(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.02,
    d=0.032,
    length=1,
    redeclare
      HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per)))
    annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={-2,16})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{70,-108},{90,-88}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}}),
        iconTransformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-108},{50,-88}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=rho*
        area*thickness*cp,                                                  T(
        start=T_start, fixed=true)) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={28,66})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,120},{10,140}})));

  BaseClasses.TabsBus2 tabsBus annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}), iconTransformation(extent={{-116,-14},{-86,16}})));

  Modelica.Blocks.Sources.Constant const(k=area*alpha)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));

  Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=1000,
    dp2_nominal=1000,
    tau1=10,
    tau2=10,
    tau_C=2,
    dT_nom=1,
    Q_nom=20000)
    annotation (Placement(transformation(extent={{14,-38},{-6,-18}})));
  Fluid.HeatExchangers.DynamicHX dynamicHX1(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=1000,
    dp2_nominal=1000,
    tau1=10,
    tau2=10,
    tau_C=2,
    dT_nom=1,
    Q_nom=20000)
    annotation (Placement(transformation(extent={{-14,-38},{-34,-18}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-60,-28},{-48,-16}})));
  HydraulicModules_old.ThrottlePump throttlePumpHot(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.02,
    d=0.032,
    length=1,
    Kv=10,
    redeclare
      HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per))) annotation (
      Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-25,-59})));
  HydraulicModules_old.ThrottlePump throttlePumpCold(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.02,
    d=0.032,
    length=1,
    Kv=10,
    redeclare
      HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per))) annotation (
      Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={15,-61})));
equation

  connect(pump.port_b1, pipe.port_a) annotation (Line(points={{-16.4,40},{-16.4,
          52},{-10,52}}, color={0,127,255}));
  connect(pipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{8.88178e-16,62},{0,62},{0,66},{20,66}},
                                                     color={191,0,0}));
  connect(heatCapacitor.port, convection.solid) annotation (Line(points={{20,66},
          {0,66},{0,70},{-6.66134e-16,70}}, color={191,0,0}));
  connect(convection.fluid, heatPort)
    annotation (Line(points={{0,90},{0,100}}, color={191,0,0}));
  connect(convection.Gc, const.y)
    annotation (Line(points={{-10,80},{-19,80}}, color={0,0,127}));
  connect(pipe.ports_b[1], pump.port_a2)
    annotation (Line(points={{10,52},{12.4,52},{12.4,40}}, color={0,127,255}));
  connect(dynamicHX1.port_a1, dynamicHX.port_b1)
    annotation (Line(points={{-14,-22},{-6,-22}}, color={0,127,255}));
  connect(dynamicHX.port_a1, pump.port_b2) annotation (Line(points={{14,-22},{
          12.4,-22},{12.4,-8}}, color={0,127,255}));
  connect(dynamicHX1.port_b1, pump.port_a1) annotation (Line(points={{-34,-22},
          {-34,-8},{-16.4,-8}}, color={0,127,255}));
  connect(bou.ports[1], dynamicHX1.port_b1)
    annotation (Line(points={{-48,-22},{-34,-22}}, color={0,127,255}));
  connect(throttlePumpHot.port_b1, dynamicHX1.port_a2)
    annotation (Line(points={{-34,-44},{-34,-34}}, color={0,127,255}));
  connect(throttlePumpHot.port_a2, dynamicHX1.port_b2) annotation (Line(points=
          {{-16,-44},{-16,-34},{-14,-34}}, color={0,127,255}));
  connect(throttlePumpCold.port_b1, dynamicHX.port_a2) annotation (Line(points=
          {{6,-46},{6,-42},{-6,-42},{-6,-34}}, color={0,127,255}));
  connect(throttlePumpCold.port_a2, dynamicHX.port_b2) annotation (Line(points=
          {{24,-46},{26,-46},{26,-34},{14,-34}}, color={0,127,255}));
  connect(throttlePumpHot.port_a1, port_a1) annotation (Line(points={{-34,-74},
          {-76,-74},{-76,-100},{-80,-100}}, color={0,127,255}));
  connect(throttlePumpHot.port_b2, port_b2) annotation (Line(points={{-16,-74},
          {-16,-100},{40,-100}}, color={0,127,255}));
  connect(port_a2, port_a2) annotation (Line(points={{-40,-100},{-40,-100},{-40,
          -100}}, color={0,127,255}));
  connect(port_a2, throttlePumpCold.port_a1) annotation (Line(points={{-40,-100},
          {-40,-94},{6,-94},{6,-76}}, color={0,127,255}));
  connect(throttlePumpCold.port_b2, port_b1)
    annotation (Line(points={{24,-76},{80,-76},{80,-100}}, color={0,127,255}));
  connect(pump.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{-26,16},{-99.9,16},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttlePumpHot.hydraulicBus, tabsBus.hotThrottleBus) annotation (
      Line(
      points={{-40,-59},{-68,-59},{-68,-60},{-99.9,-60},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttlePumpCold.hydraulicBus, tabsBus.coldThrottleBus) annotation (
      Line(
      points={{0,-61},{-99.9,-61},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
    annotation (Dialog(tab="Initialization"),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,120}}),                                        graphics={
        Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-68,98},{68,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,98},{68,94}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,46},{68,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,98},{-68,40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{68,98},{76,40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-44,-68},{-36,-68},{-40,-60},{-44,-68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={-44,-60},
          rotation=270),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          origin={-40,-56},
          rotation=180),
        Line(
          points={{-40,-90},{-40,-68}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,-90},{-80,-60},{-50,-60},{-48,-60}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{-40,-52},{-40,70},{40,70},{40,-90}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-60},{80,-60},{80,-88}},
          color={244,125,35},
          thickness=0.5),
        Ellipse(
          extent={{-8,8},{8,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-40,12},
          rotation=180),
        Line(
          points={{4,-4},{-4,4}},
          color={0,0,0},
          thickness=0.5,
          origin={-36,16},
          rotation=180),
        Line(
          points={{4,4},{-4,-4}},
          color={0,0,0},
          thickness=0.5,
          origin={-44,16},
          rotation=180),
        Polygon(
          points={{-44,-28},{-36,-28},{-40,-20},{-44,-28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={-36,-20},
          rotation=90),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          origin={-40,-16},
          rotation=180),
        Line(
          points={{-32,-20},{40,-20}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-40,74},{40,70}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,100}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points={{-38,108}},
          color={238,46,47},
          arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-52,114},{-52,100}}, color={238,46,47}),
        Line(points={{-56,110},{-52,114},{-48,110}}, color={238,46,47}),
        Line(points={{-4,110},{0,114},{4,110}}, color={238,46,47}),
        Line(points={{0,114},{0,100}}, color={238,46,47}),
        Line(points={{50,110},{54,114},{58,110}}, color={238,46,47}),
        Line(points={{54,114},{54,100}}, color={238,46,47})}),   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Tabs2;
