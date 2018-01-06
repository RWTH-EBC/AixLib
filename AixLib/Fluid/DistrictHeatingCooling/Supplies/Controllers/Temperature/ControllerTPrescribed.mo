within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature;
model ControllerTPrescribed
  "Propagates a prescribed set temperature without any effect"
  extends PartialControllerT;
  Modelica.Blocks.Interfaces.RealInput T "Temperature Input in Degree Celsius"
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
equation
  connect(T, y) annotation (Line(points={{-106,0},{110,0}}, color={0,0,127}));
end ControllerTPrescribed;
