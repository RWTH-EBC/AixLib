within AixLib.Building.Benchmark.Generation;
model Generation
  Generation_Hot generation_Hot
    annotation (Placement(transformation(extent={{36,-14},{56,6}})));
  Fluid.Sources.Boundary_ph bou(nPorts=2, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-68,38},{-48,58}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation;
