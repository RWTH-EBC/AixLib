within AixLib.Systems.EONERC_Testhall;
model EON_ERC_Testhall
  "Model of EON ERC Testhall including Monitoring Data and Weather Data from 25.Oct 2022 12am till 26.Oct 2023 12am"

  Fluid.Sources.Boundary_ph        EHA(redeclare package Medium = Media.Air,
      nPorts=1) "AirOut" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={145,65})));
  Fluid.Sources.Boundary_pT            ODA(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = AixLib.Media.Air,
    nPorts=1) "ODA"
    annotation (Placement(transformation(extent={{150,10},{140,20}})));
  Fluid.Sources.Boundary_pT        sup_c(
    redeclare package Medium = Media.Water,
    p=115000,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=270,
        origin={86,-5})));
    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{104,-20},{94,-10}})));
  ModularAHU.GenericAHU                ahu(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Water,
    T_amb=288.15,
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    usePreheater=true,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(
      hydraulicModuleIcon="Injection",
      m2_flow_nominal=0.3,
      redeclare HydraulicModules.Injection hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=1.2),
        pipe2(length=0.1, nNodes=1),
        pipe3(length=0.1),
        pipe4(length=2.3),
        pipe5(
          length=2,
          fac=10,
          nNodes=1),
        pipe6(length=0.1),
        pipe7(length=1.3),
        pipe8(length=0.3),
        pipe9(length=0.3),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))),
      dynamicHX(nNodes=1)),
    cooler(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=5,
      redeclare HydraulicModules.Injection2WayValve hydraulicModule(
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
        Kv=25,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H05_16()))),
    heater(
      hydraulicModuleIcon="Admix",
      m2_flow_nominal=0.4,
      redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H05_12()),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5, fac=10),
        pipe5(length=12, nNodes=1),
        pipe6(length=0.6)),
      dynamicHX(nNodes=1)))
    annotation (Placement(transformation(extent={{120,20},{40,60}})));
  Subsystems.CeilingInjectionDiffusor.CIDSystem_approx cid
    annotation (Placement(transformation(extent={{-12,-2},{8,18}})));
  Subsystems.JetNozzle.JN jN
    annotation (Placement(transformation(extent={{20,40},{0,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_rad(alpha=0)
    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={-3,107})));
  Modelica.Blocks.Sources.Constant intGains_rad(k=0)
    annotation (Placement(transformation(extent={{24,102},{14,112}})));
  Subsystems.ConcreteCoreActivation.CCASystem cCA
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/Aachen_251022_251023.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-160,100},{-140,120}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-100,
            120},{-80,140}}),    iconTransformation(extent={{-20,120},{20,160}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{100,100},{120,120}})));

  Subsystems.DistrictHeatingStation.DHS_substation distributor_withoutReserve
    annotation (Placement(transformation(extent={{-104,-60},{-40,-20}})));
  Subsystems.CeilingPanelHeaters.CPHSystem cPH
    annotation (Placement(transformation(extent={{-120,0},{-100,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cph_heatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,50})));
  Modelica.Blocks.Sources.CombiTimeTable QFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall2.txt"),
    columns=2:13,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "12 - Qflow in W"
    annotation (Placement(transformation(extent={{-170,40},{-150,60}})));
  Controller controller
    annotation (Placement(transformation(extent={{-170,-10},{-150,10}})));
ThermalZones.ReducedOrder.ThermalZone.ThermalZone testhall(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=288.15,
    internalGainsMode=1,
    use_C_flow=false,
    use_moisture_balance=false,
    redeclare package Medium = AixLib.Media.Air,
    redeclare
      ThermalZone.TeaserOutput.EON_ERC_Testhall.EON_ERC_Testhall_DataBase.EON_ERC_Testhall_Hall1
      zoneParam(
      T_start=288.15,
      AExt={95.91,389.64,711.0,629.0,389.64},
      specificPeople=0.01,
      activityDegree=1,
      fixedHeatFlowRatePersons=40,
      ratioConvectiveHeatPeople=0.2,
      internalGainsMachinesSpecific=1,
      lightingPowerSpecific=0.2,
      HeaterOn=false),
    redeclare model corG =
        ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_MechanicalAirExchange=false,
    use_NaturalAirExchange=false,
    nPorts=2) "ThermalZone of Testhall"
    annotation (Placement(transformation(extent={{-60,80},{-20,120}})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/InternalGains_EON_ERC_Testhall.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{-70,64},{-60,74}})));

  Fluid.Sources.Boundary_pT        ret_c(
    redeclare package Medium = Media.Water,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=90,
        origin={69,-5})));
  Subsystems.BaseClasses.Interfaces.MainBus mainBus annotation (Placement(
        transformation(extent={{-70,8},{-50,28}}), iconTransformation(extent={{
            -152,-68},{-112,-28}})));
