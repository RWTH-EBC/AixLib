within AixLib.Fluid.Pool.Examples;
model IndoorSwimmingPoolAddMoistureToVolume
    extends Modelica.Icons.Example;

  package AirMedium = AixLib.Media.Air annotation (choicesAllMatching=true);
  package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);
  parameter Integer nPools = 2 "Number of Pools";

  AixLib.Fluid.Pool.IndoorSwimmingPool indoorSwimming[nPools](poolParam={
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.ChildrensPool()},
      redeclare package WaterMedium = WaterMedium)
    annotation (Placement(transformation(extent={{-14,-72},{36,-16}})));

  Modelica.Blocks.Sources.Pulse timeOpe[nPools](
    each amplitude=1,
    each width=(13/15)*100,
    each period=(24 - 7)*3600,
    each offset=0,
    each startTime=3600*7)
    annotation (Placement(transformation(extent={{-92,-92},{-78,-78}})));
  Modelica.Blocks.Sources.Trapezoid uRelPer[nPools](
    each amplitude=0.5,
    each rising=7*3600,
    each width=1*3600,
    each falling=7*3600,
    each period=17*3600,
    each offset=0.3,
    each startTime=7*3600)
    annotation (Placement(transformation(extent={{-92,-60},{-78,-46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature[nPools]
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={56,20})));
  MixingVolumes.MixingVolumeMoistAir PoolHall(
    redeclare package Medium = AirMedium,
    T_start=303.15,
    V=7500,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=1,
    nPorts=2) "Volume"
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Sources.RealExpression MassFlowOut(y=0.0143)
    annotation (Placement(transformation(extent={{-114,52},{-96,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow idealHeater1
    annotation (Placement(transformation(extent={{0,76},{-16,92}})));
  Controls.Continuous.LimPID conPID(
    Ti=0.01,
    yMax=0,
    yMin=-150*1000)
    annotation (Placement(transformation(extent={{40,80},{22,98}})));
  Modelica.Blocks.Sources.RealExpression TSetAir(y=273.15 + 30)
    annotation (Placement(transformation(extent={{82,86},{66,102}})));
  Modelica.Blocks.Sources.RealExpression TMeaAir(y=PoolHall.T)
    annotation (Placement(transformation(extent={{82,66},{66,82}})));
  Controls.Continuous.LimPID conPID1(
    k=0.0001,
    Ti=0.01,
    yMax=0.1,
    yMin=-0.1)
    annotation (Placement(transformation(extent={{-88,54},{-74,68}})));
  Modelica.Blocks.Sources.RealExpression TSoil[nPools](each y=273.15 + 8)
    annotation (Placement(transformation(extent={{86,-50},{70,-34}})));
  BaseClasses.AirFlowMoistureToROM airFlowMoistureToROM(
    redeclare package AirMedium = AirMedium,
    nPools=2,
    m_flow_air_nominal=1,
    VAirLay=10000)
    annotation (Placement(transformation(extent={{-54,-14},{-34,6}})));
  Sources.Boundary_pT bou(redeclare package Medium = AirMedium, nPorts=1)
    annotation (Placement(transformation(extent={{-96,-22},{-82,-8}})));
equation
  connect(timeOpe.y, indoorSwimming.timeOpe) annotation (Line(points={{-77.3,-85},
          {-26,-85},{-26,-60.24},{-15.5,-60.24}},      color={0,0,127}));
  connect(uRelPer.y, indoorSwimming.uRelPer) annotation (Line(points={{-77.3,-53},
          {-26,-53},{-26,-51.56},{-15.75,-51.56}},
                                                 color={0,0,127}));
  connect(prescribedTemperature.port, indoorSwimming.convPool) annotation (Line(
        points={{56,14},{56,-8},{29.5,-8},{29.5,-14.88}},
                                                 color={191,0,0}));
  connect(idealHeater1.port,PoolHall. heatPort) annotation (Line(points={{-16,84},
          {-62,84},{-62,50},{-50,50}}, color={191,0,0}));
  connect(idealHeater1.Q_flow,conPID. y) annotation (Line(points={{0,84},{6,84},
          {6,89},{21.1,89}},  color={0,0,127}));
  connect(conPID.u_s,TSetAir. y) annotation (Line(points={{41.8,89},{60,89},{60,
          94},{65.2,94}}, color={0,0,127}));
  connect(TMeaAir.y,conPID. u_m)
    annotation (Line(points={{65.2,74},{31,74},{31,78.2}}, color={0,0,127}));
  connect(PoolHall.mWat_flow,conPID1. y) annotation (Line(points={{-52,58},{-63.55,
          58},{-63.55,61},{-73.3,61}}, color={0,0,127}));
  connect(PoolHall.X_w,conPID1. u_m) annotation (Line(points={{-28,46},{-20,46},
          {-20,34},{-81,34},{-81,52.6}},
                                       color={0,0,127}));
  connect(MassFlowOut.y,conPID1. u_s)
    annotation (Line(points={{-95.1,61},{-89.4,61}}, color={0,0,127}));
  connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{69.2,-42},{60,
          -42},{60,-30.84},{36.75,-30.84}}, color={0,0,127}));

  for i in 1:nPools loop
    connect(TMeaAir.y, prescribedTemperature[i].T)  annotation (Line(points={{65.2,74},{56,74},{56,27.2}}, color={0,0,127}));
    connect(indoorSwimming[i].TAir, TMeaAir.y) annotation (Line(points={{-5.75,-15.16},
          {-5.75,74},{65.2,74}}, color={0,0,127}));
    connect(indoorSwimming[i].X_w, PoolHall.X_w) annotation (Line(points={{3.75,-15.16},
          {3.75,46},{-28,46}}, color={0,0,127}));
  end for;

  connect(indoorSwimming.QEva, airFlowMoistureToROM.QEva) annotation (Line(
        points={{-15,-28.32},{-26,-28.32},{-26,-0.4},{-34.6,-0.4}}, color={0,0,127}));
  connect(indoorSwimming.m_flow_eva, airFlowMoistureToROM.m_flow_eva)
    annotation (Line(points={{-15.25,-36.44},{-28,-36.44},{-28,-7.7},{-34.5,-7.7}},
        color={0,0,127}));

  connect(airFlowMoistureToROM.port_a, PoolHall.ports[1]) annotation (Line(
        points={{-54,-1.6},{-64,-1.6},{-64,-2},{-76,-2},{-76,26},{-41,26},{-41,40}},
        color={0,127,255}));
  connect(airFlowMoistureToROM.port_b, PoolHall.ports[2]) annotation (Line(
        points={{-53.8,-6.4},{-68,-6.4},{-68,14},{-39,14},{-39,40}}, color={0,127,
          255}));
  connect(bou.ports[1], airFlowMoistureToROM.port_b) annotation (Line(points={{
          -82,-15},{-76,-15},{-76,-14},{-68,-14},{-68,-6.4},{-53.8,-6.4}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
end IndoorSwimmingPoolAddMoistureToVolume;
