within AixLib.Systems.HydraulicModules;
model SimpleConsumer_wPump_wFeedback
  extends AixLib.Systems.HydraulicModules.SimpleConsumer_wPump(
      volume(nPorts=2));
  parameter Boolean hasFeedback = false "circuit has Feedback" annotation (Dialog(group = "Feedback"), choices(checkBox = true));

  parameter Real k_ControlConsumerValve(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerValve(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal = 0 "Nominal additional pressure drop e.g. for distributor" annotation (Dialog(enable = hasFeedback, group="Feedback"));

  Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    from_dp=false,
    dpValve_nominal=dp_Valve,
    dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-60})));
  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerValve,
    Ti=Ti_ControlConsumerValve,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
               annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-20,-80})));
  Modelica.Blocks.Math.Gain gain2(k=-1) if hasFeedback
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={60,-72})));
  Modelica.Blocks.Math.Gain gain3(k=-1) if hasFeedback
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-40,-72})));
equation
  if hasFeedback then
    connect(val.port_a, senTReturn.port_b)
    annotation (Line(points={{12,-60},{90,-60},{90,0}}, color={0,127,255}));
    connect(PIValve.y, val.y) annotation (Line(points={{-13.4,-80},{2,-80},{2,-72}},
                                     color={0,0,127}));
    connect(val.port_b, senTFlow.port_a)
      annotation (Line(points={{-8,-60},{-90,-60},{-90,0}}, color={0,127,255}));
    connect(PIValve.u_m, gain2.y) annotation (Line(points={{-20,-87.2},{-20,-90},{
            60,-90},{60,-76.4}}, color={0,0,127}));
    connect(gain2.u, gain.y) annotation (Line(points={{60,-67.2},{60,-24},{63.6,-24}},
          color={0,0,127}));
    connect(TSet_Return.y, gain3.u) annotation (Line(points={{-43,-28},{-40,-28},{
            -40,-67.2}}, color={0,0,127}));
    connect(gain3.y, PIValve.u_s) annotation (Line(points={{-40,-76.4},{-40,-80},{
            -27.2,-80}}, color={0,0,127}));
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_wPump_wFeedback;
