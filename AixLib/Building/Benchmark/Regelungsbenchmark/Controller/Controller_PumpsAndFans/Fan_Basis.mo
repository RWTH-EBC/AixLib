within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_PumpsAndFans;
model Fan_Basis
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Hot(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-116,-40},{-96,-20}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-28,-34},{-20,-26}})));
equation
  connect(realExpression.y, controlBus.Fan_RLT) annotation (Line(points={{-39,
          -72},{0.1,-72},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(realExpression1.y, PID_RLT_Canteen_Hot.u_s)
    annotation (Line(points={{-95,-30},{-62,-30}}, color={0,0,127}));
  connect(PID_RLT_Canteen_Hot.u_m, measureBus.Aircooler_out) annotation (Line(
        points={{-50,-42},{-50,-52},{-80,-52},{-80,60},{0.1,60},{0.1,100.1}},
        color={0,0,127}));
  connect(PID_RLT_Canteen_Hot.y, gain1.u)
    annotation (Line(points={{-39,-30},{-28.8,-30}}, color={0,0,127}));
  connect(gain1.y, controlBus.Fan_Aircooler) annotation (Line(points={{-19.6,
          -30},{-10,-30},{-10,-30},{0,-30},{0,-64},{0.1,-64},{0.1,-99.9}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Fan_Basis;
