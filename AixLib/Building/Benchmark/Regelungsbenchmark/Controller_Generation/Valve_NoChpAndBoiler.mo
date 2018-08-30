within AixLib.Building.Benchmark.Regelungsbenchmark.Controller_Generation;
model Valve_NoChpAndBoiler
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.Switch Hot_Boiler
    annotation (Placement(transformation(extent={{-12,24},{0,36}})));
  Modelica.Blocks.Logical.Switch Cold_Aircooler
    annotation (Placement(transformation(extent={{-12,-16},{0,-4}})));
  Modelica.Blocks.Logical.Switch Hot_Storage
    annotation (Placement(transformation(extent={{-12,4},{0,16}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=false)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=true)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=true)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Logical.Switch Aircooler
    annotation (Placement(transformation(extent={{-12,-76},{0,-64}})));
  Modelica.Blocks.Continuous.LimPID Warm_Aircooler(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=0.01,
    Ti=200)  annotation (Placement(transformation(extent={{-12,70},{0,82}})));
  Modelica.Blocks.Continuous.LimPID Cold_Storage(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=0.01,
    Ti=200) annotation (Placement(transformation(extent={{-12,-36},{0,-24}})));
  Modelica.Blocks.Continuous.LimPID Cold_Geothermal(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=0,
    yMin=-1,
    k=0.1,
    Ti=20)   annotation (Placement(transformation(extent={{-12,-56},{0,-44}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 2.3)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 47)
    annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 3)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{16,-54},{24,-46}})));
  Modelica.Blocks.Continuous.LimPID Warm_Aircooler1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=200,
    yMax=0,
    yMin=-1) annotation (Placement(transformation(extent={{6,58},{18,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 5)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{24,60},{32,68}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{50,62},{62,74}})));
  Modelica.Blocks.Continuous.LimPID Warm_Aircooler2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=200,
    yMax=1,
    yMin=0)  annotation (Placement(transformation(extent={{-18,44},{-6,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=273.15 + 50)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
equation
  connect(booleanExpression.y, Cold_Aircooler.u2)
    annotation (Line(points={{-39,-10},{-13.2,-10}}, color={255,0,255}));
  connect(booleanExpression2.y, Hot_Storage.u2)
    annotation (Line(points={{-39,10},{-13.2,10}}, color={255,0,255}));
  connect(booleanExpression3.y, Hot_Boiler.u2)
    annotation (Line(points={{-39,30},{-13.2,30}}, color={255,0,255}));
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
  connect(Cold_Aircooler.y, controlBus.Valve3) annotation (Line(points={{0.6,
          -10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Hot_Storage.y, controlBus.Valve7) annotation (Line(points={{0.6,10},{
          40,10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Hot_Boiler.y, controlBus.Valve6) annotation (Line(points={{0.6,30},{
          40,30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(booleanExpression4.y, Aircooler.u2)
    annotation (Line(points={{-39,-70},{-13.2,-70}}, color={255,0,255}));
  connect(Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,-74.8},
          {-28,-74.8},{-28,96},{-79,96}}, color={0,0,127}));
  connect(Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
          -65.2},{-34,-65.2},{-34,-96},{-79,-96}}, color={0,0,127}));
  connect(Aircooler.y, controlBus.Valve8) annotation (Line(points={{0.6,-70},{
          40,-70},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression3.y, Warm_Aircooler.u_s)
    annotation (Line(points={{-79,76},{-13.2,76}}, color={0,0,127}));
  connect(realExpression2.y, Cold_Geothermal.u_s)
    annotation (Line(points={{-79,-50},{-13.2,-50}}, color={0,0,127}));
  connect(realExpression4.y, Cold_Storage.u_s)
    annotation (Line(points={{-79,-30},{-13.2,-30}}, color={0,0,127}));
  connect(Cold_Geothermal.u_m, measureBus.Heatpump_cold_small_out) annotation (
      Line(points={{-6,-57.2},{-6,-60},{-72,-60},{-72,86},{0.1,86},{0.1,100.1}},
        color={0,0,127}));
  connect(Cold_Storage.u_m, measureBus.ColdWater_TBottom) annotation (Line(
        points={{-6,-37.2},{-6,-40},{-72,-40},{-72,86},{0.1,86},{0.1,100.1}},
        color={0,0,127}));
  connect(Warm_Aircooler.u_m, measureBus.WarmWater_TTop) annotation (Line(
        points={{-6,68.8},{-6,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
        color={0,0,127}));
  connect(Cold_Storage.y, controlBus.Valve2) annotation (Line(points={{0.6,-30},
          {40,-30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Cold_Geothermal.y, gain2.u)
    annotation (Line(points={{0.6,-50},{15.2,-50}}, color={0,0,127}));
  connect(gain2.y, controlBus.Valve1) annotation (Line(points={{24.4,-50},{40,
          -50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression5.y, Warm_Aircooler1.u_s) annotation (Line(points={{-79,
          60},{-76,60},{-76,64},{4.8,64}}, color={0,0,127}));
  connect(Warm_Aircooler1.y, gain1.u)
    annotation (Line(points={{18.6,64},{23.2,64}}, color={0,0,127}));
  connect(gain1.y, min.u2) annotation (Line(points={{32.4,64},{40,64},{40,64.4},
          {48.8,64.4}}, color={0,0,127}));
  connect(Warm_Aircooler.y, min.u1) annotation (Line(points={{0.6,76},{26,76},{
          26,71.6},{48.8,71.6}}, color={0,0,127}));
  connect(min.y, controlBus.Valve4) annotation (Line(points={{62.6,68},{70,68},
          {70,54},{40,54},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression6.y, Warm_Aircooler2.u_s) annotation (Line(points={{-79,
          44},{-56,44},{-56,50},{-19.2,50}}, color={0,0,127}));
  connect(Warm_Aircooler2.u_m, measureBus.HotWater_TTop) annotation (Line(
        points={{-12,42.8},{-12,38},{-72,38},{-72,86},{0.1,86},{0.1,100.1}},
        color={0,0,127}));
  connect(Warm_Aircooler2.y, controlBus.Valve5) annotation (Line(points={{-5.4,
          50},{18,50},{18,40},{40,40},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Warm_Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{
          12,56.8},{12,52},{0,52},{0,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Valve_NoChpAndBoiler;
