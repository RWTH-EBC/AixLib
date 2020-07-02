within AixLib.Systems.HydraulicModules;
model SimpleConsumer "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import SI=Modelica.SIunits;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter SI.Length dPipe= 0.032 "Pipe diameter";
  parameter SI.Length len = 1.0 "Average total pipe length";
  parameter SI.Temperature T_fixed = 293.15
                                           "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter SI.HeatCapacity capacity=1 "Capacity of the material";
  parameter SI.Volume V=0.001 "Volume of water";
  parameter SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter SI.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  parameter SI.Temperature T_start=293.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true));

  Fluid.MixingVolumes.MixingVolume volume(
    final V=V,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    nPorts=2,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,10})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={28,34},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection if
    functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={10,54},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,70})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
     or functionality == "T_fixed"                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,54})));
  Fluid.FixedResistances.PlugFlowPipe pipe1(
    final allowFlowReversal=allowFlowReversal,
    final dh=dPipe,
    final v_nominal=1.5,
    final m_flow_nominal=m_flow_nominal,
    final T_start_in=T_start,
    final T_start_out=T_start,
    final length=len/2,
    final dIns=0.01,
    final kIns=0.028,
    nPorts=1,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,-10},
            {-40,10}})));
  Fluid.FixedResistances.PlugFlowPipe pipe2(
    allowFlowReversal=allowFlowReversal,
    final dh=dPipe,
    final v_nominal=1.5,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final length=len/2,
    final dIns=0.01,
    final kIns=0.028,
    redeclare package Medium = Medium,
    nPorts=1)                          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed) if
    functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,70})));
  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if
    functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,50})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q_flow_fixed) if
    functionality == "Q_flow_fixed"                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,80})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
equation
  connect(volume.heatPort,heatCapacitor. port) annotation (Line(points={{10,10},
          {10,34},{18,34}},               color={191,0,0},
      pattern=LinePattern.Dash));
  connect(heatCapacitor.port,convection. solid) annotation (Line(points={{18,34},
          {10,34},{10,44}},              color={191,0,0}));
  connect(convection.fluid,prescribedTemperature. port)
    annotation (Line(points={{10,64},{10,70},{32,70}},
                                                 color={191,0,0},
      pattern=LinePattern.Dash));
  connect(realExpression.y,convection. Gc)
    annotation (Line(points={{-19,54},{0,54}}, color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{79,70},{54,70}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pipe1.ports_b[1], volume.ports[1]) annotation (Line(points={{-40,0},{
          2,0}},                   color={0,127,255}));
  connect(volume.ports[2], pipe2.port_a) annotation (Line(points={{-2,0},{40,0}},
                          color={0,127,255}));
  connect(pipe1.port_a, port_a)
    annotation (Line(points={{-60,0},{-100,0}}, color={0,127,255}));
  connect(pipe2.ports_b[1], port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(prescribedTemperature.T, T)
    annotation (Line(points={{54,70},{60,70},{60,120}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.Q_flow, realExpression2.y)
    annotation (Line(points={{-60,60},{-60,80},{-79,80}},
                                                 color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.Q_flow, Q_flow)
    annotation (Line(points={{-60,60},{-60,120}},          color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{-60,40},{-60,34},{18,34}}, color={191,0,0},
      pattern=LinePattern.Dash));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                   Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-56,18},{56,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Model with a simple consumer. The consumed power depends either on
  the temperature (T_fixed or T_input) and the convective coefficient
  kA or the power is prescribed (Q_flow_input or _Q_flow_fixed). It is
  possible to choose between these options with the parameter
  \"functionality\".
</p>
<ul>
  <li>October 31, 2019, by Alexander Kümpel:<br/>
    Add more options
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>
    <i>2016-03-06 &#160;</i> by Peter Matthes:<br/>
    added documentation
  </li>
  <li>
    <i>2016-02-17 &#160;</i> by Rohit Lad:<br/>
    implemented simple consumers model
  </li>
</ul>
</html>"));
end SimpleConsumer;
