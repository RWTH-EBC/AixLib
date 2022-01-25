within ControlUnity.ModularCHP;
model Regulation_ModularCHP

   parameter Real PLRMin=0.5;
    parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active";
  parameter Boolean severalHeatcurcuits=false;


  Modelica.Blocks.Sources.RealExpression realExpression1 if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-66,56},{-46,76}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=PLRMin) if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-60,36},{-46,50}})));
  Modelica.Blocks.Logical.Switch switch2 if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-28,28},{-12,44}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{90,26},{110,46}})));
  Modelica.Blocks.Interfaces.BooleanOutput PLRoff
    annotation (Placement(transformation(extent={{90,-32},{110,-12}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
equation
  connect(lessThreshold.y,switch2. u2) annotation (Line(points={{-45.3,43},{-36.65,43},{-36.65,36},
          {-29.6,36}},                    color={255,0,255}));
  connect(realExpression1.y,switch2. u1) annotation (Line(points={{-45,66},{-34,66},{-34,42.4},{-29.6,
          42.4}},                          color={0,0,127}));
  connect(switch2.y,PLRset)
    annotation (Line(points={{-11.2,36},{100,36}}, color={0,0,127}));
  connect(lessThreshold.y, PLRoff)
    annotation (Line(points={{-45.3,43},{-45.3,-22},{100,-22}}, color={255,0,255}));
  connect(lessThreshold.u, PLRin) annotation (Line(points={{-61.4,43},{-70.7,43},{-70.7,40},{-100,
          40}}, color={0,0,127}));
  connect(PLRin, switch2.u3) annotation (Line(points={{-100,40},{-66,40},{-66,
          29.6},{-29.6,29.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Regulation_ModularCHP;
