within AixLib.Systems.Benchmark_fb;
model Benchmark_MODI
   extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Benchmark_old.BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{-14,50},{6,70}})));
  Benchmark.BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-40,-34},{40,20}})));
equation
  connect(benchmarkBuilding.mainBus, mainBus) annotation (Line(
      points={{-4,19.6},{-6,19.6},{-6,60},{-4,60}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=48348400, Interval=300));
end Benchmark_MODI;
