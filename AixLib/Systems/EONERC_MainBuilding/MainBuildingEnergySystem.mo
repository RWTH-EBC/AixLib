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
       2) annotation (Placement(transformation(extent={{32,22},{66,62}})));
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
        origin={-196,-12})));
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
    TflowSet=313.15,
    Td=0,
    Ti=150,
    k=0.05,
    rpm_pump=2000,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-204,64},{-188,78}})));
  HydraulicModules.SimpleConsumer consumerHTC(
    kA=20000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,84},{-164,96}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
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
    annotation (Placement(transformation(extent={{-126,62},{-110,80}})));
  HydraulicModules.Admix admixLTC(
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
          per, energyDynamics=admixHTC.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=5),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=5),
    pipe6(length=0.5),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,70})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    freqHz=1/(3600*24),
    offset=273.15 + 75)
    annotation (Placement(transformation(extent={{-192,92},{-182,102}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=1,
    freqHz=1/(3600*24),
    offset=273.15 + 25)
    annotation (Placement(transformation(extent={{-122,100},{-112,110}})));
  Modelica.Blocks.Sources.Sine sine2(
    amplitude=1,
    freqHz=1/(3600*24),
    offset=273.15 + 19)
    annotation (Placement(transformation(extent={{-18,126},{-8,136}})));
  HydraulicModules.Throttle throttle(
    redeclare package Medium = Medium,
    T_amb=293.15,
    m_flow_nominal=0.5,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    length=2,
    Kv=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,-22})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus3
    annotation (Placement(transformation(extent={{-212,-36},{-192,-16}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-252,-46},{-232,-26}})));
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
    T_amb=288.15,
    G=5000) annotation (Placement(transformation(extent={{36,-22},{62,16}})));
  HydraulicModules.Admix admixCold2(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          energyDynamics=admixHTC.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=5),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=5),
    pipe6(length=0.5),
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
    functionality="T_input",
    T_start=293.15) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={110,92})));
  Modelica.Blocks.Sources.Sine sine3(
    amplitude=1,
    freqHz=1/(3600*24),
    offset=273.15 + 17)
    annotation (Placement(transformation(extent={{86,94},{96,104}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-106,96},{-96,106}})));
  Modelica.Blocks.Sources.Sine sine4(
    amplitude=2,
    freqHz=1/(3600*24*365),
    offset=0)
    annotation (Placement(transformation(extent={{-122,86},{-112,96}})));
  Modelica.Blocks.Sources.Sine sine5(
    amplitude=2,
    freqHz=1/(3600*24*365),
    phase=0,
    offset=0)
    annotation (Placement(transformation(extent={{-16,110},{-6,120}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{0,120},{10,130}})));
  HydraulicModules.Controller.CtrMix ctrMixCold2(
    useExternalTset=false,
    TflowSet=287.15,
    k=0.05,
    Td=0,
    rpm_pump=2000,
    reverseAction=true)
    annotation (Placement(transformation(extent={{74,62},{90,80}})));
  Modelica.Blocks.Sources.Sine sine6(
    amplitude=5000,
    freqHz=1/(3600*24*365),
    offset=-5000)
    annotation (Placement(transformation(extent={{-116,132},{-106,142}})));
  Modelica.Blocks.Sources.Sine sine7(
    amplitude=50000,
    freqHz=1/(3600*24*365),
    phase=0,
    offset=50000)
    annotation (Placement(transformation(extent={{-12,92},{-2,102}})));
  BaseClasses.MainBus mainBus annotation (Placement(transformation(extent={{-56,
            104},{-26,134}}), iconTransformation(extent={{-30,110},{-10,130}})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{66,38.6667},{80,38.6667},{80,-78.6667},{52,-78.6667}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{52,-68},{94,-68},{94,58.6667},{66,58.6667}},
                                                    color={0,127,255}));
  connect(heatpumpSystem.port_a2, heatExchangerSystem.port_b3) annotation (Line(
        points={{-58,-78.6667},{-86,-78.6667},{-86,-25.56},{-84.7143,-25.56}},
                                                                          color=
         {0,127,255}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-58,-68},{-94.1429,-68},{-94.1429,-26}},
                                                color={0,127,255}));
  connect(ctrMixHTC.hydraulicBus, admixHTC.hydraulicBus) annotation (Line(
      points={{-188.56,70.23},{-186.315,70.23},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admixHTC.port_b1, consumerHTC.port_a)
    annotation (Line(points={{-176,80},{-176,90}}, color={0,127,255}));
  connect(admixHTC.port_a2, consumerHTC.port_b)
    annotation (Line(points={{-164,80},{-164,90}}, color={0,127,255}));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{-28,-114},{-2,-114},{-2,-97.3333},{-3,-97.3333}},
                                                                 color={191,0,0}));
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
  connect(admixCold1.port_b2, switchingUnit.port_a1) annotation (Line(points={{
          16,60},{20,60},{20,58.6667},{32,58.6667}}, color={0,127,255}));
  connect(admixCold1.port_a1, switchingUnit.port_b2) annotation (Line(points={{
          4,60},{4,38.6667},{32,38.6667}}, color={0,127,255}));
  connect(admixCold1.port_b1, consumerCold1.port_a)
    annotation (Line(points={{4,80},{4,90}}, color={0,127,255}));
  connect(consumerCold1.port_b, admixCold1.port_a2)
    annotation (Line(points={{16,90},{16,80}}, color={0,127,255}));
  connect(highTemperatureSystem.port_b, throttle.port_a1) annotation (Line(
        points={{-176.4,-46},{-176.4,-40},{-176,-40},{-176,-32}}, color={0,127,
          255}));
  connect(highTemperatureSystem.port_a, throttle.port_b2) annotation (Line(
        points={{-164.8,-46},{-164,-46},{-164,-32}},            color={0,127,
          255}));
  connect(boundary1.ports[1], throttle.port_b1) annotation (Line(points={{-190,
          -12},{-176,-12}},                       color={0,127,255}));
  connect(throttle.port_b1, admixHTC.port_a1)
    annotation (Line(points={{-176,-12},{-176,60}}, color={0,127,255}));
  connect(throttle.port_a2, admixHTC.port_b2)
    annotation (Line(points={{-164,-12},{-164,60}}, color={0,127,255}));
  connect(throttle.port_a2, heatExchangerSystem.port_b1) annotation (Line(
        points={{-164,-12},{-164,0.4},{-146,0.4}},            color={0,127,255}));
  connect(throttle.port_b1, heatExchangerSystem.port_a1) annotation (Line(
        points={{-176,-12},{-176,-8.4},{-146,-8.4}}, color={0,127,255}));
  connect(throttle.hydraulicBus, hydraulicBus3) annotation (Line(
      points={{-180,-22},{-194,-22},{-194,-26},{-202,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, hydraulicBus3.valSet) annotation (Line(points={{-231,-36},{
          -201.95,-36},{-201.95,-25.95}},                       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixLTC.hydraulicBus, admixLTC.hydraulicBus) annotation (Line(
      points={{-110.56,70.01},{-106.28,70.01},{-106.28,70},{-100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine.y, consumerHTC.T) annotation (Line(points={{-181.5,97},{-165.2,
          97},{-165.2,96}}, color={0,0,127}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{80,-96},
          {80,-78.6667},{52,-78.6667}},          color={0,127,255}));
  connect(heatpumpSystem.port_a1, admixCold2.port_b2)
    annotation (Line(points={{52,-68},{116,-68},{116,60}}, color={0,127,255}));
  connect(heatpumpSystem.port_b1, admixCold2.port_a1) annotation (Line(points={
          {52,-78.6667},{80,-78.6667},{80,38},{104,38},{104,60}}, color={0,127,
          255}));
  connect(sine3.y, consumerCold2.T) annotation (Line(points={{96.5,99},{96.5,98},
          {114.8,98}}, color={0,0,127}));
  connect(sine1.y, add.u1) annotation (Line(points={{-111.5,105},{-108.75,105},{
          -108.75,104},{-107,104}}, color={0,0,127}));
  connect(sine4.y, add.u2) annotation (Line(points={{-111.5,91},{-111.5,94.5},{-107,
          94.5},{-107,98}}, color={0,0,127}));
  connect(sine2.y, add1.u1) annotation (Line(points={{-7.5,131},{-4.75,131},{-4.75,
          128},{-1,128}}, color={0,0,127}));
  connect(sine5.y, add1.u2) annotation (Line(points={{-5.5,115},{-5.5,118.5},{-1,
          118.5},{-1,122}}, color={0,0,127}));
  connect(consumerCold2.port_a, admixCold2.port_b1)
    annotation (Line(points={{104,92},{104,80}}, color={0,127,255}));
  connect(consumerCold2.port_b, admixCold2.port_a2)
    annotation (Line(points={{116,92},{116,80}}, color={0,127,255}));
  connect(ctrMixCold2.hydraulicBus, admixCold2.hydraulicBus) annotation (Line(
      points={{89.44,70.01},{94.72,70.01},{94.72,70},{100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine6.y, consumerLTC.Q_flow) annotation (Line(points={{-105.5,137},{-93.6,
          137},{-93.6,96}}, color={0,0,127}));
  connect(geothermalFieldSimple.port_a, switchingUnit.port_b3) annotation (Line(
        points={{38.1667,16},{40,16},{40,22},{42.2,22}}, color={0,127,255}));
  connect(geothermalFieldSimple.port_b, switchingUnit.port_a3) annotation (Line(
        points={{59.8333,16},{55.8,16},{55.8,22}}, color={0,127,255}));
  connect(ctrMixCold1.hydraulicBus, admixCold1.hydraulicBus) annotation (Line(
      points={{-8.56,70.01},{-3.28,70.01},{-3.28,70},{0,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine7.y, consumerCold1.Q_flow) annotation (Line(points={{-1.5,97},{
          2.25,97},{2.25,96},{6.4,96}}, color={0,0,127}));
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
      points={{-100,70},{-80,70},{-80,68},{-108,68},{-108,119.075},{-40.925,
          119.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixHTC.hydraulicBus, mainBus.consHtcBus) annotation (Line(
      points={{-180,70},{-184,70},{-184,76},{-208,76},{-208,119.075},{-40.925,
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
