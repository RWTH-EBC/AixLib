within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.BaseClasses;
model Regulation_ModularBoiler

  parameter Real PLRmin=0.15 "Minimum value for partial load ratio, so that the boiler is switched on";
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active";
  parameter Boolean severalHeatCircuits=false;

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(final y=0.05)
    annotation (Placement(transformation(extent={{10,-2},{30,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression1 if not
    use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{-66,56},{-46,76}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(final threshold=PLRmin) if not
    use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{-60,36},{-46,50}})));
  Modelica.Blocks.Logical.Switch switch2 if not use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{-28,32},{-12,48}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{-120,0},{-80,40}}),
        iconTransformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput mFlow_rel
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealOutput mFlow_relB
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
        iconTransformation(extent={{92,-10},{112,10}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
if not use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{92,30},{112,50}}),
        iconTransformation(extent={{92,30},{112,50}})));
  Modelica.Blocks.Interfaces.RealInput PLRMea
    "Measured PLR after starting the simulation"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(final threshold=PLRmin)
    annotation (Placement(transformation(extent={{-44,-68},{-28,-52}})));

equation
  connect(mFlow_rel,switch1. u3)
    annotation (Line(points={{-100,-20},{-30,-20},{-30,-8},{42,-8}},
                                                   color={0,0,127}));
  connect(realExpression.y,switch1. u1)
    annotation (Line(points={{31,8},{42,8}},     color={0,0,127}));
  connect(switch1.y,mFlow_relB)
    annotation (Line(points={{65,0},{102,0}},     color={0,0,127}));
  connect(lessThreshold.y,switch2. u2)
    annotation (Line(points={{-45.3,43},{
          -36.65,43},{-36.65,40},{-29.6,40}},
                                          color={255,0,255}));
  connect(PLRin,lessThreshold. u)
    annotation (Line(points={{-100,20},{-70,20},{
          -70,43},{-61.4,43}},
                             color={0,0,127}));
  connect(PLRin,switch2. u3)
    annotation (Line(points={{-100,20},{-36,20},{-36,
          33.6},{-29.6,33.6}},
                          color={0,0,127}));
  connect(realExpression1.y,switch2. u1)
    annotation (Line(points={{-45,66},{-34,
          66},{-34,46.4},{-29.6,46.4}},    color={0,0,127}));
  connect(switch2.y, PLRset)
    annotation (Line(points={{-11.2,40},{102,40}}, color={0,0,127}));
  connect(PLRMea, lessThreshold1.u)
    annotation (Line(points={{-100,-60},{-45.6,
          -60}},                  color={0,0,127}));
  connect(lessThreshold1.y, switch1.u2)
    annotation (Line(points={{-27.2,-60},{
          28,-60},{28,0},{42,0}},  color={255,0,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Regulation_ModularBoiler;
