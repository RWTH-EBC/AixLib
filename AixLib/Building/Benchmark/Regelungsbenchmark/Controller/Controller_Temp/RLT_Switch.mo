within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_Temp;
model RLT_Switch
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
    annotation (Placement(transformation(extent={{-48,-72},{-28,-52}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.2)
    annotation (Placement(transformation(extent={{-48,20},{-28,40}})));
  Modelica.Blocks.Interfaces.RealOutput Tempvalve_Hot
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput hot
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput y_pump_hot
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-114,16},{-86,44}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Tempvalve_cold
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput cold
    "Connector of first Real input signal" annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={0,-100})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0.2)
    annotation (Placement(transformation(extent={{-48,-40},{-28,-20}})));
  Modelica.Blocks.Interfaces.RealInput y_pump_cold
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-114,-44},{-86,-16}})));
equation
  connect(hot, switch3.u1) annotation (Line(points={{1.77636e-015,100},{
          1.77636e-015,104},{0,104},{0,38},{18,38}}, color={0,0,127}));
  connect(greaterThreshold.y, switch3.u2)
    annotation (Line(points={{-27,30},{18,30}}, color={255,0,255}));
  connect(greaterThreshold.u, y_pump_hot)
    annotation (Line(points={{-50,30},{-100,30}}, color={0,0,127}));
  connect(realExpression4.y, switch3.u3) annotation (Line(points={{-27,-62},{8,
          -62},{8,22},{18,22}}, color={0,0,127}));
  connect(switch3.y, Tempvalve_Hot)
    annotation (Line(points={{41,30},{110,30}}, color={0,0,127}));
  connect(realExpression4.y, switch1.u3) annotation (Line(points={{-27,-62},{8,
          -62},{8,-38},{18,-38}}, color={0,0,127}));
  connect(switch1.y, Tempvalve_cold)
    annotation (Line(points={{41,-30},{110,-30}}, color={0,0,127}));
  connect(Tempvalve_cold, Tempvalve_cold)
    annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
  connect(switch1.u1, cold)
    annotation (Line(points={{18,-22},{0,-22},{0,-100}}, color={0,0,127}));
  connect(greaterThreshold1.u, y_pump_cold)
    annotation (Line(points={{-50,-30},{-100,-30}}, color={0,0,127}));
  connect(greaterThreshold1.y, switch1.u2) annotation (Line(points={{-27,-30},{
          -4,-30},{-4,-30},{18,-30}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RLT_Switch;
