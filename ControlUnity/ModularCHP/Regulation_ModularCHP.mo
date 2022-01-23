within ControlUnity.ModularCHP;
model Regulation_ModularCHP

   parameter Real PLRMin=0.5;


  Modelica.Blocks.Sources.RealExpression realExpression1 if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-66,56},{-46,76}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=PLRmin) if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-60,36},{-46,50}})));
  Modelica.Blocks.Logical.Switch switch2 if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-28,28},{-12,44}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{90,26},{110,46}})));
equation
  connect(lessThreshold.y,switch2. u2) annotation (Line(points={{-45.3,43},{-36.65,43},{-36.65,36},
          {-29.6,36}},                    color={255,0,255}));
  connect(PLRin,lessThreshold. u) annotation (Line(points={{-100,30},{-70,30},{-70,43},{-61.4,43}},
                             color={0,0,127}));
  connect(PLRin,switch2. u3) annotation (Line(points={{-100,30},{-70,30},{-70,29.6},{-29.6,29.6}},
                          color={0,0,127}));
  connect(realExpression1.y,switch2. u1) annotation (Line(points={{-45,66},{-34,66},{-34,42.4},{-29.6,
          42.4}},                          color={0,0,127}));
  connect(switch2.y,PLRset)
    annotation (Line(points={{-11.2,36},{100,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Regulation_ModularCHP;
