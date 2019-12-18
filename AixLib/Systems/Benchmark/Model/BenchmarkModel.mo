within AixLib.Systems.Benchmark.Model;
model BenchmarkModel "Model of building for benchmarking control strategies"
  HighTemperatureSystem highTemperatureSystem
    annotation (Placement(transformation(extent={{-164,-60},{-120,-20}})));
  HeatpumpSystem heatpumpSystem
    annotation (Placement(transformation(extent={{-20,-60},{80,-20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-200,-100},{100,100}})));
end BenchmarkModel;
