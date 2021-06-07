within AixLib.Systems.EONERC_MainBuilding;
model MainBuilding2Zones "Benchmark building model"
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          bou(
    redeclare package Medium = MediumWater, nPorts=1)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={398,-60})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-40,-80},{70,-34}})));
  EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare package Medium =
        MediumWater,
                m_flow_nominal=2) annotation (Placement(transformation(
        extent={{20,-24},{-20,24}},
        rotation=0,
        origin={256,-56})));
  EONERC_MainBuilding.HeatExchangerSystem heatExchangerSystem(redeclare package
      Medium = MediumWater,
                       m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-130,-40},{-60,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,-108})));
  EONERC_MainBuilding.Tabs2 tabs1(
    redeclare package Medium = MediumWater,
    area=30*20,
    thickness=0.3,
    alpha=15)
    annotation (Placement(transformation(extent={{158,120},{198,160}})));
  EONERC_MainBuilding.Tabs2 tabs2(
    redeclare package Medium = MediumWater,
    area=30*30,
    thickness=0.3,
    alpha=15)
    annotation (Placement(transformation(extent={{364,122},{404,162}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=BaseClasses.ERCMainBuilding_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{112,296},{168,354}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
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
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={165,280})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{44,334},{78,366}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone2(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=BaseClasses.ERCMainBuilding_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{294,206},{350,260}})));
  ModularAHU.GenericAHU                genericAHU(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=12000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    perheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
    annotation (Placement(transformation(extent={{-94,248},{26,314}})));
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
  Fluid.Sources.Boundary_pT boundaryExhaustAir(          redeclare package
      Medium = Media.Air, nPorts=1)
                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-146,302})));
  EONERC_MainBuilding.GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    T_amb=293.15)
    annotation (Placement(transformation(extent={{272,-120},{248,-88}})));
  EONERC_MainBuilding.BaseClasses.MainBus2ZoneMainBuilding mainBus annotation (
      Placement(transformation(extent={{138,390},{184,448}}),
        iconTransformation(extent={{110,388},{170,444}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-182,260},{-162,280}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    V=0.01,
    nPorts=4)
    annotation (Placement(transformation(extent={{114,76},{128,90}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    V=0.01,
    nPorts=4)
    annotation (Placement(transformation(extent={{130,100},{144,114}})));
  ModularAHU.GenericAHU                genericAHU1(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=12000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    perheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
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
    annotation (Placement(transformation(extent={{24,160},{144,226}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains1(
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
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={345,190})));

  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = MediumWater,
    p=300000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-194,-34})));
  HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = MediumWater,
    T_start=333.15,
    T_amb=293.15,
    m_flow_nominal=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                      annotation (Placement(transformation(
        extent={{-37,-29},{37,29}},
        rotation=90,
        origin={-159,-83})));
  HydraulicModules.Admix admixHTC(
    parameterPipe=DataBase.Pipes.Copper.Copper_108x2_5(),
    valve(order=1),
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          addPowerToMedium=false)),
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    T_amb=298.15,
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
        origin={-170,150})));
  HydraulicModules.Controller.CtrMix ctrMixHTC(
    TflowSet=338.15,
    Td=0,
    Ti=150,
    k=0.05,
    rpm_pump=600,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-202,144},{-188,158}})));
  HydraulicModules.SimpleConsumer consumerHTC(
    kA=20000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = MediumWater,
    functionality="Q_flow_input",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,166},{-164,178}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    V=0.01,
    nPorts=4)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-180,-20})));
  Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    V=0.01,
    nPorts=4)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-160,10})));
  Modelica.Blocks.Sources.RealExpression Q_flow_AHU1(y=-(0.9*(Tair - 273.15) +
        6)*1000)
    annotation (Placement(transformation(extent={{-198,192},{-182,208}})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU1(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-174,186})));
  HydraulicModules.Admix admixCold(
    parameterPipe=DataBase.Pipes.Copper.Copper_108x2_5(),
    valve(order=1),
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          addPowerToMedium=false)),
    redeclare package Medium = MediumWater,
    m_flow_nominal=5,
    T_amb=298.15,
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
        origin={108,-10})));
  HydraulicModules.SimpleConsumer consumerCold(
    kA=1000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = MediumWater,
    functionality="Q_flow_input",
    T_start=293.15) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={110,12})));
  HydraulicModules.Controller.CtrMix ctrMixCold(
    useExternalTset=false,
    TflowSet=285.15,
    k=0.05,
    Td=0,
    rpm_pump=1400,
    reverseAction=true)
    annotation (Placement(transformation(extent={{78,-18},{90,-4}})));
  Fluid.MixingVolumes.MixingVolume vol4(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3) annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=180,
        origin={106,-64})));
  Fluid.MixingVolumes.MixingVolume vol5(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    V=0.01,
    nPorts=3) annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=180,
        origin={122,-54})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold1(y=-(-0.18*(Tair -
        273.15) - 24.9)*1000)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={148,16})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold1(uMax=80000,  uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={126,16})));
  Modelica.Blocks.Interfaces.RealOutput Tair
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,-112}), iconTransformation(extent={{-64,-140},{-44,-120}})));
  Fluid.Sources.Boundary_pT          bou1(redeclare package Medium =
        MediumWater, nPorts=1)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-78,-88})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir1(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Media.Air,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-82,190})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir1(redeclare package Medium =
        Media.Air, nPorts=1)
                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,216})));
