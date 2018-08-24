within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_PumpsAndFans;
model Fan_Basis
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.3)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(realExpression.y, controlBus.Fan_RLT) annotation (Line(points={{-39,
          -72},{0.1,-72},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(realExpression1.y, controlBus.Fan_Aircooler) annotation (Line(points=
          {{-39,-50},{0.1,-50},{0.1,-99.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Fan_Basis;
