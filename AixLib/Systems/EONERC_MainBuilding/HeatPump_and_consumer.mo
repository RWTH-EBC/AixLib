within AixLib.Systems.EONERC_MainBuilding;
model HeatPump_and_consumer "Energy system of E.ON ERC main building"
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    p=300000,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={80,-102})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium, T_amb=293.15)
    annotation (Placement(transformation(extent={{-58,-100},{52,-52}})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    p=300000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-84,-96})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-120},{-28,-108}})));
  HydraulicModules.SimpleConsumer consumerLTC(
    kA=50000,
    V=5,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-96,84},{-84,96}})));
  HydraulicModules.SimpleConsumer consumerCold1(
    kA=312000/6,
    V=5,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={10,90})));
  HydraulicModules.Admix admixLTC(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admixLTC.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=10),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=10),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,70})));
  HydraulicModules.Admix admixCold1(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admixCold1.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=5),
    pipe2(length=5),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=5),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,70})));
  HydraulicModules.Admix admixCold2(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          energyDynamics=admixCold2.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=5),
    pipe2(length=5),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=5),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,70})));
  HydraulicModules.SimpleConsumer consumerCold2(
    kA=1000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={110,92})));
  Modelica.Blocks.Sources.Sine sine3(
    amplitude=1000,
    freqHz=1/(3600*24),
    offset=9000)
    annotation (Placement(transformation(extent={{86,92},{96,102}})));
  BaseClasses.MainBus mainBus annotation (Placement(transformation(extent={{-56,
            104},{-26,134}}), iconTransformation(extent={{-30,110},{-10,130}})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCAHot(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-130,98},{-122,106}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_AHU(y=(12000*2 + 3000 + 17*73)/
        3600*1.2*1005*(Tair - 293.15)*0.2)
    annotation (Placement(transformation(extent={{-150,84},{-134,100}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_hot(y=4000*(Tair - 288.15))
    annotation (Placement(transformation(extent={{-150,94},{-134,110}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-116,92},{-108,100}})));
  Modelica.Blocks.Nonlinear.Limiter limiterFVUCold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={24,112})));
  Modelica.Blocks.Sources.RealExpression Q_flow_FVU_cold(y=(20*73)/3600*1.2*
        1005*(Tair - 284.15)*0.8)
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={38,112})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold(y=3000*(Tair - 293.15))
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={38,102})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={12,106})));

  Modelica.Blocks.Nonlinear.Limiter limiterAHU(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-130,88},{-122,96}})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={24,102})));
  Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3) annotation (Placement(transformation(extent={{100,28},{108,36}})));
  Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3) annotation (Placement(transformation(extent={{112,46},{120,54}})));
  Modelica.Blocks.Interfaces.RealInput Tair annotation (Placement(
        transformation(extent={{-212,-12},{-188,12}}), iconTransformation(
          extent={{-212,-12},{-188,12}})));
