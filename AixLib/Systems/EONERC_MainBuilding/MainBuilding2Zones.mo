within AixLib.Systems.EONERC_MainBuilding;
model MainBuilding2Zones "Benchmark building model"
  import ModelicaServices;
  import AixLib;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.Air
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
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={8,-100})));
  AixLib.Systems.TABS.Tabs
       tabs1(
    redeclare package Medium = MediumWater,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_133x3(lambda=100),
    area=60*60,
    thickness=0.05,
    alpha=10)
    annotation (Placement(transformation(extent={{158,120},{198,160}})));
  AixLib.Systems.TABS.Tabs
       tabs2(
    redeclare package Medium = MediumWater,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_133x3(lambda=100),
    area=60*60,
    thickness=0.05,
    alpha=10)
    annotation (Placement(transformation(extent={{364,122},{404,162}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1North(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=
        AixLib.Systems.EONERC_MainBuilding.BaseClasses.ERCMainBuilding_OfficeNorth(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    use_NaturalAirExchange=true,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{112,296},{168,354}})));

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{40,368},{60,388}})));

  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/SIA2024_SingleOffice_week.txt"),
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0; 3600,0,0.1,0; 3610,0,0.1,0; 7200,0,0.1,0; 7210,0,0.1,0;
        10800,0,0.1,0; 10810,0,0.1,0; 14400,0,0.1,0; 14410,0,0.1,0; 18000,0,0.1,
        0; 18010,0,0.1,0; 21600,0,0.1,0; 21610,0,0.1,0; 25200,0,0.1,0; 25210,
        0.2,0.2,1; 28800,0.2,0.2,1; 28810,0.6,0.6,1; 32400,0.6,0.6,1; 32410,1,
        0.8,1; 36000,1,0.8,1; 36010,1,1,1; 39600,1,1,1; 39610,0.8,0.8,1; 43200,
        0.8,0.8,1; 43210,0.4,0.4,1; 46800,0.4,0.4,1; 46810,0.6,0.6,1; 50400,0.6,
        0.6,1; 50410,1,1,1; 54000,1,1,1; 54010,0.8,0.8,1; 57600,0.8,0.8,1;
        57610,0.6,0.6,1; 61200,0.6,0.6,1; 61210,0.2,0.2,1; 64800,0.2,0.2,1;
        64810,0,0.1,0; 68400,0,0.1,0; 68410,0,0.1,0; 72000,0,0.1,0; 72010,0,0.1,
        0; 75600,0,0.1,0; 75610,0,0.1,0; 79200,0,0.1,0; 79210,0,0.1,0; 82800,0,
        0.1,0; 82810,0,0.1,0; 86400,0,0.1,0; 86410,0,0.1,0; 90000,0,0.1,0;
        90010,0,0.1,0; 93600,0,0.1,0; 93610,0,0.1,0; 97200,0,0.1,0; 97210,0,0.1,
        0; 100800,0,0.1,0; 100810,0,0.1,0; 104400,0,0.1,0; 104410,0,0.1,0;
        108000,0,0.1,0; 108010,0,0.1,0; 111600,0,0.1,0; 111610,0.2,0.2,1;
        115200,0.2,0.2,1; 115210,0.6,0.6,1; 118800,0.6,0.6,1; 118810,1,0.8,1;
        122400,1,0.8,1; 122410,1,1,1; 126000,1,1,1; 126010,0.8,0.8,1; 129600,
        0.8,0.8,1; 129610,0.4,0.4,1; 133200,0.4,0.4,1; 133210,0.6,0.6,1; 136800,
        0.6,0.6,1; 136810,1,1,1; 140400,1,1,1; 140410,0.8,0.8,1; 144000,0.8,0.8,
        1; 144010,0.6,0.6,1; 147600,0.6,0.6,1; 147610,0.2,0.2,1; 151200,0.2,0.2,
        1; 151210,0,0.1,0; 154800,0,0.1,0; 154810,0,0.1,0; 158400,0,0.1,0;
        158410,0,0.1,0; 162000,0,0.1,0; 162010,0,0.1,0; 165600,0,0.1,0; 165610,
        0,0.1,0; 169200,0,0.1,0; 169210,0,0.1,0; 172800,0,0.1,0; 172810,0,0.1,0;
        176400,0,0.1,0; 176410,0,0.1,0; 180000,0,0.1,0; 180010,0,0.1,0; 183600,
        0,0.1,0; 183610,0,0.1,0; 187200,0,0.1,0; 187210,0,0.1,0; 190800,0,0.1,0;
        190810,0,0.1,0; 194400,0,0.1,0; 194410,0,0.1,0; 198000,0,0.1,0; 198010,
        0.2,0.2,1; 201600,0.2,0.2,1; 201610,0.6,0.6,1; 205200,0.6,0.6,1; 205210,
        1,0.8,1; 208800,1,0.8,1; 208810,1,1,1; 212400,1,1,1; 212410,0.8,0.8,1;
        216000,0.8,0.8,1; 216010,0.4,0.4,1; 219600,0.4,0.4,1; 219610,0.6,0.6,1;
        223200,0.6,0.6,1; 223210,1,1,1; 226800,1,1,1; 226810,0.8,0.8,1; 230400,
        0.8,0.8,1; 230410,0.6,0.6,1; 234000,0.6,0.6,1; 234010,0.2,0.2,1; 237600,
        0.2,0.2,1; 237610,0,0.1,0; 241200,0,0.1,0; 241210,0,0.1,0; 244800,0,0.1,
        0; 244810,0,0.1,0; 248400,0,0.1,0; 248410,0,0.1,0; 252000,0,0.1,0;
        252010,0,0.1,0; 255600,0,0.1,0; 255610,0,0.1,0; 259200,0,0.1,0; 259210,
        0,0.1,0; 262800,0,0.1,0; 262810,0,0.1,0; 266400,0,0.1,0; 266410,0,0.1,0;
        270000,0,0.1,0; 270010,0,0.1,0; 273600,0,0.1,0; 273610,0,0.1,0; 277200,
        0,0.1,0; 277210,0,0.1,0; 280800,0,0.1,0; 280810,0,0.1,0; 284400,0,0.1,0;
        284410,0.2,0.2,1; 288000,0.2,0.2,1; 288010,0.6,0.6,1; 291600,0.6,0.6,1;
        291610,1,0.8,1; 295200,1,0.8,1; 295210,1,1,1; 298800,1,1,1; 298810,0.8,
        0.8,1; 302400,0.8,0.8,1; 302410,0.4,0.4,1; 306000,0.4,0.4,1; 306010,0.6,
        0.6,1; 309600,0.6,0.6,1; 309610,1,1,1; 313200,1,1,1; 313210,0.8,0.8,1;
        316800,0.8,0.8,1; 316810,0.6,0.6,1; 320400,0.6,0.6,1; 320410,0.2,0.2,1;
        324000,0.2,0.2,1; 324010,0,0.1,0; 327600,0,0.1,0; 327610,0,0.1,0;
        331200,0,0.1,0; 331210,0,0.1,0; 334800,0,0.1,0; 334810,0,0.1,0; 338400,
        0,0.1,0; 338410,0,0.1,0; 342000,0,0.1,0; 342010,0,0.1,0; 345600,0,0.1,0;
        345610,0,0.1,0; 349200,0,0.1,0; 349210,0,0.1,0; 352800,0,0.1,0; 352810,
        0,0.1,0; 356400,0,0.1,0; 356410,0,0.1,0; 360000,0,0.1,0; 360010,0,0.1,0;
        363600,0,0.1,0; 363610,0,0.1,0; 367200,0,0.1,0; 367210,0,0.1,0; 370800,
        0,0.1,0; 370810,0.2,0.2,1; 374400,0.2,0.2,1; 374410,0.6,0.6,1; 378000,
        0.6,0.6,1; 378010,1,0.8,1; 381600,1,0.8,1; 381610,1,1,1; 385200,1,1,1;
        385210,0.8,0.8,1; 388800,0.8,0.8,1; 388810,0.4,0.4,1; 392400,0.4,0.4,1;
        392410,0.6,0.6,1; 396000,0.6,0.6,1; 396010,1,1,1; 399600,1,1,1; 399610,
        0.8,0.8,1; 403200,0.8,0.8,1; 403210,0.6,0.6,1; 406800,0.6,0.6,1; 406810,
        0.2,0.2,1; 410400,0.2,0.2,1; 410410,0,0.1,0; 414000,0,0.1,0; 414010,0,
        0.1,0; 417600,0,0.1,0; 417610,0,0.1,0; 421200,0,0.1,0; 421210,0,0.1,0;
        424800,0,0.1,0; 424810,0,0.1,0; 428400,0,0.1,0; 428410,0,0.1,0; 432000,
        0,0.1,0; 432010,0,0.1,0; 435600,0,0.1,0; 435610,0,0.1,0; 439200,0,0.1,0;
        439210,0,0.1,0; 442800,0,0.1,0; 442810,0,0.1,0; 446400,0,0.1,0; 446410,
        0,0.1,0; 450000,0,0.1,0; 450010,0,0.1,0; 453600,0,0.1,0; 453610,0,0.1,0;
        457200,0,0.1,0; 457210,0,0.1,0; 460800,0,0.1,0; 460810,0,0.1,0; 464400,
        0,0.1,0; 464410,0,0.1,0; 468000,0,0.1,0; 468010,0,0.1,0; 471600,0,0.1,0;
        471610,0,0.1,0; 475200,0,0.1,0; 475210,0,0.1,0; 478800,0,0.1,0; 478810,
        0,0.1,0; 482400,0,0.1,0; 482410,0,0.1,0; 486000,0,0.1,0; 486010,0,0.1,0;
        489600,0,0.1,0; 489610,0,0.1,0; 493200,0,0.1,0; 493210,0,0.1,0; 496800,
        0,0.1,0; 496810,0,0.1,0; 500400,0,0.1,0; 500410,0,0.1,0; 504000,0,0.1,0;
        504010,0,0.1,0; 507600,0,0.1,0; 507610,0,0.1,0; 511200,0,0.1,0; 511210,
        0,0.1,0; 514800,0,0.1,0; 514810,0,0.1,0; 518400,0,0.1,0; 518410,0,0.1,0;
        522000,0,0.1,0; 522010,0,0.1,0; 525600,0,0.1,0; 525610,0,0.1,0; 529200,
        0,0.1,0; 529210,0,0.1,0; 532800,0,0.1,0; 532810,0,0.1,0; 536400,0,0.1,0;
        536410,0,0.1,0; 540000,0,0.1,0; 540010,0,0.1,0; 543600,0,0.1,0; 543610,
        0,0.1,0; 547200,0,0.1,0; 547210,0,0.1,0; 550800,0,0.1,0; 550810,0,0.1,0;
        554400,0,0.1,0; 554410,0,0.1,0; 558000,0,0.1,0; 558010,0,0.1,0; 561600,
        0,0.1,0; 561610,0,0.1,0; 565200,0,0.1,0; 565210,0,0.1,0; 568800,0,0.1,0;
        568810,0,0.1,0; 572400,0,0.1,0; 572410,0,0.1,0; 576000,0,0.1,0; 576010,
        0,0.1,0; 579600,0,0.1,0; 579610,0,0.1,0; 583200,0,0.1,0; 583210,0,0.1,0;
        586800,0,0.1,0; 586810,0,0.1,0; 590400,0,0.1,0; 590410,0,0.1,0; 594000,
        0,0.1,0; 594010,0,0.1,0; 597600,0,0.1,0; 597610,0,0.1,0; 601200,0,0.1,0;
        601210,0,0.1,0; 604800,0,0.1,0])
    "Table with profiles for internal gains"
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={165,280})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{44,334},{78,366}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone2South(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=
        AixLib.Systems.EONERC_MainBuilding.BaseClasses.ERCMainBuilding_OfficeSouth(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    use_NaturalAirExchange=true,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{294,206},{350,260}})));

  ModularAHU.GenericAHU genericAHU1(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=12000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
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
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
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
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=100,
        dp2_nominal=5000,
        tau1=5,
        tau2=15,
        dT_nom=20,
        Q_nom=100000)),
    dynamicHX(
      nNodes=5,
      dT_nom=1,
      Q_nom=170000),
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
    redeclare package Medium = MediumAir,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,250})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
        MediumAir,        nPorts=1)
                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-146,302})));
  EONERC_MainBuilding.GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    T_amb=293.15)
    annotation (Placement(transformation(extent={{272,-120},{248,-88}})));
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.MainBus2Zones mainBus
    annotation (Placement(transformation(extent={{138,390},{184,448}}),
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
  ModularAHU.GenericAHU                genericAHU2(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=12000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
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
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
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
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=100,
        dp2_nominal=5000,
        tau1=5,
        tau2=15,
        dT_nom=20,
        Q_nom=100000)),
    dynamicHX(
      nNodes=5,
      dT_nom=1,
      Q_nom=170000),
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
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/SIA2024_SingleOffice_week.txt"),
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0; 3600,0,0.1,0; 3610,0,0.1,0; 7200,0,0.1,0; 7210,0,0.1,0;
        10800,0,0.1,0; 10810,0,0.1,0; 14400,0,0.1,0; 14410,0,0.1,0; 18000,0,0.1,
        0; 18010,0,0.1,0; 21600,0,0.1,0; 21610,0,0.1,0; 25200,0,0.1,0; 25210,
        0.2,0.2,1; 28800,0.2,0.2,1; 28810,0.6,0.6,1; 32400,0.6,0.6,1; 32410,1,
        0.8,1; 36000,1,0.8,1; 36010,1,1,1; 39600,1,1,1; 39610,0.8,0.8,1; 43200,
        0.8,0.8,1; 43210,0.4,0.4,1; 46800,0.4,0.4,1; 46810,0.6,0.6,1; 50400,0.6,
        0.6,1; 50410,1,1,1; 54000,1,1,1; 54010,0.8,0.8,1; 57600,0.8,0.8,1;
        57610,0.6,0.6,1; 61200,0.6,0.6,1; 61210,0.2,0.2,1; 64800,0.2,0.2,1;
        64810,0,0.1,0; 68400,0,0.1,0; 68410,0,0.1,0; 72000,0,0.1,0; 72010,0,0.1,
        0; 75600,0,0.1,0; 75610,0,0.1,0; 79200,0,0.1,0; 79210,0,0.1,0; 82800,0,
        0.1,0; 82810,0,0.1,0; 86400,0,0.1,0; 86410,0,0.1,0; 90000,0,0.1,0;
        90010,0,0.1,0; 93600,0,0.1,0; 93610,0,0.1,0; 97200,0,0.1,0; 97210,0,0.1,
        0; 100800,0,0.1,0; 100810,0,0.1,0; 104400,0,0.1,0; 104410,0,0.1,0;
        108000,0,0.1,0; 108010,0,0.1,0; 111600,0,0.1,0; 111610,0.2,0.2,1;
        115200,0.2,0.2,1; 115210,0.6,0.6,1; 118800,0.6,0.6,1; 118810,1,0.8,1;
        122400,1,0.8,1; 122410,1,1,1; 126000,1,1,1; 126010,0.8,0.8,1; 129600,
        0.8,0.8,1; 129610,0.4,0.4,1; 133200,0.4,0.4,1; 133210,0.6,0.6,1; 136800,
        0.6,0.6,1; 136810,1,1,1; 140400,1,1,1; 140410,0.8,0.8,1; 144000,0.8,0.8,
        1; 144010,0.6,0.6,1; 147600,0.6,0.6,1; 147610,0.2,0.2,1; 151200,0.2,0.2,
        1; 151210,0,0.1,0; 154800,0,0.1,0; 154810,0,0.1,0; 158400,0,0.1,0;
        158410,0,0.1,0; 162000,0,0.1,0; 162010,0,0.1,0; 165600,0,0.1,0; 165610,
        0,0.1,0; 169200,0,0.1,0; 169210,0,0.1,0; 172800,0,0.1,0; 172810,0,0.1,0;
        176400,0,0.1,0; 176410,0,0.1,0; 180000,0,0.1,0; 180010,0,0.1,0; 183600,
        0,0.1,0; 183610,0,0.1,0; 187200,0,0.1,0; 187210,0,0.1,0; 190800,0,0.1,0;
        190810,0,0.1,0; 194400,0,0.1,0; 194410,0,0.1,0; 198000,0,0.1,0; 198010,
        0.2,0.2,1; 201600,0.2,0.2,1; 201610,0.6,0.6,1; 205200,0.6,0.6,1; 205210,
        1,0.8,1; 208800,1,0.8,1; 208810,1,1,1; 212400,1,1,1; 212410,0.8,0.8,1;
        216000,0.8,0.8,1; 216010,0.4,0.4,1; 219600,0.4,0.4,1; 219610,0.6,0.6,1;
        223200,0.6,0.6,1; 223210,1,1,1; 226800,1,1,1; 226810,0.8,0.8,1; 230400,
        0.8,0.8,1; 230410,0.6,0.6,1; 234000,0.6,0.6,1; 234010,0.2,0.2,1; 237600,
        0.2,0.2,1; 237610,0,0.1,0; 241200,0,0.1,0; 241210,0,0.1,0; 244800,0,0.1,
        0; 244810,0,0.1,0; 248400,0,0.1,0; 248410,0,0.1,0; 252000,0,0.1,0;
        252010,0,0.1,0; 255600,0,0.1,0; 255610,0,0.1,0; 259200,0,0.1,0; 259210,
        0,0.1,0; 262800,0,0.1,0; 262810,0,0.1,0; 266400,0,0.1,0; 266410,0,0.1,0;
        270000,0,0.1,0; 270010,0,0.1,0; 273600,0,0.1,0; 273610,0,0.1,0; 277200,
        0,0.1,0; 277210,0,0.1,0; 280800,0,0.1,0; 280810,0,0.1,0; 284400,0,0.1,0;
        284410,0.2,0.2,1; 288000,0.2,0.2,1; 288010,0.6,0.6,1; 291600,0.6,0.6,1;
        291610,1,0.8,1; 295200,1,0.8,1; 295210,1,1,1; 298800,1,1,1; 298810,0.8,
        0.8,1; 302400,0.8,0.8,1; 302410,0.4,0.4,1; 306000,0.4,0.4,1; 306010,0.6,
        0.6,1; 309600,0.6,0.6,1; 309610,1,1,1; 313200,1,1,1; 313210,0.8,0.8,1;
        316800,0.8,0.8,1; 316810,0.6,0.6,1; 320400,0.6,0.6,1; 320410,0.2,0.2,1;
        324000,0.2,0.2,1; 324010,0,0.1,0; 327600,0,0.1,0; 327610,0,0.1,0;
        331200,0,0.1,0; 331210,0,0.1,0; 334800,0,0.1,0; 334810,0,0.1,0; 338400,
        0,0.1,0; 338410,0,0.1,0; 342000,0,0.1,0; 342010,0,0.1,0; 345600,0,0.1,0;
        345610,0,0.1,0; 349200,0,0.1,0; 349210,0,0.1,0; 352800,0,0.1,0; 352810,
        0,0.1,0; 356400,0,0.1,0; 356410,0,0.1,0; 360000,0,0.1,0; 360010,0,0.1,0;
        363600,0,0.1,0; 363610,0,0.1,0; 367200,0,0.1,0; 367210,0,0.1,0; 370800,
        0,0.1,0; 370810,0.2,0.2,1; 374400,0.2,0.2,1; 374410,0.6,0.6,1; 378000,
        0.6,0.6,1; 378010,1,0.8,1; 381600,1,0.8,1; 381610,1,1,1; 385200,1,1,1;
        385210,0.8,0.8,1; 388800,0.8,0.8,1; 388810,0.4,0.4,1; 392400,0.4,0.4,1;
        392410,0.6,0.6,1; 396000,0.6,0.6,1; 396010,1,1,1; 399600,1,1,1; 399610,
        0.8,0.8,1; 403200,0.8,0.8,1; 403210,0.6,0.6,1; 406800,0.6,0.6,1; 406810,
        0.2,0.2,1; 410400,0.2,0.2,1; 410410,0,0.1,0; 414000,0,0.1,0; 414010,0,
        0.1,0; 417600,0,0.1,0; 417610,0,0.1,0; 421200,0,0.1,0; 421210,0,0.1,0;
        424800,0,0.1,0; 424810,0,0.1,0; 428400,0,0.1,0; 428410,0,0.1,0; 432000,
        0,0.1,0; 432010,0,0.1,0; 435600,0,0.1,0; 435610,0,0.1,0; 439200,0,0.1,0;
        439210,0,0.1,0; 442800,0,0.1,0; 442810,0,0.1,0; 446400,0,0.1,0; 446410,
        0,0.1,0; 450000,0,0.1,0; 450010,0,0.1,0; 453600,0,0.1,0; 453610,0,0.1,0;
        457200,0,0.1,0; 457210,0,0.1,0; 460800,0,0.1,0; 460810,0,0.1,0; 464400,
        0,0.1,0; 464410,0,0.1,0; 468000,0,0.1,0; 468010,0,0.1,0; 471600,0,0.1,0;
        471610,0,0.1,0; 475200,0,0.1,0; 475210,0,0.1,0; 478800,0,0.1,0; 478810,
        0,0.1,0; 482400,0,0.1,0; 482410,0,0.1,0; 486000,0,0.1,0; 486010,0,0.1,0;
        489600,0,0.1,0; 489610,0,0.1,0; 493200,0,0.1,0; 493210,0,0.1,0; 496800,
        0,0.1,0; 496810,0,0.1,0; 500400,0,0.1,0; 500410,0,0.1,0; 504000,0,0.1,0;
        504010,0,0.1,0; 507600,0,0.1,0; 507610,0,0.1,0; 511200,0,0.1,0; 511210,
        0,0.1,0; 514800,0,0.1,0; 514810,0,0.1,0; 518400,0,0.1,0; 518410,0,0.1,0;
        522000,0,0.1,0; 522010,0,0.1,0; 525600,0,0.1,0; 525610,0,0.1,0; 529200,
        0,0.1,0; 529210,0,0.1,0; 532800,0,0.1,0; 532810,0,0.1,0; 536400,0,0.1,0;
        536410,0,0.1,0; 540000,0,0.1,0; 540010,0,0.1,0; 543600,0,0.1,0; 543610,
        0,0.1,0; 547200,0,0.1,0; 547210,0,0.1,0; 550800,0,0.1,0; 550810,0,0.1,0;
        554400,0,0.1,0; 554410,0,0.1,0; 558000,0,0.1,0; 558010,0,0.1,0; 561600,
        0,0.1,0; 561610,0,0.1,0; 565200,0,0.1,0; 565210,0,0.1,0; 568800,0,0.1,0;
        568810,0,0.1,0; 572400,0,0.1,0; 572410,0,0.1,0; 576000,0,0.1,0; 576010,
        0,0.1,0; 579600,0,0.1,0; 579610,0,0.1,0; 583200,0,0.1,0; 583210,0,0.1,0;
        586800,0,0.1,0; 586810,0,0.1,0; 590400,0,0.1,0; 590410,0,0.1,0; 594000,
        0,0.1,0; 594010,0,0.1,0; 597600,0,0.1,0; 597610,0,0.1,0; 601200,0,0.1,0;
        601210,0,0.1,0; 604800,0,0.1,0])
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
    valveCharacteristic=Fluid.Actuators.Valves.Data.LinearLinear(),
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
    reverseAction=true)
    annotation (Placement(transformation(extent={{-202,144},{-188,158}})));
  HydraulicModules.SimpleConsumer consumerHTC(
    kA=20000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = MediumWater,
    functionality="T_input",
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
  Modelica.Blocks.Sources.RealExpression Q_flow_AHU1(y=-(0.5*(Tair - 273.15) +
        6)*1000)
    annotation (Placement(transformation(extent={{-212,190},{-196,206}})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU1(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-184,198})));
  HydraulicModules.Admix admixCold(
    parameterPipe=DataBase.Pipes.Copper.Copper_108x2_5(),
    valveCharacteristic=Fluid.Actuators.Valves.Data.LinearLinear(),
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
    kA=2000,
    V=0.1,
    m_flow_nominal=1,
    redeclare package Medium = MediumWater,
    functionality="T_input",
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
    reverseAction=false)
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
        origin={174,0})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold1(uMax=80000,  uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={156,0})));
  Modelica.Blocks.Interfaces.RealOutput Tair
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-140}), iconTransformation(extent={{-64,-140},{-44,-120}})));
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
    redeclare package Medium = MediumAir,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-82,190})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir1(redeclare package Medium =
        MediumAir, nPorts=1)
                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,216})));
  Modelica.Blocks.Nonlinear.Limiter temperatureLimiter(uMax=373, uMin=272.15)
    "Ice Protection"
    annotation (Placement(transformation(extent={{-20,-106},{-8,-94}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold2(y=mainBus.consCold1Bus.VFlowInMea
        *4.18*(mainBus.consCold1Bus.TFwrdOutMea - mainBus.consCold1Bus.TRtrnInMea))
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={226,6})));
  Modelica.Blocks.Math.Add add(k2=1/2000) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={141,-3})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold3(y=mainBus.consCold1Bus.TRtrnInMea)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={174,-12})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold4(y=mainBus.consHtcBus.TRtrnInMea)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-204,208})));
  Modelica.Blocks.Math.Add add1(k2=1/2000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-172,204})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU2(uMax=273.15 + 90, uMin=273.15
         + 20)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-168,188})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU3(uMax=273.15 + 35, uMin=273.15
         + 10)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=180,
        origin={126,10})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold5(y=mainBus.consHtcBus.VFlowInMea
        *4.18*(mainBus.consHtcBus.TFwrdOutMea - mainBus.consHtcBus.TRtrnInMea))
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={224,-24})));
equation
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{14,-100},{14,-77.4444},{15,-77.4444}},          color={191,
          0,0}));
  connect(weaDat.weaBus, thermalZone1North.weaBus) annotation (Line(
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
  connect(internalGains.y, thermalZone1North.intGains) annotation (Line(points=
          {{165,287.7},{162.4,287.7},{162.4,300.64}}, color={0,0,127}));
  connect(tabs1.heatPort, thermalZone1North.intGainsConv) annotation (Line(
        points={{178,162},{182,162},{182,326.16},{168.56,326.16}}, color={191,0,
          0}));
  connect(weaDat.weaBus, thermalZone2South.weaBus) annotation (Line(
      points={{60,378},{216,378},{216,249.2},{294,249.2}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone2South.intGainsConv, tabs2.heatPort) annotation (Line(
        points={{350.56,234.08},{384,234.08},{384,164}}, color={191,0,0}));
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

  connect(thermalZone1North.TAir, mainBus.TZone1Mea) annotation (Line(points={{
          170.8,348.2},{170,348.2},{170,419.145},{161.115,419.145}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZone2South.TAir, mainBus.TZone2Mea) annotation (Line(points={{
          352.8,254.6},{352.8,419.145},{161.115,419.145}}, color={0,0,127}),
      Text(
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
  connect(bou.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{388,-60},{276,-60}}, color={0,127,255}));
  connect(switchingUnit.port_a1, vol.ports[1]) annotation (Line(points={{276,-36},
          {276,76},{119.95,76}},       color={0,127,255}));
  connect(vol1.ports[1], genericAHU1.port_a4) annotation (Line(points={{135.95,
          100},{-34,100},{-34,248}}, color={0,127,255}));
  connect(vol1.ports[2], tabs1.port_a2) annotation (Line(points={{136.65,100},{
          186,100},{186,120}},
                           color={0,127,255}));
  connect(vol1.ports[3], tabs2.port_a2) annotation (Line(points={{137.35,100},{
          392,100},{392,122}},
                           color={0,127,255}));
  connect(vol.ports[2], genericAHU1.port_b4) annotation (Line(points={{120.65,
          76},{-23.0909,76},{-23.0909,248}},
                                         color={0,127,255}));
  connect(vol.ports[3], tabs1.port_b2) annotation (Line(points={{121.35,76},{
          194,76},{194,120.4}},
                              color={0,127,255}));
  connect(vol.ports[4], tabs2.port_b2) annotation (Line(points={{122.05,76},{
          400,76},{400,122.4}},
                              color={0,127,255}));
  connect(vol1.ports[1],genericAHU2. port_a4)
    annotation (Line(points={{135.95,100},{84,100},{84,160}},
                                                           color={0,127,255}));
  connect(vol.ports[2],genericAHU2. port_b4) annotation (Line(points={{120.65,
          76},{94.9091,76},{94.9091,160}},
                                       color={0,127,255}));
  connect(genericAHU2.port_a5, genericAHU1.port_a5) annotation (Line(points={{105.818,
          160},{106,160},{106,128},{-12.1818,128},{-12.1818,248}},
        color={238,46,47}));
  connect(thermalZone2South.intGains, internalGains1.y) annotation (Line(points=
         {{344.4,210.32},{343.2,210.32},{343.2,197.7},{345,197.7}}, color={0,0,
          127}));
  connect(genericAHU2.port_a2, thermalZone2South.ports[1]) annotation (Line(
        points={{144.545,214},{231.272,214},{231.272,213.56},{318.71,213.56}},
        color={0,127,255}));
  connect(genericAHU2.port_b1, thermalZone2South.ports[2]) annotation (Line(
        points={{144.545,190},{332,190},{332,213.56},{325.29,213.56}}, color={0,
          127,255}));
  connect(genericAHU1.port_b1, thermalZone1North.ports[1]) annotation (Line(
        points={{26.5455,278},{142,278},{142,304.12},{136.71,304.12}}, color={0,
          127,255}));
  connect(genericAHU1.port_a2, thermalZone1North.ports[2]) annotation (Line(
        points={{26.5455,302},{80,302},{80,304.12},{143.29,304.12}}, color={0,
          127,255}));
  connect(genericAHU2.genericAHUBus, mainBus.ahu2Bus) annotation (Line(
      points={{84,226.3},{84,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericAHU1.genericAHUBus, mainBus.ahu1Bus) annotation (Line(
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
      points={{363.8,142.2},{440,142.2},{440,419.145},{161.115,419.145}},
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
        points={{-188,-34},{-176.4,-34},{-176.4,-46}}, color={255,0,0}));
  connect(highTemperatureSystem.port_a,vol3. ports[1]) annotation (Line(points={{-164.8,
          -46},{-164.8,10.6},{-164,10.6}},        color={255,0,0}));
  connect(vol3.ports[2], heatExchangerSystem.port_b1) annotation (Line(points={{-164,
          10.2},{-164,-11.2},{-130,-11.2}},color={255,0,0}));
  connect(admixHTC.port_b2,vol3. ports[3]) annotation (Line(points={{-164,140},
          {-164,9.8}},           color={238,46,47}));
  connect(highTemperatureSystem.port_b, vol2.ports[1]) annotation (Line(points={{-176.4,
          -46},{-176,-46},{-176,-20.6}},          color={255,0,0}));
  connect(vol2.ports[2], heatExchangerSystem.port_a1) annotation (Line(points={{-176,
          -20.2},{-160,-20.2},{-160,-20.8},{-130,-20.8}},       color={255,0,0}));
  connect(vol2.ports[3], admixHTC.port_a1)
    annotation (Line(points={{-176,-19.8},{-176,140}}, color={238,46,47}));
  connect(Q_flow_AHU1.y,limiterAHU1. u)
    annotation (Line(points={{-195.2,198},{-188.8,198}}, color={0,0,127}));
  connect(consumerCold.port_a, admixCold.port_b1)
    annotation (Line(points={{104,12},{104,0},{102,0}}, color={0,127,255}));
  connect(consumerCold.port_b, admixCold.port_a2)
    annotation (Line(points={{116,12},{116,0},{114,0}}, color={0,127,255}));
  connect(ctrMixCold.hydraulicBus, admixCold.hydraulicBus) annotation (Line(
      points={{90.84,-10.86},{96.72,-10.86},{96.72,-10},{98,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(heatpumpSystem.port_b1,vol4. ports[1]) annotation (Line(points={{70,
          -59.5556},{106.533,-59.5556},{106.533,-60}},color={0,127,255}));
  connect(vol4.ports[2], admixCold.port_a1) annotation (Line(points={{106,-60},
          {106,-32},{102,-32},{102,-20}}, color={0,127,255}));
  connect(vol5.ports[1], admixCold.port_b2) annotation (Line(points={{122.533,
          -50},{122.533,-24},{114,-24},{114,-20}}, color={0,127,255}));
  connect(vol5.ports[2], heatpumpSystem.port_a1) annotation (Line(points={{122,-50},
          {122,-49.3333},{70,-49.3333}},            color={0,127,255}));
  connect(limiterCCACold1.u,Q_flow_CCA_cold1. y)
    annotation (Line(points={{160.8,-5.55112e-16},{161,-5.55112e-16},{161,
          1.11022e-15},{165.2,1.11022e-15}},           color={0,0,127}));
  connect(vol5.ports[3], switchingUnit.port_b1) annotation (Line(points={{121.467,
          -50},{198,-50},{198,-36},{236,-36}},         color={0,127,255}));
  connect(vol4.ports[3], switchingUnit.port_a2)
    annotation (Line(points={{105.467,-60},{236,-60}}, color={0,127,255}));
  connect(genericAHU2.port_b5, genericAHU1.port_b5) annotation (Line(points={{116.182,
          160},{116,160},{116,120},{-1.81818,120},{-1.81818,248}},
        color={238,46,47}));
  connect(genericAHU1.port_a5, vol2.ports[4]) annotation (Line(points={{
          -12.1818,248},{-12,248},{-12,126},{-176,126},{-176,-19.4}}, color={
          238,46,47}));
  connect(genericAHU2.port_b5, vol3.ports[4]) annotation (Line(points={{116.182,
          160},{116.182,120},{-164,120},{-164,9.4}}, color={238,46,47}));
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
  connect(genericAHU1.port_a1, boundaryOutsideAir.ports[1]) annotation (Line(
        points={{-94,278},{-108,278},{-108,282},{-130,282},{-130,250}}, color={
          0,127,255}));
  connect(boundaryExhaustAir.ports[1], genericAHU1.port_b2) annotation (Line(
        points={{-136,302},{-116,302},{-116,302},{-94,302}}, color={0,127,255}));
  connect(x_pTphi.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-161,
          270},{-158,270},{-158,194},{-94,194}}, color={0,0,127}));
  connect(boundaryOutsideAir1.T_in, boundaryOutsideAir.T_in) annotation (Line(
        points={{-94,186},{-154,186},{-154,246},{-152,246}}, color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1],genericAHU2. port_a1)
    annotation (Line(points={{-72,190},{24,190}}, color={0,127,255}));
  connect(genericAHU2.port_b2, boundaryExhaustAir1.ports[1]) annotation (Line(
        points={{24,214},{22,214},{22,216},{18,216}}, color={0,127,255}));
  connect(tabs1.tabsBus, mainBus.tabs1Bus) annotation (Line(
      points={{157.8,140.2},{242,140.2},{242,410},{161.115,410},{161.115,
          419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switchingUnit.port_b2, vol1.ports[4]) annotation (Line(points={{276,-60},
          {294,-60},{294,100},{138.05,100}},     color={0,127,255}));
  connect(x_pTphi.T, Tair) annotation (Line(points={{-184,270},{-210,270},{-210,
          268},{-228,268},{-228,-140},{-48,-140}}, color={0,0,127}));
  connect(Tair, temperatureLimiter.u) annotation (Line(points={{-48,-140},{-22,
          -140},{-22,-124},{-21.2,-124},{-21.2,-100}}, color={0,0,127}));
  connect(temperatureLimiter.y, prescribedTemperature.T)
    annotation (Line(points={{-7.4,-100},{0.8,-100}}, color={0,0,127}));
  connect(internalGains.y[1], mainBus.presence) annotation (Line(points={{165,
          287.7},{210,287.7},{210,419.145},{161.115,419.145}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q_flow_CCA_cold2.y, mainBus.QCold) annotation (Line(points={{217.2,6},
          {217.2,4},{208,4},{208,280},{192,280},{192,384},{161,384},{161,419}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u2, limiterCCACold1.y) annotation (Line(points={{147,-1.22125e-15},
          {149.3,-1.22125e-15},{149.3,6.10623e-16},{151.6,6.10623e-16}}, color=
          {0,0,127}));
  connect(add.u1, Q_flow_CCA_cold3.y) annotation (Line(points={{147,-6},{152,-6},
          {152,-12},{165.2,-12}}, color={0,0,127}));
  connect(add1.u1, Q_flow_CCA_cold4.y) annotation (Line(points={{-176.8,206.4},
          {-195.2,206.4},{-195.2,208}}, color={0,0,127}));
  connect(limiterAHU1.y, add1.u2) annotation (Line(points={{-179.6,198},{-178,
          198},{-178,201.6},{-176.8,201.6}}, color={0,0,127}));
  connect(add1.y, limiterAHU2.u) annotation (Line(points={{-167.6,204},{-167.6,
          192.8},{-168,192.8}}, color={0,0,127}));
  connect(limiterAHU2.y, consumerHTC.T) annotation (Line(points={{-168,183.6},{
          -165.2,183.6},{-165.2,178}}, color={0,0,127}));
  connect(limiterAHU3.u, add.y) annotation (Line(points={{130.8,10},{132,10},{
          132,-3},{135.5,-3}}, color={0,0,127}));
  connect(limiterAHU3.y, consumerCold.T) annotation (Line(points={{121.6,10},{
          122,10},{122,18},{114.8,18}}, color={0,0,127}));
  connect(Q_flow_CCA_cold5.y, mainBus.QHtc) annotation (Line(points={{215.2,-24},
          {200,-24},{200,-18},{161,-18},{161,419}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(extent={{-220,-120},{560,420}})), Icon(
        coordinateSystem(extent={{-220,-120},{560,420}}), graphics={Rectangle(
          extent={{-220,420},{580,-120}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
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
