within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"
  extends BaseClasses.GeothermalHeatPumpBase;
  Modelica.Blocks.Sources.Constant zero(k=0.001)
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Sources.Constant one(k=0.999)
    annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Sources.BooleanConstant trueSource
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Sources.BooleanConstant falseSource(k=false)
    annotation (Placement(transformation(extent={{-80,-120},{-60,-100}})));
  Sources.Boundary_pT coldConsumerFlow(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,-20})));
  Sources.Boundary_pT heatConsumerFlow(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={156,-50})));
  Sources.Boundary_pT heatConsumerReturn(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,-106})));
  Sources.Boundary_pT coldConsumerReturn(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,32})));
  Modelica.Blocks.Sources.Constant pressureDifference(k=20000) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,10})));
  Modelica.Blocks.Sources.Constant ambientTemperature(k=273.15 + 10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-80})));
  BoilerCHP.Boiler                   boiler(                                redeclare
      package Medium =
        Medium,                                                               m_flow_nominal=0.5,
    paramBoiler=DataBase.Boiler.General.Boiler_Virtual_1kW(),
    paramHC=DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10
        ())
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={122,-50})));
equation
  connect(trueSource.y, heatPumpTab.OnOff) annotation (Line(points={{-99,-30},{
          -88,-30},{-88,24},{-22,24},{-22,16.6}}, color={255,0,255}));
  connect(zero.y, valveHeatSource.opening) annotation (Line(points={{-99,50},{
          -82,50},{-82,1},{-65.6,1}}, color={0,0,127}));
  connect(one.y, valveColdStorage.opening) annotation (Line(points={{-99,-90},{
          -94,-90},{-94,58},{-52,58},{-52,43.6}}, color={0,0,127}));
  connect(zero.y, valveColdSource.opening) annotation (Line(points={{-99,50},{
          -82,50},{-82,1},{-72,1},{-72,-39},{-30,-39},{-30,-48.4}}, color={0,0,
          127}));
  connect(one.y, valveHeatStorage.opening) annotation (Line(points={{-99,-90},{
          -44,-90},{-44,-63},{-23.6,-63}}, color={0,0,127}));
  connect(falseSource.y, pumpGeothermalField.IsNight) annotation (Line(points={
          {-59,-110},{-52,-110},{-52,-44},{-85,-44},{-85,-48.91}}, color={255,0,
          255}));
  connect(falseSource.y, boiler.switchToNightMode) annotation (Line(points={{
          -59,-110},{-59,-110},{102,-110},{102,-46},{115,-46}}, color={255,0,
          255}));
  connect(orifice1.port_b, coldConsumerFlow.ports[1]) annotation (Line(points={
          {94,-20},{122,-20},{148,-20}}, color={0,127,255}));
  connect(boiler.port_b, heatConsumerFlow.ports[1]) annotation (Line(points={{
          132,-50},{132,-50},{150,-50}}, color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points
        ={{99,10},{84,10},{64.86,10},{64.86,-11.6}}, color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points
        ={{99,10},{80,10},{56,10},{56,-36},{62.86,-36},{62.86,-41.6}}, color={0,
          0,127}));
  connect(ambientTemperature.y, boiler.TAmbient) annotation (Line(points={{129,
          -80},{96,-80},{96,-43},{115,-43}}, color={0,0,127}));
  connect(orifice4.port_b, boiler.port_a)
    annotation (Line(points={{90,-50},{112,-50}}, color={0,127,255}));
  connect(trueSource.y, boiler.isOn) annotation (Line(points={{-99,-30},{-88,
          -30},{-88,-36},{6,-36},{6,-56},{52,-56},{52,-70},{127,-70},{127,-59}},
        color={255,0,255}));
  connect(orifice5.port_a, coldConsumerReturn.ports[1])
    annotation (Line(points={{94,32},{148,32}}, color={0,127,255}));
  connect(orifice6.port_a, heatConsumerReturn.ports[1]) annotation (Line(points
        ={{96,-106},{122,-106},{148,-106}}, color={0,127,255}));
  connect(pressureDifference.y, pumpEvaporator.dp_in) annotation (Line(points={
          {99,10},{82,10},{64,10},{64,54},{7.14,54},{7.14,46.4}}, color={0,0,
          127}));
  connect(pressureDifference.y, pumpCondenser.dp_in) annotation (Line(points={{
          99,10},{56,10},{56,-36},{-0.86,-36},{-0.86,-89.6}}, color={0,0,127}));
  annotation (experiment(StopTime=1000, Interval=10));
end GeothermalHeatPump;
