within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_PumpsAndFans;
model Fan_Basis
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=273.15 +
        40) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{-60,-56},{-40,-36}})));
equation
  connect(realExpression.y, controlBus.Fan_RLT) annotation (Line(points={{-39,
          -72},{0.1,-72},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-39,0},{-22,0}}, color={255,0,255}));
  connect(switch1.u1, realExpression.y) annotation (Line(points={{-22,8},{-34,8},
          {-34,-72},{-39,-72}}, color={0,0,127}));
  connect(switch1.u3, realExpression1.y) annotation (Line(points={{-22,-8},{-28,
          -8},{-28,-46},{-39,-46}}, color={0,0,127}));
  connect(switch1.y, controlBus.Fan_Aircooler) annotation (Line(points={{1,0},{
          20,0},{20,-58},{0.1,-58},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.u, measureBus.WarmWater_TTop) annotation (Line(
        points={{-62,0},{-80,0},{-80,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Fan_Basis;
