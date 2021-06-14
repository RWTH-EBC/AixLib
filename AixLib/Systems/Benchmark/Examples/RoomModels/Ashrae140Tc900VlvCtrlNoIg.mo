within AixLib.Systems.Benchmark.Examples.RoomModels;
model Ashrae140Tc900VlvCtrlNoIg "Ashrae140 Test Case 900 Valve Controlled"
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
    m1_flow_nominal=0.129,
    m2_flow_nominal=1,
    cooler(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        Q_nom=2000)),
    heater(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{-80,-12},{-34,38}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone
                                                    thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=BaseClasses.Ashrae140_900(),
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
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

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
  AixLib.Systems.Benchmark.BaseClasses.MainBus bus annotation (Placement(
        transformation(extent={{-20,86},{16,130}}), iconTransformation(extent={
            {110,388},{170,444}})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,-92})));
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
        origin={36,-126})));
  Modelica.Blocks.Sources.RealExpression HeatPower(y=1000*4.18*(bus.tabs1Bus.hotThrottleBus.VFlowInMea
        *(bus.tabs1Bus.hotThrottleBus.TFwrdInMea - bus.tabs1Bus.hotThrottleBus.TRtrnOutMea)
         + bus.vu1Bus.heaterBus.hydraulicBus.VFlowInMea*(bus.vu1Bus.heaterBus.hydraulicBus.TFwrdInMea
         - bus.vu1Bus.heaterBus.hydraulicBus.TRtrnOutMea)))
    annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
  Modelica.Blocks.Continuous.Integrator integratorHeat
    annotation (Placement(transformation(extent={{100,-22},{120,-2}})));
  Modelica.Blocks.Continuous.Integrator integratorCold
    annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
  Modelica.Blocks.Interfaces.RealOutput EnergyHeat
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{128,-22},{148,-2}}), iconTransformation(extent={{126,-22},{
            146,-2}})));
  Modelica.Blocks.Interfaces.RealOutput EnergyCold
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{130,-62},{150,-42}}), iconTransformation(extent={{120,-62},{
            140,-42}})));
  Modelica.Blocks.Sources.RealExpression ColdPower(y=1000*4.18*(bus.tabs1Bus.coldThrottleBus.VFlowInMea
        *(bus.tabs1Bus.coldThrottleBus.TFwrdInMea - bus.tabs1Bus.coldThrottleBus.TRtrnOutMea)
         + bus.vu1Bus.coolerBus.hydraulicBus.VFlowInMea*(bus.vu1Bus.coolerBus.hydraulicBus.TFwrdInMea
         - bus.vu1Bus.coolerBus.hydraulicBus.TRtrnOutMea)))
    annotation (Placement(transformation(extent={{72,-62},{92,-42}})));
  ModularAHU.Controller.CtrVentilationUnitValveSet ctrVentilationUnitValveSet(
      VFlowSet=3*129/3600)
    annotation (Placement(transformation(extent={{-104,122},{-84,142}})));
  Controller.CtrTabsValveSet ctrTabsValveSet
    annotation (Placement(transformation(extent={{-104,152},{-84,172}})));
  Modelica.Blocks.Interfaces.RealInput valveTabsHotSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-180,170},{-140,210}})));
  Modelica.Blocks.Interfaces.RealInput valveTabsColdSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-180,142},{-140,182}})));
  Modelica.Blocks.Interfaces.RealInput valveAhuCoolerSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-180,116},{-140,156}})));
  Modelica.Blocks.Interfaces.RealInput valveAhuHeaterSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-180,84},{-140,124}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{96,54},{116,74}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_1
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-180,-46},{-140,-6}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_2
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-180,-78},{-140,-38}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_3
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-180,-112},{-140,-72}})));
  EONERC_MainBuilding.Tabs2 tabs(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.5,
    area=48,
    thickness=0.05,
    alpha=20,
    dynamicHX1(nNodes=4, Q_nom=2000),
    dynamicHX(nNodes=4, Q_nom=2000))
    annotation (Placement(transformation(extent={{6,-68},{42,-28}})));
