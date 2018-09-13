within AixLib.Building.Benchmark.Regelungsbenchmark;
model Benchmark
  extends AixLib.Building.Benchmark.Logger;
  FullModel_v4 fullModel_v4_1
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  Controller.Controller_VariablePowerCost controller_VariablePowerCost
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
equation
  connect(controller_VariablePowerCost.measureBus, fullModel_v4_1.Measure)
    annotation (Line(
      points={{-14,2},{2,2},{2,4},{20,4}},
      color={255,204,51},
      thickness=0.5));
  connect(controller_VariablePowerCost.controlBus, fullModel_v4_1.Control)
    annotation (Line(
      points={{-14,-2},{4,-2},{4,-4},{20,-4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_selections);
end Benchmark;
