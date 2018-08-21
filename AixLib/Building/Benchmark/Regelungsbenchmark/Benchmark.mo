within AixLib.Building.Benchmark.Regelungsbenchmark;
model Benchmark
  FullModel fullModel
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  Controller.ControllerBasis controllerBasis
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
equation
  connect(controllerBasis.measureBus, fullModel.measureBus) annotation (Line(
      points={{-20,4},{20,4}},
      color={255,204,51},
      thickness=0.5));
  connect(controllerBasis.controlBus, fullModel.controlBus) annotation (Line(
      points={{-20,-4},{20,-4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark;
