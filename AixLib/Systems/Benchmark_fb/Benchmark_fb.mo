within AixLib.Systems.Benchmark_fb;
model Benchmark_fb
  extends Modelica.Icons.Example;
  import PNlib.*;
  Benchmark.BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-36,-52},{44,2}})));
  CCCS.Evaluation_CCCS evaluation_CCCS(simulation_time=3628800)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Benchmark.BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{20,32},{40,52}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Mode_based_ControlStrategy.Mode_Based_Controller_StateGraph test
    annotation (Placement(transformation(extent={{-60,20},{-40,54}})));
equation
  connect(benchmarkBuilding.mainBus, mainBus) annotation (Line(
      points={{0,1.6},{0,60}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, evaluation_CCCS.mainBus) annotation (Line(
      points={{0,1.6},{0,20},{20,20}},
      color={255,204,51},
      thickness=0.5));
  connect(evaluation_CCCS.CCCSBus, mainBus.CCCSBus) annotation (Line(
      points={{39.8,20},{60,20},{60,60},{0,60}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.mainBus, energyCounter.mainBus) annotation (Line(
      points={{0,1.6},{0,36},{29.9,36},{29.9,39.6}},
      color={255,204,51},
      thickness=0.5));
  connect(test.mainBus, benchmarkBuilding.mainBus) annotation (Line(
      points={{-40,37},{-22,37},{-22,1.6},{0,1.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=1209600,
      StopTime=4838400,
      Interval=300,
      __Dymola_Algorithm="Dassl"),
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
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>benchmark with control strategy and evaluation method Cost Coefficient for Control Strategies</p>
</html>"));
end Benchmark_fb;
