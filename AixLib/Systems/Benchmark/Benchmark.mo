within AixLib.Systems.Benchmark;
model Benchmark
  extends AixLib.Systems.Benchmark.Model.BusSystems.Logger;
  Model.FullModel_v4 fullModel_v4_1
    annotation (Placement(transformation(extent={{26,-24},{66,16}})));
  ControlStrategies.Controller.Controller_NoChpAndBoiler
    controller_NoChpAndBoiler
    annotation (Placement(transformation(extent={{-34,10},{-14,30}})));
equation
  connect(controller_NoChpAndBoiler.measureBus, fullModel_v4_1.Measure)
    annotation (Line(
      points={{-14,22},{2,22},{2,0},{26,0}},
      color={255,204,51},
      thickness=0.5));
  connect(controller_NoChpAndBoiler.controlBus, fullModel_v4_1.Control)
    annotation (Line(
      points={{-14,18},{4,18},{4,-8},{26,-8}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_selections);
end Benchmark;
