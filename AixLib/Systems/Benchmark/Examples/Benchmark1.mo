within AixLib.Systems.Benchmark.Examples;
model Benchmark1
  extends Modelica.Icons.Example;

  BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-60,-80},{64,4}})));
  Controller.BenchmarkBaseControl benchmarkBaseControl
    annotation (Placement(transformation(extent={{-40,14},{-20,40}})));
equation
  connect(benchmarkBaseControl.bus, benchmarkBuilding.mainBus) annotation (Line(
      points={{-19.3333,30.1},{-4.2,30.1},{-4.2,3.37778}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end Benchmark1;
