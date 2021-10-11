within ControlUnity.threePositionController;
model threePositionController
  Modelica.Blocks.Interfaces.RealInput e "Regelfehler, TVL_Soll-TVL"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-68,20},{-48,40}})));
  Modelica.Blocks.Logical.Greater greater "Hysterese"
    annotation (Placement(transformation(extent={{-18,20},{2,40}})));
  Modelica.Blocks.Math.Sign sign1
    annotation (Placement(transformation(extent={{34,20},{54,40}})));
  Modelica.Blocks.Math.Gain gain
    annotation (Placement(transformation(extent={{72,22},{92,42}})));
equation
  connect(e, abs1.u)
    annotation (Line(points={{-100,30},{-70,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end threePositionController;
