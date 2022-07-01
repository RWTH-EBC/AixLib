within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ModularConsumer_multiport
    extends AixLib.Fluid.Interfaces.PartialModularPort_a(
    redeclare package Medium = MediumWater,
    final m_flow_nominal=sum(m_flow_nominalCon),
    final dp_nominal = sum(dp_nominalCon),
    final nPorts=n_consumers);

  package MediumWater = AixLib.Media.Water;
  parameter Integer n_consumers=1 "Number of consumers";
  parameter Integer demandType[n_consumers]= fill(1, n_consumers) "Choose between heating and cooling functionality" annotation(Dialog(enable=true, group = "System"));
  parameter Boolean hasPump[n_consumers] =  fill(false, n_consumers) "circuit has Pump";
  parameter Boolean hasFeedback[n_consumers] =  fill(false, n_consumers) "circuit has Feedback";
  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true, group = "System"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCon[n_consumers] = fill(0.3, n_consumers) "Nominal mass flow rate";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_fixed[n_consumers] = fill(10000, n_consumers) "Prescribed heat flow";
  parameter Modelica.SIunits.PressureDifference dp_nominalCon[n_consumers] = fill(10, n_consumers)
    "Pressure drop at nominal conditions for the individual consumers"
     annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));

  HydraulicModules.SimpleConsumer simpleConsumer[n_consumers](
    redeclare each final package Medium = Medium,
    each functionality = functionality,
    demandType = demandType,
    hasPump = hasPump,
    m_flow_nominal = m_flow_nominalCon,
    dp_nominalPumpConsumer = dp_nominalCon,
    Q_flow_fixed = Q_flow_fixed)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput T_Flow[n_consumers]
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealInput T_Return[n_consumers]
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-90})));
  Modelica.Blocks.Interfaces.RealInput T[n_consumers] if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[n_consumers] if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-88,100})));

equation
  for i in 1:n_consumers loop
    connect(simpleConsumer[i].port_b, port_b) annotation (Line(points={{10,0},{56,
          0},{56,0},{100,0}}, color={0,127,255}));
  end for;
  connect(ports_a, simpleConsumer.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));

  connect(T_Flow, simpleConsumer.T_Flow) annotation (Line(points={{-106,-60},{
          -80,-60},{-80,-4},{-10.6,-4}},
                                   color={0,0,127}));
  connect(T_Return, simpleConsumer.T_Return) annotation (Line(points={{-106,-80},
          {-60,-80},{-60,-6},{-10.6,-6}},
                                        color={0,0,127}));
  connect(Q_flow, simpleConsumer.Q_flow) annotation (Line(points={{-60,120},{
          -60,80},{-6,80},{-6,10}}, color={0,0,127}));
  connect(T, simpleConsumer.T) annotation (Line(points={{60,120},{60,80},{6,80},
          {6,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{80,-240},{120,-255},{80,-270},{80,-240}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{115,-255},{0,-255}},
          color={0,128,255},
          visible=not allowFlowReversal),
        Polygon(
          points={{80,-294},{120,-309},{80,-324},{80,-294}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{115,-309},{0,-309}},
          color={0,128,255},
          visible=not allowFlowReversal),
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
          textString="CONSUMER"),
                   Ellipse(
          extent={{-72,64},{88,-96}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-52,44},{68,-76}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-48,2},{64,-34}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER")}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer_multiport;
