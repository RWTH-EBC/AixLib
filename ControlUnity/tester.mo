within ControlUnity;
model tester
  flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve
    annotation (Placement(transformation(extent={{-10,8},{10,28}})));
  emergencySwitch_modularBoiler emergencySwitch_modularBoiler1
    annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 80)
    annotation (Placement(transformation(extent={{-172,48},{-152,68}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    freqHz=0.01,
    offset=273.15 + 20) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-2,-64})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-10,
    duration=200,
    offset=273.15,
    startTime=20)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{94,44},{114,64}})));
equation
  connect(ramp.y, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-79,10},{-44,10},{-44,18},{-10,18}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.PLR_set,
    flowTemperatureControl_heatingCurve.PLRin) annotation (Line(points={{-48,53},
          {-30,53},{-30,25},{-10,25}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.y, PLRset) annotation (Line(
        points={{10,18},{49.1,18},{49.1,54},{104,54}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLR,
    emergencySwitch_modularBoiler1.PLR_ein) annotation (Line(points={{10,17.6},
          {20,17.6},{20,64},{-86,64},{-86,48.8},{-68,48.8}}, color={0,0,127}));
  connect(sine.y, flowTemperatureControl_heatingCurve.TMea)
    annotation (Line(points={{-2,-53},{-2,8},{5.6,8}}, color={0,0,127}));
  connect(realExpression3.y, emergencySwitch_modularBoiler1.T_ein) annotation (
      Line(points={{-151,58},{-110,58},{-110,55.2},{-68,55.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tester;
