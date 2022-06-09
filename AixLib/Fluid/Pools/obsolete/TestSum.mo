within AixLib.Fluid.Pools.obsolete;
model TestSum
  parameter Boolean useSecondInput = false;

  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=if useSecondInput then 2 else 1)
    annotation (Placement(transformation(extent={{-12,-30},{0,-18}})));
  Modelica.Blocks.Sources.Constant const1(k=1) if useSecondInput
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
equation
  connect(multiSum.u[1], const.y) annotation (Line(points={{-12,-24},{-48,-24},{
          -48,22},{-79,22}},  color={0,0,127}));
  connect(const1.y, multiSum.u[2]) annotation (Line(points={{-79,-16},{-68,-16},
          {-68,-24},{-12,-24}},     color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestSum;
