within AixLib.Building.Benchmark.Regelungsbenchmark.Controller_Generation;
model Generation_VariablePowerCost
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-42,60},{-22,80}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-36,-14},{-24,-2}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 90)
    annotation (Placement(transformation(extent={{80,-54},{60,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=26)
    annotation (Placement(transformation(extent={{80,-66},{60,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 90)
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=true,
    uLow=273.15 + 45,
    uHigh=273.15 + 65)
    annotation (Placement(transformation(extent={{-92,-50},{-80,-38}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(
    pre_y_start=true,
    uHigh=273.15 + 70,
    uLow=273.15 + 55)
    annotation (Placement(transformation(extent={{-92,-90},{-80,-78}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 3.5, uHigh=
        273.15 + 6)
    annotation (Placement(transformation(extent={{-92,-22},{-80,-10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=273.15 + 35, uHigh=273.15
         + 45)
    annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis4(uLow=273.15 + 5, uHigh=273.15
         + 9)
    annotation (Placement(transformation(extent={{-92,52},{-80,64}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis5(uLow=273.15 + 30, uHigh=273.15
         + 40)
    annotation (Placement(transformation(extent={{-92,68},{-80,80}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{12,60},{26,74}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.5)
            annotation (Placement(transformation(extent={{-10,68},{2,80}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-50,-50},{-38,-38}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-50,-90},{-38,-78}})));
  Modelica.Blocks.Logical.Not not3
    annotation (Placement(transformation(extent={{-70,-6},{-58,6}})));
  Modelica.Blocks.Logical.Not not4
    annotation (Placement(transformation(extent={{-74,68},{-62,80}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{-16,-14},{-4,-2}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis6(uLow=273.15 + 1, uHigh=273.15
         + 4)
    annotation (Placement(transformation(extent={{-76,-34},{-64,-22}})));
  Modelica.Blocks.Logical.Not not5
    annotation (Placement(transformation(extent={{-54,-34},{-42,-22}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       22) annotation (Placement(transformation(extent={{-148,58},{-160,70}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=6)
    annotation (Placement(transformation(extent={{-148,40},{-160,52}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-116,20},{-136,40}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-56,32},{-42,46}})));
  Modelica.Blocks.Logical.And and4
    annotation (Placement(transformation(extent={{-48,12},{-34,26}})));
  Modelica.Blocks.Logical.Or or4
    annotation (Placement(transformation(extent={{-90,18},{-78,30}})));
equation
  connect(realExpression3.y, controlBus.ElSet_CHP) annotation (Line(points={{59,
          -56},{40,-56},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression2.y, controlBus.TSet_CHP) annotation (Line(points={{59,
          -44},{40,-44},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression4.y, controlBus.TSet_boiler) annotation (Line(points={{
          59,-10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(hysteresis.u, measureBus.HotWater_TTop) annotation (Line(points={{-93.2,
          -44},{-100,-44},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                 color={0,0,127}));
  connect(hysteresis1.u, measureBus.HotWater_TTop) annotation (Line(points={{-93.2,
          -84},{-100,-84},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                 color={0,0,127}));
  connect(hysteresis5.u, measureBus.WarmWater_TTop) annotation (Line(points={{
          -93.2,74},{-100,74},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{-93.2,0},
          {-100,0},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                               color={0,0,127}));
  connect(hysteresis4.u, measureBus.ColdWater_TBottom) annotation (Line(points=
          {{-93.2,58},{-100,58},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis2.u, measureBus.ColdWater_TBottom) annotation (Line(points={{-93.2,
          -16},{-100,-16},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                 color={0,0,127}));
  connect(hysteresis4.y, or1.u2) annotation (Line(points={{-79.4,58},{-54,58},{
          -54,62},{-44,62}}, color={255,0,255}));
  connect(hysteresis2.y, or2.u2) annotation (Line(points={{-79.4,-16},{-44,-16},
          {-44,-12.8},{-37.2,-12.8}},
                             color={255,0,255}));
  connect(or1.y, and1.u2) annotation (Line(points={{-21,70},{-18,70},{-18,61.4},
          {10.6,61.4}}, color={255,0,255}));
  connect(greaterThreshold.y, and1.u1) annotation (Line(points={{2.6,74},{6,74},
          {6,67},{10.6,67}}, color={255,0,255}));
  connect(greaterThreshold.u, measureBus.heatpump_cold_massflow) annotation (
      Line(points={{-11.2,74},{-20,74},{-20,86},{0.1,86},{0.1,100.1}}, color={0,
          0,127}));
  connect(hysteresis.y, not1.u)
    annotation (Line(points={{-79.4,-44},{-51.2,-44}}, color={255,0,255}));
  connect(hysteresis1.y, not2.u)
    annotation (Line(points={{-79.4,-84},{-51.2,-84}}, color={255,0,255}));
  connect(hysteresis5.y, not4.u)
    annotation (Line(points={{-79.4,74},{-75.2,74}}, color={255,0,255}));
  connect(hysteresis3.y, not3.u)
    annotation (Line(points={{-79.4,0},{-71.2,0}},   color={255,0,255}));
  connect(not1.y, controlBus.OnOff_boiler) annotation (Line(points={{-37.4,-44},
          {0.1,-44},{0.1,-99.9}}, color={255,0,255}));
  connect(not2.y, controlBus.OnOff_CHP) annotation (Line(points={{-37.4,-84},{
          0.1,-84},{0.1,-99.9}}, color={255,0,255}));
  connect(or2.y, or3.u1)
    annotation (Line(points={{-23.4,-8},{-17.2,-8}}, color={255,0,255}));
  connect(hysteresis6.y, not5.u)
    annotation (Line(points={{-63.4,-28},{-55.2,-28}},
                                                   color={255,0,255}));
  connect(not5.y, or3.u2) annotation (Line(points={{-41.4,-28},{-22,-28},{-22,
          -12.8},{-17.2,-12.8}},
                         color={255,0,255}));
  connect(integerToReal.u, measureBus.Hour) annotation (Line(points={{-114,30},
          {-100,30},{-100,86},{0.1,86},{0.1,100.1}}, color={255,127,0}));
  connect(integerToReal.y, greaterEqualThreshold.u) annotation (Line(points={{
          -137,30},{-140,30},{-140,64},{-146.8,64}}, color={0,0,127}));
  connect(lessEqualThreshold.u, greaterEqualThreshold.u) annotation (Line(
        points={{-146.8,46},{-140,46},{-140,64},{-146.8,64}}, color={0,0,127}));
  connect(not4.y, and2.u1) annotation (Line(points={{-61.4,74},{-60,74},{-60,39},
          {-57.4,39}}, color={255,0,255}));
  connect(and2.y, or1.u1) annotation (Line(points={{-41.3,39},{-40,39},{-40,54},
          {-50,54},{-50,70},{-44,70}}, color={255,0,255}));
  connect(not3.y, and4.u2) annotation (Line(points={{-57.4,0},{-52,0},{-52,13.4},
          {-49.4,13.4}}, color={255,0,255}));
  connect(and4.y, or2.u1) annotation (Line(points={{-33.3,19},{-30,19},{-30,2},
          {-42,2},{-42,-8},{-37.2,-8}}, color={255,0,255}));
  connect(and4.u1, and2.u2) annotation (Line(points={{-49.4,19},{-60,19},{-60,
          33.4},{-57.4,33.4}}, color={255,0,255}));
  connect(lessEqualThreshold.y, or4.u1) annotation (Line(points={{-160.6,46},{
          -168,46},{-168,18},{-106,18},{-106,24},{-91.2,24}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, or4.u2) annotation (Line(points={{-160.6,64},
          {-168,64},{-168,18},{-106,18},{-106,19.2},{-91.2,19.2}}, color={255,0,
          255}));
  connect(or4.y, and2.u2) annotation (Line(points={{-77.4,24},{-60,24},{-60,
          33.4},{-57.4,33.4}}, color={255,0,255}));
  connect(hysteresis6.u, measureBus.Aircooler) annotation (Line(points={{-77.2,
          -28},{-100,-28},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(or3.y, controlBus.OnOff_heatpump_1) annotation (Line(points={{-3.4,-8},
          {0.1,-8},{0.1,-99.9}}, color={255,0,255}));
  connect(and1.y, controlBus.OnOff_heatpump_2) annotation (Line(points={{26.7,
          67},{32,67},{32,0},{0.1,0},{0.1,-99.9}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_VariablePowerCost;
