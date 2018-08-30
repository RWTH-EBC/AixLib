within AixLib.Building.Benchmark.Regelungsbenchmark;
model Benchmark
  extends AixLib.Building.Benchmark.Logger;
  FullModel_v4 fullModel_v4_1
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  Controller.ControllerBasis_v2 controllerBasis_v2_1
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
equation
  connect(controllerBasis_v2_1.measureBus, fullModel_v4_1.Measure) annotation (
      Line(
      points={{-46,2},{-14,2},{-14,4},{20,4}},
      color={255,204,51},
      thickness=0.5));
  connect(controllerBasis_v2_1.controlBus, fullModel_v4_1.Control) annotation (
      Line(
      points={{-46,-2},{-12,-2},{-12,-4},{20,-4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_selections);
end Benchmark;