equation
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-59,70},{6,70},{6,58.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(ventilationUnit1.genericAHUBus, bus.vu1Bus) annotation (Line(
      points={{-57,43.25},{-57,60},{-1.91,60},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouWaterhot.ports[1], ventilationUnit1.port_a4) annotation (Line(
        points={{-56,-82},{-56,-12},{-53.78,-12}},color={0,127,255}));
  connect(bouWaterhot1.ports[1], ventilationUnit1.port_b4) annotation (Line(
        points={{-20,-76},{-50,-76},{-50,-12},{-45.96,-12}}, color={0,127,255}));
  connect(bouWatercold.ports[1], ventilationUnit1.port_a3) annotation (Line(
        points={{-8,-116},{-72,-116},{-72,-12},{-70.8,-12}}, color={0,127,255}));
  connect(bouWatercold1.ports[1], ventilationUnit1.port_b3) annotation (Line(
        points={{34,-116},{34,-112},{-66,-112},{-66,-12},{-62.98,-12}},color={0,
          127,255}));
  connect(thermalZone1.TAir, bus.TRoom1Mea) annotation (Line(points={{58.5,63.4},
          {58.5,112},{-1.91,112},{-1.91,108.11}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(HeatPower.y, integratorHeat.u)
    annotation (Line(points={{93,-12},{98,-12}}, color={0,0,127}));
  connect(integratorHeat.y, EnergyHeat)
    annotation (Line(points={{121,-12},{138,-12}}, color={0,0,127}));
  connect(integratorCold.y, EnergyCold)
    annotation (Line(points={{121,-52},{140,-52}}, color={0,0,127}));
  connect(ColdPower.y, integratorCold.u)
    annotation (Line(points={{93,-52},{98,-52}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,70},{-59,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitValveSet.genericAHUBus, bus.vu1Bus) annotation (
      Line(
      points={{-84,132.1},{-44,132.1},{-44,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabsValveSet.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-84,162},{-44,162},{-44,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabsValveSet.valveHotSet, valveTabsHotSet) annotation (Line(points=
         {{-104.3,166.1},{-121.15,166.1},{-121.15,190},{-160,190}}, color={0,0,
          127}));
  connect(ctrTabsValveSet.valveColdSet, valveTabsColdSet) annotation (Line(
        points={{-104.3,157.9},{-160,157.9},{-160,162}}, color={0,0,127}));
  connect(ctrVentilationUnitValveSet.VsetCooler, valveAhuCoolerSet) annotation (
     Line(points={{-104.2,140.6},{-121.1,140.6},{-121.1,136},{-160,136}}, color=
         {0,0,127}));
  connect(ctrVentilationUnitValveSet.VsetHeater, valveAhuHeaterSet) annotation (
     Line(points={{-104.1,132.5},{-160,132.5},{-160,104}}, color={0,0,127}));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{58.5,63.4},{92,
          63.4},{92,64},{106,64}}, color={0,0,127}));
  connect(internal_gain_1, thermalZone1.intGains[1]) annotation (Line(points={{
          -160,-26},{52,-26},{52,23.84},{51,23.84}}, color={0,0,127}));
  connect(internal_gain_2, thermalZone1.intGains[2]) annotation (Line(points={{
          -160,-58},{52,-58},{52,25.68},{51,25.68}}, color={0,0,127}));
  connect(internal_gain_3, thermalZone1.intGains[3]) annotation (Line(points={{
          -160,-92},{51,-92},{51,27.52}}, color={0,0,127}));
  connect(tabs.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{
          24,-26.1818},{62,-26.1818},{62,45.92},{56.5,45.92}}, color={191,0,0}));
  connect(tabs.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{5.82,-49.6364},{5.82,-50.8182},{-1.91,-50.8182},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(bouWatercold.ports[2], tabs.port_a2) annotation (Line(points={{-4,
          -116},{32,-116},{32,-68},{31.2,-68}}, color={0,127,255}));
  connect(bouWatercold1.ports[2], tabs.port_b2) annotation (Line(points={{38,
          -116},{38,-67.6364},{38.4,-67.6364}}, color={0,127,255}));
  connect(bouWaterhot.ports[2], tabs.port_a1) annotation (Line(points={{-52,-82},
          {10,-82},{10,-68},{9.6,-68}}, color={0,127,255}));
  connect(bouWaterhot1.ports[2], tabs.port_b1) annotation (Line(points={{-16,
          -76},{18,-76},{18,-68},{16.8,-68}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{100,
            220}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{
            100,220}})),
    experiment(
      StopTime=3600000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Ashrae140Tc900VlvCtrlNoIg;
