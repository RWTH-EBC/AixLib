within AixLib.Systems.ModularEnergySystems.ControlUnity.ModularCHP;
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
    annotation (Placement(transformation(extent={{90,-36},{110,-16}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.BooleanInput shutdown
    annotation (Placement(transformation(extent={{-120,-46},{-80,-6}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-4,-36},{16,-16}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
equation
  connect(lessThreshold.y,switch2. u2) annotation (Line(points={{-45.3,43},{-36.65,43},{-36.65,36},
          {-29.6,36}},                    color={255,0,255}));
  connect(realExpression1.y,switch2. u1) annotation (Line(points={{-45,66},{-34,66},{-34,42.4},{-29.6,
          42.4}},                          color={0,0,127}));
  connect(switch2.y,PLRset)
    annotation (Line(points={{-11.2,36},{100,36}}, color={0,0,127}));
  connect(lessThreshold.u, PLRin) annotation (Line(points={{-61.4,43},{-70.7,43},{-70.7,40},{-100,
          40}}, color={0,0,127}));
  connect(PLRin, switch2.u3) annotation (Line(points={{-100,40},{-66,40},{-66,
          29.6},{-29.6,29.6}}, color={0,0,127}));
  connect(logicalSwitch.y, PLRoff)
    annotation (Line(points={{17,-26},{100,-26}}, color={255,0,255}));
  connect(shutdown, logicalSwitch.u2)
    annotation (Line(points={{-100,-26},{-6,-26}}, color={255,0,255}));
  connect(logicalSwitch.u3, booleanExpression.y) annotation (Line(points={{-6,
          -34},{-12,-34},{-12,-40},{-17,-40}}, color={255,0,255}));
  connect(lessThreshold.y, logicalSwitch.u1) annotation (Line(points={{-45.3,43},
          {-36,43},{-36,-18},{-6,-18}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model that inclued the system-relevant control systems. It checks whether PLRmin (minimum part load ratio of the heat generator) is observed and sets the PLR and the mass flow accordingly.</p>
</html>"));
end Regulation_ModularCHP;
