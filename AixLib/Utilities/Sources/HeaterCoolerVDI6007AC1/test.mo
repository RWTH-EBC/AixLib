within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model test
  tabsHeatingCurve tabsHeatingCurve1(
    power_high=30,
    power_low=10,
    T_upperlimit=273.15 + 15,
    T_lowerlimit=273.15 - 10)
    annotation (Placement(transformation(extent={{-12,-2},{8,18}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=273.15 + 20,
    duration=24000,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-74,-4},{-54,16}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{88,-2},{108,18}})));
equation
  connect(ramp.y, tabsHeatingCurve1.tDryBul) annotation (Line(points={{-53,6},{
          -32,6},{-32,8},{-12,8}}, color={0,0,127}));
  connect(y, tabsHeatingCurve1.powerOutput)
    annotation (Line(points={{98,8},{9,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test;
