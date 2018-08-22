within AixLib.Building.Benchmark.Regelungsbenchmark.Controller_Generation;
model Valve_Basis
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.Blocks.Logical.Switch Warm_Aircooler
    annotation (Placement(transformation(extent={{-12,64},{0,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.Switch Warm_Storage
    annotation (Placement(transformation(extent={{-12,44},{0,56}})));
  Modelica.Blocks.Logical.Switch Hot_Boiler
    annotation (Placement(transformation(extent={{-12,24},{0,36}})));
  Modelica.Blocks.Logical.Switch Cold_Aircooler
    annotation (Placement(transformation(extent={{-12,-16},{0,-4}})));
  Modelica.Blocks.Logical.Switch Hot_Storage
    annotation (Placement(transformation(extent={{-12,4},{0,16}})));
  Modelica.Blocks.Logical.Switch Cold_Storage
    annotation (Placement(transformation(extent={{-12,-36},{0,-24}})));
  Modelica.Blocks.Logical.Switch Cold_Geothermalprobe
    annotation (Placement(transformation(extent={{-12,-56},{0,-44}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=true)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=true)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=true)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Logical.Switch Aircooler
    annotation (Placement(transformation(extent={{-12,-76},{0,-64}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 7, uHigh=273.15
         + 10)
    annotation (Placement(transformation(extent={{-72,-56},{-60,-44}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 7, uHigh=273.15
         + 10)
    annotation (Placement(transformation(extent={{-54,-36},{-42,-24}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-50,-56},{-38,-44}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=273.15 + 35, uHigh=273.15
         + 40)
    annotation (Placement(transformation(extent={{-54,64},{-42,76}})));
equation
  connect(booleanExpression.y, Cold_Aircooler.u2)
    annotation (Line(points={{-39,-10},{-13.2,-10}}, color={255,0,255}));
  connect(booleanExpression1.y, Warm_Storage.u2)
    annotation (Line(points={{-39,50},{-13.2,50}}, color={255,0,255}));
  connect(booleanExpression2.y, Hot_Storage.u2)
    annotation (Line(points={{-39,10},{-13.2,10}}, color={255,0,255}));
  connect(booleanExpression3.y, Hot_Boiler.u2)
    annotation (Line(points={{-39,30},{-13.2,30}}, color={255,0,255}));
  connect(Warm_Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
          74.8},{-34,74.8},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Warm_Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,
          65.2},{-28,65.2},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Cold_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,
          -34.8},{-28,-34.8},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Cold_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
          -25.2},{-34,-25.2},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Cold_Geothermalprobe.u1, realExpression1.y) annotation (Line(points={
          {-13.2,-45.2},{-34,-45.2},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Cold_Geothermalprobe.u3, realExpression.y) annotation (Line(points={{
          -13.2,-54.8},{-28,-54.8},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Warm_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
          54.8},{-34,54.8},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Warm_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,
          45.2},{-28,45.2},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Hot_Boiler.u1, realExpression1.y) annotation (Line(points={{-13.2,
          34.8},{-34,34.8},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Hot_Boiler.u3, realExpression.y) annotation (Line(points={{-13.2,25.2},
          {-28,25.2},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Hot_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
          14.8},{-34,14.8},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Hot_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,5.2},
          {-28,5.2},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Cold_Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
          -5.2},{-34,-5.2},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Cold_Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,
          -14.8},{-28,-14.8},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Cold_Geothermalprobe.y, controlBus.Valve1) annotation (Line(points={{
          0.6,-50},{40,-50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Cold_Storage.y, controlBus.Valve2) annotation (Line(points={{0.6,-30},
          {40,-30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Cold_Aircooler.y, controlBus.Valve3) annotation (Line(points={{0.6,
          -10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Hot_Storage.y, controlBus.Valve7) annotation (Line(points={{0.6,10},{
          40,10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Hot_Boiler.y, controlBus.Valve6) annotation (Line(points={{0.6,30},{
          40,30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Warm_Storage.y, controlBus.Valve5) annotation (Line(points={{0.6,50},
          {40,50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Warm_Aircooler.y, controlBus.Valve4) annotation (Line(points={{0.6,70},
          {40,70},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(booleanExpression4.y, Aircooler.u2)
    annotation (Line(points={{-39,-70},{-13.2,-70}}, color={255,0,255}));
  connect(Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,-74.8},
          {-28,-74.8},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
          -65.2},{-34,-65.2},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Aircooler.y, controlBus.Valve8) annotation (Line(points={{0.6,-70},{
          40,-70},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(hysteresis1.y, Cold_Storage.u2)
    annotation (Line(points={{-41.4,-30},{-13.2,-30}}, color={255,0,255}));
  connect(hysteresis2.y, not1.u)
    annotation (Line(points={{-59.4,-50},{-51.2,-50}}, color={255,0,255}));
  connect(not1.y, Cold_Geothermalprobe.u2)
    annotation (Line(points={{-37.4,-50},{-13.2,-50}}, color={255,0,255}));
  connect(hysteresis3.y, Warm_Aircooler.u2)
    annotation (Line(points={{-41.4,70},{-13.2,70}}, color={255,0,255}));
  connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{
          -55.2,70},{-70,70},{-70,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis1.u, measureBus.ColdWater_TBottom) annotation (Line(points=
          {{-55.2,-30},{-70,-30},{-70,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis2.u, measureBus.ColdWater_TBottom) annotation (Line(points=
          {{-73.2,-50},{-82,-50},{-82,-30},{-70,-30},{-70,86},{0.1,86},{0.1,
          100.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Valve_Basis;