equation
  connect(CoolerInput.y[1],sup_c. T_in) annotation (Line(points={{93.5,-15},{88,
          -15},{88,-11}},                      color={0,0,127}));
  connect(ODA.ports[1],ahu. port_a1)
    annotation (Line(points={{140,15},{140,14},{130,14},{130,38.1818},{120,
          38.1818}},                               color={0,127,255}));
  connect(ret_c.ports[1],ahu. port_b4) annotation (Line(points={{69,0},{68,0},{
          68,6},{72.7273,6},{72.7273,20}},
                                       color={0,127,255}));
  connect(sup_c.ports[1],ahu. port_a4) annotation (Line(points={{86,
          -1.77636e-15},{86,6},{80,6},{80,20}},
                           color={0,127,255}));
  connect(ahu.port_b1, cid.port_a1) annotation (Line(points={{39.6364,38.1818},
          {34,38.1818},{34,38},{30,38},{30,28},{-6,28},{-6,18}}, color={0,127,
          255}));
  connect(ahu.port_a2, cid.port_b1) annotation (Line(points={{39.6364,52.7273},
          {26,52.7273},{26,28},{2,28},{2,18}}, color={0,127,255}));
  connect(jN.port_b2, ahu.port_a2) annotation (Line(points={{20,55},{20,56},{26,
          56},{26,52.7273},{39.6364,52.7273}}, color={0,127,255}));
  connect(ahu.port_b1, jN.port_a1) annotation (Line(points={{39.6364,38.1818},{
          34,38.1818},{34,38},{30,38},{30,45},{20,45}}, color={0,127,255}));
  connect(intGains_rad.y,thermalzone_intGains_rad. Q_flow) annotation (Line(
        points={{13.5,107},{2,107}},                color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-140,110},{-90,110},{-90,130}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{98,104},{80,104},
          {80,130},{-90,130}},  color={0,0,127}));
  connect(x_pTphi.p_in, weaBus.pAtm)
    annotation (Line(points={{98,116},{80,116},{80,130},{-90,130}},
                                                            color={0,0,127}));
  connect(x_pTphi.T, weaBus.TDryBul) annotation (Line(points={{98,110},{80,110},
          {80,130},{-90,130}},  color={0,0,127}));
  connect(ODA.T_in, weaBus.TDryBul) annotation (Line(points={{151,17},{154,17},
          {154,130},{-90,130}},        color={0,0,127}));
  connect(ODA.X_in, x_pTphi.X) annotation (Line(points={{151,13},{154,13},{154,
          110},{121,110}},            color={0,0,127}));
  connect(cph_heatFlow.port, cPH.heat_port_CPH) annotation (Line(points={{-120,50},
          {-110,50},{-110,34}},                          color={191,0,0}));
  connect(QFlowHall2.y[12], cph_heatFlow.Q_flow) annotation (Line(points={{-149,50},
          {-140,50}},                              color={0,0,127}));
  connect(weaBus.TDryBul,controller. T_amb) annotation (Line(
      points={{-90,130},{-90,106},{-106,106},{-106,80},{-180,80},{-180,0},{
          -169.8,0}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_b2, EHA.ports[1])
    annotation (Line(points={{120,52.7273},{120,54},{130,54},{130,66},{140,66},
          {140,65}},                             color={0,127,255}));
  connect(distributor_withoutReserve.port_b1, cid.port_a2) annotation (Line(
        points={{-40.4,-26},{-6,-26},{-6,-2}}, color={0,127,255}));
  connect(distributor_withoutReserve.port_a, cid.port_b2) annotation (Line(
        points={{-40.4,-54},{-40.4,-54.15},{2,-54.15},{2,-2}}, color={0,127,255}));
  connect(distributor_withoutReserve.port_b1, ahu.port_a5) annotation (Line(
        points={{-40.4,-26},{60,-26},{60,10},{66,10},{66,20},{65.4545,20}},
        color={0,127,255}));
  connect(distributor_withoutReserve.port_a, ahu.port_b5) annotation (Line(
        points={{-40.4,-54},{58,-54},{58,20},{58.5455,20}},
        color={0,127,255}));
  connect(distributor_withoutReserve.port_a, ahu.port_b3) annotation (Line(
        points={{-40.4,-54},{106,-54},{106,0},{100,0},{100,20},{101.818,20}},
        color={0,127,255}));
  connect(distributor_withoutReserve.port_b1, ahu.port_a3) annotation (Line(
        points={{-40.4,-26},{110,-26},{110,20},{109.091,20}},
        color={0,127,255}));
  connect(distributor_withoutReserve.port_b1, cPH.port_a) annotation (Line(
        points={{-40.4,-26},{-26,-26},{-26,-8},{-116,-8},{-116,0},{-115,0}},
        color={0,127,255}));
  connect(distributor_withoutReserve.port_a, cPH.port_b) annotation (Line(
        points={{-40.4,-54},{-30,-54},{-30,-12},{-105,-12},{-105,0}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.port_b1, cCA.port_a) annotation (Line(
        points={{-40.4,-26},{-38,-26},{-38,0},{-43,0},{-43,40}}, color={0,127,
          255}));
  connect(cCA.port_b, distributor_withoutReserve.port_a) annotation (Line(
        points={{-37,39.8},{-36,39.8},{-36,-54},{-40.4,-54}}, color={0,127,255}));
  connect(tableInternalGains.y, testhall.intGains)
    annotation (Line(points={{-59.5,69},{-24,69},{-24,83.2}},
                                                          color={0,0,127}));
  connect(jN.port_a2, testhall.ports[1]) annotation (Line(points={{0,55},{-6,55},
          {-6,72},{-38,72},{-38,85.6},{-42.35,85.6}}, color={0,127,255}));
  connect(jN.port_b1, testhall.ports[2]) annotation (Line(points={{0,45},{-14,
          45},{-14,64},{-42,64},{-42,85.6},{-37.65,85.6}}, color={0,127,255}));
  connect(thermalzone_intGains_rad.port, testhall.intGainsRad)
    annotation (Line(points={{-8,107},{-8,106.8},{-19.6,106.8}},
                                                            color={191,0,0}));
  connect(cCA.heat_port_CCA, testhall.intGainsConv) annotation (Line(points={{-40,60},
          {-40,74},{-8,74},{-8,102},{-19.6,102},{-19.6,100.8}},
                                                             color={191,0,0}));
  connect(weaBus, testhall.weaBus) annotation (Line(
      points={{-90,130},{-90,112},{-60,112}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(controller.mainBus, mainBus) annotation (Line(
      points={{-150,0},{-146,0},{-146,-14},{-72,-14},{-72,18},{-60,18}},
      color={255,204,51},
      thickness=0.5));
  connect(distributor_withoutReserve.distributeBus_DHS, mainBus.bus_dhs)
    annotation (Line(
      points={{-72,-20},{-72,18.05},{-59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  connect(cPH.cphBus, mainBus.bus_cph) annotation (Line(
      points={{-120,17.1214},{-130,17.1214},{-130,-14},{-72,-14},{-72,18.05},{
          -59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  connect(cCA.ccaBus, mainBus.bus_cca) annotation (Line(
      points={{-50,50},{-59.95,50},{-59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  connect(cid.cIDBus, mainBus.bus_cid) annotation (Line(
      points={{-12,8},{-24,8},{-24,18.05},{-59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  connect(jN.jNBus, mainBus.bus_jn) annotation (Line(
      points={{10,60},{10,66},{-20,66},{-20,18.05},{-59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.genericAHUBus, mainBus.bus_ahu) annotation (Line(
      points={{80,60.1818},{80,66},{-20,66},{-20,18.05},{-59.95,18.05}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{180,
            140}}), graphics={Bitmap(
          extent={{-180,-140},{180,140}},
          imageSource=
              "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",

          fileName=
              "U:/EBC_ALLE/Vorlagen/Piktogramme_EBC/ERC-Gebäude/Halle.png")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{
            180,140}})),
    experiment(
      StartTime=1000000,
      StopTime=10000000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end EON_ERC_Testhall;
