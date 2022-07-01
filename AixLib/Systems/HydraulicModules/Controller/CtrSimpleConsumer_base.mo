within AixLib.Systems.HydraulicModules.Controller;
model CtrSimpleConsumer_base

  parameter Integer demandType   "Choose between heating and cooling functionality"
    annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true, group = "System"));
  parameter Boolean hasPump    "circuit has Pump"
    annotation (Dialog(group = "Pump"), choices(checkBox = true));
  parameter Boolean hasFeedback    "circuit has Feedback"
    annotation (Dialog(group = "Feedback"), choices(checkBox = true));
  parameter Real k_ControlConsumerPump(min=Modelica.Constants.small)=0.5 "Gain of controller"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerPump(min=Modelica.Constants.small)=10 "Time constant of Integrator block"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Real k_ControlConsumerValve(min=Modelica.Constants.small)=0.5 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerValve=10 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));

  Modelica.Blocks.Interfaces.RealInput T_Flow
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-86,40})));
  Modelica.Blocks.Interfaces.RealInput T_Return
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-86,20})));

  Modelica.Blocks.Interfaces.RealInput T_Flow_Mea
    annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=90,
        origin={-40,86})));
  Modelica.Blocks.Interfaces.RealInput T_Return_Mea
    annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=90,
        origin={0,86})));
  Modelica.Blocks.Math.Gain gain_Tf_Mea(k=demandType) if hasFeedback
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-40,60})));
  Modelica.Blocks.Math.Gain gain_Tr_Mea(k=demandType) if hasPump
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={0,58})));
  Modelica.Blocks.Math.Gain gain_Tf(k=demandType) if hasFeedback "Used to reverse direction of operation of controller"
    annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-58,40})));
  Modelica.Blocks.Math.Gain gain_Tr(k=demandType) if hasPump "Used to reverse direction of operation of controller"
    annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-58,20})));

  Modelica.Blocks.Interfaces.RealOutput y_val if hasFeedback
    annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=270,
        origin={-20,86})));
  Modelica.Blocks.Interfaces.RealOutput y_pump if hasPump
    annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=270,
        origin={20,86})));
  Modelica.Blocks.Continuous.LimPID PIPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=1) if hasPump
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={0,20})));

  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerValve,
    Ti=Ti_ControlConsumerValve,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-40,40})));

equation
  connect(T_Flow, gain_Tf.u)
    annotation (Line(points={{-86,40},{-62.8,40}},    color={0,0,127}));
  connect(T_Return, gain_Tr.u)
    annotation (Line(points={{-86,20},{-62.8,20}},    color={0,0,127}));
  connect(gain_Tr_Mea.u, T_Return_Mea)
    annotation (Line(points={{0,62.8},{0,86}},        color={0,0,127}));
  connect(gain_Tf_Mea.u, T_Flow_Mea)
    annotation (Line(points={{-40,64.8},{-40,86}},    color={0,0,127}));
  connect(gain_Tf.y, PIValve.u_s)
    annotation (Line(points={{-53.6,40},{-47.2,40}},   color={0,0,127}));
  connect(gain_Tf_Mea.y, PIValve.u_m)
    annotation (Line(points={{-40,55.6},{-40,47.2}},   color={0,0,127}));
  connect(gain_Tr.y, PIPump.u_s)
    annotation (Line(points={{-53.6,20},{-7.2,20}},    color={0,0,127}));
  connect(gain_Tr_Mea.y, PIPump.u_m) annotation (Line(points={{0,53.6},{0,27.2}},
                        color={0,0,127}));
  connect(PIValve.y, y_val) annotation (Line(points={{-33.4,40},{-20,40},{-20,86}},
        color={0,0,127}));
  connect(PIPump.y, y_pump) annotation (Line(points={{6.6,20},{20,20},{20,86}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
            {80,80}})),                                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}})));
end CtrSimpleConsumer_base;
