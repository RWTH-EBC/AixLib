within AixLib.Systems.Benchmark.Examples;
model Benchmark1
  extends Modelica.Icons.Example;

  BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-60,-78},{64,6}})));
  Controller.BenchmarkBaseControl benchmarkBaseControl
    annotation (Placement(transformation(extent={{-40,14},{-20,40}})));
  BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{20,42},{40,62}})));
  BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{-14,48},{6,68}})));
equation
  connect(benchmarkBaseControl.bus, benchmarkBuilding.mainBus) annotation (Line(
      points={{-19.3333,30.1},{-4.2,30.1},{-4.2,5.37778}},
      color={255,204,51},
      thickness=0.5));
  connect(energyCounter.mainBus, benchmarkBuilding.mainBus) annotation (Line(
      points={{29.9,49.6},{29.9,5.37778},{-4.2,5.37778}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, mainBus) annotation (Line(
      points={{-4.2,5.37778},{-4.2,58},{-4,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=259200),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      auxiliaries=false,
      events=false),
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=true,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end Benchmark1;
