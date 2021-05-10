within AixLib.Systems.Benchmark;
model BenchmarkBuilding_oneRoom "Benchmark building model"
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          bou(
    redeclare package Medium = MediumWater, nPorts=1)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={206,-60})));
  EONERC_MainBuilding.HeatpumpSystem
                           heatpumpSystem(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{-42,-78},{68,-32}})));
  EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare package Medium =
        MediumWater,
                m_flow_nominal=2) annotation (Placement(transformation(
        extent={{20,-24},{-20,24}},
        rotation=0,
        origin={104,-56})));
  EONERC_MainBuilding.HeatExchangerSystem heatExchangerSystem(redeclare package
      Medium = MediumWater,
                       m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-130,-40},{-60,8}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = MediumWater,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-204,-66})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Benchmark.HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = MediumWater,
    m_flow_nominal=10,
    T_start=323.15)
    annotation (Placement(transformation(extent={{-188,-80},{-144,-34}})));
  EONERC_MainBuilding.Tabs2 tabs4_1(
    redeclare package Medium = MediumWater,
    area=30*20,
    thickness=0.3,
    alpha=15)
    annotation (Placement(transformation(extent={{158,120},{198,160}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=Benchmark.BaseClasses.BenchmarkWorkshop(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{122,340},{154,368}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weatherdata_benchmark_new.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{40,368},{60,388}})));

  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,
        0.1,0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,
        0,0; 17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0;
        25140,0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0;
        32340,0,0.1,0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1;
        39540,1,1,1,1; 39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0;
        46740,0,0.1,0,0; 46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1;
        53940,0.6,0.6,1,1; 54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1;
        61140,0.4,0.4,1,1; 61200,0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0;
        68340,0,0.1,0,0; 68400,0,0.1,0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0;
        75540,0,0.1,0,0; 75600,0,0.1,0,0; 79140,0,0.1,0,0; 79200,0,0.1,0,0;
        82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,0,0.1,0,0; 86400,0,0.1,0,0;
        89940,0,0.1,0,0; 90000,0,0.1,0,0; 93540,0,0.1,0,0; 93600,0,0.1,0,0;
        97140,0,0.1,0,0; 97200,0,0.1,0,0; 100740,0,0.1,0,0; 100800,0,0.1,0,0;
        104340,0,0.1,0,0; 104400,0,0.1,0,0; 107940,0,0.1,0,0; 108000,0,0.1,0,0;
        111540,0,0.1,0,0; 111600,0,0.1,0,0; 115140,0,0.1,0,0; 115200,0,0.1,0,0;
        118740,0,0.1,0,0; 118800,0.6,0.6,1,1; 122340,0.6,0.6,1,1; 122400,1,1,1,
        1; 125940,1,1,1,1; 126000,0.4,0.4,1,1; 129540,0.4,0.4,1,1; 129600,0,0.1,
        0,0; 133140,0,0.1,0,0; 133200,0,0.1,0,0; 136740,0,0.1,0,0; 136800,0.6,
        0.6,1,1; 140340,0.6,0.6,1,1; 140400,1,1,1,1; 143940,1,1,1,1; 144000,0.4,
        0.4,1,1; 147540,0.4,0.4,1,1; 147600,0,0.1,0,0; 151140,0,0.1,0,0; 151200,
        0,0.1,0,0; 154740,0,0.1,0,0; 154800,0,0.1,0,0; 158340,0,0.1,0,0; 158400,
        0,0.1,0,0; 161940,0,0.1,0,0; 162000,0,0.1,0,0; 165540,0,0.1,0,0; 165600,
        0,0.1,0,0; 169140,0,0.1,0,0; 169200,0,0.1,0,0; 172740,0,0.1,0,0; 172800,
        0,0.1,0,0; 176340,0,0.1,0,0; 176400,0,0.1,0,0; 179940,0,0.1,0,0; 180000,
        0,0.1,0,0; 183540,0,0.1,0,0; 183600,0,0.1,0,0; 187140,0,0.1,0,0; 187200,
        0,0.1,0,0; 190740,0,0.1,0,0; 190800,0,0.1,0,0; 194340,0,0.1,0,0; 194400,
        0,0.1,0,0; 197940,0,0.1,0,0; 198000,0,0.1,0,0; 201540,0,0.1,0,0; 201600,
        0,0.1,0,0; 205140,0,0.1,0,0; 205200,0.6,0.6,1,1; 208740,0.6,0.6,1,1;
        208800,1,1,1,1; 212340,1,1,1,1; 212400,0.4,0.4,1,1; 215940,0.4,0.4,1,1;
        216000,0,0.1,0,0; 219540,0,0.1,0,0; 219600,0,0.1,0,0; 223140,0,0.1,0,0;
        223200,0.6,0.6,1,1; 226740,0.6,0.6,1,1; 226800,1,1,1,1; 230340,1,1,1,1;
        230400,0.4,0.4,1,1; 233940,0.4,0.4,1,1; 234000,0,0.1,0,0; 237540,0,0.1,
        0,0; 237600,0,0.1,0,0; 241140,0,0.1,0,0; 241200,0,0.1,0,0; 244740,0,0.1,
        0,0; 244800,0,0.1,0,0; 248340,0,0.1,0,0; 248400,0,0.1,0,0; 251940,0,0.1,
        0,0; 252000,0,0.1,0,0; 255540,0,0.1,0,0; 255600,0,0.1,0,0; 259140,0,0.1,
        0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,0,0.1,
        0,0; 266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,0,0.1,
        0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,0,0.1,
        0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,0,0.1,
        0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,0.6,
        0.6,1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,0.4,
        0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,0,
        0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,
        1,1,1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0;
        323940,0,0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0;
        331140,0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0;
        338340,0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0;
        345540,0,0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0;
        352740,0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0;
        359940,0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0;
        367140,0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0;
        374340,0,0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,
        1; 381540,0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,
        1; 388740,0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,
        0,0; 395940,0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,
        1,1,1; 403140,1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,
        0.1,0,0; 410340,0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,
        0.1,0,0; 417540,0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,
        0.1,0,0; 424740,0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,
        0.1,0,0; 431940,0,0.1,0,0; 432000,0,0,0,0; 435540,0,0,0,0; 435600,0,0,0,
        0; 439140,0,0,0,0; 439200,0,0,0,0; 442740,0,0,0,0; 442800,0,0,0,0;
        446340,0,0,0,0; 446400,0,0,0,0; 449940,0,0,0,0; 450000,0,0,0,0; 453540,
        0,0,0,0; 453600,0,0,0,0; 457140,0,0,0,0; 457200,0,0,0,0; 460740,0,0,0,0;
        460800,0,0,0,0; 464340,0,0,0,0; 464400,0,0,0,0; 467940,0,0,0,0; 468000,
        0,0,0,0; 471540,0,0,0,0; 471600,0,0,0,0; 475140,0,0,0,0; 475200,0,0,0,0;
        478740,0,0,0,0; 478800,0,0,0,0; 482340,0,0,0,0; 482400,0,0,0,0; 485940,
        0,0,0,0; 486000,0,0,0,0; 489540,0,0,0,0; 489600,0,0,0,0; 493140,0,0,0,0;
        493200,0,0,0,0; 496740,0,0,0,0; 496800,0,0,0,0; 500340,0,0,0,0; 500400,
        0,0,0,0; 503940,0,0,0,0; 504000,0,0,0,0; 507540,0,0,0,0; 507600,0,0,0,0;
        511140,0,0,0,0; 511200,0,0,0,0; 514740,0,0,0,0; 514800,0,0,0,0; 518340,
        0,0,0,0; 518400,0,0,0,0; 521940,0,0,0,0; 522000,0,0,0,0; 525540,0,0,0,0;
        525600,0,0,0,0; 529140,0,0,0,0; 529200,0,0,0,0; 532740,0,0,0,0; 532800,
        0,0,0,0; 536340,0,0,0,0; 536400,0,0,0,0; 539940,0,0,0,0; 540000,0,0,0,0;
        543540,0,0,0,0; 543600,0,0,0,0; 547140,0,0,0,0; 547200,0,0,0,0; 550740,
        0,0,0,0; 550800,0,0,0,0; 554340,0,0,0,0; 554400,0,0,0,0; 557940,0,0,0,0;
        558000,0,0,0,0; 561540,0,0,0,0; 561600,0,0,0,0; 565140,0,0,0,0; 565200,
        0,0,0,0; 568740,0,0,0,0; 568800,0,0,0,0; 572340,0,0,0,0; 572400,0,0,0,0;
        575940,0,0,0,0; 576000,0,0,0,0; 579540,0,0,0,0; 579600,0,0,0,0; 583140,
        0,0,0,0; 583200,0,0,0,0; 586740,0,0,0,0; 586800,0,0,0,0; 590340,0,0,0,0;
        590400,0,0,0,0; 593940,0,0,0,0; 594000,0,0,0,0; 597540,0,0,0,0; 597600,
        0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0])
    "Table with profiles for internal gains"
    annotation(Placement(transformation(extent={{88,321},{102,335}})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{54,328},{88,360}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  ModularAHU.GenericAHU                genericAHU(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=15000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    perheater(redeclare HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=50,
        dp2_nominal=1000,
        tau1=5,
        tau2=15,
        dT_nom=30,
        Q_nom=60000)),
    cooler(redeclare HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per))),
        dynamicHX(
        dp1_nominal=100,
        dp2_nominal=1000,
        tau1=5,
        tau2=10,
        dT_nom=15,
        Q_nom=150000)),
    heater(redeclare HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=100,
        dp2_nominal=5000,
        tau1=5,
        tau2=15,
        dT_nom=20,
        Q_nom=60000)),
    dynamicHX(
      dp1_nominal=150,
      dp2_nominal=150,
      dT_nom=2,
      Q_nom=50000),
    humidifier(
      dp_nominal=20,
      mWat_flow_nominal=1,
      TLiqWat_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      TLiqWat_in=288.15))
    annotation (Placement(transformation(extent={{-120,220},{0,286}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Media.Air,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,250})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(nPorts=1, redeclare package
      Medium = Media.Air) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,274})));
  EONERC_MainBuilding.GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    T_amb=293.15)
    annotation (Placement(transformation(extent={{132,-120},{108,-88}})));
  Benchmark.BaseClasses.MainBus mainBus annotation (Placement(transformation(
          extent={{152,394},{198,452}}), iconTransformation(extent={{110,388},{
            170,444}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-182,260},{-162,280}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    V=0.01,
    nPorts=3)
    annotation (Placement(transformation(extent={{114,76},{134,96}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    V=0.01,
    nPorts=3)
    annotation (Placement(transformation(extent={{130,100},{150,120}})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{84,-60},{80,-60},{80,-57.5556},{68,-57.5556}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{68,-47.3333},{78,-47.3333},{78,-36},{84,-36}},
                                                    color={0,127,255}));
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{0,-110},{14,-110},{14,-75.4444},{13,-75.4444}}, color={191,
          0,0}));
  connect(highTemperatureSystem.port_b, heatExchangerSystem.port_a1)
    annotation (Line(points={{-144,-66.2},{-142,-66.2},{-142,-66},{-138,-66},{
          -138,-20.8},{-130,-20.8}}, color={238,46,47}));
  connect(highTemperatureSystem.port_a, heatExchangerSystem.port_b1)
    annotation (Line(points={{-188,-66.2},{-188,-66},{-194,-66},{-194,-11.2},{
          -130,-11.2}}, color={238,46,47}));
  connect(boundary1.ports[1], highTemperatureSystem.port_a) annotation (Line(
        points={{-196,-66},{-196,-66.2},{-188,-66.2}},            color={0,127,
          255}));
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{60,378},{98,378},{98,362.4},{122,362.4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{60,378},{71,378},{71,344}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{102.7,
          328},{150.8,328},{150.8,342.24}}, color={0,0,127}));
  connect(tabs4_1.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{178,
          161.818},{162,161.818},{162,354.56},{154.32,354.56}},
                                                             color={191,0,0}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-42,-47.3333},{-75,-47.3333},{-75,-40}}, color={244,125,35}));
  connect(heatExchangerSystem.port_b3, heatpumpSystem.port_a2) annotation (Line(
        points={{-65,-39.52},{-65,-57.5556},{-42,-57.5556}}, color={244,125,35}));
  connect(boundaryOutsideAir.ports[1],genericAHU. port_a1)
    annotation (Line(points={{-130,250},{-120,250}},
                                                 color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU. port_b2)
    annotation (Line(points={{-130,274},{-120,274}},
                                                 color={0,127,255}));
  connect(highTemperatureSystem.port_b, genericAHU.port_a5) annotation (Line(
        points={{-144,-66.2},{-140,-66.2},{-140,130},{-38.1818,130},{-38.1818,
          220}}, color={238,46,47}));
  connect(highTemperatureSystem.port_a, genericAHU.port_b5) annotation (Line(
        points={{-188,-66.2},{-192,-66.2},{-192,104.157},{-192,140},{-27.8182,
          140},{-27.8182,220}},
                 color={238,46,47}));
  connect(boundaryOutsideAir.T_in, weaBus.TDryBul) annotation (Line(points={{-152,
          246},{-218,246},{-218,344},{71,344}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalFieldSimple.port_b, switchingUnit.port_a3) annotation (Line(
        points={{110,-88},{96,-88},{96,-80}},   color={0,127,255}));
  connect(geothermalFieldSimple.port_a, switchingUnit.port_b3) annotation (Line(
        points={{130,-88},{130,-80},{112,-80}}, color={0,127,255}));
  connect(genericAHU.genericAHUBus, mainBus.ahuBus) annotation (Line(
      points={{-60,286.3},{-60,423.145},{175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(tabs4_1.tabsBus, mainBus.tabs1Bus) annotation (Line(
      points={{157.8,138.364},{120,138.364},{120,166},{580,166},{580,423.145},{
          175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalZone1.TAir, mainBus.TRoom1Mea) annotation (Line(points={{155.6,
          365.2},{156,365.2},{156,423.145},{175.115,423.145}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(highTemperatureSystem.highTemperatureSystemBus, mainBus.htsBus)
    annotation (Line(
      points={{-165.78,-34},{-165.78,-6},{-166,-6},{-166,22},{-218,22},{-218,423.145},
          {175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatExchangerSystem.hxBus, mainBus.hxBus) annotation (Line(
      points={{-98,8},{-98,22},{-218,22},{-218,423.145},{175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatpumpSystem.heatPumpSystemBus, mainBus.hpSystemBus) annotation (
      Line(
      points={{13,-32},{16,-32},{16,22},{-218,22},{-218,423.145},{175.115,
          423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(switchingUnit.sWUBus, mainBus.swuBus) annotation (Line(
      points={{104.2,-31.6},{104.2,-4},{120,-4},{120,22},{-218,22},{-218,
          423.145},{175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalFieldSimple.twoCircuitBus, mainBus.gtfBus) annotation (Line(
      points={{132.1,-98.1},{142,-98.1},{142,-160},{-236,-160},{-236,423.145},
          {175.115,423.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundaryOutsideAir.T_in, x_pTphi.T) annotation (Line(points={{-152,
          246},{-194,246},{-194,264},{-190,264},{-190,270},{-184,270}}, color={
          0,0,127}));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{-184,264},{-210,
          264},{-210,270},{-238,270},{-238,344},{71,344}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.p_in, weaBus.pAtm) annotation (Line(points={{-184,276},{-206,
          276},{-206,284},{-226,284},{-226,344},{71,344}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.X, boundaryOutsideAir.X_in) annotation (Line(points={{-161,
          270},{-158,270},{-158,254},{-152,254}}, color={0,0,127}));
  connect(boundaryOutsideAir.T_in, prescribedTemperature.T) annotation (Line(
        points={{-152,246},{-218,246},{-218,-110},{-22,-110}}, color={0,0,127}));
  connect(bou.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{196,-60},{124,-60}}, color={0,127,255}));
  connect(switchingUnit.port_a1, vol.ports[1]) annotation (Line(points={{124,-36},
          {124,76},{121.333,76}},      color={0,127,255}));
  connect(switchingUnit.port_b2, vol1.ports[1]) annotation (Line(points={{124,-60},
          {137.333,-60},{137.333,100}},      color={0,127,255}));
  connect(vol1.ports[2], genericAHU.port_a4) annotation (Line(points={{140,100},
          {-60,100},{-60,220}}, color={0,127,255}));
  connect(vol1.ports[3], tabs4_1.port_a2) annotation (Line(points={{142.667,100},
          {170,100},{170,120}}, color={0,127,255}));
  connect(vol.ports[2], genericAHU.port_b4) annotation (Line(points={{124,76},
          {-49.0909,76},{-49.0909,220}},color={0,127,255}));
  connect(vol.ports[3], tabs4_1.port_b2) annotation (Line(points={{126.667,76},
          {186,76},{186,120.364}}, color={0,127,255}));
  connect(genericAHU.port_a2, thermalZone1.ports[1]) annotation (Line(points=
          {{0.545455,274},{134.273,274},{134.273,343.92},{134.24,343.92}},
        color={0,127,255}));
  connect(genericAHU.port_b1, thermalZone1.ports[2]) annotation (Line(points=
          {{0.545455,250},{142,250},{142,343.92},{141.76,343.92}}, color={0,
          127,255}));
  connect(heatExchangerSystem.port_b2, tabs4_1.port_a1) annotation (Line(
        points={{-75,8},{-74.5,8},{-74.5,120},{162,120}}, color={0,127,255}));
  connect(heatExchangerSystem.port_a3, tabs4_1.port_b1) annotation (Line(
        points={{-65,8},{-72,8},{-72,68},{194,68},{194,120.364}}, color={0,
          127,255}));
  annotation (Diagram(coordinateSystem(extent={{-220,-120},{580,420}})), Icon(
        coordinateSystem(extent={{-220,-120},{580,420}}), graphics={Rectangle(
          extent={{-220,420},{580,-120}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-166,316},{512,-6}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Benchmark Building")}),
    experiment(
      StopTime=86400,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end BenchmarkBuilding_oneRoom;
