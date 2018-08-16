within AixLib.Building.Benchmark.Regelungsbenchmark;
model Benchmark
  Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  FullModel fullModel
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
equation
  connect(testcontroller.controlBus, fullModel.controlBus) annotation (Line(
      points={{-20,-4},{12,-4},{12,-4},{20,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(testcontroller.measureBus, fullModel.measureBus) annotation (Line(
      points={{-20,4},{20,4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark;
