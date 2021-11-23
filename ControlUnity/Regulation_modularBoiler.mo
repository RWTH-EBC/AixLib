within ControlUnity;
model Regulation_modularBoiler
  parameter Real PLRmin=0.15 "Minimum value for partial load ratio, so that the boiler is switched on";
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active";
  parameter Boolean severalHeatcurcuits=false;
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{44,-20},{64,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{12,-12},{32,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression1 if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=PLRmin) if not
    use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-60,36},{-46,50}})));
  Modelica.Blocks.Logical.Switch switch2 if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-28,28},{-12,44}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealInput mFlow_rel
    annotation (Placement(transformation(extent={{-120,-38},{-80,2}})));
  Modelica.Blocks.Interfaces.RealOutput mFlow_relB
    annotation (Placement(transformation(extent={{92,-20},{112,0}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset if not use_advancedControl or (use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{90,26},{110,46}})));
  Modelica.Blocks.Interfaces.RealInput PLRMea
    "Measured PLR after starting the simulation"
    annotation (Placement(transformation(extent={{-120,-86},{-80,-46}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=PLRmin)
    annotation (Placement(transformation(extent={{-44,-74},{-30,-60}})));
equation
  connect(mFlow_rel,switch1. u3)
    annotation (Line(points={{-100,-18},{42,-18}}, color={0,0,127}));
  connect(realExpression.y,switch1. u1)
    annotation (Line(points={{33,-2},{42,-2}},   color={0,0,127}));
  connect(switch1.y,mFlow_relB)
    annotation (Line(points={{65,-10},{102,-10}}, color={0,0,127}));
  connect(lessThreshold.y,switch2. u2) annotation (Line(points={{-45.3,43},{-36.65,
          43},{-36.65,36},{-29.6,36}},    color={255,0,255}));
  connect(PLRin,lessThreshold. u) annotation (Line(points={{-100,30},{-70,30},{-70,
          43},{-61.4,43}},   color={0,0,127}));
  connect(PLRin,switch2. u3) annotation (Line(points={{-100,30},{-70,30},{-70,29.6},
          {-29.6,29.6}},  color={0,0,127}));
  connect(realExpression1.y,switch2. u1) annotation (Line(points={{-49,16},{-32,
          16},{-32,42.4},{-29.6,42.4}},    color={0,0,127}));
  connect(switch2.y, PLRset)
    annotation (Line(points={{-11.2,36},{100,36}}, color={0,0,127}));
  connect(PLRMea, lessThreshold1.u) annotation (Line(points={{-100,-66},{-72,-66},
          {-72,-67},{-45.4,-67}}, color={0,0,127}));
  connect(lessThreshold1.y, switch1.u2) annotation (Line(points={{-29.3,-67},{28,
          -67},{28,-10},{42,-10}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Regulation_modularBoiler;
