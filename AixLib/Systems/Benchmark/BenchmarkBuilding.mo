within AixLib.Systems.Benchmark;
model BenchmarkBuilding "Benchmark building model"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={200,-60})));
  Model.Generation.HeatpumpSystem heatpumpSystem(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-40,-80},{70,-34}})));
  EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare package Medium =
        Medium, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{20,-24},{-20,24}},
        rotation=0,
        origin={120,-56})));
  EONERC_MainBuilding.HeatExchangerSystem heatExchangerSystem(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-130,-40},{-60,8}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-208,-66})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-84,100})));
  HydraulicModules.Admix                admix(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per, energyDynamics=
            admix.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.032,
    pipe1(length=1),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(
      kIns=0.028,
      length=5,
      dIns=0.02),
    pipe5(length=1),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=10)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,70})));
  HydraulicModules.Controller.CtrMix
                    ctrMix(
    TflowSet=313.15,
    Td=0,
    Ti=180,
    k=0.12,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-204,64},{-188,78}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer(
    kA=2000,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    T_amb=298.15,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,82},{-164,94}})));
  EONERC_MainBuilding.Controller.CtrSWU ctrSWU
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=4)
    annotation (Placement(transformation(extent={{52,-20},{72,0}})));
  EONERC_MainBuilding.Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=308.15,
    Ti=60,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-148,48},{-128,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Model.Generation.HighTemperatureSystem highTemperatureSystem(redeclare
      package Medium = Medium, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-188,-80},{-144,-34}})));
  EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus heatPumpSystemBus1
    annotation (Placement(transformation(extent={{6,-34},{26,-14}})));
  Model.Generation.BaseClasses.HighTemperatureSystemBus
    highTemperatureSystemBus1
    annotation (Placement(transformation(extent={{-178,-36},{-158,-16}})));
  Model.Generation.GeothermalProbe geothermalProbe(
    redeclare package Medium = Medium,             m_flow_nominal=1,
    nParallel=3)
    annotation (Placement(transformation(extent={{110,-118},{130,-98}})));
  Model.Generation.Tabs tabs(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20)
    annotation (Placement(transformation(extent={{140,120},{180,160}})));
  Model.Generation.BaseClasses.TabsBus tabsBus1 annotation (Placement(
        transformation(extent={{118,128},{138,148}}), iconTransformation(extent
          ={{-48,46},{-28,66}})));
  HydraulicModules.Controller.CtrMix ctrMix1(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{96,130},{116,150}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{100,120},{110,130}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=
        293.15)
    annotation (Placement(transformation(extent={{120,180},{140,200}})));
  Model.Generation.Tabs tabs1(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20)
    annotation (Placement(transformation(extent={{240,120},{280,160}})));
  HydraulicModules.Controller.CtrMix ctrMix2(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{196,130},{216,150}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{200,120},{210,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus2 annotation (Placement(
        transformation(extent={{218,128},{238,148}}), iconTransformation(extent
          ={{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs2(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20)
    annotation (Placement(transformation(extent={{340,120},{380,160}})));
  HydraulicModules.Controller.CtrMix ctrMix3(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{296,130},{316,150}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{300,120},{310,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus3 annotation (Placement(
        transformation(extent={{318,128},{338,148}}), iconTransformation(extent
          ={{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs3(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20)
    annotation (Placement(transformation(extent={{440,120},{480,160}})));
  HydraulicModules.Controller.CtrMix ctrMix4(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{396,130},{416,150}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{400,120},{410,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus4 annotation (Placement(
        transformation(extent={{418,128},{438,148}}), iconTransformation(extent
          ={{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs4(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20)
    annotation (Placement(transformation(extent={{540,120},{580,160}})));
  HydraulicModules.Controller.CtrMix ctrMix5(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{496,130},{516,150}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{500,120},{510,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus5 annotation (Placement(
        transformation(extent={{518,128},{538,148}}), iconTransformation(extent
          ={{-48,46},{-28,66}})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{100,-60},{80,-60},{80,-59.5556},{70,-59.5556}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{70,-49.3333},{94,-49.3333},{94,-36},{100,-36}},
                                                    color={0,127,255}));
  connect(heatpumpSystem.fluidportBottom1, heatExchangerSystem.port_b3)
    annotation (Line(points={{-40,-59.5556},{-64,-59.5556},{-64,-39.52},{-65,
          -39.52}}, color={0,127,255}));
  connect(heatpumpSystem.fluidportTop1, heatExchangerSystem.port_a2)
    annotation (Line(points={{-40,-49.3333},{-75,-49.3333},{-75,-40}},
                                                             color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_b2)
    annotation (Line(points={{-74,100},{-74,8},{-75,8}},  color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-188.56,70.23},{-186.315,70.23},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_b1, simpleConsumer.port_a)
    annotation (Line(points={{-176,80},{-176,88}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b)
    annotation (Line(points={{-164,80},{-164,88}}, color={0,127,255}));
  connect(ctrSWU.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{100,-10},{120,-10},{120,-31.6},{120.2,-31.6}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.mode, integerExpression.y)
    annotation (Line(points={{80,-10},{73,-10}}, color={255,127,0}));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-128.7,33.4},{-118,33.4},{-118,8},{-110,8}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-128.7,39.1},{-85,39.1},{-85,8}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{0,-110},{14,-110},{14,-77.4444},{15,-77.4444}}, color={191,0,0}));
  connect(highTemperatureSystem.port_b, heatExchangerSystem.port_a1)
    annotation (Line(points={{-144,-66.2},{-142,-66.2},{-142,-66},{-138,-66},{
          -138,-20.8},{-130,-20.8}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, heatExchangerSystem.port_b1)
    annotation (Line(points={{-188,-66.2},{-188,-66},{-194,-66},{-194,-11.2},{
          -130,-11.2}}, color={0,127,255}));
  connect(boundary1.ports[1], highTemperatureSystem.port_a) annotation (Line(
        points={{-198,-66},{-196,-66},{-196,-66.2},{-188,-66.2}}, color={0,127,
          255}));
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{190,-60},{166,-60},{166,-60},{140,-60}},
                                                   color={0,127,255}));
  connect(heatpumpSystem.heatPumpSystemBus, heatPumpSystemBus1) annotation (
      Line(
      points={{15,-34},{16,-34},{16,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(highTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystemBus1) annotation (Line(
      points={{-165.78,-34},{-165.78,-30},{-168,-30},{-168,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(admix.port_a1, highTemperatureSystem.port_b) annotation (Line(points=
          {{-176,60},{-176,2},{-138,2},{-138,-66},{-144,-66},{-144,-66.2}},
        color={0,127,255}));
  connect(admix.port_b2, heatExchangerSystem.port_b1) annotation (Line(points={
          {-164,60},{-164,24},{-194,24},{-194,-11.2},{-130,-11.2}}, color={0,
          127,255}));
  connect(geothermalProbe.port_a, switchingUnit.port_b3) annotation (Line(
        points={{110,-108},{112,-108},{112,-80}}, color={0,127,255}));
  connect(geothermalProbe.port_b, switchingUnit.port_a3) annotation (Line(
        points={{130,-108},{130,-80},{128,-80}}, color={0,127,255}));
  connect(tabs.tabsBus, tabsBus1) annotation (Line(
      points={{139.8,138.364},{130.9,138.364},{130.9,138},{128,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix1.hydraulicBus, tabsBus1.admixBus) annotation (Line(
      points={{115.3,138.9},{115.65,138.9},{115.65,138.05},{128.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, tabsBus1.valSet) annotation (Line(points={{110.5,125},{128,
          125},{128,126},{128.05,126},{128.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, tabs.heatPort) annotation (Line(points={{140,
          190},{148,190},{148,174},{160,174},{160,161.818}}, color={191,0,0}));
  connect(tabs1.tabsBus, tabsBus2) annotation (Line(
      points={{239.8,138.364},{230.9,138.364},{230.9,138},{228,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix2.hydraulicBus, tabsBus2.admixBus) annotation (Line(
      points={{215.3,138.9},{215.65,138.9},{215.65,138.05},{228.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, tabsBus2.valSet) annotation (Line(points={{210.5,125},{228,
          125},{228,126},{228.05,126},{228.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, tabs1.heatPort) annotation (Line(points={{140,
          190},{248,190},{248,174},{260,174},{260,161.818}}, color={191,0,0}));
  connect(tabs2.tabsBus, tabsBus3) annotation (Line(
      points={{339.8,138.364},{330.9,138.364},{330.9,138},{328,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix3.hydraulicBus, tabsBus3.admixBus) annotation (Line(
      points={{315.3,138.9},{315.65,138.9},{315.65,138.05},{328.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y, tabsBus3.valSet) annotation (Line(points={{310.5,125},{328,
          125},{328,126},{328.05,126},{328.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, tabs2.heatPort) annotation (Line(points={{140,
          190},{348,190},{348,174},{360,174},{360,161.818}}, color={191,0,0}));
  connect(tabs3.tabsBus, tabsBus4) annotation (Line(
      points={{439.8,138.364},{430.9,138.364},{430.9,138},{428,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix4.hydraulicBus, tabsBus4.admixBus) annotation (Line(
      points={{415.3,138.9},{415.65,138.9},{415.65,138.05},{428.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y, tabsBus4.valSet) annotation (Line(points={{410.5,125},{428,
          125},{428,126},{428.05,126},{428.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, tabs3.heatPort) annotation (Line(points={{140,
          190},{448,190},{448,174},{460,174},{460,161.818}}, color={191,0,0}));
  connect(tabs4.tabsBus, tabsBus5) annotation (Line(
      points={{539.8,138.364},{530.9,138.364},{530.9,138},{528,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix5.hydraulicBus, tabsBus5.admixBus) annotation (Line(
      points={{515.3,138.9},{515.65,138.9},{515.65,138.05},{528.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const4.y, tabsBus5.valSet) annotation (Line(points={{510.5,125},{528,
          125},{528,126},{528.05,126},{528.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, tabs4.heatPort) annotation (Line(points={{140,
          190},{560,190},{560,161.818}}, color={191,0,0}));
  connect(switchingUnit.port_b2, tabs.port_a2) annotation (Line(points={{140,
          -60},{152,-60},{152,120}}, color={0,127,255}));
  connect(tabs4.port_a2, tabs.port_a2) annotation (Line(points={{552,120},{552,
          100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs1.port_a2, tabs.port_a2) annotation (Line(points={{252,120},{254,
          120},{254,100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs2.port_a2, tabs.port_a2) annotation (Line(points={{352,120},{354,
          120},{354,100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs3.port_a2, tabs.port_a2) annotation (Line(points={{452,120},{452,
          100},{152,100},{152,120}}, color={0,127,255}));
  connect(switchingUnit.port_a1, tabs.port_b2) annotation (Line(points={{140,
          -36},{176,-36},{176,120.364}}, color={0,127,255}));
  connect(tabs4.port_b2, tabs.port_b2) annotation (Line(points={{576,120.364},{
          576,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs1.port_b2, tabs.port_b2) annotation (Line(points={{276,120.364},{
          276,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs2.port_b2, tabs.port_b2) annotation (Line(points={{376,120.364},{
          376,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs3.port_b2, tabs.port_b2) annotation (Line(points={{476,120.364},{
          476,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(heatExchangerSystem.port_a3, tabs4.port_b1) annotation (Line(points={
          {-65,8},{-64,8},{-64,40},{568,40},{568,120}}, color={238,46,47}));
  connect(heatExchangerSystem.port_b2, tabs4.port_a1) annotation (Line(points={
          {-75,8},{-75,60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs.port_a1, tabs4.port_a1) annotation (Line(points={{144,120},{144,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs1.port_a1, tabs4.port_a1) annotation (Line(points={{244,120},{244,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs2.port_a1, tabs4.port_a1) annotation (Line(points={{344,120},{344,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs3.port_a1, tabs4.port_a1) annotation (Line(points={{444,120},{444,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs.port_b1, tabs4.port_b1) annotation (Line(points={{168,120},{168,
          40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs1.port_b1, tabs4.port_b1) annotation (Line(points={{268,120},{268,
          40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs2.port_b1, tabs4.port_b1) annotation (Line(points={{368,120},{370,
          120},{370,40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs3.port_b1, tabs4.port_b1) annotation (Line(points={{468,120},{470,
          120},{470,40},{568,40},{568,120}}, color={238,46,47}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{360,200}})), Icon(
        coordinateSystem(extent={{-200,-120},{360,200}})),
    experiment(
      StopTime=2419200,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end BenchmarkBuilding;
