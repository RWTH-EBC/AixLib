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
  Benchmark.BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
equation
  connect(benchmarkBuilding.mainBus, evaluation_CCCS.mainBus) annotation (Line(
      points={{0.59,-0.622222},{0.59,30},{20,30}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, benchmarkBaseControl.bus) annotation (Line(
      points={{0.59,-0.622222},{0.59,30.1},{-19.2,30.1}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, mainBus) annotation (Line(
      points={{0.59,-0.622222},{0.59,60},{0,60}},
      color={255,204,51},
      thickness=0.5));
  connect(evaluation_CCCS.OverallCosts_Output, mainBus.CCCS) annotation (Line(
        points={{40.8,30},{48,30},{48,60},{0,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark_MODI;
