within AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp;
model RLT_Switch
  Modelica.Blocks.Interfaces.RealOutput Tempvalve_Hot
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput hot
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput Tempvalve_cold
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput cold
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={0,-100})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=10)
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=10)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
equation
  connect(Tempvalve_cold, Tempvalve_cold)
    annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
  connect(firstOrder.y, Tempvalve_Hot)
    annotation (Line(points={{71,30},{110,30}}, color={0,0,127}));
  connect(firstOrder1.y, Tempvalve_cold) annotation (Line(points={{71,-30},{88,
          -30},{88,-30},{110,-30}}, color={0,0,127}));
  connect(hot, firstOrder.u) annotation (Line(points={{0,100},{0,100},{0,30},{
          48,30}}, color={0,0,127}));
  connect(cold, firstOrder1.u) annotation (Line(points={{-1.77636e-015,-100},{
          -1.77636e-015,-30},{48,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RLT_Switch;
