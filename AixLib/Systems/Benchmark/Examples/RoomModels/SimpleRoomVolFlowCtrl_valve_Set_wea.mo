within AixLib.Systems.Benchmark.Examples.RoomModels;
model SimpleRoomVolFlowCtrl_valve_Set_wea
    extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  AixLib.Systems.ModularAHU.VentilationUnit
                             ventilationUnit1(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=2,
    m2_flow_nominal=1,
    allowFlowReversal2=false,
    cooler(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=1000,
        dT_nom=4,
        Q_nom=10000)),
    heater(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=1000,
        dT_nom=7,
        Q_nom=10000)))
    annotation (Placement(transformation(extent={{-80,-12},{-34,38}})));
  AixLib.Systems.Benchmark.Tabs2
        tabs4_1(
    redeclare package Medium = MediumWater,
    area=30*20,
    thickness=0.3,
    alpha=15)
    annotation (Placement(transformation(extent={{20,-60},{60,-20}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone
                                                    thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=AixLib.Systems.Benchmark.BaseClasses.BenchmarkCanteen(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{6,22},{56,68}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,54},{-42,86}}),
    iconTransformation(extent={{-150,388},{-130,408}})));

  AixLib.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumAir,
    p=bou1.p + 400,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-108,6},{-94,20}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,22},{-94,36}})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-90})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,-86})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-126})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-126})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{86,50},{106,70}})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,-108})));
  Modelica.Blocks.Interfaces.RealInput valveTabsHotSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,148},{-128,188}})));
  Modelica.Blocks.Interfaces.RealInput valveTabsColdSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,120},{-128,160}})));
  Modelica.Blocks.Interfaces.RealInput valveAHUCoolerSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,106},{-128,146}})));
  Modelica.Blocks.Interfaces.RealInput valveHeaterSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,94},{-128,134}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_1 annotation (Placement(
        transformation(extent={{-118,-42},{-98,-22}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_2 annotation (Placement(
        transformation(extent={{-118,-58},{-98,-38}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_3 annotation (Placement(
        transformation(extent={{-118,-72},{-98,-52}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Controller.CtrTabsValveSet ctrTabsValveSet
    annotation (Placement(transformation(extent={{-106,152},{-86,172}})));
  ModularAHU.Controller.CtrVentilationUnitValveSet ctrVentilationUnitValveSet
    annotation (Placement(transformation(extent={{-104,112},{-84,132}})));

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,

    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-144,64},{-124,84}})));
equation
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-59,70},{6,70},{6,45}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(tabs4_1.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{40,
          -18.1818},{46,-18.1818},{46,33.5},{56,33.5}},                   color=
         {191,0,0}));
  connect(ventilationUnit1.port_b1, thermalZone1.ports[1]) annotation (Line(
        points={{-33.54,13},{25.125,13},{25.125,28.44}},
                                                     color={0,127,255}));
  connect(ventilationUnit1.port_a2, thermalZone1.ports[2]) annotation (Line(
        points={{-34,28},{-12,28},{-12,28.44},{36.875,28.44}},color={0,127,255}));
  connect(bou.ports[1], ventilationUnit1.port_a1)
    annotation (Line(points={{-94,13},{-80,13}}, color={0,127,255}));
  connect(bou.T_in, weaBus.TDryBul) annotation (Line(points={{-109.4,15.8},{
          -118,15.8},{-118,92},{-59,92},{-59,70}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bou1.ports[1], ventilationUnit1.port_b2) annotation (Line(points={{
          -94,29},{-94,28},{-79.54,28}}, color={0,127,255}));
  connect(bouWaterhot1.ports[1], ventilationUnit1.port_b4) annotation (Line(
        points={{-20,-76},{-44,-76},{-44,-12},{-43.66,-12}}, color={0,127,255}));
  connect(bouWaterhot1.ports[2], tabs4_1.port_b1) annotation (Line(points={{-16,-76},
          {56,-76},{56,-59.6364}},      color={0,127,255}));
  connect(tabs4_1.port_a1, bouWaterhot.ports[1]) annotation (Line(points={{24,-60},
          {24,-80},{22,-80}},        color={0,127,255}));
  connect(bouWatercold.ports[1], tabs4_1.port_a2) annotation (Line(points={{-8,-116},
          {2,-116},{2,-102},{32,-102},{32,-60}},       color={0,127,255}));
  connect(bouWatercold1.ports[1], tabs4_1.port_b2) annotation (Line(points={{48,-116},
          {48,-59.6364}},                 color={0,127,255}));
  connect(bouWatercold1.ports[2], ventilationUnit1.port_b3) annotation (Line(
        points={{52,-116},{52,-112},{-62,-112},{-62,-12},{-61.6,-12}}, color={0,
          127,255}));
  connect(thermalZone1.TAir, TAirRoom)
    annotation (Line(points={{58.5,58.8},{96,58.8},{96,60}}, color={0,0,127}));
  connect(bouWatercold.ports[2], ventilationUnit1.port_a4) annotation (Line(
        points={{-4,-116},{-54,-116},{-54,-12},{-52.4,-12}}, color={0,127,255}));
  connect(bouWaterhot2.ports[1], ventilationUnit1.port_a3) annotation (Line(
        points={{-74,-98},{-72,-98},{-72,-12},{-70.8,-12}}, color={0,127,255}));
  connect(internal_gain_1, thermalZone1.intGains[1]) annotation (Line(points={{
          -108,-32},{-28,-32},{-28,23.84},{51,23.84}}, color={0,0,127}));
  connect(internal_gain_2, thermalZone1.intGains[2]) annotation (Line(points={{
          -108,-48},{-28,-48},{-28,25.68},{51,25.68}}, color={0,0,127}));
  connect(internal_gain_3, thermalZone1.intGains[3]) annotation (Line(points={{
          -108,-62},{-30,-62},{-30,27.52},{51,27.52}}, color={0,0,127}));
  connect(ctrTabsValveSet.tabsBus, tabs4_1.tabsBus) annotation (Line(
      points={{-86,162},{-14,162},{-14,-41.6364},{19.8,-41.6364}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrTabsValveSet.valveHotSet, valveTabsHotSet) annotation (Line(points=
         {{-106.3,166.1},{-118.15,166.1},{-118.15,168},{-148,168}}, color={0,0,
          127}));
  connect(ctrTabsValveSet.valveColdSet, valveTabsColdSet) annotation (Line(
        points={{-106.3,157.9},{-119.15,157.9},{-119.15,140},{-148,140}}, color=
         {0,0,127}));
  connect(ctrVentilationUnitValveSet.genericAHUBus, ventilationUnit1.genericAHUBus)
    annotation (Line(
      points={{-84,122.1},{-70,122.1},{-70,43.25},{-57,43.25}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrVentilationUnitValveSet.VsetCooler, valveAHUCoolerSet) annotation (
     Line(points={{-104.2,130.6},{-117.1,130.6},{-117.1,126},{-148,126}}, color=
         {0,0,127}));
  connect(ctrVentilationUnitValveSet.VsetHeater, valveHeaterSet) annotation (
      Line(points={{-104.1,122.5},{-119.05,122.5},{-119.05,114},{-148,114}},
        color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-124,74},{-92,74},{-92,70},{-59,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=36000, __Dymola_Algorithm="Dassl"));
end SimpleRoomVolFlowCtrl_valve_Set_wea;
