within AixLib.Building.Benchmark.Regelungsbenchmark;
model Benchmark
  Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-40,-2},{-20,18}})));
  FullModel fullModel
    annotation (Placement(transformation(extent={{52,-6},{72,14}})));
equation
  connect(testcontroller.controlBus, fullModel.controlBus) annotation (Line(
      points={{-20,8},{-4,8},{-4,8.4},{51.4,8.4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark;
