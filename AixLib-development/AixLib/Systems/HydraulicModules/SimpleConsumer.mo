within AixLib.Systems.HydraulicModules;
model SimpleConsumer "Simple Consumer"
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the component" annotation (choicesAllMatching=true);
  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]";
  parameter Modelica.SIunits.Length Pipe_diam=0.0125 "Pipe Diameter";
  parameter Modelica.SIunits.Length len = 1.0 "Average total pipe length";
  parameter Modelica.SIunits.Temperature T_amb = 303.15 "Ambient temperature for convection";
  parameter Modelica.SIunits.HeatCapacity capacity=1 "Capacity of the material";
  parameter Modelica.SIunits.Volume V=0.001 "Volume of water";
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Fluid.MixingVolumes.MixingVolume volume(
    V=V,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    nPorts=2,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,16})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={8,22},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        origin={34,32},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,32})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,76})));
  Fluid.FixedResistances.PlugFlowPipe pipe1(
    final allowFlowReversal=allowFlowReversal,
    dh=0.032,
    final v_nominal=1.5,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    length=1,
    dIns=0.01,
    kIns=0.028,
    nPorts=1,
    redeclare package Medium = Medium) annotation (Dialog(enable=true),
      Placement(transformation(extent={{-78,-10},{-58,10}})));
  Fluid.FixedResistances.PlugFlowPipe pipe2(
    nPorts=1,
    allowFlowReversal=allowFlowReversal,
    dh=0.032,
    final v_nominal=1.5,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    length=1,
    dIns=0.01,
    kIns=0.028,
    redeclare package Medium = Medium) annotation (Dialog(enable=true),
      Placement(transformation(extent={{38,-10},{58,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_amb)
                                                              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,76})));
equation
  connect(volume.heatPort,heatCapacitor. port) annotation (Line(points={{-10,16},
          {-10,32},{8,32}},               color={191,0,0}));
  connect(heatCapacitor.port,convection. solid) annotation (Line(points={{8,32},{
          24,32}},                       color={191,0,0}));
  connect(convection.fluid,prescribedTemperature. port)
    annotation (Line(points={{44,32},{54,32}},   color={191,0,0}));
  connect(realExpression.y,convection. Gc)
    annotation (Line(points={{34,65},{34,42}}, color={0,0,127}));
  connect(pipe1.port_a, port_a)
    annotation (Line(points={{-78,0},{-100,0}},   color={0,127,255}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{80,65},{80,32},{76,32}}, color={0,0,127}));
  connect(pipe2.ports_b[1], port_b)
    annotation (Line(points={{58,0},{100,0}}, color={0,127,255}));
  connect(pipe1.ports_b[1], volume.ports[1]) annotation (Line(points={{-58,0},{
          -40,0},{-40,6},{-18,6}}, color={0,127,255}));
  connect(volume.ports[2], pipe2.port_a) annotation (Line(points={{-22,6},{10,6},
          {10,0},{38,0}}, color={0,127,255}));
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
    Documentation(info="<html>
<p>Model with a simple consumer. The consumed power depends on the ambient temperature and the convective coefficient kA.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib</li>
<li><i>2016-03-06 &nbsp;</i> by Peter Matthes:<br/>added documentation</li>
<li><i>2016-02-17 &nbsp;</i> by Rohit Lad:<br/>implemented simple consumers model</li>
</ul>
</html>"));
end SimpleConsumer;
