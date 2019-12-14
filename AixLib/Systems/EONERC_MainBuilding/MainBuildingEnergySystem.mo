within AixLib.Systems.EONERC_MainBuilding;
model MainBuildingEnergySystem
  "Energy system of E.ON ERC main building"
  extends Modelica.Icons.Example;
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
       2) annotation (Placement(transformation(extent={{26,24},{60,64}})));
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
  HydraulicModules.Admix                admix(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admix.energyDynamics)),
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
    Kv=63)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,70})));
  HydraulicModules.Controller.CtrMix
                    ctrMix(
    TflowSet=313.15,
    Td=0,
    Ti=150,
    k=0.05,
    rpm_pump=2000,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-204,64},{-188,78}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer(
    kA=20000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,84},{-164,96}})));
  Controller.EonERCModeControl.EonERCModeBasedControl eonERCModeBasedControl
    annotation (Placement(transformation(extent={{-48,-2},{-28,18}})));
  Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=298.15,
    Ti=60,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-148,48},{-128,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-40,-120},{-28,-108}})));
  Controller.CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{-218,-90},{-198,-70}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer1(
    kA=50000,
    V=5,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-96,84},{-84,96}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer2(
    kA=312000/6,
    V=5,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-28,92})));
  HydraulicModules.Controller.CtrMix ctrMix1(
    useExternalTset=false,
    TflowSet=301.15,
    k=0.05,
    Td=0,
    rpm_pump=2000)
    annotation (Placement(transformation(extent={{-126,62},{-110,80}})));
  HydraulicModules.Admix                admix1(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admix.energyDynamics)),
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
    Kv=63)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,70})));
  HydraulicModules.Admix                admix2(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per, energyDynamics=admix.energyDynamics)),
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
    Kv=63)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,70})));
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
    annotation (Placement(transformation(extent={{-66,128},{-56,138}})));
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
  HydraulicModules.Controller.CtrMix ctrMix2(
    useExternalTset=false,
    TflowSet=289.15,
    k=0.05,
    Td=0,
    rpm_pump=2000,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-60,62},{-44,80}})));
  GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_start=285.15,
    T_amb=288.15,
    G=5000) annotation (Placement(transformation(extent={{32,-18},{52,16}})));
  HydraulicModules.Admix                admix3(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          energyDynamics=admix.energyDynamics)),
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
    Kv=63)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,70})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer3(
    kA=1000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
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
    annotation (Placement(transformation(extent={{-64,112},{-54,122}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-48,122},{-38,132}})));
  HydraulicModules.Controller.CtrMix ctrMix3(
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
    annotation (Placement(transformation(extent={{-58,90},{-48,100}})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{60,40.6667},{80,40.6667},{80,-78.6667},{52,-78.6667}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{52,-68},{94,-68},{94,60.6667},{60,60.6667}},
                                                    color={0,127,255}));
  connect(heatpumpSystem.port_a2, heatExchangerSystem.port_b3) annotation (Line(
        points={{-58,-78.6667},{-86,-78.6667},{-86,-25.56},{-84.7143,-25.56}},
                                                                          color=
         {0,127,255}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-58,-68},{-94.1429,-68},{-94.1429,-26}},
                                                color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-188.56,70.23},{-186.315,70.23},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_b1, simpleConsumer.port_a)
    annotation (Line(points={{-176,80},{-176,90}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b)
    annotation (Line(points={{-164,80},{-164,90}}, color={0,127,255}));
  connect(eonERCModeBasedControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-28,15},{-6,15},{-6,-52},{-3,-52}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-128.7,33.4},{-118,33.4},{-118,18},{-127.143,18}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-128.7,39.1},{-103.571,39.1},{-103.571,18}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{-28,-114},{-2,-114},{-2,-97.3333},{-3,-97.3333}},
                                                                 color={191,0,0}));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystem.hTCBus) annotation (Line(
      points={{-198,-79.9},{-203,-79.9},{-203,-79.8692},{-187.71,-79.8692}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary4.ports[1], heatpumpSystem.port_a2) annotation (Line(points={{-86,-94},
          {-86,-78.6667},{-58,-78.6667}},           color={0,127,255}));
  connect(admix1.port_b1, simpleConsumer1.port_a)
    annotation (Line(points={{-96,80},{-96,90}}, color={0,127,255}));
  connect(admix1.port_a2, simpleConsumer1.port_b)
    annotation (Line(points={{-84,80},{-84,90}}, color={0,127,255}));
  connect(admix1.port_a1, heatExchangerSystem.port_b2)
    annotation (Line(points={{-96,60},{-96,18},{-94.1429,18}},
                                                          color={0,127,255}));
  connect(admix1.port_b2, heatExchangerSystem.port_a3)
    annotation (Line(points={{-84,60},{-84,18},{-84.7143,18}},
                                                          color={0,127,255}));
  connect(admix2.port_b2, switchingUnit.port_a1) annotation (Line(points={{-22,60},
          {6,60},{6,60.6667},{26,60.6667}},
                                      color={0,127,255}));
  connect(admix2.port_a1, switchingUnit.port_b2) annotation (Line(points={{-34,60},
          {-34,40.6667},{26,40.6667}},color={0,127,255}));
  connect(admix2.port_b1, simpleConsumer2.port_a)
    annotation (Line(points={{-34,80},{-34,92}}, color={0,127,255}));
  connect(simpleConsumer2.port_b, admix2.port_a2)
    annotation (Line(points={{-22,92},{-22,80}}, color={0,127,255}));
  connect(highTemperatureSystem.port_b, throttle.port_a1) annotation (Line(
        points={{-176.4,-46},{-176.4,-40},{-176,-40},{-176,-32}}, color={0,127,
          255}));
  connect(highTemperatureSystem.port_a, throttle.port_b2) annotation (Line(
        points={{-164.8,-46},{-164,-46},{-164,-32}},            color={0,127,
          255}));
  connect(boundary1.ports[1], throttle.port_b1) annotation (Line(points={{-190,
          -12},{-176,-12}},                       color={0,127,255}));
  connect(throttle.port_b1, admix.port_a1) annotation (Line(points={{-176,-12},
          {-176,60}},                      color={0,127,255}));
  connect(throttle.port_a2, admix.port_b2) annotation (Line(points={{-164,-12},
          {-164,60}},                      color={0,127,255}));
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
  connect(ctrMix1.hydraulicBus, admix1.hydraulicBus) annotation (Line(
      points={{-110.56,70.01},{-106.28,70.01},{-106.28,70},{-100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine.y, simpleConsumer.T) annotation (Line(points={{-181.5,97},{
          -165.2,97},{-165.2,96}},
                             color={0,0,127}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{80,-96},
          {80,-78.6667},{52,-78.6667}},          color={0,127,255}));
  connect(ctrMix2.hydraulicBus, admix2.hydraulicBus) annotation (Line(
      points={{-44.56,70.01},{-41.28,70.01},{-41.28,70},{-38,70}},
      color={255,204,51},
      thickness=0.5));
  connect(eonERCModeBasedControl.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{-27.8571,8.69231},{6,8.69231},{6,64.3333},{42.83,64.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(eonERCModeBasedControl.busThrottle, geothermalFieldSimple.busThrottle)
    annotation (Line(
      points={{-27.9286,4},{20,4},{20,11.325},{32.0833,11.325}},
      color={255,204,51},
      thickness=0.5));
  connect(eonERCModeBasedControl.busPump, geothermalFieldSimple.busPump)
    annotation (Line(
      points={{-27.9286,-0.615385},{32.0833,-0.615385},{32.0833,3.25}},
      color={255,204,51},
      thickness=0.5));
  connect(heatpumpSystem.port_a1, admix3.port_b2)
    annotation (Line(points={{52,-68},{116,-68},{116,60}}, color={0,127,255}));
  connect(heatpumpSystem.port_b1, admix3.port_a1) annotation (Line(points={{52,
          -78.6667},{82,-78.6667},{82,-78},{104,-78},{104,60}}, color={0,127,
          255}));
  connect(sine3.y,simpleConsumer3. T) annotation (Line(points={{96.5,99},{96.5,
          98},{114.8,98}},         color={0,0,127}));
  connect(sine1.y, add.u1) annotation (Line(points={{-111.5,105},{-108.75,105},
          {-108.75,104},{-107,104}}, color={0,0,127}));
  connect(sine4.y, add.u2) annotation (Line(points={{-111.5,91},{-111.5,94.5},{
          -107,94.5},{-107,98}}, color={0,0,127}));
  connect(sine2.y, add1.u1) annotation (Line(points={{-55.5,133},{-52.75,133},{
          -52.75,130},{-49,130}}, color={0,0,127}));
  connect(sine5.y, add1.u2) annotation (Line(points={{-53.5,117},{-53.5,120.5},
          {-49,120.5},{-49,124}}, color={0,0,127}));
  connect(simpleConsumer3.port_a, admix3.port_b1)
    annotation (Line(points={{104,92},{104,80}}, color={0,127,255}));
  connect(simpleConsumer3.port_b, admix3.port_a2)
    annotation (Line(points={{116,92},{116,80}}, color={0,127,255}));
  connect(ctrMix3.hydraulicBus, admix3.hydraulicBus) annotation (Line(
      points={{89.44,70.01},{94.72,70.01},{94.72,70},{100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sine6.y, simpleConsumer1.Q_flow) annotation (Line(points={{-105.5,137},
          {-93.6,137},{-93.6,96}}, color={0,0,127}));
  connect(sine7.y, simpleConsumer2.Q_flow) annotation (Line(points={{-47.5,95},
          {-40,95},{-40,106},{-31.6,106},{-31.6,98}}, color={0,0,127}));
  connect(geothermalFieldSimple.port_a, switchingUnit.port_b3) annotation (Line(
        points={{33.6667,16},{34,16},{34,24},{36.2,24}}, color={0,127,255}));
  connect(geothermalFieldSimple.port_b, switchingUnit.port_a3) annotation (Line(
        points={{50.3333,16},{49.8,16},{49.8,24}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{120,100}})), Icon(
        coordinateSystem(extent={{-200,-120},{120,100}})),
    experiment(
      StopTime=432000,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end MainBuildingEnergySystem;
