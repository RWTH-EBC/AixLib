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
        origin={8,44})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-74},{50,-26}})));
  SwitchingUnit switchingUnit(redeclare package Medium = Medium, m_flow_nominal=
       2) annotation (Placement(transformation(extent={{20,40},{60,88}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,16})));
  HeatExchangerSystem heatExchangerSystem(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-150,-26},{-80,22}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    p=300000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-218,-10})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    p=300000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-86,-64})));
  HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = Medium,
    T_amb=293.15,
    m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-36,-27},{36,27}},
        rotation=90,
        origin={-167,-84})));
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
    annotation (Placement(transformation(extent={{-176,82},{-164,94}})));
  Controller.HeatPumpSystemSimpleControl
                                     heatPumpSystemSimpleControl
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Controller.CtrSWU ctrSWU
    annotation (Placement(transformation(extent={{76,98},{56,118}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=4)
    annotation (Placement(transformation(extent={{110,96},{90,116}})));
  Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=305.15,
    Ti=60,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-148,48},{-128,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Controller.CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{-226,-92},{-206,-72}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer1(
    kA=60000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-96,92},{-84,104}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer2(
    kA=312000/6,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-40,70})));
  HydraulicModules.Controller.CtrMix ctrMix1(
    useExternalTset=false,
    TflowSet=306.15,
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
        rotation=180,
        origin={-18,70})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    freqHz=1/(3600*24),
    offset=273.15 + 75)
    annotation (Placement(transformation(extent={{-202,90},{-182,110}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=2,
    freqHz=1/(3600*24),
    offset=273.15 + 30)
    annotation (Placement(transformation(extent={{-122,102},{-102,122}})));
  Modelica.Blocks.Sources.Sine sine2(
    amplitude=3,
    freqHz=1/(3600*24),
    offset=273.15 + 18)
    annotation (Placement(transformation(extent={{-64,60},{-50,74}})));
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
        origin={-176,-22})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus3
    annotation (Placement(transformation(extent={{-212,-36},{-192,-16}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-244,-48},{-224,-28}})));
  HydraulicModules.Controller.CtrMix ctrMix2(
    useExternalTset=false,
    TflowSet=285.15,
    k=0.05,
    Td=0,
    rpm_pump=2000,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-40,38},{-24,56}})));
