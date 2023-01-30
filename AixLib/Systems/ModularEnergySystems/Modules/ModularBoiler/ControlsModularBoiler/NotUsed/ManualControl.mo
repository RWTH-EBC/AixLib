within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler.NotUsed;
model ManualControl
  "This model offers the choice between intern and extern control"
  parameter Real PLRMin=0.15;
  parameter Boolean manualTimeDelay=false "If true, the user can set a time during which the heat genearator is switched on independently of the internal control";
  parameter Modelica.Units.SI.Time time_minOff=900
    "Time after which the device can be turned on again";
  parameter Modelica.Units.SI.Time time_minOn=900
    "Time after which the device can be turned off again";

  Modelica.Blocks.Interfaces.BooleanInput isOn "On/off value of boiler"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(
    final y=manualTimeDelay)
    annotation (Placement(transformation(extent={{-14,18},{6,38}})));
  Modelica.Blocks.Interfaces.RealInput PLRPreCtrl
    "Set value for PLR before control"
    annotation (Placement(transformation(extent={{-122,56},{-82,96}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch1
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  Modelica.Blocks.Interfaces.RealOutput PLRAftCtrl
    annotation (Placement(transformation(extent={{90,58},{110,78}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{0,58},{20,78}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-32,50},{-12,70}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
    final threshold=PLRMin)
    annotation (Placement(transformation(extent={{-80,42},{-64,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(final y=1)
    annotation (Placement(transformation(extent={{-34,66},{-14,86}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{46,58},{66,78}})));

equation
  connect(isOn, logicalSwitch.u2)
    annotation (Line(points={{-100,0},{-18,0}}, color={255,0,255}));
  connect(isOn, logicalSwitch.u3) annotation (Line(points={{-100,0},{-44,0},{
          -44,-8},{-18,-8}}, color={255,0,255}));
  connect(deviceStatusDelay1.y, logicalSwitch.u1)
    annotation (Line(points={{-27,
          22},{-24,22},{-24,8},{-18,8}}, color={255,0,255}));
  connect(logicalSwitch.y, logicalSwitch1.u1)
    annotation (Line(points={{5,0},{12,0},{12,8},{24,8}}, color={255,0,255}));
  connect(isOn, logicalSwitch1.u3) annotation (Line(points={{-100,0},{-44,0},
          {-44,-16},{14,-16},{14,-8},{24,-8}}, color={255,0,255}));
  connect(booleanExpression.y, logicalSwitch1.u2)
    annotation (Line(points={{7,
          28},{16,28},{16,0},{24,0}}, color={255,0,255}));
  connect(PLRPreCtrl, greaterEqualThreshold.u) annotation (Line(points={{-102,
          76},{-84,76},{-84,50},{-81.6,50}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, deviceStatusDelay1.u)
    annotation (Line(
        points={{-63.2,50},{-56,50},{-56,22},{-50,22}}, color={255,0,255}));
  connect(switch1.u3, realExpression.y)
    annotation (Line(points={{-2,60},{-11,60}}, color={0,0,127}));
  connect(switch1.u1, realExpression1.y)
    annotation (Line(points={{-2,76},{-13,76}}, color={0,0,127}));
  connect(logicalSwitch1.y, switch1.u2)
    annotation (Line(points={{47,0},{54,0},
          {54,50},{-6,50},{-6,68},{-2,68}}, color={255,0,255}));
  connect(booleanExpression.y, switch2.u2)
    annotation (Line(points={{7,28},{34,
          28},{34,68},{44,68}}, color={255,0,255}));
  connect(PLRPreCtrl, switch2.u3) annotation (Line(points={{-102,76},{-46,76},
          {-46,44},{40,44},{40,60},{44,60}}, color={0,0,127}));
  connect(switch1.y, switch2.u1)
    annotation (Line(points={{21,68},{32,68},{32,
          76},{44,76}}, color={0,0,127}));
  connect(switch2.y, PLRAftCtrl)
    annotation (Line(points={{67,68},{100,68}}, color={0,0,127}));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-102,26},{98,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  With this model, the switch between internal and external control
  takes place. In addition, this model implements the function of
  manually specifying a fixed operating time for the heat generator
  from the outside.
</p>
</html>"));
end ManualControl;
