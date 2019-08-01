within AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp;
model TBA_Hystersis_v2
  Modelica.Blocks.Interfaces.RealOutput Valve_Warm
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput warm
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput Cold
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={20,-100})));
  Modelica.Blocks.Interfaces.RealOutput Valve_Temp
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
equation
  connect(warm, Valve_Warm) annotation (Line(points={{20,100},{20,100},{20,30},
          {110,30}}, color={0,0,127}));
  connect(Cold, Valve_Temp)
    annotation (Line(points={{20,-100},{20,-30},{110,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TBA_Hystersis_v2;
