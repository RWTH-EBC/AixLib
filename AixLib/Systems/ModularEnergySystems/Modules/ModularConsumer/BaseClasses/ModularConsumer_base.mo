within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.BaseClasses;
partial model ModularConsumer_base

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
    redeclare each final package Medium = MediumWater,
    each functionality=functionality,
    demandType=demandType,
    hasPump=hasPump,
    hasFeedback=hasFeedback,
    m_flow_nominal=m_flow_nominalCon,
    dp_nominalPumpConsumer=dp_nominalCon,
    Q_flow_fixed=Q_flow_fixed)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
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

equation
  connect(Q_flow,simpleConsumer. Q_flow) annotation (Line(points={{-60,120},{-60,
          80},{-6,80},{-6,10}},     color={0,0,127}));
  connect(T,simpleConsumer. T) annotation (Line(points={{60,120},{60,80},{6,80},
          {6,10}}, color={0,0,127}));
  connect(T_Flow,simpleConsumer. T_Flow) annotation (Line(points={{-106,-60},{-80,
          -60},{-80,-4},{-10.6,-4}},
                                   color={0,0,127}));
  connect(T_Return,simpleConsumer. T_Return) annotation (Line(points={{-106,-80},
          {-78,-80},{-78,-6},{-10.6,-6}},
                                        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer_base;
