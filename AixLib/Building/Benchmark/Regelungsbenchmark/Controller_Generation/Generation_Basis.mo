within AixLib.Building.Benchmark.Regelungsbenchmark.Controller_Generation;
model Generation_Basis
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-46,60},{-26,80}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=90)
    annotation (Placement(transformation(extent={{80,-54},{60,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=26)
    annotation (Placement(transformation(extent={{80,-66},{60,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=90)
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 60, uHigh=273.15
         + 80)
    annotation (Placement(transformation(extent={{-92,-16},{-80,-4}})));
  Modelica.Blocks.Logical.Change change1
    annotation (Placement(transformation(extent={{-46,-16},{-34,-4}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 70, uHigh=273.15
         + 90)
    annotation (Placement(transformation(extent={{-92,-56},{-80,-44}})));
  Modelica.Blocks.Logical.Change change2
    annotation (Placement(transformation(extent={{-46,-56},{-34,-44}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 8, uHigh=273.15
         + 10)
    annotation (Placement(transformation(extent={{-92,12},{-80,24}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=273.15 + 35, uHigh=273.15
         + 45)
    annotation (Placement(transformation(extent={{-92,28},{-80,40}})));
  Modelica.Blocks.Logical.Change change4
    annotation (Placement(transformation(extent={{-72,28},{-60,40}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis4(uLow=273.15 + 10, uHigh=273.15
         + 13)
    annotation (Placement(transformation(extent={{-92,52},{-80,64}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis5(uLow=273.15 + 30, uHigh=273.15
         + 40)
    annotation (Placement(transformation(extent={{-92,68},{-80,80}})));
  Modelica.Blocks.Logical.Change change6
    annotation (Placement(transformation(extent={{-72,68},{-60,80}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{12,60},{26,74}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.5)
            annotation (Placement(transformation(extent={{-10,68},{2,80}})));
equation
  connect(realExpression3.y, controlBus.ElSet_CHP) annotation (Line(points={{59,
          -56},{40,-56},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression2.y, controlBus.TSet_CHP) annotation (Line(points={{59,
          -44},{40,-44},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression4.y, controlBus.TSet_boiler) annotation (Line(points={{
          59,-10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(hysteresis.y, change1.u)
    annotation (Line(points={{-79.4,-10},{-47.2,-10}}, color={255,0,255}));
  connect(hysteresis.u, measureBus.HotWater_TTop) annotation (Line(points={{
          -93.2,-10},{-100,-10},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis1.y, change2.u)
    annotation (Line(points={{-79.4,-50},{-47.2,-50}}, color={255,0,255}));
  connect(hysteresis1.u, measureBus.HotWater_TTop) annotation (Line(points={{
          -93.2,-50},{-100,-50},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis3.y, change4.u) annotation (Line(points={{-79.4,34},{-76,34},
          {-76,34},{-74,34},{-74,34},{-73.2,34}}, color={255,0,255}));
  connect(hysteresis5.y, change6.u) annotation (Line(points={{-79.4,74},{-76,74},
          {-76,74},{-72,74},{-72,74},{-73.2,74}}, color={255,0,255}));
  connect(change4.y, or2.u1) annotation (Line(points={{-59.4,34},{-54,34},{-54,
          30},{-48,30}}, color={255,0,255}));
  connect(change6.y, or1.u1) annotation (Line(points={{-59.4,74},{-54,74},{-54,
          70},{-48,70}}, color={255,0,255}));
  connect(hysteresis5.u, measureBus.WarmWater_TTop) annotation (Line(points={{
          -93.2,74},{-100,74},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{
          -93.2,34},{-100,34},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis4.u, measureBus.ColdWater_TBottom) annotation (Line(points=
          {{-93.2,58},{-100,58},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis2.u, measureBus.ColdWater_TBottom) annotation (Line(points=
          {{-93.2,18},{-100,18},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis4.y, or1.u2) annotation (Line(points={{-79.4,58},{-54,58},{
          -54,62},{-48,62}}, color={255,0,255}));
  connect(hysteresis2.y, or2.u2) annotation (Line(points={{-79.4,18},{-54,18},{
          -54,22},{-48,22}}, color={255,0,255}));
  connect(change2.y, controlBus.OnOff_CHP) annotation (Line(points={{-33.4,-50},
          {0.1,-50},{0.1,-99.9}}, color={255,0,255}));
  connect(change1.y, controlBus.OnOff_boiler) annotation (Line(points={{-33.4,
          -10},{0.1,-10},{0.1,-99.9}}, color={255,0,255}));
  connect(or2.y, controlBus.OnOff_heatpump_small) annotation (Line(points={{-25,
          30},{0.1,30},{0.1,-99.9}}, color={255,0,255}));
  connect(or1.y, and1.u2) annotation (Line(points={{-25,70},{-18,70},{-18,61.4},
          {10.6,61.4}}, color={255,0,255}));
  connect(greaterThreshold.y, and1.u1) annotation (Line(points={{2.6,74},{6,74},
          {6,67},{10.6,67}}, color={255,0,255}));
  connect(greaterThreshold.u, measureBus.heatpump_cold_massflow) annotation (
      Line(points={{-11.2,74},{-20,74},{-20,86},{0.1,86},{0.1,100.1}}, color={0,
          0,127}));
  connect(and1.y, controlBus.OnOff_heatpump_big) annotation (Line(points={{26.7,
          67},{36,67},{36,40},{0.1,40},{0.1,-99.9}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_Basis;
