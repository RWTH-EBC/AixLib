within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler;
model EmergencySwitch
protected
  parameter Modelica.SIunits.Temperature THotMax=TMax-onOffController.bandwidth/2;

public
  parameter Modelica.SIunits.Temperature TMax=273.15+105 "Maximum temperature, at which the system is shut down";
  parameter Real PLRMin=0.15 "Minimal zulässiges PLR";

  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax)
    annotation (Placement(transformation(extent={{-100,-4},{-80,16}})));
  Modelica.Blocks.Interfaces.RealInput TBoiler
    "Boiler temperature for measurement "
    annotation (Placement(transformation(extent={{-120,-82},{-80,-42}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-52,-42},{-32,-22}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=10,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

equation

   ///Assertion
   assert(TBoiler<TMax, "Maximum boiler temperature has been exceeded", AssertionLevel.warning);

  connect(TBoiler, onOffController.u) annotation (Line(points={{-100,-62},{-66,
          -62},{-66,-6},{-52,-6}},
                              color={0,0,127}));
  connect(tHotMax.y, onOffController.reference) annotation (Line(points={{-79,6},
          {-52,6}},                    color={0,0,127}));
  connect(onOffController.y, logicalSwitch.u2)
    annotation (Line(points={{-29,0},{6,0}},    color={255,0,255}));
  connect(logicalSwitch.u3, booleanExpression.y) annotation (Line(points={{6,-8},{
          -26,-8},{-26,-32},{-31,-32}},
                                    color={255,0,255}));
  connect(isOn, logicalSwitch.u1) annotation (Line(points={{-100,74},{-26,74},{
          -26,8},{6,8}},color={255,0,255}));
  connect(logicalSwitch.y, y)
    annotation (Line(points={{29,0},{104,0}}, color={255,0,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EmergencySwitch;
