within AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans;
model Fan_Basis
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
        1; 6,1; 22,1])
    annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 30, uHigh=
        273.15 + 47)
    annotation (Placement(transformation(extent={{-74,54},{-54,74}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.5)
    annotation (Placement(transformation(extent={{-28,-60},{-8,-40}})));
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-26,48},{-6,68}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.01, uHigh=0.1)
    annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-58,30},{-38,50}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-28,0},{-8,20}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 20, uHigh=
        273.15 + 35)
    annotation (Placement(transformation(extent={{-76,6},{-56,26}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=0.3, uHigh=0.4)
    annotation (Placement(transformation(extent={{-94,-18},{-74,2}})));
  Modelica.Blocks.Continuous.LimPID Aircooler(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01,
    yMax=0,
    yMin=-1) annotation (Placement(transformation(extent={{44,52},{32,64}})));
  Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 35)
    annotation (Placement(transformation(extent={{74,48},{54,68}})));
  Modelica.Blocks.Continuous.LimPID Aircooler1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01,
    yMax=0,
    yMin=-1) annotation (Placement(transformation(extent={{44,4},{32,16}})));
  Modelica.Blocks.Sources.RealExpression Heatpump2(y=273.15 + 25)
    annotation (Placement(transformation(extent={{74,0},{54,20}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{20,52},{8,64}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{20,4},{8,16}})));
equation
  connect(integerToReal.u,measureBus. Hour) annotation (Line(points={{-92,-50},
          {-100,-50},{-100,80},{0.1,80},{0.1,100.1}}, color={255,127,0}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(integerToReal.y,combiTable1Ds1. u)
    annotation (Line(points={{-69,-50},{-60,-50}}, color={0,0,127}));
  connect(combiTable1Ds1.y[1],realToBoolean. u)
    annotation (Line(points={{-37,-50},{-30,-50}}, color={0,0,127}));
  connect(realToBoolean.y,controlBus. OnOff_RLT) annotation (Line(points={{-7,
          -50},{0.1,-50},{0.1,-99.9}}, color={255,0,255}));
  connect(hysteresis1.u, controlBus.Valve4) annotation (Line(points={{-94,40},
          {-100,40},{-100,-99.9},{0.1,-99.9}},color={0,0,127}));
  connect(hysteresis1.y, not1.u)
    annotation (Line(points={{-71,40},{-60,40}},
                                               color={255,0,255}));
  connect(not1.y, and1.u2) annotation (Line(points={{-37,40},{-28,40},{-28,50}},
                     color={255,0,255}));
  connect(hysteresis.y, and1.u1) annotation (Line(points={{-53,64},{-28,64},{
          -28,58}},                            color={255,0,255}));
  connect(hysteresis2.y, and2.u1) annotation (Line(points={{-55,16},{-44,16},
          {-44,10},{-30,10}}, color={255,0,255}));
  connect(not2.y, and2.u2) annotation (Line(points={{-39,-8},{-34,-8},{-34,2},
          {-30,2}}, color={255,0,255}));
  connect(hysteresis3.y, not2.u)
    annotation (Line(points={{-73,-8},{-62,-8}}, color={255,0,255}));
  connect(hysteresis3.u, controlBus.Valve4) annotation (Line(points={{-96,-8},
          {-100,-8},{-100,-100},{0.1,-99.9}}, color={0,0,127}));
  connect(and2.y, controlBus.OnOff_Aircooler_small) annotation (Line(points={
          {-7,10},{0.1,10},{0.1,-99.9}}, color={255,0,255}));
  connect(and1.y, controlBus.OnOff_Aircooler_big) annotation (Line(points={{
          -5,58},{0.1,58},{0.1,-99.9}}, color={255,0,255}));
  connect(Aircooler.u_s, Heatpump1.y)
    annotation (Line(points={{45.2,58},{53,58}}, color={0,0,127}));
  connect(Aircooler1.u_s, Heatpump2.y)
    annotation (Line(points={{45.2,10},{53,10}}, color={0,0,127}));
  connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{38,
          50.8},{38,42},{0.1,42},{0.1,100.1}}, color={0,0,127}));
  connect(Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{38,
          2.8},{38,-6},{0.1,-6},{0.1,100.1}}, color={0,0,127}));
  connect(Aircooler.y, gain.u)
    annotation (Line(points={{31.4,58},{21.2,58}}, color={0,0,127}));
  connect(gain.y, controlBus.Fan_Aircooler_big) annotation (Line(points={{7.4,
          58},{0.1,58},{0.1,-99.9}}, color={0,0,127}));
  connect(gain1.u, Aircooler1.y)
    annotation (Line(points={{21.2,10},{31.4,10}}, color={0,0,127}));
  connect(gain1.y, controlBus.Fan_Aircooler_small) annotation (Line(points={{
          7.4,10},{0.1,10},{0.1,-99.9}}, color={0,0,127}));
  connect(hysteresis.u, measureBus.Aircooler_in) annotation (Line(points={{
          -76,64},{-100,64},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
  connect(hysteresis2.u, measureBus.Aircooler_in) annotation (Line(points={{
          -78,16},{-100,16},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Fan_Basis;