equation
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{-28,-114},{-2,-114},{-2,-97.3333},{-3,-97.3333}}, color={
          191,0,0}));
  connect(admixLTC.port_b1, consumerLTC.port_a)
    annotation (Line(points={{-96,80},{-96,90}}, color={0,127,255}));
  connect(admixLTC.port_a2, consumerLTC.port_b)
    annotation (Line(points={{-84,80},{-84,90}}, color={0,127,255}));
  connect(admixCold1.port_b1, consumerCold1.port_a)
    annotation (Line(points={{4,80},{4,90}}, color={0,127,255}));
  connect(consumerCold1.port_b, admixCold1.port_a2)
    annotation (Line(points={{16,90},{16,80}}, color={0,127,255}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{80,-96},
          {80,-78.6667},{52,-78.6667}},          color={0,127,255}));
  connect(consumerCold2.port_a, admixCold2.port_b1)
    annotation (Line(points={{104,92},{104,80}}, color={0,127,255}));
  connect(consumerCold2.port_b, admixCold2.port_a2)
    annotation (Line(points={{116,92},{116,80}}, color={0,127,255}));
  connect(heatpumpSystem.heatPumpSystemBus, mainBus.hpSystemBus) annotation (
      Line(
      points={{-3,-52},{-4,-52},{-4,-28},{-40.925,-28},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(admixLTC.hydraulicBus, mainBus.consLtcBus) annotation (Line(
      points={{-100,70},{-62,70},{-62,119.075},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixCold1.hydraulicBus, mainBus.consCold1Bus) annotation (Line(
      points={{0,70},{-2,70},{-2,82},{-24,82},{-24,119.075},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(admixCold2.hydraulicBus, mainBus.consCold2Bus) annotation (Line(
      points={{100,70},{98,70},{98,76},{96,76},{96,84},{74,84},{74,119.075},{
          -40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sine3.y, consumerCold2.Q_flow) annotation (Line(points={{96.5,97},{
          101.25,97},{101.25,98},{106.4,98}}, color={0,0,127}));
  connect(add.y, consumerLTC.Q_flow)
    annotation (Line(points={{-107.6,96},{-93.6,96}}, color={0,0,127}));
  connect(Q_flow_CCA_hot.y, limiterCCAHot.u)
    annotation (Line(points={{-133.2,102},{-130.8,102}}, color={0,0,127}));
  connect(Q_flow_AHU.y, limiterAHU.u)
    annotation (Line(points={{-133.2,92},{-130.8,92}}, color={0,0,127}));
  connect(limiterAHU.y, add.u2) annotation (Line(points={{-121.6,92},{-120,92},
          {-120,93.6},{-116.8,93.6}}, color={0,0,127}));
  connect(limiterCCAHot.y, add.u1) annotation (Line(points={{-121.6,102},{-118,
          102},{-118,98.4},{-116.8,98.4}}, color={0,0,127}));
  connect(Q_flow_FVU_cold.y, limiterFVUCold.u)
    annotation (Line(points={{29.2,112},{28.8,112}}, color={0,0,127}));
  connect(add1.y, consumerCold1.Q_flow)
    annotation (Line(points={{7.6,106},{6.4,106},{6.4,96}}, color={0,0,127}));
  connect(add1.u2, limiterFVUCold.y) annotation (Line(points={{16.8,108.4},{
          16.8,110.2},{19.6,110.2},{19.6,112}}, color={0,0,127}));
  connect(add1.u1, limiterCCACold.y) annotation (Line(points={{16.8,103.6},{18,
          103.6},{18,102},{19.6,102}}, color={0,0,127}));
  connect(Q_flow_CCA_cold.y, limiterCCACold.u)
    annotation (Line(points={{29.2,102},{28.8,102}}, color={0,0,127}));
  connect(heatpumpSystem.port_b1, vol2.ports[1]) annotation (Line(points={{52,
          -78.6667},{102.933,-78.6667},{102.933,28}}, color={0,127,255}));
  connect(vol2.ports[2], admixCold2.port_a1) annotation (Line(points={{104,28},
          {104,44},{104,44},{104,60}},         color={0,127,255}));
  connect(vol3.ports[1], admixCold2.port_b2)
    annotation (Line(points={{114.933,46},{114.933,60},{116,60}},
                                                          color={0,127,255}));
  connect(vol3.ports[2], heatpumpSystem.port_a1) annotation (Line(points={{116,46},
          {118,46},{118,-68},{52,-68}},             color={0,127,255}));
  connect(admixLTC.port_a1, heatpumpSystem.port_b2) annotation (Line(points={{
          -96,60},{-96,-68},{-58,-68}}, color={0,127,255}));
  connect(heatpumpSystem.port_a2, admixLTC.port_b2) annotation (Line(points={{-58,
          -78.6667},{-58,-78},{-84,-78},{-84,60}},     color={0,127,255}));
  connect(boundary4.ports[1], admixLTC.port_b2)
    annotation (Line(points={{-84,-90},{-84,60}}, color={0,127,255}));
  connect(admixCold1.port_b2, vol3.ports[3]) annotation (Line(points={{16,60},{
          16,46},{117.067,46}}, color={0,127,255}));
  connect(admixCold1.port_a1, vol2.ports[3]) annotation (Line(points={{4,60},{6,
          60},{6,28},{105.067,28}}, color={0,127,255}));
  connect(prescribedTemperature.T, Tair) annotation (Line(points={{-41.2,-114},
          {-120,-114},{-120,0},{-200,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{120,120}})), Icon(
        coordinateSystem(extent={{-200,-120},{120,120}}), graphics={Rectangle(
          extent={{-200,120},{120,-120}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-166,106},{106,-126}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="E.ON ERC Main building energy system")}),
    experiment(
      StopTime=432000,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end HeatPump_and_consumer;
