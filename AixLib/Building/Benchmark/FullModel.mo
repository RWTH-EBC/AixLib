within AixLib.Building.Benchmark;
model FullModel
  Weather weather
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{0,-80},{62,-20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FullModel;
