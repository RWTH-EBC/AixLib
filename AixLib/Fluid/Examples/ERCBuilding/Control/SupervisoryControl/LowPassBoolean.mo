within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model LowPassBoolean

  parameter Real delayTime_off = 120;
  parameter Real delayTime_on = 120;

  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-78,-28},{-58,-8}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
        delayTime_off)
    annotation (Placement(transformation(extent={{-28,-28},{-8,-8}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-99,-18})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch1
    annotation (Placement(transformation(extent={{14,-28},{34,-8}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch2
    annotation (Placement(transformation(extent={{14,6},{34,26}})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{-78,2},{-58,22}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=
        delayTime_on)
    annotation (Placement(transformation(extent={{-28,6},{-8,26}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{192,-10},{212,10}})));
  Modelica.Blocks.Logical.Pre pre3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-100})));
  Modelica.Blocks.Logical.Pre pre4 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,80})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Continuous.Filter filter(            normalized=false, f_cut=1/
        35)
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK12P2(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-160})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK12P1(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-160})));
  Modelica.Blocks.Logical.FallingEdge fallingEdge annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-46,-36})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-86})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={38,-60})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=180)
    annotation (Placement(transformation(extent={{62,-70},{82,-50}})));
  Modelica.Blocks.Math.Gain gain(k=10) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={0,-114})));
  Modelica.Blocks.Math.Gain gain1(k=14) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-40,-114})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Modelica.Constants.inf, uMin=
       0.001) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-40,-135})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Modelica.Constants.inf,
      uMin=0.001) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={0,-135})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3(threshold=0.5)
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-72,-58})));
  Modelica.Blocks.Logical.Edge edge1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-42})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={142,-84})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold=0.5)
    annotation (Placement(transformation(extent={{152,-130},{172,-110}})));
