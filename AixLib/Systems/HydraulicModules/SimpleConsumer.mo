within AixLib.Systems.HydraulicModules;
model SimpleConsumer "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import SI=Modelica.SIunits;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
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
    redeclare package Medium = Medium,
    nPorts=2)                          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,10})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={44,40},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection if
    functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,80})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
     or functionality == "T_fixed"                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,78})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed) if
    functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,80})));
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
        origin={-62,58})));
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
          {10,40},{34,40}},               color={191,0,0},
      pattern=LinePattern.Dash));
  connect(heatCapacitor.port,convection. solid) annotation (Line(points={{34,40},
          {10,40},{10,60}},              color={191,0,0}));
  connect(convection.fluid,prescribedTemperature. port)
    annotation (Line(points={{10,80},{30,80}},   color={191,0,0},
      pattern=LinePattern.Dash));
  connect(realExpression.y,convection. Gc)
    annotation (Line(points={{-19,78},{-10,78},{-10,70},{0,70}},
                                               color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{79,80},{52,80}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedTemperature.T, T)
    annotation (Line(points={{52,80},{60,80},{60,120}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.Q_flow, realExpression2.y)
    annotation (Line(points={{-62,68},{-62,80},{-79,80}},
                                                 color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.Q_flow, Q_flow)
    annotation (Line(points={{-62,68},{-62,94},{-60,94},{-60,120}},
                                                           color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{-62,48},{-62,40},{34,40}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(port_a, volume.ports[1])
    annotation (Line(points={{-100,0},{2,0}}, color={0,127,255}));
  connect(volume.ports[2], port_b)
    annotation (Line(points={{-2,0},{100,0}}, color={0,127,255}));
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
</html>", revisions="<html>
<ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    Remove pipes
  </li>
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
