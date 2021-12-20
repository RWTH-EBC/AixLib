within ControlUnity;
model emergencySwitch_modularBoiler
                                   //Notausschaltung bei Überschreitung der Grenztemperatur und Abschaltung bei Unterschreitung von PLRmin
  parameter Modelica.SIunits.Temperature TMax=273.15+90 "Maximum temperature, at which the system is shut down";
  parameter Real PLRmin=0.15 "Minimal zulässiges PLR";

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-56,20},{-36,40}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=TMax)
    annotation (Placement(transformation(extent={{-102,12},{-82,32}})));
  Modelica.Blocks.Interfaces.RealInput TBoiler
    "Boiler temperature for measurement "
    annotation (Placement(transformation(extent={{-120,32},{-80,72}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{38,20},{58,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{92,20},{112,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-102,74},{-82,94}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,-42},{-80,-2}})));
equation

  connect(tHotMax.y, greater.u2)
    annotation (Line(points={{-81,22},{-58,22}}, color={0,0,127}));
  connect(TBoiler, greater.u1) annotation (Line(points={{-100,52},{-80,52},{-80,
          30},{-58,30}}, color={0,0,127}));
  connect(logicalSwitch.y, y)
    annotation (Line(points={{59,30},{102,30}}, color={255,0,255}));
  connect(greater.y, logicalSwitch.u2)
    annotation (Line(points={{-35,30},{36,30}}, color={255,0,255}));
  connect(booleanExpression.y, logicalSwitch.u1) annotation (Line(points={{-81,
          84},{-22,84},{-22,38},{36,38}}, color={255,0,255}));
  connect(isOn, logicalSwitch.u3) annotation (Line(points={{-100,-22},{18,-22},
          {18,22},{36,22}}, color={255,0,255}));

   ///Assertion
   assert(TBoiler<TMax, "Maximum boiler temperature has been exceeded", AssertionLevel.warning);

end emergencySwitch_modularBoiler;
