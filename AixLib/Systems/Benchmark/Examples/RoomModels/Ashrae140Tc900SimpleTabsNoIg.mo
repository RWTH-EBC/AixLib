within AixLib.Systems.Benchmark.Examples.RoomModels;
model Ashrae140Tc900SimpleTabsNoIg
  "Ashrae140 Test Case 900 Set Point and Simple Tabs Controlled without Internal Gains"
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
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,-90})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-74})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-98,-66})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,-90})));
  Modelica.Blocks.Sources.RealExpression HeatPower(y=Q_flowTabs)
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
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{96,54},{116,74}})));
  TabsSimple tabsSimple(
    area=48,
    thickness=0.05,
    cp=1000,
    alpha=20) annotation (Placement(transformation(extent={{-12,-56},{40,-6}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowTabs
    annotation (Placement(transformation(extent={{-160,-52},{-120,-12}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic(
    useExternalTset=true,
    VFlowSet=3*129/3600,
    ctrCo(k=0.5, Ti=90),
    ctrRh(k=0.5, Ti=90))
    annotation (Placement(transformation(extent={{-92,140},{-72,160}})));
  Modelica.Blocks.Interfaces.RealInput TsetAHU
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-160,130},{-120,170}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_1
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-160,-140},{-120,-100}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_2
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-160,-172},{-120,-132}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_3
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{-160,-206},{-120,-166}})));
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
        points={{-48,-80},{-48,-84},{-54,-84},{-54,-12},{-53.78,-12}},
                                                  color={0,127,255}));
  connect(bouWaterhot1.ports[1], ventilationUnit1.port_b4) annotation (Line(
        points={{-24,-64},{-50,-64},{-50,-12},{-45.96,-12}}, color={0,127,255}));
  connect(bouWatercold.ports[1], ventilationUnit1.port_a3) annotation (Line(
        points={{-98,-56},{-72,-56},{-72,-12},{-70.8,-12}},  color={0,127,255}));
  connect(bouWatercold1.ports[1], ventilationUnit1.port_b3) annotation (Line(
        points={{-74,-80},{-74,-82},{-64,-82},{-64,-12},{-62.98,-12}}, color={0,
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
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{58.5,63.4},{92,
          63.4},{92,64},{106,64}}, color={0,0,127}));
  connect(tabsSimple.heatPort, thermalZone1.intGainsConv) annotation (Line(
        points={{14,-3.72727},{14,10.1364},{56.5,10.1364},{56.5,45.92}}, color=
          {191,0,0}));
  connect(tabsSimple.Q_flowTabs, Q_flowTabs) annotation (Line(points={{-15.12,
          -33.2727},{-140,-33.2727},{-140,-32}}, color={0,0,127}));
  connect(ctrVentilationUnitBasic.genericAHUBus, bus.vu1Bus) annotation (Line(
      points={{-72,150.1},{-50,150.1},{-50,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitBasic.Tset, TsetAHU)
    annotation (Line(points={{-94,150},{-140,150}}, color={0,0,127}));
  connect(internal_gain_1, thermalZone1.intGains[1]) annotation (Line(points={{
          -140,-120},{51,-120},{51,23.84}}, color={0,0,127}));
  connect(internal_gain_2, thermalZone1.intGains[2]) annotation (Line(points={{
          -140,-152},{52,-152},{52,25.68},{51,25.68}}, color={0,0,127}));
  connect(internal_gain_3, thermalZone1.intGains[3]) annotation (Line(points={{
          -140,-186},{52,-186},{52,27.52},{51,27.52}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-200},{140,
            160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-200},{
            140,160}})));
end Ashrae140Tc900SimpleTabsNoIg;
