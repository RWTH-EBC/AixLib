within ControlUnity;
model deviceStatus
  deviceStatusDelay deviceStatusDelay1(
    time_minOff=0,
    time_minOn=900,
    use_safetyShutoff=use_safetyShutoff)
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
  parameter Modelica.SIunits.Time time_minOff=900
    "Time after which the device can be turned on again";
  parameter Modelica.SIunits.Time time_minOn=900
    "Time after which the device can be turned off again";
  parameter Boolean use_safetyShutoff=false
    "Set true, to enable an additional boolean input to perform manual shutoffs for security reasons without messing up the timer";
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(deviceStatusDelay1.u, booleanExpression.y)
    annotation (Line(points={{12,0},{-9,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end deviceStatus;
