within ControlUnity;
model deviceStatus
  deviceStatusDelay deviceStatusDelay1(
    time_minOff=time_minOff,
    time_minOn=time_minOn,
    use_safetyShutoff=use_safetyShutoff)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{92,40},{112,60}})));
  parameter Modelica.SIunits.Time time_minOff=900
    "Time after which the device can be turned on again";
  parameter Modelica.SIunits.Time time_minOn=900
    "Time after which the device can be turned off again";
  parameter Boolean use_safetyShutoff=false
    "Set true, to enable an additional boolean input to perform manual shutoffs for security reasons without messing up the timer";
equation
  connect(deviceStatusDelay1.y, y)
    annotation (Line(points={{41,50},{102,50}}, color={255,0,255}));
  connect(greater.y, deviceStatusDelay1.u)
    annotation (Line(points={{1,50},{18,50}}, color={255,0,255}));
  connect(PLR, greater.u1)
    annotation (Line(points={{-100,50},{-22,50}}, color={0,0,127}));
  connect(realExpression.y, greater.u2) annotation (Line(points={{-71,10},{-46,
          10},{-46,42},{-22,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end deviceStatus;
