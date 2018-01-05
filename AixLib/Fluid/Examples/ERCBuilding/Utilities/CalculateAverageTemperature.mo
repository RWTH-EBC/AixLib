within AixLib.Fluid.Examples.ERCBuilding.Utilities;
model CalculateAverageTemperature
  extends Modelica.Blocks.Interfaces.MIMO;
  Modelica.Blocks.Math.Sum sum1(nin=nin, k=ones(nin)/nin)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(u, sum1.u)
    annotation (Line(points={{-120,0},{-12,0},{-12,0}}, color={0,0,127}));
  connect(sum1.y, y[1])
    annotation (Line(points={{11,0},{110,0},{110,0}}, color={0,0,127}));
end CalculateAverageTemperature;
