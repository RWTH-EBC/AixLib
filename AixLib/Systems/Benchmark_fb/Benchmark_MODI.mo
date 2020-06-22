within AixLib.Systems.Benchmark_fb;
model Benchmark_MODI
   extends Modelica.Icons.Example;
  AixLib.Systems.Benchmark_fb.BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-40,-56},{42,0}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Benchmark.BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Benchmark.Controller.BenchmarkBaseControl benchmarkBaseControl
    annotation (Placement(transformation(extent={{-44,4},{-20,30}})));
equation
  connect(benchmarkBuilding.mainBus, mainBus) annotation (Line(
      points={{0.59,-0.622222},{0.59,60},{0,60}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBaseControl.bus, benchmarkBuilding.mainBus) annotation (Line(
      points={{-19.2,20.1},{0.59,20.1},{0.59,-0.622222}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=604800, Interval=300));
end Benchmark_MODI;
