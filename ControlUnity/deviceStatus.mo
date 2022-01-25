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
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=45, period=500)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(booleanPulse.y, deviceStatusDelay1.u)
    annotation (Line(points={{-79,0},{12,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end deviceStatus;