equation
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{18,-98},{18,-77.4444},{15,-77.4444}},           color={191,
          0,0}));
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{60,378},{112,378},{112,342.4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{60,378},{61,378},{61,350}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{165,
          287.7},{162.4,287.7},{162.4,300.64}},
                                            color={0,0,127}));
  connect(tabs1.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{178,
          161.818},{182,161.818},{182,326.16},{168.56,326.16}},     color={191,
          0,0}));
  connect(weaDat.weaBus,thermalZone2. weaBus) annotation (Line(
      points={{60,378},{216,378},{216,249.2},{294,249.2}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone2.intGainsConv, tabs2.heatPort) annotation (Line(points={{350.56,
          234.08},{384,234.08},{384,163.818}},        color={191,0,0}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-40,-49.3333},{-75,-49.3333},{-75,-40}}, color={244,125,35}));
  connect(heatExchangerSystem.port_b3, heatpumpSystem.port_a2) annotation (Line(
        points={{-65,-39.52},{-65,-59.5556},{-40,-59.5556}}, color={244,125,35}));
  connect(boundaryOutsideAir.T_in, weaBus.TDryBul) annotation (Line(points={{-152,
          246},{-218,246},{-218,350},{61,350}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalFieldSimple.port_b, switchingUnit.port_a3) annotation (Line(
        points={{250,-88},{248,-88},{248,-80}}, color={0,127,255}));
  connect(geothermalFieldSimple.port_a, switchingUnit.port_b3) annotation (Line(
        points={{270,-88},{270,-80},{264,-80}}, color={0,127,255}));

  connect(thermalZone1.TAir, mainBus.TRoom1Mea) annotation (Line(points={{170.8,
          348.2},{170,348.2},{170,419.145},{161.115,419.145}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZone2.TAir, mainBus.TRoom2Mea) annotation (Line(points={{352.8,
          254.6},{352.8,419.145},{161.115,419.145}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatExchangerSystem.hxBus, mainBus.hxBus) annotation (Line(
      points={{-98,8},{-98,22},{-220,22},{-220,420},{-30,420},{-30,419.145},{
          161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatpumpSystem.heatPumpSystemBus, mainBus.hpSystemBus) annotation (
      Line(
      points={{15,-34},{16,-34},{16,22},{-220,22},{-220,420},{-30,420},{-30,
          419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(switchingUnit.sWUBus, mainBus.swuBus) annotation (Line(
      points={{256.2,-31.6},{256.2,-2},{256,-2},{256,22},{-220,22},{-220,420},{
          -28,420},{-28,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalFieldSimple.twoCircuitBus, mainBus.gtfBus) annotation (Line(
      points={{272.1,-98.1},{312,-98.1},{312,-120},{-220,-120},{-220,419.145},{
          161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundaryOutsideAir.T_in, x_pTphi.T) annotation (Line(points={{-152,
          246},{-194,246},{-194,270},{-184,270}},                       color={
          0,0,127}));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{-184,264},{-218,
          264},{-218,350},{61,350}},                       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.p_in, weaBus.pAtm) annotation (Line(points={{-184,276},{-218,
          276},{-218,350},{61,350}},                       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.X, boundaryOutsideAir.X_in) annotation (Line(points={{-161,
          270},{-158,270},{-158,254},{-152,254}}, color={0,0,127}));
  connect(boundaryOutsideAir.T_in, prescribedTemperature.T) annotation (Line(
        points={{-152,246},{-220,246},{-220,-120},{18,-120}},  color={0,0,127}));
  connect(bou.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{388,-60},{276,-60}}, color={0,127,255}));
  connect(switchingUnit.port_a1, vol.ports[1]) annotation (Line(points={{276,-36},
          {276,76},{118.9,76}},        color={0,127,255}));
  connect(vol1.ports[1], genericAHU.port_a4) annotation (Line(points={{134.9,
          100},{-34,100},{-34,248}},
                                color={0,127,255}));
  connect(vol1.ports[2], tabs1.port_a2) annotation (Line(points={{136.3,100},{
          186,100},{186,120}},
                           color={0,127,255}));
  connect(vol1.ports[3], tabs2.port_a2) annotation (Line(points={{137.7,100},{
          392,100},{392,122}},
                           color={0,127,255}));
  connect(vol.ports[2], genericAHU.port_b4) annotation (Line(points={{120.3,76},
          {-23.0909,76},{-23.0909,248}},color={0,127,255}));
  connect(vol.ports[3], tabs1.port_b2) annotation (Line(points={{121.7,76},{194,
          76},{194,120.364}}, color={0,127,255}));
  connect(vol.ports[4], tabs2.port_b2) annotation (Line(points={{123.1,76},{400,
          76},{400,122.364}}, color={0,127,255}));
  connect(vol1.ports[1], genericAHU1.port_a4)
    annotation (Line(points={{134.9,100},{84,100},{84,160}},
                                                           color={0,127,255}));
  connect(vol.ports[2], genericAHU1.port_b4) annotation (Line(points={{120.3,76},
          {94.9091,76},{94.9091,160}}, color={0,127,255}));
  connect(genericAHU1.port_a5, genericAHU.port_a5) annotation (Line(points={{105.818,
          160},{106,160},{106,128},{-12.1818,128},{-12.1818,248}},
        color={238,46,47}));
  connect(thermalZone2.intGains, internalGains1.y) annotation (Line(points={{
          344.4,210.32},{343.2,210.32},{343.2,197.7},{345,197.7}}, color={0,0,
          127}));
  connect(genericAHU1.port_a2, thermalZone2.ports[1]) annotation (Line(points={{144.545,
          214},{231.272,214},{231.272,213.56},{315.42,213.56}},          color=
          {0,127,255}));
  connect(genericAHU1.port_b1, thermalZone2.ports[2]) annotation (Line(points={{144.545,
          190},{332,190},{332,213.56},{328.58,213.56}},          color={0,127,
          255}));
  connect(genericAHU.port_b1, thermalZone1.ports[1]) annotation (Line(points={{26.5455,
          278},{142,278},{142,304.12},{133.42,304.12}},         color={0,127,
          255}));
  connect(genericAHU.port_a2, thermalZone1.ports[2]) annotation (Line(points={{26.5455,
          302},{80,302},{80,304.12},{146.58,304.12}},         color={0,127,255}));
  connect(genericAHU1.genericAHUBus, mainBus.ahu2Bus) annotation (Line(
      points={{84,226.3},{84,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericAHU.genericAHUBus, mainBus.ahu1Bus) annotation (Line(
      points={{-34,314.3},{-36,314.3},{-36,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(tabs1.port_a1, heatExchangerSystem.port_b2) annotation (Line(points={
          {162,120},{162,54},{-75,54},{-75,8}}, color={244,125,35}));
  connect(tabs2.port_b1, heatExchangerSystem.port_a3) annotation (Line(points={{376,122},
          {376,46},{-65,46},{-65,8}},               color={244,125,35}));
  connect(tabs1.port_b1, heatExchangerSystem.port_a3) annotation (Line(points={{170,120},
          {170,46},{-65,46},{-65,8}},               color={244,125,35}));
  connect(tabs2.port_a1, heatExchangerSystem.port_b2) annotation (Line(points={
          {368,122},{368,54},{-75,54},{-75,8}}, color={244,125,35}));
  connect(tabs2.tabsBus, mainBus.tabs2Bus) annotation (Line(
      points={{363.8,140.364},{440,140.364},{440,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixHTC.hydraulicBus,admixHTC. hydraulicBus) annotation (Line(
      points={{-187.02,151.14},{-186.315,151.14},{-186.315,150},{-180,150}},
      color={255,204,51},
      thickness=0.5));
  connect(admixHTC.port_b1,consumerHTC. port_a)
    annotation (Line(points={{-176,160},{-176,172}},
                                                   color={0,127,255}));
  connect(admixHTC.port_a2,consumerHTC. port_b)
    annotation (Line(points={{-164,160},{-164,172}},
                                                   color={0,127,255}));
  connect(highTemperatureSystem.hTCBus, mainBus.htsBus) annotation (Line(
      points={{-187.71,-79.8692},{-204,-79.8692},{-204,-80},{-220,-80},{-220,
          419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(admixHTC.hydraulicBus, mainBus.consHtcBus) annotation (Line(
      points={{-180,150},{-182,150},{-182,164},{-220,164},{-220,419.145},{
          161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundary1.ports[1],highTemperatureSystem. port_b) annotation (Line(
        points={{-188,-34},{-176.4,-34},{-176.4,-46}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a,vol3. ports[1]) annotation (Line(points={{-164.8,
          -46},{-164.8,11.2},{-164,11.2}},        color={0,127,255}));
  connect(vol3.ports[2], heatExchangerSystem.port_b1) annotation (Line(points={{-164,
          10.4},{-164,-11.2},{-130,-11.2}},color={0,127,255}));
  connect(admixHTC.port_b2,vol3. ports[3]) annotation (Line(points={{-164,140},
          {-164,9.6}},           color={238,46,47}));
  connect(highTemperatureSystem.port_b, vol2.ports[1]) annotation (Line(points=
          {{-176.4,-46},{-176,-46},{-176,-21.2}}, color={0,127,255}));
  connect(vol2.ports[2], heatExchangerSystem.port_a1) annotation (Line(points={
          {-176,-20.4},{-160,-20.4},{-160,-20.8},{-130,-20.8}}, color={0,127,
          255}));
  connect(vol2.ports[3], admixHTC.port_a1)
    annotation (Line(points={{-176,-19.6},{-176,140}}, color={238,46,47}));
  connect(Q_flow_AHU1.y,limiterAHU1. u)
    annotation (Line(points={{-181.2,200},{-174,200},{-174,190.8}},
                                                         color={0,0,127}));
  connect(limiterAHU1.y,consumerHTC. Q_flow) annotation (Line(points={{-174,
          181.6},{-174,178},{-173.6,178}},        color={0,0,127}));
  connect(consumerCold.port_a, admixCold.port_b1)
    annotation (Line(points={{104,12},{104,0},{102,0}}, color={0,127,255}));
  connect(consumerCold.port_b, admixCold.port_a2)
    annotation (Line(points={{116,12},{116,0},{114,0}}, color={0,127,255}));
  connect(ctrMixCold.hydraulicBus, admixCold.hydraulicBus) annotation (Line(
      points={{90.84,-10.86},{96.72,-10.86},{96.72,-10},{98,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(heatpumpSystem.port_b1,vol4. ports[1]) annotation (Line(points={{70,
          -59.5556},{107.067,-59.5556},{107.067,-60}},color={0,127,255}));
  connect(vol4.ports[2], admixCold.port_a1) annotation (Line(points={{106,-60},
          {106,-32},{102,-32},{102,-20}}, color={0,127,255}));
  connect(vol5.ports[1], admixCold.port_b2) annotation (Line(points={{123.067,
          -50},{123.067,-24},{114,-24},{114,-20}}, color={0,127,255}));
  connect(vol5.ports[2], heatpumpSystem.port_a1) annotation (Line(points={{122,-50},
          {122,-49.3333},{70,-49.3333}},            color={0,127,255}));
  connect(limiterCCACold1.y, consumerCold.Q_flow) annotation (Line(points={{
          121.6,16},{106.4,16},{106.4,18}}, color={0,0,127}));
  connect(limiterCCACold1.u,Q_flow_CCA_cold1. y)
    annotation (Line(points={{130.8,16},{139.2,16}},   color={0,0,127}));
  connect(vol5.ports[3], switchingUnit.port_b1) annotation (Line(points={{120.933,
          -50},{198,-50},{198,-36},{236,-36}},         color={0,127,255}));
  connect(vol4.ports[3], switchingUnit.port_a2)
    annotation (Line(points={{104.933,-60},{236,-60}}, color={0,127,255}));
  connect(genericAHU1.port_b5, genericAHU.port_b5) annotation (Line(points={{116.182,
          160},{116,160},{116,120},{-1.81818,120},{-1.81818,248}},
        color={238,46,47}));
  connect(genericAHU.port_a5, vol2.ports[4]) annotation (Line(points={{-12.1818,
          248},{-12,248},{-12,128},{-176,128},{-176,-18.8}}, color={238,46,47}));
  connect(genericAHU1.port_b5, vol3.ports[4]) annotation (Line(points={{116.182,
          160},{116.182,120},{-164,120},{-164,8.8}}, color={238,46,47}));
  connect(prescribedTemperature.T, Tair) annotation (Line(points={{18,-120},{18,
          -112},{-28,-112}}, color={0,0,127}));
  connect(admixCold.hydraulicBus, mainBus.consCold1Bus) annotation (Line(
      points={{98,-10},{98,28},{-220,28},{-220,420},{161.115,420},{161.115,
          419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bou1.ports[1], heatExchangerSystem.port_a2) annotation (Line(points={
          {-78,-78},{-78,-40},{-75,-40}}, color={0,127,255}));
  connect(genericAHU.port_a1, boundaryOutsideAir.ports[1]) annotation (Line(
        points={{-94,278},{-108,278},{-108,282},{-130,282},{-130,250}}, color={
          0,127,255}));
  connect(boundaryExhaustAir.ports[1], genericAHU.port_b2) annotation (Line(
        points={{-136,302},{-116,302},{-116,302},{-94,302}}, color={0,127,255}));
  connect(x_pTphi.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-161,
          270},{-158,270},{-158,194},{-94,194}}, color={0,0,127}));
  connect(boundaryOutsideAir1.T_in, boundaryOutsideAir.T_in) annotation (Line(
        points={{-94,186},{-154,186},{-154,246},{-152,246}}, color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1], genericAHU1.port_a1)
    annotation (Line(points={{-72,190},{24,190}}, color={0,127,255}));
  connect(genericAHU1.port_b2, boundaryExhaustAir1.ports[1]) annotation (Line(
        points={{24,214},{22,214},{22,216},{18,216}}, color={0,127,255}));
  connect(tabs1.tabsBus, mainBus.tabs1Bus) annotation (Line(
      points={{157.8,138.364},{242,138.364},{242,410},{161.115,410},{161.115,
          419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switchingUnit.port_b2, vol1.ports[4]) annotation (Line(points={{276,
          -60},{294,-60},{294,100},{139.1,100}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-220,-120},{580,420}})), Icon(
        coordinateSystem(extent={{-220,-120},{580,420}}), graphics={Rectangle(
          extent={{-220,420},{580,-120}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-164,316},{514,-6}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Main Building 2 zones")}),
    experiment(
      StopTime=31536000,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end MainBuilding2Zones;
