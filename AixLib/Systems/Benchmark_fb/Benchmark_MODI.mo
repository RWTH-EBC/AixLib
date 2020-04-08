within AixLib.Systems.Benchmark_fb;
model Benchmark_MODI
   extends Modelica.Icons.Example;
  AixLib.Systems.Benchmark_fb.BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-40,-40},{40,14}})));
  CCCS.Evaluation_CCCS evaluation_CCCS
    annotation (Placement(transformation(extent={{16,30},{36,50}})));
  Mode_based_ControlStrategy.Mode_based_Controller controlling_MODI
    annotation (Placement(transformation(extent={{-64,22},{-44,42}})));
equation
  connect(benchmarkBuilding.mainBus, evaluation_CCCS.mainBus) annotation (Line(
      points={{-4,13.6},{-4,40},{16,40}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, controlling_MODI.mainBus) annotation (Line(
      points={{-4,13.6},{-4,40},{-44,40}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.y, controlling_MODI.TAirOutside) annotation (Line(
        points={{-34.4,15.4},{-34.4,34},{-43.2,34}},  color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark_MODI;
