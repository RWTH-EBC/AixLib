within AixLib.Systems.Benchmark.Model.BusSystems;
model LogModel
  BusSystems.Logger_Bus_measure logger_Bus_measure
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  BusSystems.Logger_Bus_Control logger_Bus_Control
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LogModel;
