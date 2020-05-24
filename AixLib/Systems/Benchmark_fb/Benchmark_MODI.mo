within AixLib.Systems.Benchmark_fb;
model Benchmark_MODI
   extends Modelica.Icons.Example;
  AixLib.Systems.Benchmark_fb.BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-40,-56},{42,0}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  CCCS.Evaluation_CCCS evaluation_CCCS
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Benchmark.Controller.BenchmarkBaseControl benchmarkBaseControl
    annotation (Placement(transformation(extent={{-44,14},{-20,40}})));
equation
  connect(benchmarkBuilding.mainBus, evaluation_CCCS.mainBus) annotation (Line(
      points={{0.59,-0.622222},{0.59,30},{20,30}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, benchmarkBaseControl.bus) annotation (Line(
      points={{0.59,-0.622222},{0.59,30.1},{-19.2,30.1}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark_MODI;
