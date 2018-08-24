within AixLib.Building.Benchmark;
model LogModel
  BusSystem.Logger_Bus_measure logger_Bus_measure
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  BusSystem.Logger_Bus_Control logger_Bus_Control
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LogModel;