equation
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{8,50},{8,60},{20,60}},
                                                color={0,127,255}));
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{60,60},{80,60},{80,-52.6667},{50,-52.6667}}, color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{50,-42},{94,-42},{94,84},{60,84}}, color={0,127,255}));
  connect(vol.ports[1], switchingUnit.port_a3) annotation (Line(points={{42,26},
          {36,26},{36,40},{32,40}}, color={0,127,255}));
  connect(vol.ports[2], switchingUnit.port_b3) annotation (Line(points={{38,26},
          {46,26},{46,40},{48,40}}, color={0,127,255}));
  connect(heatpumpSystem.port_a2, heatExchangerSystem.port_b3) annotation (Line(
        points={{-60,-52.6667},{-86,-52.6667},{-86,-25.52},{-85,-25.52}}, color
        ={0,127,255}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-60,-42},{-95,-42},{-95,-26}}, color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-188.56,70.23},{-186.315,70.23},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_b1, simpleConsumer.port_a)
    annotation (Line(points={{-176,80},{-176,88}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b)
    annotation (Line(points={{-164,80},{-164,88}}, color={0,127,255}));
  connect(heatPumpSystemSimpleControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-20,0.1},{-6,0.1},{-6,-26},{-5,-26}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{56,108},{40,108},{40,88.4},{39.8,88.4}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.mode, integerExpression.y)
    annotation (Line(points={{76,108},{86,108},{86,106},{89,106}},
                                                 color={255,127,0}));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-128.7,33.4},{-118,33.4},{-118,22},{-130,22}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-128.7,39.1},{-105,39.1},{-105,22}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{0,-110},{-2,-110},{-2,-71.3333},{-5,-71.3333}}, color={191,0,0}));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystem.hTCBus) annotation (Line(
      points={{-206,-81.9},{-203,-81.9},{-203,-80.9538},{-193.73,-80.9538}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary4.ports[1], heatpumpSystem.port_a2) annotation (Line(points={
          {-86,-58},{-86,-52.6667},{-60,-52.6667}}, color={0,127,255}));
  connect(admix1.port_b1, simpleConsumer1.port_a)
    annotation (Line(points={{-96,80},{-96,98}}, color={0,127,255}));
  connect(admix1.port_a2, simpleConsumer1.port_b)
    annotation (Line(points={{-84,80},{-84,98}}, color={0,127,255}));
  connect(admix1.port_a1, heatExchangerSystem.port_b2)
    annotation (Line(points={{-96,60},{-96,22},{-95,22}}, color={0,127,255}));
  connect(admix1.port_b2, heatExchangerSystem.port_a3)
    annotation (Line(points={{-84,60},{-84,22},{-85,22}}, color={0,127,255}));
  connect(admix2.port_b2, switchingUnit.port_a1) annotation (Line(points={{-8,
          76},{6,76},{6,84},{20,84}}, color={0,127,255}));
  connect(admix2.port_a1, switchingUnit.port_b2) annotation (Line(points={{-8,
          64},{6,64},{6,60},{20,60}}, color={0,127,255}));
  connect(admix2.port_b1, simpleConsumer2.port_a)
    annotation (Line(points={{-28,64},{-40,64}}, color={0,127,255}));
  connect(simpleConsumer2.port_b, admix2.port_a2)
    annotation (Line(points={{-40,76},{-28,76}}, color={0,127,255}));
  connect(highTemperatureSystem.port_b, throttle.port_a1) annotation (Line(
        points={{-183.2,-48},{-183.2,-40},{-182,-40},{-182,-32}}, color={0,127,
          255}));
  connect(highTemperatureSystem.port_a, throttle.port_b2) annotation (Line(
        points={{-172.4,-48},{-172,-48},{-172,-32},{-170,-32}}, color={0,127,
          255}));
  connect(boundary1.ports[1], throttle.port_b1) annotation (Line(points={{-208,
          -10},{-196,-10},{-196,-12},{-182,-12}}, color={0,127,255}));
  connect(throttle.port_b1, admix.port_a1) annotation (Line(points={{-182,-12},
          {-180,-12},{-180,60},{-176,60}}, color={0,127,255}));
  connect(throttle.port_a2, admix.port_b2) annotation (Line(points={{-170,-12},
          {-168,-12},{-168,60},{-164,60}}, color={0,127,255}));
  connect(throttle.port_a2, heatExchangerSystem.port_b1) annotation (Line(
        points={{-170,-12},{-168,-12},{-168,2.8},{-150,2.8}}, color={0,127,255}));
  connect(throttle.port_b1, heatExchangerSystem.port_a1) annotation (Line(
        points={{-182,-12},{-182,-6.8},{-150,-6.8}}, color={0,127,255}));
  connect(throttle.hydraulicBus, hydraulicBus3) annotation (Line(
      points={{-186,-22},{-194,-22},{-194,-26},{-202,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, hydraulicBus3.valSet) annotation (Line(points={{-223,-38},{
          -216,-38},{-216,-36},{-201.95,-36},{-201.95,-25.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMix1.hydraulicBus, admix1.hydraulicBus) annotation (Line(
      points={{-110.56,70.01},{-106.28,70.01},{-106.28,70},{-100,70}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrMix2.hydraulicBus, admix2.hydraulicBus) annotation (Line(
      points={{-24.56,46.01},{-24.56,46},{-18,46},{-18,60}},
      color={255,204,51},
      thickness=0.5));
  connect(sine.y, simpleConsumer.T) annotation (Line(points={{-181,100},{-165.2,
          100},{-165.2,94}}, color={0,0,127}));
  connect(sine1.y, simpleConsumer1.T) annotation (Line(points={{-101,112},{
          -85.2,112},{-85.2,104}}, color={0,0,127}));
  connect(sine2.y, simpleConsumer2.T) annotation (Line(points={{-49.3,67},{
          -49.3,74.8},{-46,74.8}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{100,100}})), Icon(
        coordinateSystem(extent={{-200,-120},{100,100}})),
    experiment(
      StopTime=604800,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end MainBuildingEnergySystem;
