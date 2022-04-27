within AixLib.Systems.HydraulicModules;
model SimpleConsumer_3
  extends AixLib.Systems.HydraulicModules.SimpleConsumer_2(
      volume(nPorts=2));
  parameter Boolean hasFeedback = false "circuit has Feedback";

  Fluid.Actuators.Valves.TwoWayEqualPercentage val if hasFeedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-60})));
  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
               annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-10,-80})));
equation
  if hasFeedback then
    connect(val.port_a, senTReturn.port_b)
    annotation (Line(points={{10,-60},{90,-60},{90,0}}, color={0,127,255}));
    connect(val.port_b, senTFlow.port_a)
    annotation (Line(points={{-10,-60},{-90,-60},{-90,0}}, color={0,127,255}));
    connect(PIValve.y, val.y) annotation (Line(points={{-3.4,-80},{0,-80},{0,
            -72}},                   color={0,0,127}));
    connect(PIValve.u_m, gain.y) annotation (Line(points={{-10,-87.2},{-10,-90},
            {62,-90},{62,-24},{63.6,-24}},
                       color={0,0,127}));
    connect(TSet_Return.y, PIValve.u_s) annotation (Line(points={{-43,-28},{-42,
            -28},{-42,-80},{-17.2,-80}},color={0,0,127}));

  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_3;
