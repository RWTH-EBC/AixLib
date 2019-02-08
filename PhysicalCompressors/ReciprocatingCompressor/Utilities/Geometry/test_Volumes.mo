within PhysicalCompressors.ReciprocatingCompressor.Utilities.Geometry;
model test_Volumes
  Volumes volumes
    annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=20)
    annotation (Placement(transformation(extent={{-82,38},{-62,58}})));
equation
  connect(constantSpeed.flange, volumes.flange_a) annotation (Line(points={{-62,
          48},{-50,48},{-50,46},{-40,46}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_Volumes;
