within ControlUnity;
model emergencySwitch_modularBoiler

protected
  parameter Modelica.SIunits.Temperature TMax=273.15+100 "Maximum temperature, at which the system is shut down";

public
  parameter Real PLRmin=0.15 "Minimal zulässiges PLR";

  Modelica.Blocks.Sources.RealExpression tHotMax(y=TMax)
    annotation (Placement(transformation(extent={{-102,26},{-82,46}})));
  Modelica.Blocks.Interfaces.RealInput TBoiler
    "Boiler temperature for measurement "
    annotation (Placement(transformation(extent={{-120,-76},{-80,-36}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{38,20},{58,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{92,20},{112,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-22,-14},{-2,6}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=10,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
equation

  connect(logicalSwitch.y, y)
    annotation (Line(points={{59,30},{102,30}}, color={255,0,255}));

   ///Assertion
   assert(TBoiler<TMax, "Maximum boiler temperature has been exceeded", AssertionLevel.warning);

  connect(TBoiler, onOffController.u) annotation (Line(points={{-100,-56},{-68,-56},
          {-68,24},{-54,24}}, color={0,0,127}));
  connect(tHotMax.y, onOffController.reference) annotation (Line(points={{-81,36},
          {-54,36}},                   color={0,0,127}));
  connect(onOffController.y, logicalSwitch.u2)
    annotation (Line(points={{-31,30},{36,30}}, color={255,0,255}));
  connect(logicalSwitch.u3, booleanExpression.y) annotation (Line(points={{36,22},
          {18,22},{18,-4},{-1,-4}}, color={255,0,255}));
  connect(isOn, logicalSwitch.u1) annotation (Line(points={{-100,74},{22,74},{22,
          38},{36,38}}, color={255,0,255}));
end emergencySwitch_modularBoiler;
