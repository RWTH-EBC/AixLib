within ControlUnity;
model tester
  parameter Boolean severalHeatCurcuits=true "If true, there are two or more heat curcuits";

  replaceable flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve
    constrainedby
    ControlUnity.flowTemperatureController.partialFlowtemperatureControl
    annotation (Placement(transformation(extent={{-32,-56},{-12,-36}})),
                                                                       choicesAllMatching=true, Dialog(enable= use_advancedControl));

    Modelica.Blocks.Interfaces.RealInput Tamb
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-98},{-80,-58}})));

 emergencySwitch_modularBoiler emergencySwitch_modularBoiler2
    annotation (Placement(transformation(extent={{8,-2},{28,18}})));
  Modelica.Blocks.Interfaces.RealInput TMeaRet
    "Measurement temperature of the return" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-16,-108})));

  parameter Modelica.SIunits.Temperature THotMax=273.15 + 90
    "Maximum temperature, from which the system is switched off" annotation(Dialog(group="Security-related systems"));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{54,-62},{74,-42}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        severalHeatCurcuits)
    annotation (Placement(transformation(extent={{20,-62},{40,-42}})));
  Modelica.Blocks.Interfaces.RealOutput set "Output for PLR or valve position"
    annotation (Placement(transformation(extent={{98,-62},{118,-42}})));
  Modelica.Blocks.Interfaces.RealInput Tin
    annotation (Placement(transformation(extent={{-120,-2},{-80,38}})));
equation
  connect(TMeaRet, flowTemperatureControl_heatingCurve.TMea) annotation (Line(
        points={{-16,-108},{-16,-82},{-16,-56},{-16.4,-56}}, color={0,0,127}));
  connect(Tamb, flowTemperatureControl_heatingCurve.u) annotation (Line(points={
          {-100,-78},{-66,-78},{-66,-46},{-32,-46}}, color={0,0,127}));
  connect(booleanExpression.y, switch1.u2)
    annotation (Line(points={{41,-52},{52,-52}}, color={255,0,255}));
  connect(flowTemperatureControl_heatingCurve.y, emergencySwitch_modularBoiler2.PLR_ein)
    annotation (Line(points={{-12,-46},{0,-46},{0,6.8},{8,6.8}}, color={0,0,127}));
  connect(Tin, emergencySwitch_modularBoiler2.T_ein) annotation (Line(points={{-100,
          18},{-44,18},{-44,13.2},{8,13.2}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler2.PLR_set,
    flowTemperatureControl_heatingCurve.PLRin) annotation (Line(points={{28,11},
          {32,11},{32,-28},{-50,-28},{-50,-38},{-32,-38}}, color={0,0,127}));
  connect(switch1.y, set)
    annotation (Line(points={{75,-52},{108,-52}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.y, switch1.u1) annotation (Line(
        points={{-12,-46},{20,-46},{20,-44},{52,-44}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLRset, switch1.u3) annotation (
      Line(points={{-11.8,-38},{8,-38},{8,-60},{52,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tester;
