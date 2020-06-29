within AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp;
model TBA_Hysteresis
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 19, uHigh=273.15
         + 21)
    annotation (Placement(transformation(extent={{-40,-8},{-24,8}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
    annotation (Placement(transformation(extent={{-44,-48},{-24,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
    annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));
  Modelica.Blocks.Interfaces.RealInput RoomTemp
    annotation (Placement(transformation(extent={{-114,-14},{-86,14}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Interfaces.RealOutput WarmCold
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Tempvalve
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
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Interfaces.RealInput y_pump
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-114,-54},{-86,-26}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.2, uHigh=0.3)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=0.2, uHigh=0.3)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
equation
  connect(hysteresis.u, RoomTemp) annotation (Line(points={{-41.6,0},{-70,0},{
          -70,1.77636e-015},{-100,1.77636e-015}}, color={0,0,127}));
  connect(realExpression4.y, switch2.u1)
    annotation (Line(points={{-23,-22},{38,-22}}, color={0,0,127}));
  connect(realExpression5.y, switch2.u3)
    annotation (Line(points={{-23,-38},{38,-38}}, color={0,0,127}));
  connect(hysteresis.y, switch2.u2) annotation (Line(points={{-23.2,0},{-12,0},
          {-12,-30},{38,-30}}, color={255,0,255}));
  connect(switch2.y, WarmCold)
    annotation (Line(points={{61,-30},{110,-30}}, color={0,0,127}));
  connect(switch1.y, Tempvalve)
    annotation (Line(points={{61,30},{110,30}}, color={0,0,127}));
  connect(warm, switch3.u1) annotation (Line(points={{20,100},{20,74},{-8,74},{
          -8,58},{-2,58}}, color={0,0,127}));
  connect(switch3.u3, switch2.u1) annotation (Line(points={{-2,42},{-2,42},{-8,
          42},{-8,-22},{-4,-22},{-4,-22},{38,-22}}, color={0,0,127}));
  connect(switch3.y, switch1.u1) annotation (Line(points={{21,50},{30,50},{30,
          38},{38,38}}, color={0,0,127}));
  connect(switch1.u2, switch2.u2) annotation (Line(points={{38,30},{-12,30},{
          -12,-30},{38,-30}}, color={255,0,255}));
  connect(Cold, switch4.u1) annotation (Line(points={{20,-100},{20,-80},{-12,
          -80},{-12,-56},{-2,-56}}, color={0,0,127}));
  connect(switch4.u3, switch2.u1) annotation (Line(points={{-2,-72},{-8,-72},{
          -8,-22},{38,-22}}, color={0,0,127}));
  connect(switch4.y, switch1.u3) annotation (Line(points={{21,-64},{30,-64},{30,
          22},{38,22}}, color={0,0,127}));
  connect(hysteresis1.y, switch3.u2)
    annotation (Line(points={{-29,50},{-2,50}}, color={255,0,255}));
  connect(hysteresis2.y, switch4.u2) annotation (Line(points={{-29,-70},{-16,
          -70},{-16,-64},{-2,-64}}, color={255,0,255}));
  connect(hysteresis2.u, y_pump) annotation (Line(points={{-52,-70},{-72,-70},{
          -72,-40},{-100,-40}}, color={0,0,127}));
  connect(hysteresis1.u, y_pump) annotation (Line(points={{-52,50},{-72,50},{
          -72,-40},{-100,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TBA_Hysteresis;
