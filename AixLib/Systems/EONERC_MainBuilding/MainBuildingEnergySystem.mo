within AixLib.Systems.EONERC_MainBuilding;
model MainBuildingEnergySystem
  "Energy system of E.ON ERC main building"
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
  SwitchingUnit switchingUnit(redeclare package Medium = Medium, m_flow_nominal=
       5) annotation (Placement(transformation(extent={{32,22},{66,62}})));
  HeatExchangerSystem heatExchangerSystem(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-146,-26},{-80,18}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    p=300000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-194,-34})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    p=300000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-86,-100})));
  HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = Medium,
    T_start=333.15,
    T_amb=293.15,
    m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-37,-29},{37,29}},
        rotation=90,
        origin={-159,-83})));
  HydraulicModules.Admix admixHTC(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admixHTC.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=15),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=15),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,70})));
  HydraulicModules.Controller.CtrMix ctrMixHTC(
    TflowSet=338.15,
    Td=0,
    Ti=150,
    k=0.05,
    rpm_pump=2000,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-202,62},{-188,76}})));
  HydraulicModules.SimpleConsumer consumerHTC(
    kA=20000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,84},{-164,96}})));
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
  HydraulicModules.Controller.CtrMix ctrMixLTC(
    useExternalTset=false,
    TflowSet=301.15,
    k=0.05,
    Td=0,
    rpm_pump=2000)
    annotation (Placement(transformation(extent={{-128,64},{-114,78}})));
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
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    freqHz=1/(3600*24),
    offset=273.15 + 60)
    annotation (Placement(transformation(extent={{-192,92},{-182,102}})));
  HydraulicModules.Controller.CtrMix ctrMixCold1(
    useExternalTset=false,
    TflowSet=289.15,
    k=0.05,
    Td=0,
    rpm_pump=2000,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-24,62},{-8,80}})));
  GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_start=285.15,
    T_amb=288.15)
            annotation (Placement(transformation(extent={{36,-22},{62,16}})));
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
    annotation (Placement(transformation(extent={{86,94},{96,104}})));
  HydraulicModules.Controller.CtrMix ctrMixCold2(
    useExternalTset=false,
    TflowSet=285.15,
    k=0.05,
    Td=0,
    rpm_pump=2000,
    reverseAction=true)
    annotation (Placement(transformation(extent={{74,62},{90,80}})));
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
  Modelica.Blocks.Interfaces.RealOutput Tair
    annotation (Placement(transformation(extent={{-138,-150},{-118,-130}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=5,
    freqHz=1/(3600*24),
    offset=273.15 + 15)
    annotation (Placement(transformation(extent={{-186,-140},{-176,-130}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-216,-142},{-196,-122}})));

  BoundaryConditions.WeatherData.Bus weaBus1
             "Weather data bus"
    annotation (Placement(transformation(extent={{-170,-140},{-150,-120}})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-130,88},{-122,96}})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={24,102})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3)
    annotation (Placement(transformation(extent={{-180,-10},{-172,-2}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3)
    annotation (Placement(transformation(extent={{-168,6},{-160,14}})));
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
equation
  connect(heatpumpSystem.port_a2, heatExchangerSystem.port_b3) annotation (Line(
        points={{-58,-78.6667},{-86,-78.6667},{-86,-25.56},{-84.7143,-25.56}},
                                                                          color=
         {0,127,255}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-58,-68},{-94.1429,-68},{-94.1429,-26}},
                                                color={0,127,255}));
  connect(ctrMixHTC.hydraulicBus, admixHTC.hydraulicBus) annotation (Line(
      points={{-187.02,69.14},{-186.315,69.14},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admixHTC.port_b1, consumerHTC.port_a)
    annotation (Line(points={{-176,80},{-176,90}}, color={0,127,255}));
  connect(admixHTC.port_a2, consumerHTC.port_b)
    annotation (Line(points={{-164,80},{-164,90}}, color={0,127,255}));
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{-28,-114},{-2,-114},{-2,-97.3333},{-3,-97.3333}}, color={
          191,0,0}));
  connect(boundary4.ports[1], heatpumpSystem.port_a2) annotation (Line(points={{-86,-94},
          {-86,-78.6667},{-58,-78.6667}},           color={0,127,255}));
  connect(admixLTC.port_b1, consumerLTC.port_a)
    annotation (Line(points={{-96,80},{-96,90}}, color={0,127,255}));
  connect(admixLTC.port_a2, consumerLTC.port_b)
    annotation (Line(points={{-84,80},{-84,90}}, color={0,127,255}));
  connect(admixLTC.port_a1, heatExchangerSystem.port_b2) annotation (Line(
        points={{-96,60},{-96,18},{-94.1429,18}}, color={0,127,255}));
  connect(admixLTC.port_b2, heatExchangerSystem.port_a3) annotation (Line(
        points={{-84,60},{-84,18},{-84.7143,18}}, color={0,127,255}));
  connect(admixCold1.port_b2, switchingUnit.port_a1) annotation (Line(points={{16,60},
          {20,60},{20,58.6667},{32,58.6667}},        color={0,127,255}));
  connect(admixCold1.port_a1, switchingUnit.port_b2) annotation (Line(points={{4,60},{
          4,38.6667},{32,38.6667}},        color={0,127,255}));
  connect(admixCold1.port_b1, consumerCold1.port_a)
    annotation (Line(points={{4,80},{4,90}}, color={0,127,255}));
  connect(consumerCold1.port_b, admixCold1.port_a2)
    annotation (Line(points={{16,90},{16,80}}, color={0,127,255}));
  connect(ctrMixLTC.hydraulicBus, admixLTC.hydraulicBus) annotation (Line(
      points={{-113.02,71.14},{-106.28,71.14},{-106.28,70},{-100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine.y, consumerHTC.T) annotation (Line(points={{-181.5,97},{-165.2,
          97},{-165.2,96}}, color={0,0,127}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{80,-96},
          {80,-78.6667},{52,-78.6667}},          color={0,127,255}));
  connect(consumerCold2.port_a, admixCold2.port_b1)
    annotation (Line(points={{104,92},{104,80}}, color={0,127,255}));
  connect(consumerCold2.port_b, admixCold2.port_a2)
    annotation (Line(points={{116,92},{116,80}}, color={0,127,255}));
  connect(ctrMixCold2.hydraulicBus, admixCold2.hydraulicBus) annotation (Line(
      points={{91.12,71.18},{94.72,71.18},{94.72,70},{100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(geothermalFieldSimple.port_a, switchingUnit.port_b3) annotation (Line(
        points={{38.1667,16},{40,16},{40,22},{42.2,22}}, color={0,127,255}));
  connect(geothermalFieldSimple.port_b, switchingUnit.port_a3) annotation (Line(
        points={{59.8333,16},{55.8,16},{55.8,22}}, color={0,127,255}));
  connect(ctrMixCold1.hydraulicBus, admixCold1.hydraulicBus) annotation (Line(
      points={{-6.88,71.18},{-3.28,71.18},{-3.28,70},{0,70}},
      color={255,204,51},
      thickness=0.5));
  connect(heatpumpSystem.heatPumpSystemBus, mainBus.hpSystemBus) annotation (
      Line(
      points={{-3,-52},{-4,-52},{-4,-28},{-40.925,-28},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalFieldSimple.twoCircuitBus, mainBus.gtfBus) annotation (Line(
      points={{35.8917,4.00625},{-40.925,4.00625},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switchingUnit.sWUBus, mainBus.swuBus) annotation (Line(
      points={{48.83,62.3333},{48.83,119.075},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatExchangerSystem.hxBus, mainBus.hxBus) annotation (Line(
      points={{-115.829,18},{-116,18},{-116,38},{-40.925,38},{-40.925,119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(highTemperatureSystem.hTCBus, mainBus.htsBus) annotation (Line(
      points={{-187.71,-79.8692},{-208,-79.8692},{-208,119.075},{-40.925,
          119.075}},
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
  connect(admixHTC.hydraulicBus, mainBus.consHtcBus) annotation (Line(
      points={{-180,70},{-184,70},{-184,82},{-208,82},{-208,119.075},{-40.925,
          119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(sine3.y, consumerCold2.Q_flow) annotation (Line(points={{96.5,99},{
          101.25,99},{101.25,98},{106.4,98}}, color={0,0,127}));
  connect(Tair, prescribedTemperature.T) annotation (Line(points={{-128,-140},{
          -108,-140},{-108,-144},{-54,-144},{-54,-114},{-41.2,-114}}, color={0,
          0,127}));
  connect(weaDat.weaBus, weaBus1) annotation (Line(
      points={{-196,-132},{-180,-132},{-180,-130},{-160,-130}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Tair, weaBus1.TDryBul) annotation (Line(points={{-128,-140},{-144,
          -140},{-144,-130},{-160,-130}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(boundary1.ports[1], highTemperatureSystem.port_b) annotation (Line(
        points={{-188,-34},{-176.4,-34},{-176.4,-46}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, vol1.ports[1]) annotation (Line(points={{-164.8,
          -46},{-164.8,6},{-165.067,6}},          color={0,127,255}));
  connect(vol1.ports[2], heatExchangerSystem.port_b1) annotation (Line(points={
          {-164,6},{-164,0.4},{-146,0.4}}, color={0,127,255}));
  connect(admixHTC.port_b2, vol1.ports[3]) annotation (Line(points={{-164,60},{
          -164,6},{-162.933,6}}, color={0,127,255}));
  connect(highTemperatureSystem.port_b, vol.ports[1]) annotation (Line(points={{-176.4,
          -46},{-177.067,-46},{-177.067,-10}},         color={0,127,255}));
  connect(vol.ports[2], heatExchangerSystem.port_a1) annotation (Line(points={{
          -176,-10},{-160,-10},{-160,-8.4},{-146,-8.4}}, color={0,127,255}));
  connect(vol.ports[3], admixHTC.port_a1) annotation (Line(points={{-174.933,
          -10},{-174.933,24},{-176,24},{-176,60}}, color={0,127,255}));
  connect(heatpumpSystem.port_b1, vol2.ports[1]) annotation (Line(points={{52,
          -78.6667},{102.933,-78.6667},{102.933,28}}, color={0,127,255}));
  connect(vol2.ports[2], switchingUnit.port_a2) annotation (Line(points={{104,28},
          {102,28},{102,40},{66,40},{66,38.6667}},     color={0,127,255}));
  connect(vol2.ports[3], admixCold2.port_a1) annotation (Line(points={{105.067,
          28},{105.067,44},{104,44},{104,60}}, color={0,127,255}));
  connect(switchingUnit.port_b1, vol3.ports[1]) annotation (Line(points={{66,
          58.6667},{72,58.6667},{72,58},{80,58},{80,46},{114.933,46}}, color={0,
          127,255}));
  connect(vol3.ports[2], admixCold2.port_b2)
    annotation (Line(points={{116,46},{116,60},{116,60}}, color={0,127,255}));
  connect(vol3.ports[3], heatpumpSystem.port_a1) annotation (Line(points={{117.067,
          46},{118,46},{118,-68},{52,-68}},         color={0,127,255}));
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
end MainBuildingEnergySystem;