equation
  connect(logicalSwitch.u3, logicalSwitch1.y) annotation (Line(points={{48,-8},
          {42,-8},{42,-18},{35,-18}},        color={255,0,255}));
  connect(greaterThreshold.y, logicalSwitch1.u2)
    annotation (Line(points={{-7,-18},{12,-18}}, color={255,0,255}));
  connect(logicalSwitch2.y, logicalSwitch.u1) annotation (Line(points={{35,16},
          {30,16},{36,16},{42,16},{42,8},{48,8}},
                                         color={255,0,255}));
  connect(greaterThreshold1.y, logicalSwitch2.u2) annotation (Line(points={{-7,16},
          {-7,16},{12,16}},           color={255,0,255}));
  connect(u, logicalSwitch2.u1) annotation (Line(points={{-140,0},{-118,0},{
          -118,34},{4,34},{4,24},{12,24}},    color={255,0,255}));
  connect(u, logicalSwitch1.u1) annotation (Line(points={{-140,0},{0,0},{0,
          -10},{12,-10}},                   color={255,0,255}));
  connect(u, logicalSwitch.u2) annotation (Line(points={{-140,0},{-118,0},{
          -118,0},{38,0},{38,0},{48,0}},    color={255,0,255}));
  connect(timer1.y, greaterThreshold.u) annotation (Line(points={{-57,12},{
          -40,12},{-40,-18},{-30,-18}}, color={0,0,127}));
  connect(timer.y, greaterThreshold1.u) annotation (Line(points={{-57,-18},{
          -44,-18},{-44,16},{-36,16},{-36,16},{-30,16}}, color={0,0,127}));
  connect(not1.y, timer.u) annotation (Line(points={{-89.1,-18},{-88,-18},{
          -80,-18}}, color={255,0,255}));
  connect(pre3.y, not1.u) annotation (Line(points={{59,-100},{-122,-100},{
          -122,-18},{-109.8,-18}}, color={255,0,255}));
  connect(pre4.y, timer1.u) annotation (Line(points={{59,80},{-104,80},{-104,
          12},{-80,12}}, color={255,0,255}));
  connect(pre3.y, logicalSwitch1.u3) annotation (Line(points={{59,-100},{59,
          -100},{0,-100},{0,-26},{12,-26}}, color={255,0,255}));
  connect(pre4.y, logicalSwitch2.u3) annotation (Line(points={{59,80},{0,80},
          {0,8},{12,8}}, color={255,0,255}));
  connect(logicalSwitch.y, booleanToReal.u)
    annotation (Line(points={{71,0},{71,0},{78,0}}, color={255,0,255}));
  connect(booleanToReal.y, filter.u)
    annotation (Line(points={{101,0},{101,0},{108,0}}, color={0,0,127}));
  connect(booleanToReal1.y, fixedDelay.u)
    annotation (Line(points={{49,-60},{54,-60},{60,-60}}, color={0,0,127}));
  connect(fixedDelay.y, switch1.u1) annotation (Line(points={{83,-60},{102,
          -60},{102,-80},{10,-80},{10,-70},{-12,-70},{-12,-74}}, color={0,0,
          127}));
  connect(booleanToReal1.y, switch1.u3) annotation (Line(points={{49,-60},{56,
          -60},{56,-38},{-28,-38},{-28,-70},{-28,-74}},           color={0,0,
          127}));
  connect(gain1.y, limiter.u) annotation (Line(points={{-40,-120.6},{-40,
          -120.6},{-40,-126.6}}, color={0,0,127}));
  connect(limiter.y, massFlowHK12P1) annotation (Line(points={{-40,-142.7},{
          -40,-142.7},{-40,-160}}, color={0,0,127}));
  connect(gain.y, limiter1.u) annotation (Line(points={{-1.22125e-015,-120.6},
          {0,-120.6},{0,-126.6}}, color={0,0,127}));
  connect(limiter1.y, massFlowHK12P2) annotation (Line(points={{0,-142.7},{0,
          -160},{0,-160}}, color={0,0,127}));
  connect(switch1.y, gain1.u) annotation (Line(points={{-20,-97},{-20,-102},{
          -40,-102},{-40,-106.8}}, color={0,0,127}));
  connect(switch1.y, gain.u) annotation (Line(points={{-20,-97},{-20,-97},{
          -20,-102},{0,-102},{0,-106.8}}, color={0,0,127}));
  connect(greaterThreshold3.y, pre4.u) annotation (Line(points={{161,0},{174,
          0},{186,0},{186,80},{82,80}}, color={255,0,255}));
  connect(greaterThreshold3.y, pre3.u) annotation (Line(points={{161,0},{174,
          0},{186,0},{186,-100},{82,-100}}, color={255,0,255}));
  connect(fallingEdge.y, rSFlipFlop.S) annotation (Line(points={{-57,-36},{
          -62,-36},{-66,-36},{-66,-46}}, color={255,0,255}));
  connect(edge1.y, rSFlipFlop.R) annotation (Line(points={{-89,-42},{-78,-42},
          {-78,-46}}, color={255,0,255}));
  connect(rSFlipFlop.Q, switch1.u2) annotation (Line(points={{-66,-69},{-66,
          -69},{-66,-80},{-44,-80},{-44,-60},{-20,-60},{-20,-74}}, color={255,
          0,255}));
  connect(filter.y, greaterThreshold3.u)
    annotation (Line(points={{131,0},{134,0},{138,0}}, color={0,0,127}));
  connect(fixedDelay.y, switch2.u3) annotation (Line(points={{83,-60},{104,
          -60},{134,-60},{134,-72}}, color={0,0,127}));
  connect(booleanToReal1.y, switch2.u1) annotation (Line(points={{49,-60},{54,
          -60},{56,-60},{56,-38},{122,-38},{150,-38},{150,-72}}, color={0,0,
          127}));
  connect(rSFlipFlop.Q, switch2.u2) annotation (Line(points={{-66,-69},{-66,
          -69},{-66,-80},{-44,-80},{-44,-60},{14,-60},{14,-78},{118,-78},{118,
          -56},{142,-56},{142,-72}}, color={255,0,255}));
  connect(greaterThreshold3.y, booleanToReal1.u) annotation (Line(points={{
          161,0},{172,0},{172,-36},{18,-36},{18,-60},{26,-60}}, color={255,0,
          255}));
  connect(greaterThreshold3.y, fallingEdge.u) annotation (Line(points={{161,0},
          {172,0},{172,-36},{-34,-36}}, color={255,0,255}));
  connect(greaterThreshold3.y, edge1.u) annotation (Line(points={{161,0},{172,
          0},{172,-36},{18,-36},{18,-56},{-52,-56},{-52,-86},{-118,-86},{-118,
          -42},{-112,-42}}, color={255,0,255}));
  connect(switch2.y, greaterThreshold2.u) annotation (Line(points={{142,-95},
          {142,-95},{142,-122},{142,-120},{150,-120}}, color={0,0,127}));
  connect(greaterThreshold2.y, y) annotation (Line(points={{173,-120},{190,
          -120},{190,0},{202,0}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-140,-160},{200,120}},
          preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-140,
            -160},{200,120}})));
end LowPassBoolean;
