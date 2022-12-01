within AixLib.Fluid.Pool.Examples;
model IndoorSwimmingPoolExternalHeatingSystem
    extends Modelica.Icons.Example;
  Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater
    "Flow rate of added fresh water to the pool and water treatment system"
    annotation (Placement(transformation(extent={{98,-100},{126,-72}}),
        iconTransformation(extent={{98,-100},{126,-72}})));
  .AixLib.Fluid.Pool.IndoorSwimmingPool indoorSwimming(poolParam=
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(
        use_idealHeater=false), redeclare package WaterMedium = WaterMedium)
    annotation (Placement(transformation(extent={{-60,-36},{8,38}})));

    replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.RealExpression TSoil(y=273.15 + 8)
    annotation (Placement(transformation(extent={{74,80},{58,96}})));
  Modelica.Blocks.Sources.RealExpression X_W(y=14.3/1000)
    annotation (Placement(transformation(extent={{-86,54},{-70,70}})));
  Modelica.Blocks.Sources.RealExpression T_Air(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-86,72},{-70,88}})));
  Modelica.Blocks.Sources.Pulse Opening(
    amplitude=1,
    width=(13/15)*100,
    period=(24 - 7)*3600,
    offset=0,
    startTime=3600*7)
    annotation (Placement(transformation(extent={{-94,-44},{-80,-30}})));
  Modelica.Blocks.Sources.Trapezoid Person(
    amplitude=0.5,
    rising=7*3600,
    width=1*3600,
    falling=7*3600,
    period=17*3600,
    offset=0.3,
    startTime=7*3600)
    annotation (Placement(transformation(extent={{-94,-8},{-80,6}})));
  Modelica.Blocks.Interfaces.RealOutput QEvap annotation (Placement(
        transformation(extent={{-86,16},{-118,48}}), iconTransformation(extent={
            {-86,16},{-118,48}})));
  Modelica.Blocks.Interfaces.RealOutput PPool
    "Output eletric energy needed for pool operation" annotation (Placement(
        transformation(extent={{98,-78},{124,-52}}),iconTransformation(extent={{98,-78},
            {124,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
  Modelica.Blocks.Interfaces.RealOutput TPool "Value of Real output"
    annotation (Placement(transformation(extent={{98,58},{122,82}}),
        iconTransformation(extent={{98,58},{122,82}})));
  Controls.Continuous.LimPID        PI(
    k=1000,
    yMax=10000000,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1)                                                                                                                                                                                                         annotation(Placement(transformation(extent={{-8,-8},
            {8,8}},
        rotation=180,
        origin={62,6})));
  Modelica.Blocks.Sources.RealExpression SetTemperature(y=273.15 + 28)
    annotation (Placement(transformation(extent={{98,20},{80,36}})));
  Modelica.Blocks.Interfaces.RealOutput y1
               "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{98,-32},{122,-8}}),
        iconTransformation(extent={{98,-32},{122,-8}})));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=indoorSwimming.m_flow_nominal,
    V=2,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={32,-14})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,-50},{42,-30}})));
equation
  connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{57.2,88},{18,
          88},{18,18.39},{9.02,18.39}},  color={0,0,127}));
  connect(indoorSwimming.X_w, X_W.y) annotation (Line(points={{-35.86,39.11},{
          -34,39.11},{-34,50},{-64,50},{-64,62},{-69.2,62}},
                                       color={0,0,127}));
  connect(indoorSwimming.TAir, T_Air.y) annotation (Line(points={{-48.78,39.11},
          {-48.78,80},{-69.2,80}}, color={0,0,127}));
  connect(Opening.y, indoorSwimming.openingHours) annotation (Line(points={{-79.3,
          -37},{-70,-37},{-70,-20.46},{-62.04,-20.46}}, color={0,0,127}));
  connect(Person.y, indoorSwimming.persons) annotation (Line(points={{-79.3,-1},
          {-70,-1},{-70,-8.25},{-61.7,-8.25}}, color={0,0,127}));
  connect(indoorSwimming.QEvap, QEvap) annotation (Line(points={{-61.36,21.72},
          {-61.36,20},{-80,20},{-80,32},{-102,32}},color={0,0,127}));
  connect(indoorSwimming.PPool, PPool) annotation (Line(points={{10.72,-27.12},
          {10.72,-26},{18,-26},{18,-65},{111,-65}},            color={0,0,127}));
  connect(indoorSwimming.MFlowFreshWater, MFlowFreshWater) annotation (Line(
        points={{10.72,-33.04},{10.72,-86},{112,-86}}, color={0,0,127}));
  connect(prescribedTemperature.T, T_Air.y)
    annotation (Line(points={{-17.2,80},{-69.2,80}}, color={0,0,127}));
  connect(prescribedTemperature.port, indoorSwimming.convPoolSurface)
    annotation (Line(points={{-4,80},{-0.84,80},{-0.84,39.48}}, color={191,0,0}));
  connect(indoorSwimming.TPool, TPool) annotation (Line(points={{10.72,6.92},{
          32,6.92},{32,70},{110,70}}, color={0,0,127}));
  connect(MFlowFreshWater, MFlowFreshWater)
    annotation (Line(points={{112,-86},{112,-86}}, color={0,0,127}));
  connect(PI.u_s, SetTemperature.y) annotation (Line(points={{71.6,6},{76,6},{
          76,28},{79.1,28}}, color={0,0,127}));
  connect(indoorSwimming.TPool, PI.u_m) annotation (Line(points={{10.72,6.92},{
          32,6.92},{32,20},{62,20},{62,15.6}}, color={0,0,127}));
  connect(PI.y, y1) annotation (Line(points={{53.2,6},{48,6},{48,-20},{110,-20}},
        color={0,0,127}));
  connect(vol.ports[1], indoorSwimming.toPool) annotation (Line(points={{22,-15},
          {22,-10.1},{8,-10.1}}, color={0,127,255}));
  connect(vol.ports[2], indoorSwimming.fromPool) annotation (Line(points={{22,
          -13},{22,-18.98},{8,-18.98}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, vol.heatPort)
    annotation (Line(points={{42,-40},{32,-40},{32,-24}}, color={191,0,0}));
  connect(PI.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{53.2,6},{
          48,6},{48,-20},{78,-20},{78,-40},{62,-40}}, color={0,0,127}));
  connect(TPool, TPool)
    annotation (Line(points={{110,70},{110,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
end IndoorSwimmingPoolExternalHeatingSystem;
