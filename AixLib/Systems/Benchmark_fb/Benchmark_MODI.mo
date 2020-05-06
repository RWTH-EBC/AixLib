within AixLib.Systems.Benchmark_fb;
model Benchmark_MODI
   extends Modelica.Icons.Example;
  AixLib.Systems.Benchmark_fb.BenchmarkBuilding benchmarkBuilding
    annotation (Placement(transformation(extent={{-40,-40},{40,14}})));
  CCCS.Evaluation_CCCS evaluation_CCCS
    annotation (Placement(transformation(extent={{16,30},{36,50}})));
  Mode_based_ControlStrategy.Mode_based_Controller mode_based_Controller
    annotation (Placement(transformation(extent={{-76,32},{-56,52}})));
equation
  connect(benchmarkBuilding.mainBus, evaluation_CCCS.mainBus) annotation (Line(
      points={{-4,13.6},{-4,40},{16,40}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding.y, mode_based_Controller.TAirOutside) annotation (
      Line(points={{-34.4,15.4},{-34.4,44},{-55.2,44}}, color={0,0,127}));
  connect(benchmarkBuilding.mainBus, mode_based_Controller.mainBus) annotation
    (Line(
      points={{-4,13.6},{-4,50},{-56,50}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark_MODI;
