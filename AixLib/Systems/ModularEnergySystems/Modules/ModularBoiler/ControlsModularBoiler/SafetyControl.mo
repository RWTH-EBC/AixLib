within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler;
model SafetyControl
  parameter Modelica.Units.SI.Temperature TFlowMax=378.15 "Maximum flow temperature, at which the system is shut down";
  parameter Modelica.Units.SI.Temperature TRetMin=313.15 "Minimum return temperature, at which the system is shut down";

  Modelica.Blocks.Sources.RealExpression TFlowMaxExp(final y=TFlowMax)
    annotation (Placement(transformation(extent={{-96,-30},{-76,-10}})));
  Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K")
    "Measured flow temperature of boiler"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput isOn
    "Set value for on/off status of boiler after emergency check"
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Interfaces.BooleanInput isOnSet
    "Set value for on off status of boiler"
    annotation (Placement(transformation(extent={{-120,24},{-80,64}})));

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Interfaces.RealInput TRetMea(unit="K")
    "Measured return temperature of boiler"
    annotation (Placement(transformation(extent={{-140,-62},{-100,-22}})));
  Modelica.Blocks.Sources.RealExpression TRetMinExp(final y=TRetMin)
    annotation (Placement(transformation(extent={{-96,-72},{-76,-52}})));
  Modelica.Blocks.Logical.Less    less
    annotation (Placement(transformation(extent={{-48,-52},{-28,-32}})));
  parameter Modelica.Units.SI.Time time_minOff=900
    "Time after which the device can be turned on again";
  parameter Modelica.Units.SI.Time time_minOn=900
    "Time after which the device can be turned off again";
  DeviceStatusDelay deviceStatusDelay
    annotation (Placement(transformation(extent={{68,-2},{88,18}})));
equation

   ///Assertion
  assert(
    TFlowMea < TFlowMax,
    "Maximum boiler temperature has been exceeded",
    AssertionLevel.warning);
  assert(
    TRetMea > TRetMin,
    "Maximum boiler temperature has been exceeded",
    AssertionLevel.warning);
  connect(TFlowMea, greater.u1)
    annotation (Line(points={{-120,0},{-50,0}}, color={0,0,127}));
  connect(TFlowMaxExp.y, greater.u2)
    annotation (Line(points={{-75,-20},{-50,-20},{-50,-8}}, color={0,0,127}));
  connect(TRetMinExp.y, less.u2) annotation (Line(points={{-75,-62},{-58,-62},{-58,
          -50},{-50,-50}}, color={0,0,127}));
  connect(TRetMea, less.u1)
    annotation (Line(points={{-120,-42},{-50,-42}}, color={0,0,127}));
  connect(isOnSet, deviceStatusDelay.u) annotation (Line(points={{-100,44},{60,
          44},{60,8},{66,8}}, color={255,0,255}));
  connect(deviceStatusDelay.y, isOn) annotation (Line(points={{89,8},{98,8},{98,
          0},{104,0}}, color={255,0,255}));
  connect(greater.y, deviceStatusDelay.u_safety)
    annotation (Line(points={{-27,0},{66,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SafetyControl;
