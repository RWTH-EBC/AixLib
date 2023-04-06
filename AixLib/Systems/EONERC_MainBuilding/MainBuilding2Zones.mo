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
    alpha=10,
    Q_nom_hx=100000,
    dynamicHXCold(nNodes=4),
    dynamicHXHot(nNodes=3),
    throttlePumpCold(PumpInterface(pump(per(motorCooledByFluid=false)))))
    annotation (Placement(transformation(extent={{158,120},{198,160}})));
  AixLib.Systems.TABS.Tabs
       tabs2(
    redeclare package Medium = MediumWater,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_133x3(lambda=100),
    area=60*60,
    thickness=0.05,
    alpha=10,
    Q_nom_hx=100000,
    dynamicHXHot(nNodes=3),
    dynamicHXCold(nNodes=4),
    throttlePumpCold(PumpInterface(pump(per(motorCooledByFluid=false)))))
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

  AixLib.Systems.EONERC_MainBuilding.ERC_AHU
                        eRC_AHU(
    redeclare package MediumWater = MediumWater,
    redeclare package MediumAir = MediumAir,
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
        Kv=25,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per(
                motorCooledByFluid=false)))), dynamicHX(
        dp1_nominal=100,
        dp2_nominal=1000,
        nNodes=4,
        tau1=5,
        tau2=10,
        dT_nom=10,
        Q_nom=200000)),
    heater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=25,
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
  AixLib.Systems.EONERC_MainBuilding.ERC_AHU
                                       eRC_AHU1(
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
        Kv=25,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per(
                motorCooledByFluid=false)))), dynamicHX(
        dp1_nominal=100,
        dp2_nominal=1000,
        nNodes=4,
        tau1=5,
        tau2=10,
        dT_nom=10,
        Q_nom=200000)),
    heater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=25,
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
    kA=2000,
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
  Modelica.Blocks.Sources.CombiTimeTable htcLoads_in_kW(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/SIA2024_SingleOffice_week.txt"),
    columns={2},
    tableOnFile=false,
    table=[0,27.62; 3600,26.99; 7200,26.77; 10800,26.9; 14400,26.88; 18000,
        26.41; 21600,26.74; 25200,26.6; 28800,28.29; 32400,13.06; 36000,10.47;
        39600,13.47; 43200,9.58; 46800,10.35; 50400,15.99; 54000,7.17; 57600,
        10.33; 61200,12.2; 64800,9.54; 68400,11.88; 72000,11.85; 75600,9.19;
        79200,12.64; 82800,7.42; 86400,12.57; 90000,8.3; 93600,12.53; 97200,
        15.69; 100800,6.76; 104400,12.53; 108000,8.17; 111600,14.65; 115200,
        12.28; 118800,9.5; 122400,15.25; 126000,6.58; 129600,16.49; 133200,9.29;
        136800,11.52; 140400,7.17; 144000,9.63; 147600,12.93; 151200,8.77;
        154800,11.15; 158400,15.74; 162000,10.84; 165600,10.88; 169200,15.7;
        172800,10.36; 176400,9.77; 180000,12.24; 183600,9.07; 187200,7.25;
        190800,13.87; 194400,6.63; 198000,15.19; 201600,12.31; 205200,9.86;
        208800,12.49; 212400,6.29; 216000,12.42; 219600,18.03; 223200,8.22;
        226800,17.21; 230400,6.63; 234000,10.02; 237600,13.8; 241200,9.08;
        244800,10.47; 248400,13.57; 252000,10.53; 255600,12.94; 259200,8.88;
        262800,12.42; 266400,16.55; 270000,9.96; 273600,11.45; 277200,11.65;
        280800,10.34; 284400,10.91; 288000,12.03; 291600,8.44; 295200,12.96;
        298800,7.68; 302400,10.55; 306000,16.72; 309600,11.26; 313200,11.1;
        316800,13.91; 320400,12.25; 324000,8; 327600,12.61; 331200,10.36;
        334800,12.34; 338400,10.75; 342000,10.77; 345600,14.13; 349200,13.24;
        352800,9.88; 356400,7.11; 360000,8.51; 363600,9.15; 367200,11.03;
        370800,8.71; 374400,8.85; 378000,8.64; 381600,7.65; 385200,7.62; 388800,
        9.92; 392400,7.8; 396000,14.44; 399600,8.62; 403200,5.71; 406800,13.24;
        410400,7.42; 414000,13.37; 417600,10.49; 421200,6.08; 424800,11.63;
        428400,11.26; 432000,10.88; 435600,11.73; 439200,7.88; 442800,6.67;
        446400,5.81; 450000,6.35; 453600,10.21; 457200,6.14; 460800,9.52;
        464400,8.06; 468000,5.55; 471600,3.99; 475200,8.26; 478800,15.17;
        482400,0; 486000,0; 489600,0; 493200,0; 496800,0; 500400,0; 504000,0;
        507600,0; 511200,0; 514800,0; 518400,0; 522000,0; 525600,0; 529200,0;
        532800,0; 536400,0; 540000,0; 543600,0; 547200,0; 550800,0; 554400,0;
        558000,0; 561600,0; 565200,0; 568800,0; 572400,0; 576000,0; 579600,0;
        583200,0; 586800,0; 590400,0; 594000,0; 597600,0; 601200,0; 604800,0;
        608400,0; 612000,0; 615600,0; 619200,0; 622800,0; 626400,0; 630000,0;
        633600,0; 637200,0; 640800,0; 644400,0; 648000,0; 651600,0; 655200,0;
        658800,0; 662400,0; 666000,0; 669600,0; 673200,0; 676800,0; 680400,0;
        684000,0; 687600,0; 691200,0; 694800,0; 698400,0; 702000,6.77; 705600,
        4.02; 709200,6.01; 712800,2.84; 716400,11.87; 720000,5.66; 723600,5.37;
        727200,7.01; 730800,5.73; 734400,6.87; 738000,5.2; 741600,14.96; 745200,
        9.2; 748800,5.34; 752400,6.78; 756000,3.91; 759600,5.21; 763200,8.11;
        766800,5.22; 770400,6.86; 774000,7.65; 777600,8.14; 781200,5.98; 784800,
        5.22; 788400,3.44; 792000,7.85; 795600,5.11; 799200,8.21; 802800,5.23;
        806400,7.25; 810000,0; 813600,0; 817200,12.23; 820800,6.24; 824400,0.81;
        828000,5.46; 831600,8.28; 835200,2.03; 838800,7.63; 842400,8.15; 846000,
        4.09; 849600,6.77; 853200,4.12; 856800,2.94; 860400,2.26; 864000,4.73;
        867600,0.94; 871200,4.44; 874800,3.48; 878400,0; 882000,6.99; 885600,
        7.71; 889200,1.92; 892800,0; 896400,8.03; 900000,6.98; 903600,1.03;
        907200,3.3; 910800,9.52; 914400,1.84; 918000,0; 921600,3.45; 925200,
        9.75; 928800,3.14; 932400,0; 936000,0; 939600,7.69; 943200,6.47; 946800,
        6.1; 950400,1.36; 954000,0; 957600,7.71; 961200,2.07; 964800,0; 968400,
        0; 972000,0; 975600,0; 979200,0; 982800,0; 986400,4.39; 990000,1.23;
        993600,11.44; 997200,12.51; 1000800,5.38; 1004400,0.65; 1008000,8.65;
        1011600,4.96; 1015200,0.47; 1018800,5.99; 1022400,3.48; 1026000,0;
        1029600,0; 1033200,10.48; 1036800,5.11; 1040400,0; 1044000,0; 1047600,
        11.4; 1051200,3.56; 1054800,0; 1058400,0; 1062000,13.6; 1065600,3.39;
        1069200,0; 1072800,0; 1076400,13.69; 1080000,3.27; 1083600,1.45;
        1087200,9.74; 1090800,2.28; 1094400,0; 1098000,4.71; 1101600,11.75;
        1105200,1.35; 1108800,0; 1112400,0; 1116000,12.15; 1119600,6.24;
        1123200,0.09; 1126800,0; 1130400,11.56; 1134000,5.09; 1137600,0;
        1141200,0; 1144800,10.31; 1148400,6.3; 1152000,0.14; 1155600,0; 1159200,
        7.05; 1162800,11.06; 1166400,1.89; 1170000,5.57; 1173600,2.17; 1177200,
        0; 1180800,6.64; 1184400,4.79; 1188000,0; 1191600,0; 1195200,5.25;
        1198800,10.04; 1202400,0.7; 1206000,0; 1209600,6.66; 1213200,10.15;
        1216800,0.42; 1220400,0; 1224000,0; 1227600,13.53; 1231200,1.39;
        1234800,0; 1238400,3.32; 1242000,12.44; 1245600,0.58; 1249200,0;
        1252800,0; 1256400,13.12; 1260000,5.88; 1263600,0; 1267200,0; 1270800,
        12.52; 1274400,4.27; 1278000,0; 1281600,0; 1285200,9.06; 1288800,7.39;
        1292400,0; 1296000,7.57; 1299600,6.96; 1303200,0.13; 1306800,0; 1310400,
        9.12; 1314000,6.38; 1317600,0; 1321200,0; 1324800,13.08; 1328400,4.31;
        1332000,0; 1335600,0; 1339200,11.48; 1342800,7.71; 1346400,5.04;
        1350000,3.54; 1353600,0; 1357200,6.94; 1360800,6.45; 1364400,0.12;
        1368000,0; 1371600,5.25; 1375200,8.85; 1378800,0.29; 1382400,2.11;
        1386000,9.6; 1389600,0.94; 1393200,0; 1396800,6.08; 1400400,10.48;
        1404000,0.97; 1407600,0; 1411200,5.82; 1414800,9.85; 1418400,1.28;
        1422000,0.05; 1425600,4.51; 1429200,9.18; 1432800,3.33; 1436400,0;
        1440000,0; 1443600,12.14; 1447200,3.5; 1450800,0; 1454400,0; 1458000,
        9.89; 1461600,3.68; 1465200,0; 1468800,5.33; 1472400,9.41; 1476000,6.51;
        1479600,0.01; 1483200,8.37; 1486800,4.92; 1490400,0.03; 1494000,0;
        1497600,7.63; 1501200,7.65; 1504800,0.27; 1508400,0; 1512000,11.67;
        1515600,3.44; 1519200,2.22; 1522800,6.5; 1526400,0.53; 1530000,0;
        1533600,10.94; 1537200,6.96; 1540800,0; 1544400,0; 1548000,7.36;
        1551600,8.66; 1555200,0.25; 1558800,0; 1562400,10.26; 1566000,6.68;
        1569600,0; 1573200,0; 1576800,10.27; 1580400,4.28; 1584000,0; 1587600,
        3.02; 1591200,10.74; 1594800,4.29; 1598400,0.07; 1602000,4.31; 1605600,
        7.59; 1609200,0.7; 1612800,5.64; 1616400,8.86; 1620000,0.21; 1623600,0;
        1627200,3.93; 1630800,9.64; 1634400,1.43; 1638000,0; 1641600,7.2;
        1645200,8.85; 1648800,0.74; 1652400,0; 1656000,9.61; 1659600,4.99;
        1663200,0; 1666800,0; 1670400,9.33; 1674000,9.01; 1677600,0.8; 1681200,
        0; 1684800,11.95; 1688400,5.64; 1692000,1.82; 1695600,6.67; 1699200,
        0.34; 1702800,0; 1706400,8.88; 1710000,5.89; 1713600,0; 1717200,0;
        1720800,10.69; 1724400,5.98; 1728000,0; 1731600,3.69; 1735200,10.97;
        1738800,1.1; 1742400,0; 1746000,4.23; 1749600,11.68; 1753200,1.19;
        1756800,0; 1760400,6.19; 1764000,8.06; 1767600,0.64; 1771200,0; 1774800,
        7.71; 1778400,8.55; 1782000,0.36; 1785600,0; 1789200,8.51; 1792800,9.75;
        1796400,0.19; 1800000,0; 1803600,9.2; 1807200,9.98; 1810800,1.01;
        1814400,6.98; 1818000,3.32; 1821600,0; 1825200,0; 1828800,11.87;
        1832400,5.27; 1836000,0; 1839600,3.96; 1843200,10.67; 1846800,1.57;
        1850400,0; 1854000,4.17; 1857600,10.42; 1861200,3.76; 1864800,3.25;
        1868400,4.45; 1872000,0.11; 1875600,3.21; 1879200,9.38; 1882800,0.78;
        1886400,0; 1890000,0; 1893600,8.56; 1897200,5.32; 1900800,0; 1904400,
        0.53; 1908000,11.58; 1911600,3.92; 1915200,0; 1918800,11.04; 1922400,
        1.7; 1926000,0; 1929600,0; 1933200,11.5; 1936800,3.84; 1940400,0.03;
        1944000,0; 1947600,6.83; 1951200,9.62; 1954800,3.99; 1958400,5.26;
        1962000,4.25; 1965600,0; 1969200,0; 1972800,8.34; 1976400,4.07; 1980000,
        0; 1983600,5.83; 1987200,8.63; 1990800,0.29; 1994400,0; 1998000,5.94;
        2001600,10.01; 2005200,0.4; 2008800,0; 2012400,8.65; 2016000,6.67;
        2019600,0; 2023200,0; 2026800,12.2; 2030400,4.33; 2034000,0; 2037600,0;
        2041200,9.62; 2044800,4.05; 2048400,0; 2052000,0; 2055600,8.88; 2059200,
        8.87; 2062800,0.31; 2066400,0; 2070000,9.19; 2073600,3.18; 2077200,0;
        2080800,0; 2084400,12.93; 2088000,1.29; 2091600,0; 2095200,4.98;
        2098800,9.37; 2102400,9.51; 2106000,6.34; 2109600,5.72; 2113200,8.19;
        2116800,1; 2120400,0; 2124000,6.47; 2127600,7.9; 2131200,0.1; 2134800,0;
        2138400,6.94; 2142000,9.75; 2145600,0.6; 2149200,0; 2152800,5.43;
        2156400,10.22; 2160000,0.41; 2163600,0; 2167200,5.97; 2170800,10.52;
        2174400,0.21; 2178000,0; 2181600,5.63; 2185200,6.22; 2188800,0.69;
        2192400,3.71; 2196000,8.16; 2199600,0.58; 2203200,0; 2206800,4.71;
        2210400,10.66; 2214000,0.19; 2217600,0; 2221200,0; 2224800,13.42;
        2228400,3.48; 2232000,0; 2235600,0; 2239200,8.91; 2242800,7.08; 2246400,
        0; 2250000,3.7; 2253600,10.82; 2257200,2.68; 2260800,0; 2264400,6.28;
        2268000,10.58; 2271600,1.27; 2275200,19.43; 2278800,7.74; 2282400,5.72;
        2286000,22.27; 2289600,12.21; 2293200,7.74; 2296800,5.72; 2300400,6.74;
        2304000,7.67; 2307600,4.47; 2311200,6.23; 2314800,9.15; 2318400,5.13;
        2322000,4.64; 2325600,8.05; 2329200,5.39; 2332800,5.49; 2336400,6.57;
        2340000,5.75; 2343600,6.05; 2347200,6.2; 2350800,4.47; 2354400,8.03;
        2358000,7.01; 2361600,3.57; 2365200,7.75; 2368800,6.57; 2372400,4.7;
        2376000,9.47; 2379600,6.33; 2383200,2.79; 2386800,7.82; 2390400,6.82;
        2394000,4.52; 2397600,6.12; 2401200,6.42; 2404800,3.5; 2408400,9.45;
        2412000,5.6; 2415600,5.12; 2419200,7.07; 2422800,4.97; 2426400,6.86;
        2430000,6.34; 2433600,9.08; 2437200,4.32; 2440800,6.58; 2444400,7.78;
        2448000,3.75; 2451600,4.87; 2455200,9.85; 2458800,4.57; 2462400,5;
        2466000,8.65; 2469600,5.69; 2473200,7.92; 2476800,9.73; 2480400,5.41;
        2484000,4.78; 2487600,9; 2491200,8.37; 2494800,3.68; 2498400,7.05;
        2502000,8.37; 2505600,5.36; 2509200,4.57; 2512800,10.61; 2516400,20.46;
        2520000,13.24; 2523600,17.16; 2527200,14.36; 2530800,12.57; 2534400,
        15.64; 2538000,11.99; 2541600,9.25; 2545200,11.53; 2548800,11.92;
        2552400,11.05; 2556000,14.93; 2559600,7.99; 2563200,7.72; 2566800,13.88;
        2570400,8.07; 2574000,9.01; 2577600,11.51; 2581200,8.94; 2584800,12.4;
        2588400,9.98; 2592000,10.42; 2595600,8.81; 2599200,10.56; 2602800,9.98;
        2606400,10.86; 2610000,10.71; 2613600,10.49; 2617200,8.48; 2620800,
        12.16; 2624400,9.08; 2628000,7.94; 2631600,10.43; 2635200,8.33; 2638800,
        8.45; 2642400,11.78; 2646000,6.99; 2649600,9.83; 2653200,10.01; 2656800,
        7.48; 2660400,11.96; 2664000,7.75; 2667600,6.74; 2671200,11.75; 2674800,
        10.41; 2678400,7.59; 2682000,10.78; 2685600,9.03; 2689200,10.25;
        2692800,10.93; 2696400,6.2; 2700000,9.11; 2703600,9.2; 2707200,9.22;
        2710800,13.69; 2714400,23.76; 2718000,17.2; 2721600,11.23; 2725200,13.2;
        2728800,12.34; 2732400,7.7; 2736000,16.61; 2739600,13.91; 2743200,12.77;
        2746800,10.14; 2750400,14.86; 2754000,8.88; 2757600,13.67; 2761200,8.27;
        2764800,12.66; 2768400,6.72; 2772000,7.95; 2775600,5.49; 2779200,12.49;
        2782800,6.53; 2786400,5.37; 2790000,7.46; 2793600,8.72; 2797200,10.42;
        2800800,7.43; 2804400,6.01; 2808000,11.49; 2811600,9.21; 2815200,6.66;
        2818800,8.75; 2822400,8.17; 2826000,7.78; 2829600,5.97; 2833200,14.3;
        2836800,8.63; 2840400,5.83; 2844000,10.23; 2847600,8.97; 2851200,6.27;
        2854800,8.52; 2858400,8.61; 2862000,14.46; 2865600,7.94; 2869200,12.41;
        2872800,7.88; 2876400,6.89; 2880000,11.12; 2883600,7.46; 2887200,10.66;
        2890800,7.86; 2894400,13.76; 2898000,5.91; 2901600,10.88; 2905200,13.01;
        2908800,6.86; 2912400,13.85; 2916000,12.25; 2919600,6.03; 2923200,13.01;
        2926800,10.96; 2930400,5.1; 2934000,10.35; 2937600,8.52; 2941200,7.02;
        2944800,12.32; 2948400,11.73; 2952000,14.46; 2955600,7.39; 2959200,8.25;
        2962800,9.42; 2966400,7.24; 2970000,6.03; 2973600,7.13; 2977200,9.81;
        2980800,12.81; 2984400,7.19; 2988000,5.46; 2991600,16.13; 2995200,7.03;
        2998800,8.29; 3002400,9.96; 3006000,8.44; 3009600,10.05; 3013200,10.46;
        3016800,7.64; 3020400,10.93; 3024000,9.49; 3027600,10.9; 3031200,9.44;
        3034800,8.51; 3038400,6.13; 3042000,9.85; 3045600,4.97; 3049200,8.03;
        3052800,14.23; 3056400,13.44; 3060000,12.59; 3063600,15.79; 3067200,
        6.81; 3070800,11.49; 3074400,8.07; 3078000,8.2; 3081600,8.78; 3085200,
        6.24; 3088800,8.9; 3092400,7.3; 3096000,14.93; 3099600,9.8; 3103200,
        7.03; 3106800,8.46; 3110400,9.51; 3114000,17.71; 3117600,11.76; 3121200,
        7.05; 3124800,10.22; 3128400,5.47; 3132000,11.52; 3135600,13.3; 3139200,
        10.03; 3142800,6.58; 3146400,7.34; 3150000,11.2; 3153600,10.1; 3157200,
        9.88; 3160800,6.88; 3164400,8.91; 3168000,14.74; 3171600,8.57; 3175200,
        8.49; 3178800,8; 3182400,8.85; 3186000,8.27; 3189600,17.29; 3193200,
        3.78; 3196800,9.15; 3200400,5.91; 3204000,6.12; 3207600,13.96; 3211200,
        5.07; 3214800,8.03; 3218400,9.86; 3222000,4.63; 3225600,8.15; 3229200,
        16.07; 3232800,7.52; 3236400,6.37; 3240000,12.61; 3243600,8.37; 3247200,
        5.68; 3250800,7.35; 3254400,8.57; 3258000,13.2; 3261600,5.78; 3265200,
        2.75; 3268800,12.42; 3272400,9.49; 3276000,6.37; 3279600,9.24; 3283200,
        8.17; 3286800,8.17; 3290400,4.98; 3294000,14.42; 3297600,5.78; 3301200,
        5.37; 3304800,11.71; 3308400,10.48; 3312000,12.63; 3315600,10.81;
        3319200,5.81; 3322800,3.69; 3326400,11.1; 3330000,6.31; 3333600,6.07;
        3337200,6.51; 3340800,9.36; 3344400,5.11; 3348000,4.76; 3351600,7.73;
        3355200,7.26; 3358800,4.24; 3362400,7.49; 3366000,6.39; 3369600,18.69;
        3373200,21.09; 3376800,20.76; 3380400,12.01; 3384000,6.46; 3387600,4.86;
        3391200,6.26; 3394800,11; 3398400,9.03; 3402000,6.89; 3405600,11.07;
        3409200,9.36; 3412800,7.8; 3416400,6.3; 3420000,9.51; 3423600,7.39;
        3427200,6.74; 3430800,5.24; 3434400,9.47; 3438000,9.77; 3441600,5.37;
        3445200,8.27; 3448800,7.07; 3452400,6.07; 3456000,6.44; 3459600,8.79;
        3463200,19.04; 3466800,22.6; 3470400,21.94; 3474000,22.04; 3477600,
        14.11; 3481200,6.01; 3484800,10.17; 3488400,7.41; 3492000,12.78;
        3495600,8.81; 3499200,14.49; 3502800,9.18; 3506400,9.32; 3510000,5.46;
        3513600,8.54; 3517200,6.34; 3520800,9.74; 3524400,11; 3528000,18.77;
        3531600,18.08; 3535200,10.42; 3538800,6.36; 3542400,7.93; 3546000,14;
        3549600,4.5; 3553200,8.45; 3556800,15.79; 3560400,3.7; 3564000,5.22;
        3567600,5.44; 3571200,11.85; 3574800,9.87; 3578400,7.44; 3582000,8.55;
        3585600,17.18; 3589200,7.24; 3592800,11.59; 3596400,10.21; 3600000,9.92;
        3603600,10.41; 3607200,10.4; 3610800,8.82; 3614400,7.8; 3618000,5.16;
        3621600,4.6; 3625200,13.42; 3628800,5.28; 3632400,3.96; 3636000,2.57;
        3639600,14.48; 3643200,7.42; 3646800,8.12; 3650400,9.33; 3654000,12.74;
        3657600,9.65; 3661200,7.44; 3664800,8.92; 3668400,9.34; 3672000,7.41;
        3675600,9.96; 3679200,9.97; 3682800,9.82; 3686400,10.23; 3690000,9.26;
        3693600,13.13; 3697200,9.51; 3700800,6.46; 3704400,10.67; 3708000,8.39;
        3711600,8.65; 3715200,14.37; 3718800,9.55; 3722400,11.04; 3726000,9.43;
        3729600,11.15; 3733200,7.61; 3736800,9.4; 3740400,8.63; 3744000,12.44;
        3747600,9.48; 3751200,10.72; 3754800,10.21; 3758400,9.06; 3762000,7.46;
        3765600,9.48; 3769200,11.35; 3772800,10.33; 3776400,12.01; 3780000,
        11.54; 3783600,10.69; 3787200,8.58; 3790800,9.24; 3794400,10.28;
        3798000,9.6; 3801600,11.01; 3805200,11.54; 3808800,9.91; 3812400,9.43;
        3816000,5.95; 3819600,11.47; 3823200,21.25; 3826800,16.89; 3830400,23.4;
        3834000,22.44; 3837600,9.9; 3841200,16.17; 3844800,23.57; 3848400,22.46;
        3852000,3.67; 3855600,20.92; 3859200,3.66; 3862800,13.42; 3866400,5.37;
        3870000,7.13; 3873600,4.34; 3877200,12.54; 3880800,5.63; 3884400,10.96;
        3888000,1.85; 3891600,16.56; 3895200,10.66; 3898800,23.38; 3902400,
        21.67; 3906000,21.65; 3909600,13.36; 3913200,16.52; 3916800,18.23;
        3920400,17.1; 3924000,17.69; 3927600,4.9; 3931200,8.98; 3934800,6.05;
        3938400,7.85; 3942000,6.18; 3945600,3.57; 3949200,11.57; 3952800,7.05;
        3956400,7.58; 3960000,11.06; 3963600,15.65; 3967200,4.58; 3970800,7.42;
        3974400,9.87; 3978000,0; 3981600,0; 3985200,7.53; 3988800,9.9; 3992400,
        10.12; 3996000,7.58; 3999600,10.14; 4003200,12.53; 4006800,22.68;
        4010400,8.59; 4014000,10.29; 4017600,11.26; 4021200,5.98; 4024800,8.95;
        4028400,8.22; 4032000,5.76; 4035600,13.11; 4039200,9.2; 4042800,7.23;
        4046400,13.26; 4050000,20.09; 4053600,11.34; 4057200,8.38; 4060800,
        11.03; 4064400,10.04; 4068000,8.95; 4071600,10.96; 4075200,10.66;
        4078800,10.61; 4082400,8.18; 4086000,12.24; 4089600,11.95; 4093200,18.2;
        4096800,19.29; 4100400,9.81; 4104000,10.07; 4107600,7.67; 4111200,10.31;
        4114800,9.3; 4118400,11.28; 4122000,12.51; 4125600,10.24; 4129200,9.15;
        4132800,16.37; 4136400,22.51; 4140000,11.97; 4143600,6.51; 4147200,
        11.74; 4150800,7.4; 4154400,14.17; 4158000,12.09; 4161600,9.99; 4165200,
        12.63; 4168800,13.02; 4172400,7.61; 4176000,20.12; 4179600,9.16;
        4183200,9.53; 4186800,14.49; 4190400,21.14; 4194000,16.21; 4197600,5.16;
        4201200,18.4; 4204800,10.34; 4208400,10.29; 4212000,10.02; 4215600,
        16.14; 4219200,14.02; 4222800,21.81; 4226400,11.76; 4230000,13.58;
        4233600,8.54; 4237200,10.63; 4240800,13.98; 4244400,9.87; 4248000,9.14;
        4251600,16.8; 4255200,11.67; 4258800,9.72; 4262400,13.73; 4266000,11.35;
        4269600,17.14; 4273200,10.48; 4276800,15.54; 4280400,23.56; 4284000,
        9.85; 4287600,14.05; 4291200,10.26; 4294800,13.97; 4298400,10.93;
        4302000,11.94; 4305600,15.52; 4309200,21.69; 4312800,13.88; 4316400,
        11.66; 4320000,12.62; 4323600,13.07; 4327200,11.5; 4330800,14.41;
        4334400,12.67; 4338000,15.87; 4341600,13.43; 4345200,8.7; 4348800,18.79;
        4352400,20.5; 4356000,18.55; 4359600,8.85; 4363200,12.35; 4366800,11.08;
        4370400,15.18; 4374000,14.3; 4377600,10.81; 4381200,11.91; 4384800,9.69;
        4388400,13.09; 4392000,16.55; 4395600,22.32; 4399200,16.14; 4402800,
        12.62; 4406400,14.16; 4410000,7.06; 4413600,13.14; 4417200,9.54;
        4420800,15.75; 4424400,15.53; 4428000,11.28; 4431600,15.64; 4435200,
        15.72; 4438800,21.79; 4442400,19.83; 4446000,11.79; 4449600,11.67;
        4453200,14.01; 4456800,11.15; 4460400,11.92; 4464000,9.65; 4467600,
        13.08; 4471200,15; 4474800,12.57; 4478400,18.73; 4482000,19.03; 4485600,
        15.93; 4489200,12.02; 4492800,11.02; 4496400,10.38; 4500000,9.66;
        4503600,8.53; 4507200,8.76; 4510800,19.01; 4514400,20.05; 4518000,23.09;
        4521600,10.95; 4525200,5.5; 4528800,8.58; 4532400,12.64; 4536000,24.19;
        4539600,13.49; 4543200,10.64; 4546800,11.4; 4550400,11.09; 4554000,5.39;
        4557600,8.95; 4561200,12.38; 4564800,6.32; 4568400,10.73; 4572000,8.77;
        4575600,14.29; 4579200,16.52; 4582800,9.08; 4586400,7.61; 4590000,5.91;
        4593600,9.24; 4597200,7.09; 4600800,8.38; 4604400,6.42; 4608000,6.96;
        4611600,8.7; 4615200,11.18; 4618800,15.69; 4622400,20.51; 4626000,14.2;
        4629600,8.12; 4633200,12.71; 4636800,10.31; 4640400,8.5; 4644000,10.08;
        4647600,10.53; 4651200,10.66; 4654800,8.83; 4658400,15.29; 4662000,
        12.18; 4665600,14.02; 4669200,7.75; 4672800,12.49; 4676400,8.02;
        4680000,8.52; 4683600,5.42; 4687200,7.6; 4690800,8.53; 4694400,8.33;
        4698000,8.43; 4701600,6.75; 4705200,14.94; 4708800,21.16; 4712400,13.04;
        4716000,10.94; 4719600,3.84; 4723200,10.58; 4726800,9.63; 4730400,14.19;
        4734000,14.74; 4737600,8; 4741200,11.49; 4744800,11.59; 4748400,17.73;
        4752000,19.63; 4755600,10.66; 4759200,5.97; 4762800,11.88; 4766400,7.88;
        4770000,7.48; 4773600,7.09; 4777200,7.37; 4780800,6.85; 4784400,7.63;
        4788000,6.8; 4791600,10.93; 4795200,11.08; 4798800,15.83; 4802400,14.4;
        4806000,21.08; 4809600,11; 4813200,9.81; 4816800,12.54; 4820400,10.46;
        4824000,10.66; 4827600,11.39; 4831200,14.1; 4834800,20.06; 4838400,
        16.39; 4842000,11.17; 4845600,11.1; 4849200,12.72; 4852800,5.93;
        4856400,5.41; 4860000,25.32; 4863600,3.69; 4867200,11.2; 4870800,6.62;
        4874400,15.9; 4878000,14.62; 4881600,15.24; 4885200,11.89; 4888800,
        15.28; 4892400,17.96; 4896000,17.63; 4899600,14.99; 4903200,11.77;
        4906800,12.34; 4910400,10.68; 4914000,14.48; 4917600,12.89; 4921200,
        20.48; 4924800,21.75; 4928400,10.83; 4932000,12.25; 4935600,16.15;
        4939200,17.48; 4942800,11.82; 4946400,11.86; 4950000,15.68; 4953600,
        14.56; 4957200,20.33; 4960800,17.77; 4964400,27.13; 4968000,28.03;
        4971600,17.7; 4975200,25; 4978800,17.54; 4982400,20.08; 4986000,15.62;
        4989600,22.27; 4993200,16.83; 4996800,17.77; 5000400,17.29; 5004000,
        25.33; 5007600,26.92; 5011200,28.41; 5014800,21.2; 5018400,13.88;
        5022000,17.54; 5025600,15.46; 5029200,12; 5032800,13.83; 5036400,13.87;
        5040000,12.62; 5043600,13.17; 5047200,18.6; 5050800,24.72; 5054400,
        26.41; 5058000,21.12; 5061600,19.79; 5065200,18.8; 5068800,19.98;
        5072400,16.41; 5076000,15.09; 5079600,18.47; 5083200,16.83; 5086800,
        17.57; 5090400,20.44; 5094000,24.46; 5097600,27.03; 5101200,20.86;
        5104800,20.24; 5108400,15.26; 5112000,18.04; 5115600,12.78; 5119200,
        12.7; 5122800,8.86; 5126400,13.38; 5130000,13.12; 5133600,11.07;
        5137200,14.24; 5140800,13.4; 5144400,11.07; 5148000,13.48; 5151600,13.6;
        5155200,10.75; 5158800,13.77; 5162400,13.11; 5166000,12.02; 5169600,
        14.59; 5173200,13.66; 5176800,13.57; 5180400,10.22; 5184000,13.68;
        5187600,21.74; 5191200,23.64; 5194800,24.61; 5198400,23.96; 5202000,
        24.1; 5205600,23.22; 5209200,22.89; 5212800,25.56; 5216400,17.09;
        5220000,12.89; 5223600,11.06; 5227200,12.74; 5230800,13.18; 5234400,
        13.17; 5238000,13.17; 5241600,16.22; 5245200,17.35; 5248800,14.53;
        5252400,19.75; 5256000,17.99; 5259600,15.16; 5263200,15.33; 5266800,
        15.25; 5270400,17.77; 5274000,18.02; 5277600,17.11; 5281200,17.09;
        5284800,16.55; 5288400,18.65; 5292000,18.23; 5295600,22.54; 5299200,
        23.32; 5302800,18.36; 5306400,14.9; 5310000,15.29; 5313600,8.64;
        5317200,13.99; 5320800,14.65; 5324400,12.81; 5328000,19.18; 5331600,
        22.41; 5335200,15.46; 5338800,20.77; 5342400,21.61; 5346000,15.98;
        5349600,13.43; 5353200,15.55; 5356800,15.24; 5360400,14.08; 5364000,
        17.13; 5367600,17.78; 5371200,15.16; 5374800,15.33; 5378400,14.25;
        5382000,20.17; 5385600,23.96; 5389200,18.29; 5392800,14.67; 5396400,
        10.65; 5400000,13.48; 5403600,15.15; 5407200,14.44; 5410800,15.77;
        5414400,20.82; 5418000,18.29; 5421600,21.59; 5425200,25.2; 5428800,
        23.93; 5432400,15.51; 5436000,15.62; 5439600,15.63; 5443200,17.23;
        5446800,17.76; 5450400,15.48; 5454000,16.19; 5457600,16.99; 5461200,
        19.58; 5464800,16.89; 5468400,19.83; 5472000,21.35; 5475600,18.69;
        5479200,18.91; 5482800,26.31; 5486400,21.78; 5490000,12.91; 5493600,
        18.08; 5497200,16.11; 5500800,20.6; 5504400,17.83; 5508000,20.66;
        5511600,23.89; 5515200,26.22; 5518800,18.07; 5522400,17.77; 5526000,
        17.78; 5529600,20.2; 5533200,19.6; 5536800,17.64; 5540400,19.9; 5544000,
        20.65; 5547600,18.94; 5551200,19.52; 5554800,20.41; 5558400,15.9;
        5562000,12.38; 5565600,11.13; 5569200,11.27; 5572800,13.15; 5576400,
        12.5; 5580000,12.31; 5583600,12.62; 5587200,12.81; 5590800,12.83;
        5594400,12.27; 5598000,12.53; 5601600,11.54; 5605200,12.19; 5608800,
        11.59; 5612400,12.26; 5616000,23.96; 5619600,27.09; 5623200,26.55;
        5626800,18.81; 5630400,28.51; 5634000,20.43; 5637600,22.73; 5641200,
        25.13; 5644800,20.12; 5648400,8.74; 5652000,15.89; 5655600,11.83;
        5659200,11.37; 5662800,11.34; 5666400,14.08; 5670000,12.18; 5673600,
        13.96; 5677200,15.85; 5680800,17.86; 5684400,19.56; 5688000,13.26;
        5691600,15.02; 5695200,12.38; 5698800,14.07; 5702400,16.22; 5706000,
        15.81; 5709600,14.08; 5713200,14.74; 5716800,20.41; 5720400,17.62;
        5724000,20.75; 5727600,24.05; 5731200,14.27; 5734800,12.35; 5738400,
        13.79; 5742000,14.95; 5745600,12.78; 5749200,12.67; 5752800,14.47;
        5756400,18.76; 5760000,19.02; 5763600,14.73; 5767200,24.06; 5770800,
        22.15; 5774400,11.77; 5778000,13.2; 5781600,18.85; 5785200,13.43;
        5788800,18.5; 5792400,12.63; 5796000,12.55; 5799600,14.36; 5803200,
        25.17; 5806800,18.15; 5810400,25.48; 5814000,25.16; 5817600,18.35;
        5821200,15.12; 5824800,14.08; 5828400,15.51; 5832000,11.21; 5835600,
        22.68; 5839200,16.41; 5842800,16.37; 5846400,20.87; 5850000,17.93;
        5853600,25.89; 5857200,21.95; 5860800,20.53; 5864400,18.21; 5868000,
        13.02; 5871600,23.38; 5875200,15.01; 5878800,16.99; 5882400,19.9;
        5886000,16.83; 5889600,17.49; 5893200,15.28; 5896800,24.65; 5900400,
        15.27; 5904000,22.53; 5907600,20.86; 5911200,27.43; 5914800,22.64;
        5918400,16.58; 5922000,18.04; 5925600,14.73; 5929200,20.11; 5932800,18;
        5936400,23.54; 5940000,22.09; 5943600,27.45; 5947200,18; 5950800,16.34;
        5954400,19.49; 5958000,17.02; 5961600,15.97; 5965200,19.04; 5968800,
        17.64; 5972400,17.09; 5976000,19.86; 5979600,17.36; 5983200,20.11;
        5986800,19.75; 5990400,20.26; 5994000,22.33; 5997600,22.57; 6001200,
        27.51; 6004800,17.16; 6008400,19.92; 6012000,19.37; 6015600,20.07;
        6019200,23.03; 6022800,18.88; 6026400,22.39; 6030000,27.58; 6033600,
        15.24; 6037200,14.28; 6040800,15.01; 6044400,20.29; 6048000,16.58;
        6051600,19.44; 6055200,18.32; 6058800,17.87; 6062400,22.69; 6066000,
        18.62; 6069600,25.33; 6073200,26.41; 6076800,23.44; 6080400,14.49;
        6084000,16.2; 6087600,16.05; 6091200,13.21; 6094800,22.23; 6098400,
        22.17; 6102000,21.31; 6105600,23.75; 6109200,17.58; 6112800,26.58;
        6116400,26.74; 6120000,16.48; 6123600,21.05; 6127200,19.01; 6130800,
        22.17; 6134400,21.61; 6138000,19.66; 6141600,18.16; 6145200,22.1;
        6148800,20.78; 6152400,22.6; 6156000,22.43; 6159600,27.03; 6163200,
        23.31; 6166800,11.26; 6170400,12.41; 6174000,10.54; 6177600,25.77;
        6181200,14.58; 6184800,18.71; 6188400,19.81; 6192000,20.91; 6195600,
        19.65; 6199200,18.19; 6202800,28.28; 6206400,18.99; 6210000,19.76;
        6213600,14.74; 6217200,20.84; 6220800,11.98; 6224400,10.91; 6228000,
        11.64; 6231600,13.15; 6235200,13.38; 6238800,21.04; 6242400,16.69;
        6246000,10.99; 6249600,15.83; 6253200,13.47; 6256800,19.95; 6260400,
        23.76; 6264000,23.95; 6267600,26.67; 6271200,13.58; 6274800,13.66;
        6278400,13.8; 6282000,16.39; 6285600,2.25; 6289200,12.53; 6292800,14.63;
        6296400,15.01; 6300000,19.87; 6303600,18.44; 6307200,19.15; 6310800,
        13.5; 6314400,14.02; 6318000,8; 6321600,9.63; 6325200,10.25; 6328800,
        7.55; 6332400,10.81; 6336000,11.84; 6339600,7.06; 6343200,8.77; 6346800,
        8.22; 6350400,7.68; 6354000,7.02; 6357600,4.83; 6361200,4.31; 6364800,
        4.11; 6368400,6.16; 6372000,9.72; 6375600,9.87; 6379200,9.45; 6382800,
        7.89; 6386400,6.63; 6390000,6.96; 6393600,5.89; 6397200,9.04; 6400800,
        8.61; 6404400,10.69; 6408000,14.78; 6411600,7.55; 6415200,8.79; 6418800,
        15.45; 6422400,9.53; 6426000,19.01; 6429600,22.27; 6433200,20.37;
        6436800,14.82; 6440400,8.23; 6444000,6.94; 6447600,6.65; 6451200,10.25;
        6454800,9.53; 6458400,7.6; 6462000,9.48; 6465600,13.64; 6469200,9.94;
        6472800,18.86; 6476400,15.39; 6480000,7.07; 6483600,6.34; 6487200,8.56;
        6490800,8.35; 6494400,9.14; 6498000,9.28; 6501600,7.17; 6505200,11.56;
        6508800,11.48; 6512400,12.07; 6516000,17.16; 6519600,12.24; 6523200,
        14.93; 6526800,9.07; 6530400,7.13; 6534000,7.1; 6537600,7.47; 6541200,
        13.01; 6544800,7.15; 6548400,7.42; 6552000,9.42; 6555600,11.59; 6559200,
        13.13; 6562800,10.78; 6566400,9.85; 6570000,8.79; 6573600,7.39; 6577200,
        6.92; 6580800,7.63; 6584400,7.56; 6588000,9.23; 6591600,7.37; 6595200,
        14.15; 6598800,13.36; 6602400,17.78; 6606000,18.77; 6609600,14.95;
        6613200,6.22; 6616800,12.43; 6620400,13.64; 6624000,6.81; 6627600,7.04;
        6631200,8.52; 6634800,17.86; 6638400,16.51; 6642000,14.5; 6645600,18.07;
        6649200,13.31; 6652800,10.22; 6656400,8.44; 6660000,8.13; 6663600,6.73;
        6667200,6.49; 6670800,9.33; 6674400,7.29; 6678000,14.58; 6681600,5.91;
        6685200,10.81; 6688800,13.77; 6692400,21.16; 6696000,19.5; 6699600,
        18.08; 6703200,24.85; 6706800,11.78; 6710400,7.39; 6714000,10.14;
        6717600,10.95; 6721200,17.99; 6724800,15.82; 6728400,15.93; 6732000,
        23.57; 6735600,18.38; 6739200,6.76; 6742800,6.85; 6746400,7.79; 6750000,
        6.59; 6753600,8.13; 6757200,6.24; 6760800,7.09; 6764400,10.12; 6768000,
        11.09; 6771600,13.86; 6775200,17.07; 6778800,21.4; 6782400,15.28;
        6786000,14.73; 6789600,21.52; 6793200,7.09; 6796800,7.13; 6800400,13.44;
        6804000,8.11; 6807600,12.11; 6811200,19.71; 6814800,15.74; 6818400,
        21.76; 6822000,8.88; 6825600,12.49; 6829200,9.02; 6832800,6.69; 6836400,
        7.32; 6840000,4.35; 6843600,7.22; 6847200,11.8; 6850800,11.1; 6854400,
        14.79; 6858000,14.82; 6861600,22.23; 6865200,16.34; 6868800,16.23;
        6872400,18.24; 6876000,10.85; 6879600,9.79; 6883200,14.75; 6886800,
        12.48; 6890400,16.75; 6894000,15.2; 6897600,15.83; 6901200,15.51;
        6904800,21.16; 6908400,20.34; 6912000,7.47; 6915600,6.92; 6919200,5.65;
        6922800,8.78; 6926400,10.47; 6930000,6.36; 6933600,6.57; 6937200,13.22;
        6940800,11.26; 6944400,15.73; 6948000,20.93; 6951600,18.05; 6955200,
        23.6; 6958800,10.46; 6962400,10.63; 6966000,6.15; 6969600,9.77; 6973200,
        7.53; 6976800,17.96; 6980400,15.11; 6984000,14.68; 6987600,17.97;
        6991200,18.31; 6994800,16.46; 6998400,6.34; 7002000,7.9; 7005600,7.02;
        7009200,7.93; 7012800,7.35; 7016400,6.34; 7020000,9.02; 7023600,6.72;
        7027200,9.39; 7030800,7.98; 7034400,8.03; 7038000,5.76; 7041600,9.14;
        7045200,8.34; 7048800,8.93; 7052400,7.65; 7056000,7.71; 7059600,7.65;
        7063200,8.59; 7066800,8.94; 7070400,7.65; 7074000,7.68; 7077600,6.83;
        7081200,9.12; 7084800,9.52; 7088400,9.49; 7092000,9.39; 7095600,6.8;
        7099200,7.37; 7102800,8.49; 7106400,7.37; 7110000,8.05; 7113600,7.3;
        7117200,8.03; 7120800,8.66; 7124400,5.33; 7128000,8.29; 7131600,6.95;
        7135200,8.05; 7138800,11.5; 7142400,7.81; 7146000,10.19; 7149600,8.38;
        7153200,7.15; 7156800,10.3; 7160400,7.88; 7164000,7.9; 7167600,7.23;
        7171200,7.65; 7174800,8; 7178400,7.63; 7182000,7.91; 7185600,7.1;
        7189200,7.17; 7192800,8.01; 7196400,6.77; 7200000,8.46; 7203600,8.11;
        7207200,8.53; 7210800,4.88; 7214400,8.36; 7218000,4.88; 7221600,7.7;
        7225200,7.3; 7228800,5.11; 7232400,8.31; 7236000,0; 7239600,5.71;
        7243200,5.13; 7246800,8.28; 7250400,9.89; 7254000,6.72; 7257600,5.37;
        7261200,8.66; 7264800,6.69; 7268400,7.8; 7272000,8.05; 7275600,7.13;
        7279200,5.36; 7282800,7.98; 7286400,6.97; 7290000,10.2; 7293600,6.15;
        7297200,2.9; 7300800,7.28; 7304400,11.55; 7308000,6.01; 7311600,3;
        7315200,7.75; 7318800,8.54; 7322400,8.76; 7326000,4.81; 7329600,7.2;
        7333200,6.9; 7336800,10.65; 7340400,7.22; 7344000,7.58; 7347600,7.18;
        7351200,6.92; 7354800,7.9; 7358400,8.11; 7362000,7.48; 7365600,5.01;
        7369200,7.4; 7372800,8.08; 7376400,9.39; 7380000,6.88; 7383600,8.44;
        7387200,8.23; 7390800,8.64; 7394400,7.83; 7398000,4.48; 7401600,8.26;
        7405200,5.46; 7408800,9.56; 7412400,10.4; 7416000,5.37; 7419600,6.35;
        7423200,9.79; 7426800,9.19; 7430400,5.69; 7434000,8.59; 7437600,6.02;
        7441200,5.39; 7444800,10.14; 7448400,27.37; 7452000,5.86; 7455600,7.15;
        7459200,9.79; 7462800,9.35; 7466400,5.8; 7470000,6.25; 7473600,9.89;
        7477200,7.92; 7480800,8.46; 7484400,5.62; 7488000,5.17; 7491600,8.41;
        7495200,6.49; 7498800,8.97; 7502400,8.17; 7506000,7.51; 7509600,8.15;
        7513200,8.72; 7516800,9.64; 7520400,7.62; 7524000,5.89; 7527600,7.41;
        7531200,7.15; 7534800,6.51; 7538400,10.58; 7542000,8.05; 7545600,7.95;
        7549200,9.13; 7552800,7.75; 7556400,8.61; 7560000,7.51; 7563600,8.06;
        7567200,8.27; 7570800,8.4; 7574400,8.63; 7578000,5.6; 7581600,8.55;
        7585200,7.64; 7588800,8.37; 7592400,7.04; 7596000,10.59; 7599600,9.7;
        7603200,8.42; 7606800,7.82; 7610400,9.77; 7614000,10.82; 7617600,7.2;
        7621200,7.35; 7624800,7.45; 7628400,4.07; 7632000,4.69; 7635600,9.17;
        7639200,9.55; 7642800,7.92; 7646400,7.96; 7650000,5.15; 7653600,7.1;
        7657200,7.71; 7660800,7.52; 7664400,6.63; 7668000,7.21; 7671600,10.03;
        7675200,7.37; 7678800,9.95; 7682400,7.67; 7686000,6.64; 7689600,7.15;
        7693200,7.89; 7696800,8.65; 7700400,7.31; 7704000,9.21; 7707600,7.54;
        7711200,7.09; 7714800,6.76; 7718400,6.37; 7722000,9.07; 7725600,8.01;
        7729200,8.31; 7732800,7.72; 7736400,7.15; 7740000,4.94; 7743600,4.88;
        7747200,6.85; 7750800,7.08; 7754400,7.77; 7758000,6.89; 7761600,7.33;
        7765200,9.74; 7768800,6.3; 7772400,7.62; 7776000,4.99; 7779600,10.44;
        7783200,10.67; 7786800,8.81; 7790400,7.46; 7794000,6.85; 7797600,8.26;
        7801200,7.64; 7804800,8.06; 7808400,8.08; 7812000,9.84; 7815600,9.78;
        7819200,7.39; 7822800,7.44; 7826400,6.76; 7830000,9.51; 7833600,6.87;
        7837200,7.2; 7840800,7.82; 7844400,7.93; 7848000,8.45; 7851600,7.62;
        7855200,9.47; 7858800,7.56; 7862400,7.15; 7866000,6.79; 7869600,6.71;
        7873200,10; 7876800,6.53; 7880400,7.7; 7884000,9.87; 7887600,7.44;
        7891200,6.14; 7894800,6.01; 7898400,4.91; 7902000,7.1; 7905600,9.24;
        7909200,8.24; 7912800,7.18; 7916400,9.51; 7920000,7.7; 7923600,4.69;
        7927200,6.88; 7930800,7.23; 7934400,6.42; 7938000,7.35; 7941600,9.88;
        7945200,8.99; 7948800,8.72; 7952400,8.8; 7956000,6.99; 7959600,7.16;
        7963200,7.21; 7966800,5.81; 7970400,7.4; 7974000,7.69; 7977600,8.51;
        7981200,6.96; 7984800,6.77; 7988400,6.96; 7992000,5.35; 7995600,7.31;
        7999200,6.54; 8002800,8.2; 8006400,9.34; 8010000,7.1; 8013600,9.42;
        8017200,9.1; 8020800,7.24; 8024400,6.64; 8028000,6.34; 8031600,7.16;
        8035200,6.08; 8038800,9.17; 8042400,6.43; 8046000,7.26; 8049600,7.62;
        8053200,5.87; 8056800,6.9; 8060400,5.58; 8064000,7.1; 8067600,7.47;
        8071200,7.41; 8074800,8.08; 8078400,5.42; 8082000,5.07; 8085600,7.02;
        8089200,9.67; 8092800,8.11; 8096400,9.71; 8100000,7.83; 8103600,9.84;
        8107200,7.2; 8110800,7.57; 8114400,8.81; 8118000,9.07; 8121600,6.6;
        8125200,6.69; 8128800,6.86; 8132400,17.08; 8136000,22.64; 8139600,17.64;
        8143200,5.63; 8146800,7.38; 8150400,9.97; 8154000,21.65; 8157600,16.6;
        8161200,18.95; 8164800,20.93; 8168400,12.97; 8172000,16.82; 8175600,
        25.86; 8179200,20.01; 8182800,12.39; 8186400,12.16; 8190000,7.39;
        8193600,9.13; 8197200,8.95; 8200800,8.27; 8204400,9.16; 8208000,16.05;
        8211600,13.24; 8215200,17.19; 8218800,13.25; 8222400,10.15; 8226000,
        6.59; 8229600,10.63; 8233200,8.26; 8236800,9.76; 8240400,10.99; 8244000,
        5.57; 8247600,4.81; 8251200,14.49; 8254800,11.03; 8258400,12.3; 8262000,
        24.78; 8265600,9.02; 8269200,9.92; 8272800,6.2; 8276400,7.42; 8280000,
        5.44; 8283600,7.29; 8287200,8.03; 8290800,14.09; 8294400,12.65; 8298000,
        11.94; 8301600,16; 8305200,15.92; 8308800,9.9; 8312400,9.71; 8316000,
        6.55; 8319600,8.13; 8323200,10.7; 8326800,8.19; 8330400,9.43; 8334000,
        11.76; 8337600,9.49; 8341200,23.61; 8344800,14.35; 8348400,21.18;
        8352000,13.58; 8355600,9.78; 8359200,11.25; 8362800,8.39; 8366400,6.18;
        8370000,12.95; 8373600,11.84; 8377200,7.75; 8380800,11.5; 8384400,12.44;
        8388000,10.09; 8391600,18; 8395200,19.27; 8398800,14.42; 8402400,5.93;
        8406000,6.71; 8409600,10.84; 8413200,8.89; 8416800,13.81; 8420400,11.52;
        8424000,14.59; 8427600,7.36; 8431200,14; 8434800,12.8; 8438400,18.08;
        8442000,18.5; 8445600,18.5; 8449200,14.24; 8452800,11.09; 8456400,8.83;
        8460000,8.33; 8463600,9.25; 8467200,13.04; 8470800,9.98; 8474400,16.62;
        8478000,15.56; 8481600,11.9; 8485200,12.54; 8488800,14.58; 8492400,
        11.05; 8496000,9.57; 8499600,12.54; 8503200,17.78; 8506800,9.1; 8510400,
        14.27; 8514000,11.52; 8517600,14.68; 8521200,16.36; 8524800,12.97;
        8528400,13.89; 8532000,16.79; 8535600,23.48; 8539200,16.9; 8542800,
        19.32; 8546400,10.92; 8550000,9.47; 8553600,11.19; 8557200,18.6;
        8560800,18.46; 8564400,18.88; 8568000,14.92; 8571600,17.03; 8575200,
        9.71; 8578800,10.81; 8582400,11.76; 8586000,10.15; 8589600,18.75;
        8593200,9.96; 8596800,13.78; 8600400,19.92; 8604000,18.22; 8607600,
        10.42; 8611200,17.87; 8614800,24.12; 8618400,18.43; 8622000,18.2;
        8625600,17.72; 8629200,15.78; 8632800,14.4; 8636400,13.16; 8640000,5.91;
        8643600,9.05; 8647200,11.86; 8650800,7.75; 8654400,7.2; 8658000,7.33;
        8661600,9.74; 8665200,5.02; 8668800,9.7; 8672400,8.71; 8676000,9.39;
        8679600,9.68; 8683200,5.91; 8686800,5.51; 8690400,8.2; 8694000,8.33;
        8697600,8.78; 8701200,7.42; 8704800,3.77; 8708400,6.93; 8712000,6.78;
        8715600,6.93; 8719200,7.81; 8722800,7.29; 8726400,6.74; 8730000,14.79;
        8733600,3.93; 8737200,4.97; 8740800,7.03; 8744400,5.51; 8748000,3.98;
        8751600,9.77; 8755200,4.51; 8758800,4.14; 8762400,4.39; 8766000,7.23;
        8769600,5.4; 8773200,6.81; 8776800,9.07; 8780400,5.61; 8784000,7.26;
        8787600,6.6; 8791200,5.15; 8794800,6.41; 8798400,6.66; 8802000,9.9;
        8805600,11; 8809200,9.08; 8812800,7.32; 8816400,7.02; 8820000,9.49;
        8823600,3.05; 8827200,3.66; 8830800,6.61; 8834400,5.85; 8838000,11.28;
        8841600,18.02; 8845200,21.15; 8848800,18.86; 8852400,15.13; 8856000,
        10.96; 8859600,6.1; 8863200,12.48; 8866800,22.2; 8870400,18.7; 8874000,
        40.06; 8877600,16.53; 8881200,11.01; 8884800,9.3; 8888400,14.57;
        8892000,13.5; 8895600,12.39; 8899200,10.66; 8902800,12.67; 8906400,
        24.03; 8910000,14.81; 8913600,9.76; 8917200,8.51; 8920800,5.51; 8924400,
        5.32; 8928000,7.19; 8931600,6.08; 8935200,5.22; 8938800,4.27; 8942400,
        7.52; 8946000,16.08; 8949600,19.42; 8953200,25.76; 8956800,10.92;
        8960400,13.82; 8964000,10.43; 8967600,9.93; 8971200,10.61; 8974800,12.7;
        8978400,10.96; 8982000,16.41; 8985600,11.82; 8989200,14.08; 8992800,
        23.95; 8996400,10.48; 9000000,11.98; 9003600,14.57; 9007200,5.28;
        9010800,7.01; 9014400,6.55; 9018000,5.68; 9021600,6.2; 9025200,6.19;
        9028800,5.97; 9032400,11.18; 9036000,23.03; 9039600,17.89; 9043200,
        15.37; 9046800,15.72; 9050400,14.54; 9054000,16.71; 9057600,12.17;
        9061200,14.13; 9064800,15.25; 9068400,13.13; 9072000,12.9; 9075600,
        16.24; 9079200,21.96; 9082800,16.41; 9086400,12.78; 9090000,9.26;
        9093600,5.04; 9097200,4.58; 9100800,6.54; 9104400,6.69; 9108000,4.74;
        9111600,5.6; 9115200,6.91; 9118800,12.96; 9122400,20.43; 9126000,21.8;
        9129600,16.37; 9133200,21.71; 9136800,22.08; 9140400,15.75; 9144000,
        13.39; 9147600,8.63; 9151200,12.07; 9154800,12.58; 9158400,16.66;
        9162000,11.34; 9165600,4.75; 9169200,1.18; 9172800,22.53; 9176400,14.89;
        9180000,7.32; 9183600,6.81; 9187200,5.38; 9190800,6.05; 9194400,4.34;
        9198000,7.65; 9201600,8.41; 9205200,8.37; 9208800,7.56; 9212400,8.17;
        9216000,6.25; 9219600,9.64; 9223200,5.53; 9226800,7.79; 9230400,7.6;
        9234000,8.08; 9237600,6.89; 9241200,7.82; 9244800,16.07; 9248400,20.11;
        9252000,22.22; 9255600,19.09; 9259200,8.1; 9262800,7.07; 9266400,7.5;
        9270000,21.08; 9273600,20.2; 9277200,12.84; 9280800,15.02; 9284400,8.75;
        9288000,10.57; 9291600,14.37; 9295200,13.25; 9298800,14.78; 9302400,
        10.68; 9306000,12.31; 9309600,19.23; 9313200,21.37; 9316800,10.79;
        9320400,9.25; 9324000,9.23; 9327600,8.05; 9331200,9.02; 9334800,4.95;
        9338400,0; 9342000,0; 9345600,0; 9349200,0; 9352800,0; 9356400,0;
        9360000,0; 9363600,0; 9367200,0; 9370800,0; 9374400,0; 9378000,0;
        9381600,0; 9385200,0; 9388800,0; 9392400,0; 9396000,0; 9399600,0;
        9403200,0; 9406800,0; 9410400,0; 9414000,0; 9417600,0; 9421200,0;
        9424800,0; 9428400,39.07; 9432000,6.54; 9435600,6.54; 9439200,7.59;
        9442800,8.29; 9446400,7.52; 9450000,4.39; 9453600,3.47; 9457200,4.31;
        9460800,6.67; 9464400,6.46; 9468000,4.76; 9471600,6.15; 9475200,6.95;
        9478800,4.5; 9482400,7.09; 9486000,7.34; 9489600,4.18; 9493200,7.21;
        9496800,8.16; 9500400,8.42; 9504000,8.59; 9507600,9.09; 9511200,8.74;
        9514800,22.56; 9518400,21.97; 9522000,19.31; 9525600,14.38; 9529200,
        6.89; 9532800,10.73; 9536400,8.04; 9540000,25.97; 9543600,18.39;
        9547200,20.51; 9550800,11.3; 9554400,9.71; 9558000,8.61; 9561600,10.44;
        9565200,14.21; 9568800,10.74; 9572400,6.78; 9576000,10.57; 9579600,
        16.49; 9583200,13.89; 9586800,14.89; 9590400,12.4; 9594000,5.73;
        9597600,6.69; 9601200,4.7; 9604800,6.58; 9608400,2.39; 9612000,12.56;
        9615600,5.93; 9619200,11.44; 9622800,18.42; 9626400,20.82; 9630000,
        16.74; 9633600,10.65; 9637200,7.04; 9640800,13.09; 9644400,14.01;
        9648000,9.12; 9651600,14.35; 9655200,8.53; 9658800,13.43; 9662400,13.49;
        9666000,19.3; 9669600,13.29; 9673200,11.52; 9676800,11.27; 9680400,3.95;
        9684000,9.22; 9687600,9.36; 9691200,4.08; 9694800,5.02; 9698400,7.3;
        9702000,6.07; 9705600,11.87; 9709200,22.29; 9712800,18.93; 9716400,
        18.62; 9720000,12.56; 9723600,13.56; 9727200,14.73; 9730800,8.08;
        9734400,14.09; 9738000,11.72; 9741600,14.21; 9745200,14.54; 9748800,
        9.93; 9752400,23.49; 9756000,21.93; 9759600,12.43; 9763200,11.18;
        9766800,6.67; 9770400,6.96; 9774000,5.81; 9777600,7.97; 9781200,6.15;
        9784800,8.68; 9788400,7.99; 9792000,11.31; 9795600,22.36; 9799200,12.35;
        9802800,13.7; 9806400,20.97; 9810000,19.62; 9813600,17.46; 9817200,
        19.92; 9820800,13.35; 9824400,16.96; 9828000,13.04; 9831600,21.49;
        9835200,13.17; 9838800,23.24; 9842400,17.28; 9846000,18.16; 9849600,
        8.85; 9853200,8.48; 9856800,6.55; 9860400,6.54; 9864000,6.09; 9867600,
        6.52; 9871200,4.29; 9874800,9.8; 9878400,11.45; 9882000,24.65; 9885600,
        19; 9889200,11.44; 9892800,15.65; 9896400,19.69; 9900000,21.84; 9903600,
        12.1; 9907200,17.2; 9910800,16.74; 9914400,14.88; 9918000,13.97;
        9921600,16.8; 9925200,23.52; 9928800,18.56; 9932400,16.26; 9936000,
        13.84; 9939600,8.14; 9943200,5.81; 9946800,6.97; 9950400,5.57; 9954000,
        11.3; 9957600,6.1; 9961200,5.35; 9964800,10.97; 9968400,21.25; 9972000,
        19.71; 9975600,18.27; 9979200,17.52; 9982800,13.9; 9986400,11.3;
        9990000,13.86; 9993600,13.42; 9997200,16.24; 10000800,16.67; 10004400,
        14.08; 10008000,12.9; 10011600,19.95; 10015200,23.33; 10018800,12.18;
        10022400,14.04; 10026000,14.93; 10029600,4.85; 10033200,6.98; 10036800,
        8.39; 10040400,5.14; 10044000,9.41; 10047600,7.09; 10051200,13.67;
        10054800,23.86; 10058400,17.11; 10062000,16.1; 10065600,16.07; 10069200,
        11.01; 10072800,18.77; 10076400,14.54; 10080000,17.79; 10083600,6.79;
        10087200,14.36; 10090800,20.38; 10094400,12.45; 10098000,17.53;
        10101600,22.37; 10105200,16.1; 10108800,13.36; 10112400,6.28; 10116000,
        8.57; 10119600,7.04; 10123200,5.84; 10126800,6.49; 10130400,6.43;
        10134000,7.52; 10137600,6.84; 10141200,8.64; 10144800,3.86; 10148400,
        2.31; 10152000,7.15; 10155600,6.38; 10159200,7.29; 10162800,7.52;
        10166400,7.35; 10170000,7.74; 10173600,7.56; 10177200,6.9; 10180800,
        6.43; 10184400,7.41; 10188000,7.2; 10191600,7.3; 10195200,6.29;
        10198800,6.36; 10202400,6.55; 10206000,6.96; 10209600,8.26; 10213200,
        4.14; 10216800,5.06; 10220400,7.9; 10224000,5.21; 10227600,4.69;
        10231200,6.55; 10234800,6.75; 10238400,6.68; 10242000,6.47; 10245600,
        6.14; 10249200,6.67; 10252800,5.51; 10256400,6.93; 10260000,6.56;
        10263600,7.66; 10267200,6.9; 10270800,4.98; 10274400,5.75; 10278000,
        5.86; 10281600,7.81; 10285200,9.42; 10288800,6.54; 10292400,6.48;
        10296000,6.39; 10299600,6.79; 10303200,5.08; 10306800,5.44; 10310400,
        7.35; 10314000,6.48; 10317600,8.05; 10321200,6.77; 10324800,4.6;
        10328400,6.2; 10332000,10.07; 10335600,4.55; 10339200,5.92; 10342800,
        4.82; 10346400,4.41; 10350000,5.97; 10353600,7.5; 10357200,3.82;
        10360800,9.47; 10364400,8.41; 10368000,6.21; 10371600,12.79; 10375200,
        3.06; 10378800,3.82; 10382400,5.55; 10386000,5.96; 10389600,4.83;
        10393200,5.42; 10396800,6.97; 10400400,10.73; 10404000,27.3; 10407600,
        17.98; 10411200,17.72; 10414800,2.88; 10418400,5.91; 10422000,12.33;
        10425600,20.88; 10429200,21.45; 10432800,18.65; 10436400,10.08;
        10440000,14.87; 10443600,7.02; 10447200,9.87; 10450800,13.66; 10454400,
        11.18; 10458000,5.1; 10461600,14.87; 10465200,12.53; 10468800,25.86;
        10472400,8.19; 10476000,12.02; 10479600,14.52; 10483200,7.03; 10486800,
        6.36; 10490400,6.46; 10494000,5.58; 10497600,11.57; 10501200,5.13;
        10504800,7.06; 10508400,13.49; 10512000,20.43; 10515600,18.25; 10519200,
        11.36; 10522800,6.63; 10526400,8.42; 10530000,10.72; 10533600,8.43;
        10537200,8.04; 10540800,8.4; 10544400,8.93; 10548000,13.69; 10551600,
        10.83; 10555200,24.19; 10558800,8.84; 10562400,9.02; 10566000,10.54;
        10569600,7.13; 10573200,8.74; 10576800,6.99; 10580400,5.79; 10584000,
        6.49; 10587600,4.63; 10591200,7.84; 10594800,14.06; 10598400,19.53;
        10602000,22.94; 10605600,11.56; 10609200,12.28; 10612800,8.44; 10616400,
        10.62; 10620000,10.4; 10623600,11.93; 10627200,11.18; 10630800,5.91;
        10634400,6.88; 10638000,6.55; 10641600,6.56; 10645200,3.99; 10648800,
        9.33; 10652400,9.74; 10656000,8.89; 10659600,7.7; 10663200,7.21;
        10666800,6.75; 10670400,7.87; 10674000,3.7; 10677600,6.68; 10681200,
        5.48; 10684800,6.6; 10688400,6.34; 10692000,9.32; 10695600,6.83;
        10699200,7.93; 10702800,7.06; 10706400,6.54; 10710000,6.39; 10713600,
        3.76; 10717200,7.25; 10720800,5.89; 10724400,8.6; 10728000,6.39;
        10731600,4.74; 10735200,7.07; 10738800,5.34; 10742400,5.93; 10746000,
        7.37; 10749600,8.4; 10753200,7.27; 10756800,5.58; 10760400,5.58;
        10764000,8.39; 10767600,4.76; 10771200,7.48; 10774800,8.15; 10778400,
        7.39; 10782000,4.85; 10785600,5.08; 10789200,7.68; 10792800,4.98;
        10796400,4.72; 10800000,6.64; 10803600,7.48; 10807200,7.92; 10810800,
        7.1; 10814400,4.85; 10818000,4.47; 10821600,7.71; 10825200,7.05;
        10828800,8.1; 10832400,7.63; 10836000,6.27; 10839600,7.31; 10843200,
        7.08; 10846800,5.8; 10850400,7.63; 10854000,2.44; 10857600,7.56;
        10861200,4.7; 10864800,7.19; 10868400,5.72; 10872000,5.7; 10875600,4.8;
        10879200,7.18; 10882800,4.93; 10886400,7.99; 10890000,7.41; 10893600,
        6.97; 10897200,5.86; 10900800,6.82; 10904400,7.36; 10908000,6.47;
        10911600,5.11; 10915200,6.35; 10918800,2.46; 10922400,3.82; 10926000,
        7.01; 10929600,7.1; 10933200,5.53; 10936800,5.15; 10940400,5.54;
        10944000,7.43; 10947600,4.19; 10951200,7.4; 10954800,6.8; 10958400,6.47;
        10962000,8.52; 10965600,8.21; 10969200,5.32; 10972800,6.75; 10976400,
        2.93; 10980000,5.92; 10983600,3.85; 10987200,5.26; 10990800,5.57;
        10994400,9.34; 10998000,9.03; 11001600,6.23; 11005200,3.97; 11008800,
        5.58; 11012400,6.62; 11016000,8.75; 11019600,9.36; 11023200,6.44;
        11026800,5.64; 11030400,5.94; 11034000,6.2; 11037600,5.85; 11041200,
        9.36; 11044800,7.47; 11048400,6.57; 11052000,6.25; 11055600,6.92;
        11059200,6.97; 11062800,6.53; 11066400,7.22; 11070000,6.47; 11073600,
        6.21; 11077200,5.26; 11080800,12.14; 11084400,8.15; 11088000,5.59;
        11091600,12.38; 11095200,7.3; 11098800,11.98; 11102400,5.97; 11106000,
        4.26; 11109600,11.45; 11113200,9.35; 11116800,8.39; 11120400,9.33;
        11124000,7.38; 11127600,8.03; 11131200,6.95; 11134800,5.29; 11138400,
        8.27; 11142000,5.94; 11145600,10.65; 11149200,10.71; 11152800,6.42;
        11156400,11.18; 11160000,5.56; 11163600,12.05; 11167200,7.63; 11170800,
        8.44; 11174400,4.78; 11178000,5.29; 11181600,5.43; 11185200,6.14;
        11188800,6.65; 11192400,4.64; 11196000,6.26; 11199600,3.7; 11203200,
        7.21; 11206800,5.69; 11210400,12.19; 11214000,7.3; 11217600,7.56;
        11221200,8.01; 11224800,6.97; 11228400,7.03; 11232000,6.27; 11235600,
        7.04; 11239200,14.75; 11242800,4.78; 11246400,5.36; 11250000,6.64;
        11253600,6.1; 11257200,7.4; 11260800,5.67; 11264400,4.95; 11268000,4.9;
        11271600,4.35; 11275200,6.89; 11278800,3.02; 11282400,3.67; 11286000,
        7.51; 11289600,9.28; 11293200,5.34; 11296800,6.62; 11300400,5.51;
        11304000,2.67; 11307600,6.31; 11311200,7.68; 11314800,6.4; 11318400,
        7.29; 11322000,2.15; 11325600,5.63; 11329200,4.77; 11332800,5.14;
        11336400,5.87; 11340000,6.48; 11343600,6.47; 11347200,6.1; 11350800,
        6.01; 11354400,9.51; 11358000,5.9; 11361600,6.92; 11365200,4.35;
        11368800,13.17; 11372400,2.76; 11376000,5.99; 11379600,6.1; 11383200,
        6.05; 11386800,9.24; 11390400,7.58; 11394000,5.74; 11397600,6.84;
        11401200,5.9; 11404800,6.77; 11408400,5.73; 11412000,4.54; 11415600,
        6.95; 11419200,8.9; 11422800,17.42; 11426400,6.64; 11430000,7.76;
        11433600,7.7; 11437200,6.84; 11440800,8.77; 11444400,7.4; 11448000,9.93;
        11451600,7.1; 11455200,3.54; 11458800,5.6; 11462400,5.72; 11466000,6.86;
        11469600,6.79; 11473200,8.05; 11476800,7.32; 11480400,5.5; 11484000,
        7.58; 11487600,7.83; 11491200,2.9; 11494800,12.39; 11498400,5.61;
        11502000,12.35; 11505600,6.02; 11509200,9.78; 11512800,8.31; 11516400,
        10.44; 11520000,6.18; 11523600,6.5; 11527200,6.74; 11530800,9.7;
        11534400,7.77; 11538000,4.86; 11541600,11.28; 11545200,6.35; 11548800,
        4.14; 11552400,6.52; 11556000,4.45; 11559600,6.51; 11563200,7.65;
        11566800,6.39; 11570400,6.67; 11574000,5.45; 11577600,6.12; 11581200,
        5.54; 11584800,4.72; 11588400,6.32; 11592000,5.47; 11595600,11.25;
        11599200,10.58; 11602800,6.32; 11606400,9.08; 11610000,8.09; 11613600,
        10.53; 11617200,6.14; 11620800,5.58; 11624400,7.18; 11628000,9.26;
        11631600,3.19; 11635200,4.45; 11638800,7.15; 11642400,7.23; 11646000,
        5.61; 11649600,8.02; 11653200,7.83; 11656800,10.08; 11660400,6.48;
        11664000,7.43; 11667600,5.71; 11671200,6.06; 11674800,4.55; 11678400,
        4.04; 11682000,8.71; 11685600,10.48; 11689200,5.76; 11692800,9.86;
        11696400,8.09; 11700000,11; 11703600,11.27; 11707200,1.9; 11710800,6.73;
        11714400,3.81; 11718000,7.31; 11721600,7.59; 11725200,4.41; 11728800,
        7.04; 11732400,7.61; 11736000,9.5; 11739600,7.42; 11743200,8.71;
        11746800,7.91; 11750400,6.75; 11754000,7.72; 11757600,4.49; 11761200,
        4.16; 11764800,5.7; 11768400,3.79; 11772000,5.37; 11775600,6.28;
        11779200,5.79; 11782800,10.71; 11786400,4.67; 11790000,5.03; 11793600,
        6.54; 11797200,5.36; 11800800,7.12; 11804400,6.54; 11808000,7.48;
        11811600,7.38; 11815200,4.25; 11818800,7.1; 11822400,7.71; 11826000,
        7.84; 11829600,7.92; 11833200,8.88; 11836800,6.97; 11840400,4.31;
        11844000,12.9; 11847600,8.35; 11851200,9.05; 11854800,8.33; 11858400,
        8.46; 11862000,8.7; 11865600,8.76; 11869200,11.97; 11872800,7.35;
        11876400,7.56; 11880000,6; 11883600,6.43; 11887200,11.91; 11890800,8.69;
        11894400,6.95; 11898000,5.68; 11901600,8.05; 11905200,6.89; 11908800,
        5.43; 11912400,7.23; 11916000,7.14; 11919600,6.36; 11923200,5.94;
        11926800,5.62; 11930400,5.44; 11934000,7.12; 11937600,6.57; 11941200,
        5.93; 11944800,4.75; 11948400,6.33; 11952000,3.07; 11955600,11.49;
        11959200,7.7; 11962800,7.58; 11966400,5.72; 11970000,7.26; 11973600,
        5.74; 11977200,5.84; 11980800,6.16; 11984400,8.23; 11988000,5.29;
        11991600,4.72; 11995200,3.82; 11998800,8.46; 12002400,9.04; 12006000,
        13.7; 12009600,3.62; 12013200,5.93; 12016800,5.48; 12020400,7.02;
        12024000,9.34; 12027600,3.92; 12031200,4.38; 12034800,8.68; 12038400,
        4.87; 12042000,6.84; 12045600,8.14; 12049200,6.84; 12052800,5.59;
        12056400,5.96; 12060000,5.6; 12063600,6.74; 12067200,5.76; 12070800,
        7.25; 12074400,4.87; 12078000,8.59; 12081600,8.42; 12085200,4.65;
        12088800,6.78; 12092400,4.93; 12096000,3.29; 12099600,6.46; 12103200,
        7.92; 12106800,10.43; 12110400,7.81; 12114000,9.74; 12117600,8.12;
        12121200,8.29; 12124800,5.57; 12128400,7.41; 12132000,6.87; 12135600,
        6.6; 12139200,6.26; 12142800,5.31; 12146400,8.36; 12150000,5.15;
        12153600,3.9; 12157200,4.41; 12160800,9.88; 12164400,8.79; 12168000,
        3.35; 12171600,7.76; 12175200,13.08; 12178800,9.79; 12182400,6.46;
        12186000,5.08; 12189600,5.56; 12193200,3.24; 12196800,3.24; 12200400,
        3.24; 12204000,3.24; 12207600,3.24; 12211200,3.24; 12214800,3.24;
        12218400,3.24; 12222000,3.24; 12225600,3.24; 12229200,3.24; 12232800,
        3.24; 12236400,3.24; 12240000,3.24; 12243600,3.24; 12247200,3.24;
        12250800,3.24; 12254400,3.24; 12258000,3.24; 12261600,3.24; 12265200,
        3.24; 12268800,3.24; 12272400,3.24; 12276000,3.24; 12279600,3.24;
        12283200,3.24; 12286800,3.24; 12290400,3.24; 12294000,3.24; 12297600,
        3.24; 12301200,3.24; 12304800,3.24; 12308400,3.24; 12312000,3.24;
        12315600,3.24; 12319200,3.24; 12322800,3.24; 12326400,3.24; 12330000,
        3.24; 12333600,3.24; 12337200,3.24; 12340800,3.24; 12344400,3.24;
        12348000,3.24; 12351600,3.24; 12355200,3.24; 12358800,3.24; 12362400,
        3.24; 12366000,3.24; 12369600,3.24; 12373200,3.24; 12376800,3.24;
        12380400,3.24; 12384000,3.24; 12387600,3.24; 12391200,3.24; 12394800,
        3.24; 12398400,3.24; 12402000,3.24; 12405600,3.24; 12409200,3.24;
        12412800,3.24; 12416400,3.24; 12420000,3.24; 12423600,3.24; 12427200,
        3.24; 12430800,3.24; 12434400,3.24; 12438000,3.24; 12441600,3.24;
        12445200,3.24; 12448800,3.24; 12452400,3.24; 12456000,3.24; 12459600,
        3.24; 12463200,3.24; 12466800,3.24; 12470400,3.24; 12474000,3.24;
        12477600,3.24; 12481200,3.24; 12484800,3.24; 12488400,3.24; 12492000,
        3.24; 12495600,3.24; 12499200,3.24; 12502800,3.24; 12506400,3.24;
        12510000,3.24; 12513600,3.24; 12517200,3.24; 12520800,3.24; 12524400,
        3.24; 12528000,3.24; 12531600,3.24; 12535200,3.24; 12538800,3.24;
        12542400,3.24; 12546000,3.24; 12549600,3.24; 12553200,3.24; 12556800,
        3.24; 12560400,3.24; 12564000,3.24; 12567600,3.24; 12571200,3.24;
        12574800,3.24; 12578400,3.24; 12582000,3.24; 12585600,3.24; 12589200,
        3.24; 12592800,3.24; 12596400,3.24; 12600000,3.24; 12603600,3.24;
        12607200,3.24; 12610800,3.24; 12614400,3.24; 12618000,3.24; 12621600,
        3.24; 12625200,3.24; 12628800,3.24; 12632400,3.24; 12636000,3.24;
        12639600,3.24; 12643200,3.24; 12646800,3.24; 12650400,3.24; 12654000,
        3.24; 12657600,3.24; 12661200,3.24; 12664800,3.24; 12668400,3.24;
        12672000,3.24; 12675600,3.24; 12679200,3.24; 12682800,3.24; 12686400,
        3.24; 12690000,3.24; 12693600,3.24; 12697200,3.24; 12700800,3.24;
        12704400,3.24; 12708000,3.24; 12711600,3.24; 12715200,3.24; 12718800,
        3.24; 12722400,3.24; 12726000,3.24; 12729600,3.24; 12733200,3.24;
        12736800,3.24; 12740400,3.24; 12744000,3.24; 12747600,3.24; 12751200,
        3.24; 12754800,3.24; 12758400,3.24; 12762000,3.24; 12765600,3.24;
        12769200,3.24; 12772800,3.24; 12776400,3.24; 12780000,3.24; 12783600,
        3.24; 12787200,3.24; 12790800,3.24; 12794400,3.24; 12798000,3.24;
        12801600,3.24; 12805200,3.24; 12808800,3.24; 12812400,3.24; 12816000,
        3.24; 12819600,3.24; 12823200,3.24; 12826800,3.24; 12830400,3.24;
        12834000,3.24; 12837600,3.24; 12841200,3.24; 12844800,3.24; 12848400,
        3.24; 12852000,3.24; 12855600,3.24; 12859200,3.24; 12862800,3.24;
        12866400,3.24; 12870000,3.24; 12873600,3.24; 12877200,3.24; 12880800,
        3.24; 12884400,3.24; 12888000,3.24; 12891600,3.24; 12895200,3.24;
        12898800,3.24; 12902400,3.24; 12906000,3.24; 12909600,3.24; 12913200,
        3.24; 12916800,3.24; 12920400,3.24; 12924000,3.24; 12927600,3.24;
        12931200,3.24; 12934800,3.24; 12938400,3.24; 12942000,3.24; 12945600,
        3.24; 12949200,3.24; 12952800,3.24; 12956400,3.24; 12960000,3.24;
        12963600,3.24; 12967200,3.24; 12970800,3.24; 12974400,3.24; 12978000,
        3.24; 12981600,3.24; 12985200,3.24; 12988800,3.24; 12992400,3.24;
        12996000,3.24; 12999600,3.24; 13003200,3.24; 13006800,3.24; 13010400,
        3.24; 13014000,3.24; 13017600,3.24; 13021200,3.24; 13024800,3.24;
        13028400,3.24; 13032000,3.24; 13035600,3.24; 13039200,3.24; 13042800,
        3.24; 13046400,3.24; 13050000,3.24; 13053600,3.24; 13057200,3.24;
        13060800,3.24; 13064400,3.24; 13068000,3.24; 13071600,3.24; 13075200,
        3.24; 13078800,3.24; 13082400,3.24; 13086000,3.24; 13089600,3.24;
        13093200,3.24; 13096800,3.24; 13100400,3.24; 13104000,3.24; 13107600,
        3.24; 13111200,3.24; 13114800,3.24; 13118400,3.24; 13122000,3.24;
        13125600,3.24; 13129200,3.24; 13132800,3.24; 13136400,3.24; 13140000,
        3.24; 13143600,3.24; 13147200,3.24; 13150800,3.24; 13154400,3.24;
        13158000,3.24; 13161600,3.24; 13165200,3.24; 13168800,3.24; 13172400,
        3.24; 13176000,3.24; 13179600,3.24; 13183200,3.24; 13186800,3.24;
        13190400,3.24; 13194000,3.24; 13197600,3.24; 13201200,3.24; 13204800,
        3.24; 13208400,3.24; 13212000,3.24; 13215600,3.24; 13219200,3.24;
        13222800,3.24; 13226400,3.24; 13230000,3.24; 13233600,3.24; 13237200,
        3.24; 13240800,3.24; 13244400,3.24; 13248000,3.24; 13251600,3.24;
        13255200,3.24; 13258800,3.24; 13262400,3.24; 13266000,3.24; 13269600,
        6.56; 13273200,4.83; 13276800,5.39; 13280400,4.96; 13284000,5.72;
        13287600,8.15; 13291200,7.72; 13294800,9.43; 13298400,3.79; 13302000,
        3.77; 13305600,6.22; 13309200,9.85; 13312800,5.13; 13316400,5.39;
        13320000,4.31; 13323600,9.34; 13327200,7.58; 13330800,5.64; 13334400,
        5.65; 13338000,6.85; 13341600,6.74; 13345200,5.89; 13348800,6.44;
        13352400,8.8; 13356000,7.32; 13359600,4.81; 13363200,6.8; 13366800,1.11;
        13370400,7.63; 13374000,6; 13377600,5.5; 13381200,7.5; 13384800,4.92;
        13388400,7.09; 13392000,5.55; 13395600,7.97; 13399200,8.95; 13402800,
        10.01; 13406400,9.5; 13410000,9.11; 13413600,8; 13417200,10.38;
        13420800,8.08; 13424400,12.83; 13428000,5.94; 13431600,8.79; 13435200,
        4.87; 13438800,8.49; 13442400,4.29; 13446000,7.47; 13449600,3.26;
        13453200,11.37; 13456800,5.02; 13460400,7.33; 13464000,6.83; 13467600,8;
        13471200,8.42; 13474800,6.55; 13478400,7.53; 13482000,4.31; 13485600,
        6.19; 13489200,4.97; 13492800,9.35; 13496400,32.07; 13500000,29.14;
        13503600,8.33; 13507200,6.05; 13510800,5.81; 13514400,5.69; 13518000,
        7.91; 13521600,5.41; 13525200,5.47; 13528800,6.84; 13532400,9.23;
        13536000,7.4; 13539600,4.99; 13543200,6.36; 13546800,7.85; 13550400,
        7.09; 13554000,7.14; 13557600,8.21; 13561200,6.11; 13564800,7.04;
        13568400,5.85; 13572000,5.24; 13575600,5.92; 13579200,6.57; 13582800,
        6.16; 13586400,5.88; 13590000,5.8; 13593600,9.49; 13597200,4.4;
        13600800,7.45; 13604400,5.7; 13608000,6.5; 13611600,4.39; 13615200,5.98;
        13618800,6.53; 13622400,6.94; 13626000,5.53; 13629600,6.09; 13633200,
        6.31; 13636800,5.8; 13640400,5.69; 13644000,10.39; 13647600,8.23;
        13651200,10.94; 13654800,8.06; 13658400,7.42; 13662000,9.39; 13665600,
        5.3; 13669200,4.67; 13672800,8.52; 13676400,8.21; 13680000,5.91;
        13683600,4.25; 13687200,4.02; 13690800,6.92; 13694400,5.35; 13698000,7;
        13701600,6.19; 13705200,8.06; 13708800,6.17; 13712400,6.57; 13716000,
        4.62; 13719600,7.26; 13723200,5.1; 13726800,6.16; 13730400,5.96;
        13734000,5.67; 13737600,6.03; 13741200,5.98; 13744800,6.28; 13748400,4;
        13752000,7; 13755600,7.88; 13759200,10.12; 13762800,10.57; 13766400,
        5.18; 13770000,6.41; 13773600,5.67; 13777200,5.18; 13780800,3.19;
        13784400,5.45; 13788000,6.38; 13791600,8.94; 13795200,9.45; 13798800,
        7.33; 13802400,5.31; 13806000,3.29; 13809600,7.1; 13813200,6.14;
        13816800,3.89; 13820400,6.99; 13824000,9; 13827600,11.31; 13831200,5.98;
        13834800,10.69; 13838400,7.16; 13842000,11.21; 13845600,4.91; 13849200,
        5.84; 13852800,9.08; 13856400,6.75; 13860000,5.86; 13863600,5.55;
        13867200,6.65; 13870800,8.75; 13874400,6.46; 13878000,7.04; 13881600,
        5.36; 13885200,5.29; 13888800,7.45; 13892400,6.62; 13896000,6.05;
        13899600,7.09; 13903200,5.53; 13906800,5.39; 13910400,6.31; 13914000,
        5.71; 13917600,6.06; 13921200,5.34; 13924800,7.08; 13928400,5.78;
        13932000,5.01; 13935600,6.66; 13939200,7.48; 13942800,5.75; 13946400,
        5.24; 13950000,3.51; 13953600,4.25; 13957200,5.71; 13960800,6.77;
        13964400,6.8; 13968000,9.24; 13971600,4.99; 13975200,4.18; 13978800,
        6.02; 13982400,6.16; 13986000,4.05; 13989600,7.01; 13993200,5.2;
        13996800,5.43; 14000400,4.81; 14004000,6.08; 14007600,6.37; 14011200,
        4.52; 14014800,7.13; 14018400,5.32; 14022000,6.21; 14025600,5.47;
        14029200,5.57; 14032800,5.94; 14036400,5.83; 14040000,6.48; 14043600,
        9.83; 14047200,7.1; 14050800,4.84; 14054400,5.37; 14058000,5.6;
        14061600,6.77; 14065200,8.46; 14068800,8.1; 14072400,6.7; 14076000,5.9;
        14079600,5.52; 14083200,6.36; 14086800,6.26; 14090400,5.85; 14094000,
        5.69; 14097600,5.8; 14101200,6.99; 14104800,5.61; 14108400,5.37;
        14112000,4.65; 14115600,5.32; 14119200,7.03; 14122800,5.58; 14126400,4;
        14130000,6.47; 14133600,6.83; 14137200,4.52; 14140800,5.11; 14144400,
        5.96; 14148000,4.04; 14151600,7.23; 14155200,6.65; 14158800,6.29;
        14162400,8.84; 14166000,4.12; 14169600,6.02; 14173200,5.54; 14176800,
        3.68; 14180400,7.66; 14184000,4; 14187600,5.53; 14191200,7.84; 14194800,
        8.47; 14198400,6.87; 14202000,5.71; 14205600,5.54; 14209200,6.42;
        14212800,7.98; 14216400,5.22; 14220000,4.04; 14223600,4.19; 14227200,
        5.79; 14230800,6.57; 14234400,8.86; 14238000,5.71; 14241600,9.62;
        14245200,8.32; 14248800,5.93; 14252400,5.14; 14256000,4.74; 14259600,
        5.93; 14263200,5.73; 14266800,6.7; 14270400,4.57; 14274000,5.61;
        14277600,5.41; 14281200,6.45; 14284800,7.25; 14288400,5.93; 14292000,
        6.21; 14295600,8.86; 14299200,6.48; 14302800,6.39; 14306400,5.17;
        14310000,2.96; 14313600,7.22; 14317200,6.04; 14320800,7.51; 14324400,
        5.78; 14328000,7.89; 14331600,5.26; 14335200,6.78; 14338800,5.41;
        14342400,2.56; 14346000,7.01; 14349600,4.58; 14353200,7.01; 14356800,
        6.32; 14360400,6.07; 14364000,4.86; 14367600,5.46; 14371200,4.23;
        14374800,4.9; 14378400,5.79; 14382000,7.17; 14385600,8.28; 14389200,
        5.21; 14392800,5.23; 14396400,2.25; 14400000,5.82; 14403600,5.71;
        14407200,5.7; 14410800,6.6; 14414400,7.23; 14418000,6.84; 14421600,3.26;
        14425200,8.11; 14428800,3.67; 14432400,5.22; 14436000,6.8; 14439600,
        7.45; 14443200,9.25; 14446800,2.42; 14450400,5.31; 14454000,5.79;
        14457600,8.72; 14461200,5.91; 14464800,9.61; 14468400,4.28; 14472000,
        5.82; 14475600,5.9; 14479200,5.23; 14482800,8.6; 14486400,8.33;
        14490000,2.08; 14493600,7.78; 14497200,7.11; 14500800,3.96; 14504400,
        6.67; 14508000,5.95; 14511600,5.62; 14515200,8.51; 14518800,9.2;
        14522400,5.88; 14526000,4.56; 14529600,6.12; 14533200,6.78; 14536800,
        6.46; 14540400,8.58; 14544000,4.66; 14547600,6.38; 14551200,9.8;
        14554800,6.84; 14558400,6.34; 14562000,5.72; 14565600,11.7; 14569200,
        15.06; 14572800,8.34; 14576400,9.72; 14580000,9.42; 14583600,8.08;
        14587200,7.35; 14590800,13.09; 14594400,8.59; 14598000,9.9; 14601600,
        9.43; 14605200,12.28; 14608800,8.12; 14612400,4.49; 14616000,6.56;
        14619600,10.91; 14623200,6.28; 14626800,15.51; 14630400,15.34; 14634000,
        14.71; 14637600,15.37; 14641200,16.31; 14644800,14.34; 14648400,14.84;
        14652000,15.91; 14655600,12.44; 14659200,18.1; 14662800,13.16; 14666400,
        15.81; 14670000,14.22; 14673600,13.82; 14677200,14.99; 14680800,19.48;
        14684400,13.22; 14688000,15.23; 14691600,12.11; 14695200,18.93;
        14698800,23; 14702400,26.57; 14706000,21.94; 14709600,25.25; 14713200,
        22.89; 14716800,19.06; 14720400,19.76; 14724000,20.91; 14727600,17.15;
        14731200,18.17; 14734800,16; 14738400,17.88; 14742000,23.93; 14745600,
        22.07; 14749200,18.7; 14752800,16.55; 14756400,20.06; 14760000,18.19;
        14763600,17.67; 14767200,21.16; 14770800,18.15; 14774400,16.21;
        14778000,25.32; 14781600,28.72; 14785200,29.06; 14788800,17.5; 14792400,
        15.41; 14796000,22.79; 14799600,15.97; 14803200,8.52; 14806800,5.78;
        14810400,5.2; 14814000,5.2; 14817600,8.03; 14821200,8.53; 14824800,7.98;
        14828400,2.24; 14832000,7.69; 14835600,8.73; 14839200,11.15; 14842800,
        7.35; 14846400,7.7; 14850000,7.44; 14853600,6.86; 14857200,10.53;
        14860800,8.11; 14864400,11.17; 14868000,6.58; 14871600,4.75; 14875200,
        7.21; 14878800,22.9; 14882400,30.05; 14886000,30.26; 14889600,15.64;
        14893200,18.18; 14896800,20.87; 14900400,16.96; 14904000,19.85;
        14907600,21.07; 14911200,18.03; 14914800,17.82; 14918400,16.66;
        14922000,18.55; 14925600,22.57; 14929200,17.85; 14932800,16.75;
        14936400,21.12; 14940000,20.62; 14943600,15.2; 14947200,22.65; 14950800,
        23.29; 14954400,17.93; 14958000,22.28; 14961600,10.07; 14965200,8.58;
        14968800,8.31; 14972400,8.14; 14976000,7.93; 14979600,6.93; 14983200,
        6.86; 14986800,8.52; 14990400,5.32; 14994000,20.39; 14997600,15.08;
        15001200,13.77; 15004800,13.34; 15008400,12.32; 15012000,20.24;
        15015600,15.92; 15019200,13.9; 15022800,13.3; 15026400,14.78; 15030000,
        12.19; 15033600,18.5; 15037200,10.42; 15040800,12.7; 15044400,11.22;
        15048000,14.01; 15051600,12.22; 15055200,13.43; 15058800,12.1; 15062400,
        15.84; 15066000,14.98; 15069600,16.36; 15073200,15.48; 15076800,14.31;
        15080400,14.65; 15084000,14.38; 15087600,15.26; 15091200,16.91;
        15094800,12.14; 15098400,19.63; 15102000,15.29; 15105600,14.63;
        15109200,17.29; 15112800,15.99; 15116400,15.04; 15120000,15.06;
        15123600,12.14; 15127200,17.65; 15130800,14.9; 15134400,17.79; 15138000,
        7.44; 15141600,11.96; 15145200,6.17; 15148800,4.45; 15152400,6.39;
        15156000,7.78; 15159600,7.29; 15163200,18.64; 15166800,12.2; 15170400,
        17.82; 15174000,10.12; 15177600,13.83; 15181200,13.33; 15184800,17.92;
        15188400,16.06; 15192000,16; 15195600,14.92; 15199200,12.13; 15202800,
        10.99; 15206400,17.12; 15210000,15.09; 15213600,13.88; 15217200,5.66;
        15220800,13.17; 15224400,11.6; 15228000,16.03; 15231600,26.66; 15235200,
        20.15; 15238800,8.72; 15242400,6.43; 15246000,28.23; 15249600,10.78;
        15253200,17.89; 15256800,15.79; 15260400,10.79; 15264000,13.87;
        15267600,13.7; 15271200,21.52; 15274800,15.99; 15278400,16.84; 15282000,
        15.89; 15285600,15.91; 15289200,12.75; 15292800,9.38; 15296400,4.78;
        15300000,4.78; 15303600,4.78; 15307200,4.78; 15310800,7.56; 15314400,
        6.32; 15318000,10.28; 15321600,4.24; 15325200,4.56; 15328800,6.94;
        15332400,5.65; 15336000,7.02; 15339600,6.27; 15343200,6.88; 15346800,
        3.78; 15350400,18.22; 15354000,2.27; 15357600,0; 15361200,6.87;
        15364800,6.26; 15368400,9.1; 15372000,7.61; 15375600,6.78; 15379200,
        5.98; 15382800,4.54; 15386400,3.06; 15390000,5.57; 15393600,5.45;
        15397200,4.29; 15400800,6.58; 15404400,6.52; 15408000,7.01; 15411600,
        4.1; 15415200,1.7; 15418800,5.26; 15422400,5.63; 15426000,6.39;
        15429600,6.07; 15433200,1.01; 15436800,6.98; 15440400,6.63; 15444000,
        9.78; 15447600,4.75; 15451200,8.14; 15454800,7.01; 15458400,7.25;
        15462000,7.13; 15465600,8.83; 15469200,6.04; 15472800,4.33; 15476400,
        3.35; 15480000,6.79; 15483600,6.51; 15487200,0.22; 15490800,0; 15494400,
        0; 15498000,0; 15501600,0; 15505200,0; 15508800,0; 15512400,0; 15516000,
        0; 15519600,0; 15523200,0; 15526800,0; 15530400,0; 15534000,0; 15537600,
        0; 15541200,0; 15544800,0; 15548400,0; 15552000,0; 15555600,0; 15559200,
        0; 15562800,0; 15566400,0; 15570000,0; 15573600,0; 15577200,51.29;
        15580800,12.24; 15584400,4.99; 15588000,6.28; 15591600,3.59; 15595200,
        12.06; 15598800,25.06; 15602400,6.99; 15606000,20.38; 15609600,18.8;
        15613200,7.85; 15616800,5.64; 15620400,16.02; 15624000,24.82; 15627600,
        12.27; 15631200,6.2; 15634800,11.08; 15638400,19.29; 15642000,11.68;
        15645600,1.93; 15649200,4.23; 15652800,2.98; 15656400,14.84; 15660000,
        23.41; 15663600,7.31; 15667200,3.3; 15670800,19.95; 15674400,17.31;
        15678000,3.01; 15681600,4.36; 15685200,10.38; 15688800,19.25; 15692400,
        2.46; 15696000,10.93; 15699600,1.6; 15703200,35.79; 15706800,11.1;
        15710400,18.49; 15714000,7.95; 15717600,11.57; 15721200,36.35; 15724800,
        26.82; 15728400,25.68; 15732000,13.72; 15735600,11.45; 15739200,5.51;
        15742800,16.67; 15746400,29.81; 15750000,48.45; 15753600,8.85; 15757200,
        10.58; 15760800,7.05; 15764400,8.8; 15768000,24.39; 15771600,11.08;
        15775200,9.52; 15778800,3.54; 15782400,15.38; 15786000,18.59; 15789600,
        20.22; 15793200,19.88; 15796800,13.67; 15800400,19.12; 15804000,8.92;
        15807600,15.52; 15811200,16.82; 15814800,8.6; 15818400,8.99; 15822000,
        11.09; 15825600,20.55; 15829200,15.71; 15832800,15.18; 15836400,8.32;
        15840000,19.72; 15843600,23.09; 15847200,9.09; 15850800,16.13; 15854400,
        21.18; 15858000,15.56; 15861600,20.31; 15865200,5.58; 15868800,12.29;
        15872400,16.44; 15876000,15.56; 15879600,20.27; 15883200,19.02;
        15886800,13.7; 15890400,18.97; 15894000,14.54; 15897600,29.2; 15901200,
        22.31; 15904800,15.33; 15908400,16.77; 15912000,4.48; 15915600,16.65;
        15919200,17.94; 15922800,22.98; 15926400,19.56; 15930000,15.16;
        15933600,20.38; 15937200,29.79; 15940800,24.19; 15944400,27.99;
        15948000,22.42; 15951600,0.69; 15955200,19.39; 15958800,3.42; 15962400,
        10.86; 15966000,10.01; 15969600,24.15; 15973200,2.13; 15976800,10.41;
        15980400,6.24; 15984000,9.16; 15987600,8.56; 15991200,10.34; 15994800,
        14.25; 15998400,12.71; 16002000,11.35; 16005600,5.96; 16009200,4.55;
        16012800,4.77; 16016400,9.48; 16020000,19.72; 16023600,37.61; 16027200,
        31.62; 16030800,33.78; 16034400,34.77; 16038000,38.07; 16041600,3.26;
        16045200,18.16; 16048800,22.59; 16052400,12.46; 16056000,4.76; 16059600,
        7.54; 16063200,12.15; 16066800,7.89; 16070400,9.95; 16074000,8.32;
        16077600,7.92; 16081200,15.12; 16084800,11.22; 16088400,10.45; 16092000,
        21.35; 16095600,5.85; 16099200,22.35; 16102800,42.17; 16106400,27.99;
        16110000,28.51; 16113600,9.44; 16117200,41.58; 16120800,3.98; 16124400,
        6.11; 16128000,6.31; 16131600,17.72; 16135200,10.08; 16138800,23.48;
        16142400,4; 16146000,9.92; 16149600,35.07; 16153200,29.34; 16156800,
        44.85; 16160400,24.79; 16164000,41.24; 16167600,15.48; 16171200,23.58;
        16174800,28.17; 16178400,5.22; 16182000,8.1; 16185600,2.15; 16189200,
        5.62; 16192800,5.91; 16196400,19.59; 16200000,12.62; 16203600,6.58;
        16207200,8.67; 16210800,12.96; 16214400,18.71; 16218000,19.96; 16221600,
        14.61; 16225200,15.05; 16228800,16.85; 16232400,21.06; 16236000,12.59;
        16239600,18.44; 16243200,22.97; 16246800,14.01; 16250400,13.41;
        16254000,16.02; 16257600,16.01; 16261200,8.49; 16264800,33.4; 16268400,
        24.29; 16272000,25.84; 16275600,39.49; 16279200,13.39; 16282800,10.79;
        16286400,4.63; 16290000,12.75; 16293600,39.73; 16297200,28.8; 16300800,
        23.49; 16304400,8.44; 16308000,26.86; 16311600,5.51; 16315200,13.8;
        16318800,24.57; 16322400,33.82; 16326000,33.23; 16329600,3.93; 16333200,
        47.03; 16336800,34.36; 16340400,14.32; 16344000,4.29; 16347600,9.37;
        16351200,11.36; 16354800,12.49; 16358400,12.36; 16362000,13.28;
        16365600,10.78; 16369200,13.02; 16372800,13.98; 16376400,16.31;
        16380000,12.55; 16383600,17.9; 16387200,22.9; 16390800,23.98; 16394400,
        12.45; 16398000,17.72; 16401600,19.22; 16405200,20.57; 16408800,10.73;
        16412400,12.09; 16416000,5.95; 16419600,3.87; 16423200,1.59; 16426800,
        3.76; 16430400,5.8; 16434000,4.56; 16437600,4.36; 16441200,5.98;
        16444800,6.4; 16448400,6.13; 16452000,19.05; 16455600,31.71; 16459200,
        28.24; 16462800,16.05; 16466400,22.91; 16470000,45.67; 16473600,20.84;
        16477200,14.22; 16480800,13.97; 16484400,13; 16488000,14.09; 16491600,
        12.75; 16495200,15.93; 16498800,18.5; 16502400,15.75; 16506000,9.35;
        16509600,3.84; 16513200,5.9; 16516800,4.8; 16520400,4.8; 16524000,3.47;
        16527600,5.06; 16531200,3.73; 16534800,4.32; 16538400,6.16; 16542000,
        9.34; 16545600,8.69; 16549200,7.86; 16552800,7.4; 16556400,5.67;
        16560000,7.44; 16563600,4.59; 16567200,9.7; 16570800,23.51; 16574400,
        40.43; 16578000,33.28; 16581600,32.29; 16585200,28.43; 16588800,14.01;
        16592400,7.2; 16596000,7.67; 16599600,4.82; 16603200,3.13; 16606800,
        7.49; 16610400,2.7; 16614000,11.59; 16617600,3.79; 16621200,6.18;
        16624800,6.37; 16628400,12.07; 16632000,13.54; 16635600,10.4; 16639200,
        11.7; 16642800,51.7; 16646400,58.48; 16650000,19.28; 16653600,12.72;
        16657200,19.05; 16660800,35.72; 16664400,29.09; 16668000,12.31;
        16671600,24.29; 16675200,9.62; 16678800,15.99; 16682400,9.11; 16686000,
        17.06; 16689600,1.27; 16693200,5.83; 16696800,5.17; 16700400,2.58;
        16704000,2.03; 16707600,5.49; 16711200,5.72; 16714800,2.32; 16718400,
        3.31; 16722000,6.29; 16725600,3.66; 16729200,4.11; 16732800,41.69;
        16736400,50.87; 16740000,48.77; 16743600,2.5; 16747200,8.89; 16750800,
        42.44; 16754400,111.08; 16758000,3.77; 16761600,6.15; 16765200,1.96;
        16768800,5.21; 16772400,4.57; 16776000,5.21; 16779600,4.53; 16783200,
        6.22; 16786800,4.48; 16790400,3.87; 16794000,1.78; 16797600,51.93;
        16801200,62.56; 16804800,58.41; 16808400,4.78; 16812000,32.36; 16815600,
        42.58; 16819200,48.66; 16822800,33.26; 16826400,24.43; 16830000,17.02;
        16833600,61.83; 16837200,20.34; 16840800,0; 16844400,18.59; 16848000,
        31.59; 16851600,33.8; 16855200,32.57; 16858800,33.31; 16862400,33.31;
        16866000,32.59; 16869600,28.51; 16873200,19.57; 16876800,29.26;
        16880400,31.01; 16884000,31.43; 16887600,30.98; 16891200,31.12;
        16894800,33.73; 16898400,33.01; 16902000,28.73; 16905600,13.92;
        16909200,32.67; 16912800,34.13; 16916400,36.36; 16920000,35.65;
        16923600,36.42; 16927200,36.42; 16930800,36.42; 16934400,25.47;
        16938000,31.12; 16941600,32.66; 16945200,34.14; 16948800,36.12;
        16952400,35.71; 16956000,35.71; 16959600,34.25; 16963200,56.27;
        16966800,6.16; 16970400,74.46; 16974000,20.14; 16977600,18.73; 16981200,
        1.98; 16984800,47.22; 16988400,7.05; 16992000,12.83; 16995600,39.51;
        16999200,49.77; 17002800,95.75; 17006400,22.71; 17010000,58.66;
        17013600,31.49; 17017200,71.16; 17020800,14.98; 17024400,9.12; 17028000,
        15.22; 17031600,25.64; 17035200,19; 17038800,11.63; 17042400,16.81;
        17046000,11.46; 17049600,2.08; 17053200,6.02; 17056800,58.1; 17060400,
        27.03; 17064000,35.03; 17067600,6.3; 17071200,7.98; 17074800,14.63;
        17078400,7.12; 17082000,4.15; 17085600,3.45; 17089200,6.74; 17092800,
        6.56; 17096400,4.46; 17100000,7.66; 17103600,4.46; 17107200,4.85;
        17110800,5.29; 17114400,17.88; 17118000,3.29; 17121600,2.97; 17125200,
        5.81; 17128800,5.34; 17132400,5.46; 17136000,4.28; 17139600,6.06;
        17143200,21.59; 17146800,28.29; 17150400,28.11; 17154000,28.14;
        17157600,28.58; 17161200,28.87; 17164800,24.77; 17168400,26.64;
        17172000,30.39; 17175600,30.87; 17179200,30.08; 17182800,31.9; 17186400,
        28.5; 17190000,30.13; 17193600,31.64; 17197200,27.07; 17200800,5.31;
        17204400,4.01; 17208000,2.79; 17211600,5.75; 17215200,4.31; 17218800,
        5.89; 17222400,6.46; 17226000,4.16; 17229600,21.38; 17233200,28.4;
        17236800,30.53; 17240400,9.71; 17244000,8.24; 17247600,8.82; 17251200,
        6.58; 17254800,30.96; 17258400,31.24; 17262000,30.55; 17265600,30.79;
        17269200,30.64; 17272800,29.73; 17276400,33.5; 17280000,31.17; 17283600,
        33.19; 17287200,4.44; 17290800,4.18; 17294400,4.33; 17298000,1.91;
        17301600,3.76; 17305200,7.04; 17308800,2.08; 17312400,17.23; 17316000,
        1.68; 17319600,11.38; 17323200,11.78; 17326800,11.13; 17330400,9.13;
        17334000,8.11; 17337600,8.97; 17341200,8.2; 17344800,10.75; 17348400,
        10.89; 17352000,12.15; 17355600,8.27; 17359200,9.11; 17362800,8.85;
        17366400,9.13; 17370000,12.57; 17373600,5.87; 17377200,2.43; 17380800,
        11.28; 17384400,1.81; 17388000,5.72; 17391600,1.69; 17395200,6.15;
        17398800,7.89; 17402400,9.39; 17406000,9.88; 17409600,9.02; 17413200,
        7.48; 17416800,7.05; 17420400,5.55; 17424000,11.84; 17427600,8.6;
        17431200,8.38; 17434800,11.38; 17438400,10.48; 17442000,9.89; 17445600,
        9.36; 17449200,11.87; 17452800,11.34; 17456400,8.81; 17460000,9.82;
        17463600,10.49; 17467200,10.71; 17470800,10.35; 17474400,9.87; 17478000,
        9.8; 17481600,13.23; 17485200,9.69; 17488800,9.16; 17492400,5.7;
        17496000,9.42; 17499600,11.77; 17503200,12.68; 17506800,8.04; 17510400,
        11.2; 17514000,9.28; 17517600,17.4; 17521200,15.05; 17524800,18.1;
        17528400,18.62; 17532000,16.82; 17535600,21.8; 17539200,9.98; 17542800,
        10.72; 17546400,27.08; 17550000,17.51; 17553600,26.39; 17557200,13.25;
        17560800,40.41; 17564400,30.91; 17568000,18.92; 17571600,12.19;
        17575200,14.28; 17578800,5.51; 17582400,12.85; 17586000,13.16; 17589600,
        11.43; 17593200,4.49; 17596800,3.19; 17600400,10.07; 17604000,5.97;
        17607600,3.82; 17611200,24.24; 17614800,18.07; 17618400,32.89; 17622000,
        26.85; 17625600,8.66; 17629200,10.16; 17632800,4.57; 17636400,3.56;
        17640000,1.33; 17643600,6.01; 17647200,5.27; 17650800,3.14; 17654400,
        4.74; 17658000,6.74; 17661600,6.25; 17665200,6.12; 17668800,6.79;
        17672400,5.07; 17676000,4.77; 17679600,2; 17683200,6.03; 17686800,5.29;
        17690400,9.32; 17694000,8.02; 17697600,9.89; 17701200,8.79; 17704800,
        23.67; 17708400,7.49; 17712000,10.47; 17715600,4.98; 17719200,7.12;
        17722800,1.69; 17726400,5.2; 17730000,6.41; 17733600,5.87; 17737200,
        6.67; 17740800,6.13; 17744400,5.07; 17748000,13.92; 17751600,9.45;
        17755200,11.65; 17758800,7.23; 17762400,60.5; 17766000,9.21; 17769600,
        11.08; 17773200,13.11; 17776800,12.07; 17780400,10.41; 17784000,9.55;
        17787600,21.69; 17791200,17.24; 17794800,11.41; 17798400,6.45; 17802000,
        7.31; 17805600,6.83; 17809200,0; 17812800,0.37; 17816400,0.17; 17820000,
        1.38; 17823600,0.19; 17827200,0.5; 17830800,0.07; 17834400,0.44;
        17838000,5.45; 17841600,11.17; 17845200,7.94; 17848800,2.36; 17852400,
        3.78; 17856000,12.35; 17859600,26.59; 17863200,5.13; 17866800,12.63;
        17870400,15.64; 17874000,5; 17877600,12.54; 17881200,26.83; 17884800,
        10.31; 17888400,3.22; 17892000,18.11; 17895600,21.53; 17899200,6.33;
        17902800,3.51; 17906400,9.57; 17910000,15.73; 17913600,3.74; 17917200,
        8.25; 17920800,18.94; 17924400,14.44; 17928000,2.77; 17931600,12.44;
        17935200,18.03; 17938800,13.6; 17942400,6.2; 17946000,13.56; 17949600,
        15.93; 17953200,4.78; 17956800,0.89; 17960400,0.67; 17964000,46.5;
        17967600,16.37; 17971200,5.53; 17974800,5.31; 17978400,7.76; 17982000,
        17.07; 17985600,14.09; 17989200,2.89; 17992800,15.06; 17996400,17.81;
        18000000,3.39; 18003600,2.96; 18007200,15.59; 18010800,6.72; 18014400,
        3.4; 18018000,4.76; 18021600,14.96; 18025200,13.93; 18028800,4.99;
        18032400,6.05; 18036000,14.86; 18039600,20.28; 18043200,6.72; 18046800,
        5.49; 18050400,18.09; 18054000,21.89; 18057600,4.19; 18061200,1.87;
        18064800,11.18; 18068400,14.25; 18072000,3.57; 18075600,1.21; 18079200,
        9.63; 18082800,4.35; 18086400,3.89; 18090000,1.03; 18093600,1.58;
        18097200,13.41; 18100800,1.62; 18104400,2.07; 18108000,2.15; 18111600,
        13.17; 18115200,12.63; 18118800,4.35; 18122400,4.69; 18126000,19.51;
        18129600,13.54; 18133200,5.09; 18136800,13.58; 18140400,18.98; 18144000,
        9.65; 18147600,2.04; 18151200,0.96; 18154800,13.74; 18158400,9.62;
        18162000,0.48; 18165600,0; 18169200,2.22; 18172800,11.2; 18176400,2.93;
        18180000,0.3; 18183600,3.94; 18187200,3.31; 18190800,8.83; 18194400,
        3.22; 18198000,2.13; 18201600,2.74; 18205200,20.95; 18208800,12.09;
        18212400,6.07; 18216000,2.48; 18219600,11.82; 18223200,8.47; 18226800,
        0.73; 18230400,0.34; 18234000,5.02; 18237600,7.88; 18241200,0; 18244800,
        0.4; 18248400,0.68; 18252000,14.6; 18255600,5.7; 18259200,1.49;
        18262800,0.06; 18266400,23.81; 18270000,5.18; 18273600,8.92; 18277200,
        4.72; 18280800,6.55; 18284400,12.67; 18288000,19.68; 18291600,20.25;
        18295200,9.54; 18298800,12.96; 18302400,10.28; 18306000,2.36; 18309600,
        1.37; 18313200,4.78; 18316800,7; 18320400,4.92; 18324000,6.8; 18327600,
        15.83; 18331200,20.69; 18334800,10.17; 18338400,5.26; 18342000,13.09;
        18345600,23.31; 18349200,11.27; 18352800,6.08; 18356400,18.53; 18360000,
        14.25; 18363600,2.5; 18367200,1.13; 18370800,11.26; 18374400,8.63;
        18378000,0.98; 18381600,0.99; 18385200,8.29; 18388800,12.91; 18392400,
        0.56; 18396000,0.51; 18399600,6.98; 18403200,49.12; 18406800,4.95;
        18410400,2.43; 18414000,6.62; 18417600,8.61; 18421200,1.48; 18424800,
        0.12; 18428400,0.48; 18432000,10.54; 18435600,4.88; 18439200,0.29;
        18442800,0.63; 18446400,0.7; 18450000,11.33; 18453600,5.09; 18457200,
        1.03; 18460800,0.81; 18464400,13.95; 18468000,6.32; 18471600,0.95;
        18475200,0.79; 18478800,12.71; 18482400,8.25; 18486000,0.96; 18489600,
        0.66; 18493200,10.84; 18496800,3.93; 18500400,4.55; 18504000,8.12;
        18507600,17.94; 18511200,14.82; 18514800,7.59; 18518400,26.3; 18522000,
        5.22; 18525600,0.91; 18529200,0.62; 18532800,7.89; 18536400,6.49;
        18540000,0.84; 18543600,1.2; 18547200,15.76; 18550800,11.73; 18554400,
        1.65; 18558000,1.28; 18561600,4.96; 18565200,15.17; 18568800,6.78;
        18572400,7.98; 18576000,18.27; 18579600,18.36; 18583200,5.4; 18586800,
        10.36; 18590400,19.32; 18594000,5.98; 18597600,7.91; 18601200,20.26;
        18604800,12.16; 18608400,5.29; 18612000,1.05; 18615600,12.03; 18619200,
        4.84; 18622800,0.42; 18626400,0.57; 18630000,13.18; 18633600,7.16;
        18637200,1.58; 18640800,0.94; 18644400,10.37; 18648000,7.54; 18651600,
        0.92; 18655200,0.69; 18658800,12.8; 18662400,5.04; 18666000,1.08;
        18669600,1.46; 18673200,10.9; 18676800,4.86; 18680400,1.36; 18684000,
        4.9; 18687600,12.52; 18691200,2.88; 18694800,0.84; 18698400,2.37;
        18702000,14.2; 18705600,2.58; 18709200,0.91; 18712800,2.25; 18716400,
        10.09; 18720000,2.8; 18723600,1.03; 18727200,3.49; 18730800,15.4;
        18734400,2.46; 18738000,0.61; 18741600,8.39; 18745200,6.91; 18748800,
        1.11; 18752400,2.86; 18756000,20.19; 18759600,16.04; 18763200,13.5;
        18766800,10.42; 18770400,2.45; 18774000,5.14; 18777600,8.82; 18781200,
        6.72; 18784800,7.05; 18788400,13.75; 18792000,19.91; 18795600,6.22;
        18799200,8.45; 18802800,22.63; 18806400,15.35; 18810000,3.75; 18813600,
        14.34; 18817200,18.82; 18820800,9.59; 18824400,6.5; 18828000,17.21;
        18831600,18.98; 18835200,7.26; 18838800,1.58; 18842400,5.92; 18846000,
        8.26; 18849600,0.35; 18853200,0; 18856800,1.17; 18860400,9.19; 18864000,
        0.09; 18867600,0; 18871200,0; 18874800,4.6; 18878400,9.33; 18882000,
        0.85; 18885600,0.84; 18889200,11.76; 18892800,7.46; 18896400,1.31;
        18900000,0.95; 18903600,11.3; 18907200,7.05; 18910800,1.41; 18914400,
        0.43; 18918000,10.98; 18921600,6.57; 18925200,3.69; 18928800,9.22;
        18932400,17.45; 18936000,7.6; 18939600,3.76; 18943200,4.99; 18946800,
        16.85; 18950400,11.16; 18954000,2.24; 18957600,3.36; 18961200,8.48;
        18964800,9.12; 18968400,1.03; 18972000,0.81; 18975600,5.68; 18979200,
        10.38; 18982800,6.53; 18986400,0.66; 18990000,5.72; 18993600,11.25;
        18997200,1.61; 19000800,0.8; 19004400,5.46; 19008000,10.3; 19011600,
        6.69; 19015200,5.31; 19018800,14.11; 19022400,14.53; 19026000,5.93;
        19029600,7.49; 19033200,18.67; 19036800,15.83; 19040400,5.77; 19044000,
        6.8; 19047600,18.78; 19051200,15.59; 19054800,7.65; 19058400,7.74;
        19062000,22.1; 19065600,12.19; 19069200,6.81; 19072800,12.19; 19076400,
        17.92; 19080000,12.9; 19083600,6.75; 19087200,16.48; 19090800,20.01;
        19094400,9.14; 19098000,5.76; 19101600,17.83; 19105200,16.29; 19108800,
        4.24; 19112400,7.09; 19116000,16.69; 19119600,15.42; 19123200,15.2;
        19126800,6.74; 19130400,7.53; 19134000,19.26; 19137600,16.13; 19141200,
        6.73; 19144800,8.17; 19148400,19.76; 19152000,15.77; 19155600,5.05;
        19159200,8.55; 19162800,21.15; 19166400,14.54; 19170000,6.45; 19173600,
        10.75; 19177200,18.93; 19180800,10.67; 19184400,5.43; 19188000,13.17;
        19191600,19.95; 19195200,9.47; 19198800,6.94; 19202400,16.75; 19206000,
        21.09; 19209600,8.2; 19213200,6.58; 19216800,16.85; 19220400,13.66;
        19224000,4.53; 19227600,12.61; 19231200,12.96; 19234800,4.7; 19238400,
        1.79; 19242000,3.06; 19245600,7.33; 19249200,19.15; 19252800,5.26;
        19256400,2.95; 19260000,9.13; 19263600,16.21; 19267200,6.11; 19270800,
        0.78; 19274400,0.09; 19278000,8.9; 19281600,3.72; 19285200,0.25;
        19288800,0.12; 19292400,2.97; 19296000,10.57; 19299600,4.82; 19303200,
        1.98; 19306800,4.58; 19310400,12.74; 19314000,3.59; 19317600,0.6;
        19321200,3.41; 19324800,12.57; 19328400,1.09; 19332000,1.13; 19335600,
        7.07; 19339200,11.3; 19342800,6.22; 19346400,6.88; 19350000,33.67;
        19353600,24.26; 19357200,13.53; 19360800,12.92; 19364400,32.36;
        19368000,33.94; 19371600,8.3; 19375200,11.39; 19378800,16.13; 19382400,
        36.68; 19386000,10.22; 19389600,19.72; 19393200,8.61; 19396800,9.15;
        19400400,13.8; 19404000,44.88; 19407600,26.58; 19411200,55.86; 19414800,
        30.54; 19418400,8.98; 19422000,26.19; 19425600,15.15; 19429200,18.52;
        19432800,15.61; 19436400,11.47; 19440000,17.71; 19443600,16.75;
        19447200,4.56; 19450800,15.5; 19454400,11.13; 19458000,8.23; 19461600,
        11.07; 19465200,23.6; 19468800,7.16; 19472400,7.44; 19476000,20.42;
        19479600,2.79; 19483200,15.6; 19486800,16.85; 19490400,16.21; 19494000,
        12.89; 19497600,16.55; 19501200,18.16; 19504800,14.1; 19508400,13.97;
        19512000,19.79; 19515600,50.05; 19519200,16.65; 19522800,15.9; 19526400,
        15.13; 19530000,8.65; 19533600,17.71; 19537200,15.39; 19540800,5.53;
        19544400,14.34; 19548000,10.15; 19551600,19.76; 19555200,10.16;
        19558800,3.7; 19562400,3.85; 19566000,15.97; 19569600,19.24; 19573200,
        7.05; 19576800,7.6; 19580400,17.44; 19584000,26.94; 19587600,7.37;
        19591200,32.83; 19594800,15.12; 19598400,10.53; 19602000,21.15;
        19605600,27.93; 19609200,9.48; 19612800,16.86; 19616400,11.08; 19620000,
        3.07; 19623600,3.57; 19627200,10.77; 19630800,17.97; 19634400,4.79;
        19638000,2.85; 19641600,4.67; 19645200,16.51; 19648800,5.93; 19652400,0;
        19656000,9.38; 19659600,35.14; 19663200,27.87; 19666800,6.05; 19670400,
        14.23; 19674000,9.88; 19677600,17.08; 19681200,24.88; 19684800,35.68;
        19688400,14.53; 19692000,21.65; 19695600,7.53; 19699200,15.38; 19702800,
        16.54; 19706400,1.39; 19710000,0.47; 19713600,9.39; 19717200,3.01;
        19720800,0.21; 19724400,0.03; 19728000,7.97; 19731600,3.95; 19735200,
        0.24; 19738800,0.77; 19742400,6.17; 19746000,12.72; 19749600,1.87;
        19753200,1.18; 19756800,4.97; 19760400,10.12; 19764000,7.6; 19767600,
        2.11; 19771200,11.07; 19774800,12.18; 19778400,1.57; 19782000,0.05;
        19785600,7.96; 19789200,9.67; 19792800,0; 19796400,0; 19800000,0.74;
        19803600,8.36; 19807200,0.72; 19810800,0; 19814400,0; 19818000,4.77;
        19821600,6.03; 19825200,0; 19828800,0; 19832400,2.69; 19836000,8.84;
        19839600,0.34; 19843200,0.16; 19846800,3.31; 19850400,8.51; 19854000,
        2.22; 19857600,0.11; 19861200,3.34; 19864800,9.78; 19868400,0.09;
        19872000,0; 19875600,5.59; 19879200,7.47; 19882800,0; 19886400,0;
        19890000,1.85; 19893600,6.97; 19897200,1.58; 19900800,0.48; 19904400,
        3.27; 19908000,10.73; 19911600,2.69; 19915200,0.62; 19918800,2.09;
        19922400,11.15; 19926000,2.32; 19929600,1; 19933200,3.67; 19936800,
        10.67; 19940400,1.26; 19944000,0.98; 19947600,10.43; 19951200,8.55;
        19954800,0.61; 19958400,2.25; 19962000,8.97; 19965600,2.48; 19969200,
        0.43; 19972800,4.02; 19976400,10.88; 19980000,2.12; 19983600,0.74;
        19987200,1.59; 19990800,10.27; 19994400,10.04; 19998000,15.98; 20001600,
        0.81; 20005200,13.4; 20008800,7.13; 20012400,0; 20016000,0.42; 20019600,
        7.53; 20023200,3.1; 20026800,1.12; 20030400,0.84; 20034000,8.82;
        20037600,3.28; 20041200,0.2; 20044800,15.83; 20048400,9.23; 20052000,
        3.53; 20055600,0.98; 20059200,4.8; 20062800,12.53; 20066400,1.87;
        20070000,0.29; 20073600,3.24; 20077200,11.88; 20080800,2.81; 20084400,
        0.28; 20088000,0.67; 20091600,14.43; 20095200,4.19; 20098800,0.5;
        20102400,1; 20106000,11.95; 20109600,2.02; 20113200,0.57; 20116800,0.52;
        20120400,14.83; 20124000,5.62; 20127600,0.06; 20131200,0.23; 20134800,
        12.69; 20138400,7.23; 20142000,0.39; 20145600,0.19; 20149200,17.59;
        20152800,6.36; 20156400,0.38; 20160000,0.38; 20163600,9.41; 20167200,
        6.26; 20170800,0; 20174400,0; 20178000,9.76; 20181600,1.78; 20185200,0;
        20188800,0.04; 20192400,5.12; 20196000,7.26; 20199600,12.8; 20203200,
        4.93; 20206800,18.45; 20210400,18.92; 20214000,0.03; 20217600,3.61;
        20221200,6.03; 20224800,3.19; 20228400,2.18; 20232000,6.84; 20235600,
        16.13; 20239200,17.19; 20242800,9.35; 20246400,4.87; 20250000,2.59;
        20253600,5.82; 20257200,10.82; 20260800,18.24; 20264400,0.22; 20268000,
        0.19; 20271600,16.97; 20275200,29.79; 20278800,5.08; 20282400,1.32;
        20286000,33.09; 20289600,34.83; 20293200,5.3; 20296800,12.26; 20300400,
        3.38; 20304000,9.69; 20307600,25; 20311200,6.69; 20314800,16.63;
        20318400,18.67; 20322000,8.6; 20325600,17.57; 20329200,0.6; 20332800,
        1.45; 20336400,2.27; 20340000,26.37; 20343600,22.27; 20347200,5.91;
        20350800,5.18; 20354400,19.69; 20358000,9.38; 20361600,5.45; 20365200,
        5.47; 20368800,28.33; 20372400,8.32; 20376000,7.5; 20379600,11.58;
        20383200,25.14; 20386800,8.03; 20390400,4.92; 20394000,20.33; 20397600,
        5.57; 20401200,1.89; 20404800,2.58; 20408400,18.86; 20412000,7.54;
        20415600,0.69; 20419200,0.54; 20422800,13.9; 20426400,8.65; 20430000,
        0.47; 20433600,3.1; 20437200,10.07; 20440800,16.9; 20444400,4.03;
        20448000,1.92; 20451600,0.42; 20455200,13.16; 20458800,5.92; 20462400,
        0.57; 20466000,0.51; 20469600,12.89; 20473200,33.12; 20476800,6.65;
        20480400,7.69; 20484000,20.32; 20487600,7.05; 20491200,4.38; 20494800,
        8.95; 20498400,19.21; 20502000,9.82; 20505600,5.3; 20509200,6.38;
        20512800,21.71; 20516400,14.83; 20520000,4.79; 20523600,5.97; 20527200,
        14.76; 20530800,16.66; 20534400,5.48; 20538000,5.49; 20541600,16.67;
        20545200,16.49; 20548800,5.42; 20552400,5.13; 20556000,16.08; 20559600,
        13.72; 20563200,5.59; 20566800,6.55; 20570400,20.59; 20574000,12.82;
        20577600,5.56; 20581200,5.24; 20584800,17.11; 20588400,10.94; 20592000,
        4.22; 20595600,6.05; 20599200,20.32; 20602800,14.46; 20606400,3.75;
        20610000,6.05; 20613600,17.64; 20617200,14.91; 20620800,4.3; 20624400,
        6.34; 20628000,19.53; 20631600,12.99; 20635200,5.82; 20638800,6.07;
        20642400,18.47; 20646000,14; 20649600,4.98; 20653200,6.64; 20656800,
        18.95; 20660400,34.08; 20664000,18.08; 20667600,10.68; 20671200,16.75;
        20674800,15.3; 20678400,13.76; 20682000,9.1; 20685600,9.8; 20689200,
        7.65; 20692800,6.73; 20696400,10.98; 20700000,16.37; 20703600,6.25;
        20707200,13.41; 20710800,12.48; 20714400,11.85; 20718000,11.87;
        20721600,12.46; 20725200,11.17; 20728800,12.71; 20732400,9.85; 20736000,
        13.98; 20739600,30.63; 20743200,19.04; 20746800,34.31; 20750400,11.21;
        20754000,50.68; 20757600,24.46; 20761200,10.58; 20764800,12.83;
        20768400,9.4; 20772000,7.75; 20775600,6.94; 20779200,6.51; 20782800,
        14.4; 20786400,10.77; 20790000,18.44; 20793600,10.82; 20797200,10.31;
        20800800,14.46; 20804400,13.27; 20808000,12.2; 20811600,10.35; 20815200,
        10.04; 20818800,11.96; 20822400,12.82; 20826000,9.3; 20829600,13.99;
        20833200,10.91; 20836800,8.96; 20840400,11.55; 20844000,3.39; 20847600,
        14.25; 20851200,13.6; 20854800,11.15; 20858400,9.49; 20862000,8.79;
        20865600,9.49; 20869200,11.08; 20872800,9.88; 20876400,9.63; 20880000,
        10.28; 20883600,14.94; 20887200,11.07; 20890800,9.96; 20894400,11.29;
        20898000,8.95; 20901600,14.98; 20905200,12.21; 20908800,10.24; 20912400,
        6.34; 20916000,7.8; 20919600,10.58; 20923200,11.8; 20926800,12.69;
        20930400,10.56; 20934000,15.34; 20937600,21.54; 20941200,14.15;
        20944800,14.66; 20948400,16.44; 20952000,15.39; 20955600,15.01;
        20959200,16.07; 20962800,13.47; 20966400,14.95; 20970000,10.18;
        20973600,14.83; 20977200,14.2; 20980800,13.73; 20984400,12.46; 20988000,
        12.12; 20991600,16.22; 20995200,9.91; 20998800,11.35; 21002400,12.87;
        21006000,14.73; 21009600,14.26; 21013200,9.76; 21016800,8.11; 21020400,
        9.35; 21024000,8.65; 21027600,14.75; 21031200,10.31; 21034800,11.34;
        21038400,11.4; 21042000,11.47; 21045600,11.03; 21049200,9.95; 21052800,
        12.61; 21056400,13.17; 21060000,14.68; 21063600,11.94; 21067200,13.19;
        21070800,11.87; 21074400,11.17; 21078000,11.27; 21081600,10.89;
        21085200,14.28; 21088800,10.44; 21092400,12.18; 21096000,10.66;
        21099600,8.25; 21103200,9.74; 21106800,8.62; 21110400,12.67; 21114000,
        14.13; 21117600,13.6; 21121200,11.77; 21124800,14.2; 21128400,12.81;
        21132000,13.58; 21135600,17.82; 21139200,14.23; 21142800,15.98;
        21146400,13.62; 21150000,14.86; 21153600,14.92; 21157200,14.68;
        21160800,15.56; 21164400,13.13; 21168000,13.4; 21171600,13.68; 21175200,
        10.72; 21178800,11.95; 21182400,14.09; 21186000,10.76; 21189600,12.87;
        21193200,11.33; 21196800,12.17; 21200400,14.81; 21204000,10.8; 21207600,
        12.04; 21211200,9.92; 21214800,11.51; 21218400,13.01; 21222000,17.03;
        21225600,14.73; 21229200,13.81; 21232800,16.21; 21236400,15; 21240000,
        15.08; 21243600,14.83; 21247200,14.14; 21250800,14.16; 21254400,14.5;
        21258000,12.6; 21261600,15.57; 21265200,8.97; 21268800,11.9; 21272400,
        44.91; 21276000,55.56; 21279600,18.94; 21283200,28.56; 21286800,20.28;
        21290400,12.48; 21294000,5.08; 21297600,6.28; 21301200,3.82; 21304800,
        4.58; 21308400,7.05; 21312000,6.47; 21315600,4.66; 21319200,31.6;
        21322800,12.8; 21326400,12.98; 21330000,11.5; 21333600,12.44; 21337200,
        14.75; 21340800,8.72; 21344400,14.9; 21348000,15.26; 21351600,9.64;
        21355200,12.16; 21358800,26.97; 21362400,13.16; 21366000,5.52; 21369600,
        6.34; 21373200,16.4; 21376800,8.64; 21380400,17.62; 21384000,22.66;
        21387600,72.01; 21391200,5.44; 21394800,4.81; 21398400,5; 21402000,
        25.82; 21405600,41.85; 21409200,31.42; 21412800,63.38; 21416400,53.7;
        21420000,7.66; 21423600,48.59; 21427200,7.5; 21430800,11.51; 21434400,
        9.42; 21438000,5.82; 21441600,6.41; 21445200,7.98; 21448800,6.27;
        21452400,7.79; 21456000,6.54; 21459600,8.79; 21463200,6.6; 21466800,
        4.82; 21470400,9.57; 21474000,10.64; 21477600,7.94; 21481200,9.04;
        21484800,8.37; 21488400,9.24; 21492000,9.16; 21495600,10.34; 21499200,
        5.85; 21502800,22.8; 21506400,19.45; 21510000,19.28; 21513600,13.18;
        21517200,14.82; 21520800,17.85; 21524400,15.4; 21528000,10.64; 21531600,
        8; 21535200,6.16; 21538800,4.35; 21542400,11.07; 21546000,11.53;
        21549600,8.18; 21553200,10.87; 21556800,9.56; 21560400,8.98; 21564000,
        11.28; 21567600,11.75; 21571200,6.51; 21574800,11.99; 21578400,14.12;
        21582000,33.12; 21585600,65.91; 21589200,16.55; 21592800,46.6; 21596400,
        31.47; 21600000,24.77; 21603600,16.74; 21607200,5.19; 21610800,13.93;
        21614400,0.61; 21618000,12.47; 21621600,11.25; 21625200,2.11; 21628800,
        10.26; 21632400,0.1; 21636000,8.06; 21639600,11.62; 21643200,8.07;
        21646800,12.87; 21650400,8.84; 21654000,0.8; 21657600,19.16; 21661200,
        16.5; 21664800,9.6; 21668400,2.86; 21672000,22.22; 21675600,14.29;
        21679200,1.31; 21682800,16.5; 21686400,11.83; 21690000,5.91; 21693600,
        13.77; 21697200,14.24; 21700800,6.18; 21704400,1.7; 21708000,53.37;
        21711600,106.67; 21715200,102.21; 21718800,35.57; 21722400,5.92;
        21726000,12.69; 21729600,12.67; 21733200,10.63; 21736800,4.31; 21740400,
        24.74; 21744000,10.77; 21747600,3.66; 21751200,21.68; 21754800,16.71;
        21758400,2.25; 21762000,18.39; 21765600,18.06; 21769200,9.88; 21772800,
        3.79; 21776400,47.16; 21780000,53.09; 21783600,73.02; 21787200,71.07;
        21790800,60.29; 21794400,119.1; 21798000,47.92; 21801600,31.19;
        21805200,38.41; 21808800,10.11; 21812400,13.06; 21816000,13.71;
        21819600,33.68; 21823200,13.62; 21826800,14.48; 21830400,1.79; 21834000,
        23.17; 21837600,15.91; 21841200,11.47; 21844800,9.3; 21848400,15.44;
        21852000,15.54; 21855600,10.22; 21859200,9.48; 21862800,15.36; 21866400,
        13.04; 21870000,13.21; 21873600,14.25; 21877200,12.22; 21880800,14.22;
        21884400,12.28; 21888000,15.41; 21891600,16.09; 21895200,12.93;
        21898800,16.13; 21902400,17.81; 21906000,14.72; 21909600,18.51;
        21913200,12.19; 21916800,15.7; 21920400,15.01; 21924000,16.47; 21927600,
        17.53; 21931200,15.53; 21934800,19.06; 21938400,15.23; 21942000,15.44;
        21945600,14.4; 21949200,13.78; 21952800,14.73; 21956400,18.89; 21960000,
        12.55; 21963600,15.84; 21967200,22.88; 21970800,34.97; 21974400,15.51;
        21978000,17.4; 21981600,12.81; 21985200,7.86; 21988800,5.24; 21992400,
        6.13; 21996000,5.72; 21999600,6.22; 22003200,8.3; 22006800,6.53;
        22010400,5.99; 22014000,5.47; 22017600,6.18; 22021200,5.72; 22024800,
        6.71; 22028400,6.4; 22032000,6.18; 22035600,6.28; 22039200,7.49;
        22042800,6.34; 22046400,5.48; 22050000,6.46; 22053600,12.46; 22057200,
        2.32; 22060800,10.31; 22064400,17.29; 22068000,9.05; 22071600,13.04;
        22075200,11.8; 22078800,12.34; 22082400,19.4; 22086000,13.53; 22089600,
        16.85; 22093200,10.18; 22096800,14.16; 22100400,13.79; 22104000,17.64;
        22107600,14.32; 22111200,16.97; 22114800,16.24; 22118400,15.59;
        22122000,13.82; 22125600,13.31; 22129200,15.47; 22132800,14.86;
        22136400,12.75; 22140000,15.74; 22143600,13.01; 22147200,15; 22150800,
        12.89; 22154400,17.33; 22158000,14.61; 22161600,18.09; 22165200,17.05;
        22168800,16.62; 22172400,17.42; 22176000,18.19; 22179600,10.89;
        22183200,18.61; 22186800,17.41; 22190400,14.42; 22194000,16.89;
        22197600,16.65; 22201200,14.15; 22204800,12.68; 22208400,20.04;
        22212000,15.51; 22215600,16.01; 22219200,13.6; 22222800,15.53; 22226400,
        32.13; 22230000,15.76; 22233600,13.03; 22237200,16.01; 22240800,18.18;
        22244400,16.74; 22248000,19.6; 22251600,12.82; 22255200,15.19; 22258800,
        19.12; 22262400,13.72; 22266000,16.59; 22269600,17.37; 22273200,15.81;
        22276800,18.87; 22280400,14.23; 22284000,15.72; 22287600,13.09;
        22291200,20.29; 22294800,15.17; 22298400,14.25; 22302000,13.3; 22305600,
        18.34; 22309200,17.39; 22312800,11.98; 22316400,13.48; 22320000,18.67;
        22323600,17.85; 22327200,13.35; 22330800,12.24; 22334400,14.35;
        22338000,13.35; 22341600,19.53; 22345200,21.25; 22348800,13.34;
        22352400,16.01; 22356000,16.6; 22359600,13.62; 22363200,19.01; 22366800,
        16.01; 22370400,15.75; 22374000,13.86; 22377600,21.25; 22381200,19.27;
        22384800,18.29; 22388400,11.87; 22392000,17.26; 22395600,17.91;
        22399200,17.15; 22402800,14.1; 22406400,9.1; 22410000,16.33; 22413600,
        17.08; 22417200,14.48; 22420800,16.49; 22424400,19.66; 22428000,18.64;
        22431600,6.95; 22435200,17.71; 22438800,17.61; 22442400,20.13; 22446000,
        26.82; 22449600,14.26; 22453200,12.78; 22456800,22.68; 22460400,10.9;
        22464000,17.7; 22467600,23.21; 22471200,15.25; 22474800,3.56; 22478400,
        31.11; 22482000,19.06; 22485600,7.76; 22489200,20.59; 22492800,20.12;
        22496400,14.36; 22500000,4.71; 22503600,29.11; 22507200,16.36; 22510800,
        5.5; 22514400,22.1; 22518000,18.25; 22521600,9.92; 22525200,5.63;
        22528800,27.7; 22532400,15.48; 22536000,22.5; 22539600,5.26; 22543200,
        22.3; 22546800,21.92; 22550400,9.83; 22554000,18.29; 22557600,16.74;
        22561200,13.03; 22564800,13.02; 22568400,21.97; 22572000,21.22;
        22575600,4.11; 22579200,21.76; 22582800,18.76; 22586400,12.86; 22590000,
        13.02; 22593600,17.78; 22597200,17.09; 22600800,6.44; 22604400,21.43;
        22608000,21.3; 22611600,15.52; 22615200,9.88; 22618800,24.34; 22622400,
        20.37; 22626000,15.72; 22629600,28.84; 22633200,19.99; 22636800,13.71;
        22640400,17.91; 22644000,18.73; 22647600,19.5; 22651200,5.24; 22654800,
        25.65; 22658400,20.96; 22662000,16.62; 22665600,5.08; 22669200,20.34;
        22672800,15.87; 22676400,16.96; 22680000,7.03; 22683600,26.23; 22687200,
        18.61; 22690800,12.91; 22694400,18.23; 22698000,22.73; 22701600,6.29;
        22705200,21.79; 22708800,22.98; 22712400,17.67; 22716000,17.07;
        22719600,2.5; 22723200,29.54; 22726800,18.84; 22730400,16.67; 22734000,
        19.39; 22737600,14.47; 22741200,18.99; 22744800,43.39; 22748400,78.61;
        22752000,34.44; 22755600,26; 22759200,24.55; 22762800,18.6; 22766400,
        17.24; 22770000,17.24; 22773600,17.24; 22777200,17.24; 22780800,17.24;
        22784400,17.24; 22788000,17.24; 22791600,17.24; 22795200,17.24;
        22798800,17.24; 22802400,17.24; 22806000,17.24; 22809600,15.33;
        22813200,13.63; 22816800,29.46; 22820400,13.34; 22824000,4.07; 22827600,
        23.66; 22831200,17.85; 22834800,10.72; 22838400,17.48; 22842000,18.25;
        22845600,14.97; 22849200,4.19; 22852800,27.19; 22856400,17.31; 22860000,
        9.22; 22863600,18.64; 22867200,23.26; 22870800,23.52; 22874400,8.09;
        22878000,22.96; 22881600,20.88; 22885200,16.89; 22888800,16.65;
        22892400,22.72; 22896000,20.16; 22899600,20.52; 22903200,9.81; 22906800,
        29.77; 22910400,21.71; 22914000,6.25; 22917600,22.44; 22921200,20;
        22924800,16.95; 22928400,15.27; 22932000,9.81; 22935600,22.33; 22939200,
        11.81; 22942800,17.56; 22946400,20.97; 22950000,27.89; 22953600,14.82;
        22957200,25.9; 22960800,16.5; 22964400,7.5; 22968000,26.35; 22971600,
        23.6; 22975200,18.18; 22978800,7.86; 22982400,27.03; 22986000,20.07;
        22989600,4.46; 22993200,23.16; 22996800,17.27; 23000400,13.04; 23004000,
        4.8; 23007600,29.63; 23011200,19.9; 23014800,11.1; 23018400,20.74;
        23022000,18.67; 23025600,5.82; 23029200,24.82; 23032800,22.46; 23036400,
        16.06; 23040000,19.28; 23043600,22.5; 23047200,13.55; 23050800,38.77;
        23054400,19.17; 23058000,24.11; 23061600,35.46; 23065200,39.21;
        23068800,68.96; 23072400,13.66; 23076000,23.53; 23079600,11.75;
        23083200,15.79; 23086800,17.57; 23090400,11.85; 23094000,15.08;
        23097600,16.78; 23101200,18.64; 23104800,15.88; 23108400,17.89;
        23112000,11.45; 23115600,19.08; 23119200,15.56; 23122800,16.43;
        23126400,20.86; 23130000,15.79; 23133600,19.22; 23137200,16.81;
        23140800,19.7; 23144400,13.66; 23148000,16.09; 23151600,19.98; 23155200,
        18.07; 23158800,28.48; 23162400,26.1; 23166000,10.78; 23169600,19.36;
        23173200,16.48; 23176800,13.18; 23180400,18.25; 23184000,14.09;
        23187600,15.15; 23191200,14.77; 23194800,16.9; 23198400,17.61; 23202000,
        17.04; 23205600,12.48; 23209200,15.86; 23212800,17.28; 23216400,18.35;
        23220000,20.66; 23223600,22.53; 23227200,15.34; 23230800,18.55;
        23234400,19.31; 23238000,19.31; 23241600,16.96; 23245200,13.35;
        23248800,16.52; 23252400,16.28; 23256000,20.28; 23259600,17.67;
        23263200,16.89; 23266800,13.12; 23270400,15.16; 23274000,12.62;
        23277600,18.66; 23281200,18.53; 23284800,14.83; 23288400,16.65;
        23292000,14.76; 23295600,12.99; 23299200,10.99; 23302800,19.87;
        23306400,17.8; 23310000,21.74; 23313600,13.77; 23317200,18.97; 23320800,
        16.61; 23324400,20.97; 23328000,15.6; 23331600,16.1; 23335200,20.72;
        23338800,12.42; 23342400,17.64; 23346000,13.77; 23349600,15.28;
        23353200,6.77; 23356800,18.89; 23360400,24.27; 23364000,31.84; 23367600,
        65.55; 23371200,16.24; 23374800,14.2; 23378400,22.31; 23382000,16.24;
        23385600,15.23; 23389200,21.54; 23392800,9.91; 23396400,10.98; 23400000,
        21.15; 23403600,20.5; 23407200,16.2; 23410800,14.47; 23414400,13.66;
        23418000,15.66; 23421600,16.26; 23425200,17.47; 23428800,11.24;
        23432400,14.8; 23436000,24.29; 23439600,28.84; 23443200,19.43; 23446800,
        15.65; 23450400,18.34; 23454000,18.87; 23457600,18.87; 23461200,16.11;
        23464800,14.59; 23468400,17.09; 23472000,23.1; 23475600,18.73; 23479200,
        11.45; 23482800,15.43; 23486400,14.26; 23490000,15.08; 23493600,30.39;
        23497200,29.94; 23500800,45.62; 23504400,39.45; 23508000,11.76;
        23511600,15.18; 23515200,5.74; 23518800,8.96; 23522400,0; 23526000,
        16.87; 23529600,29; 23533200,24.72; 23536800,12.91; 23540400,13.81;
        23544000,18.2; 23547600,18.19; 23551200,15.86; 23554800,22.93; 23558400,
        4.1; 23562000,11.98; 23565600,8.12; 23569200,6.48; 23572800,17.6;
        23576400,15.81; 23580000,27.13; 23583600,18.26; 23587200,22.09;
        23590800,16.22; 23594400,10.59; 23598000,23.71; 23601600,28.82;
        23605200,24.03; 23608800,23.14; 23612400,30.08; 23616000,28.92;
        23619600,18.94; 23623200,22.76; 23626800,23.93; 23630400,13.14;
        23634000,4.98; 23637600,33.97; 23641200,19.91; 23644800,31.35; 23648400,
        24.21; 23652000,22.1; 23655600,19.68; 23659200,31.09; 23662800,22.4;
        23666400,22.97; 23670000,6.18; 23673600,15.93; 23677200,20.6; 23680800,
        23.18; 23684400,0.76; 23688000,22.87; 23691600,18.11; 23695200,19.91;
        23698800,22.13; 23702400,17.06; 23706000,5.21; 23709600,24.76; 23713200,
        29.48; 23716800,7.79; 23720400,22.06; 23724000,24.21; 23727600,5.59;
        23731200,16.02; 23734800,19.68; 23738400,17.81; 23742000,13.38;
        23745600,26.24; 23749200,13.88; 23752800,17.45; 23756400,28.28;
        23760000,16.32; 23763600,10.9; 23767200,18.81; 23770800,13.83; 23774400,
        16.45; 23778000,21.05; 23781600,7.31; 23785200,15.45; 23788800,24.42;
        23792400,9.88; 23796000,12.28; 23799600,24.65; 23803200,17.28; 23806800,
        8.04; 23810400,34.39; 23814000,28.73; 23817600,11.51; 23821200,22.44;
        23824800,12.03; 23828400,18.47; 23832000,24.15; 23835600,9.57; 23839200,
        23.31; 23842800,15.38; 23846400,18.7; 23850000,22.18; 23853600,24.25;
        23857200,23.58; 23860800,16.26; 23864400,21.53; 23868000,11.73;
        23871600,19.79; 23875200,23.85; 23878800,15.68; 23882400,16.05;
        23886000,22.25; 23889600,9.79; 23893200,32.09; 23896800,15.11; 23900400,
        14.22; 23904000,22.93; 23907600,27.07; 23911200,11.59; 23914800,25.7;
        23918400,20.97; 23922000,13.02; 23925600,23.26; 23929200,22.5; 23932800,
        10.86; 23936400,24.32; 23940000,26.18; 23943600,27.28; 23947200,5.8;
        23950800,35; 23954400,19.82; 23958000,26.17; 23961600,14.79; 23965200,
        28.86; 23968800,27.34; 23972400,10.06; 23976000,23.97; 23979600,19.91;
        23983200,23.51; 23986800,11.4; 23990400,25.12; 23994000,21.81; 23997600,
        21.64; 24001200,22.97; 24004800,27.3; 24008400,19.71; 24012000,18.69;
        24015600,23.72; 24019200,29.18; 24022800,14.26; 24026400,12.6; 24030000,
        28.67; 24033600,19.06; 24037200,9.42; 24040800,23.6; 24044400,21.44;
        24048000,18.56; 24051600,14.65; 24055200,19.58; 24058800,21.47;
        24062400,15.98; 24066000,21.07; 24069600,23.36; 24073200,25.2; 24076800,
        15; 24080400,28.57; 24084000,26.18; 24087600,15.4; 24091200,21;
        24094800,23.84; 24098400,20.53; 24102000,21.96; 24105600,18.42;
        24109200,16.38; 24112800,24.31; 24116400,19.06; 24120000,27.2; 24123600,
        18.51; 24127200,15.99; 24130800,21.04; 24134400,29.69; 24138000,21.03;
        24141600,12.56; 24145200,30.64; 24148800,25.88; 24152400,16.58;
        24156000,19.66; 24159600,31.6; 24163200,16.62; 24166800,24.75; 24170400,
        17.42; 24174000,21.54; 24177600,14.71; 24181200,16.99; 24184800,11.56;
        24188400,21.38; 24192000,17.51; 24195600,12.51; 24199200,11.86;
        24202800,12.17; 24206400,11.36; 24210000,8.37; 24213600,5.74; 24217200,
        3.06; 24220800,6.75; 24224400,3.86; 24228000,4.48; 24231600,16.01;
        24235200,12.35; 24238800,11.1; 24242400,11.69; 24246000,11.9; 24249600,
        11.99; 24253200,12.04; 24256800,11.88; 24260400,11.8; 24264000,11.95;
        24267600,11.6; 24271200,11.11; 24274800,12.29; 24278400,11.6; 24282000,
        11.83; 24285600,12.2; 24289200,11.08; 24292800,8.48; 24296400,5.97;
        24300000,5.32; 24303600,3.82; 24307200,5.66; 24310800,4.9; 24314400,
        10.53; 24318000,13.06; 24321600,11.51; 24325200,11.62; 24328800,12.04;
        24332400,11.07; 24336000,11.32; 24339600,12.02; 24343200,12.03;
        24346800,12; 24350400,11.94; 24354000,11.79; 24357600,11.58; 24361200,
        11.77; 24364800,11.95; 24368400,11.7; 24372000,10.86; 24375600,11.29;
        24379200,10.4; 24382800,10.56; 24386400,10.86; 24390000,10.43; 24393600,
        7.52; 24397200,14.15; 24400800,13.86; 24404400,12.87; 24408000,14.98;
        24411600,17.12; 24415200,13.63; 24418800,9.78; 24422400,13.15; 24426000,
        14.28; 24429600,12.39; 24433200,16.96; 24436800,13.31; 24440400,11.21;
        24444000,13.96; 24447600,14.57; 24451200,11.97; 24454800,11.87;
        24458400,10.15; 24462000,15.43; 24465600,11.59; 24469200,12.9; 24472800,
        13.34; 24476400,13.13; 24480000,9.18; 24483600,9.55; 24487200,21.3;
        24490800,14.73; 24494400,11.67; 24498000,12.41; 24501600,11.07;
        24505200,13.94; 24508800,10.97; 24512400,14.75; 24516000,11.64;
        24519600,11.73; 24523200,9.82; 24526800,14.1; 24530400,14.68; 24534000,
        11.84; 24537600,10.4; 24541200,11.39; 24544800,19.96; 24548400,11.64;
        24552000,9.18; 24555600,9.99; 24559200,9.42; 24562800,8.32; 24566400,
        11.81; 24570000,8.07; 24573600,10.29; 24577200,8.88; 24580800,9.4;
        24584400,8.5; 24588000,7.63; 24591600,9; 24595200,6.44; 24598800,10.36;
        24602400,10.34; 24606000,10.02; 24609600,6.58; 24613200,8.75; 24616800,
        9.07; 24620400,9.09; 24624000,9.61; 24627600,7.29; 24631200,11.1;
        24634800,8.16; 24638400,10.11; 24642000,6.39; 24645600,8.22; 24649200,
        7.85; 24652800,12.02; 24656400,10.6; 24660000,8.2; 24663600,7.92;
        24667200,10.01; 24670800,7.43; 24674400,10.78; 24678000,14.08; 24681600,
        8.33; 24685200,10.98; 24688800,11.27; 24692400,8.76; 24696000,8.2;
        24699600,11.21; 24703200,10.89; 24706800,10.51; 24710400,11; 24714000,
        9.09; 24717600,11.34; 24721200,7.13; 24724800,10.62; 24728400,9.25;
        24732000,9.66; 24735600,11.95; 24739200,14.37; 24742800,11.86; 24746400,
        11.14; 24750000,5.71; 24753600,7.33; 24757200,10.38; 24760800,9.59;
        24764400,10.88; 24768000,7.78; 24771600,6.73; 24775200,9.01; 24778800,
        9.58; 24782400,11.3; 24786000,13.05; 24789600,13.96; 24793200,14.68;
        24796800,12; 24800400,7.85; 24804000,20.17; 24807600,7.92; 24811200,
        6.64; 24814800,7.52; 24818400,9.17; 24822000,11.68; 24825600,11.27;
        24829200,11.11; 24832800,10.93; 24836400,8.63; 24840000,11.18; 24843600,
        9.08; 24847200,11.24; 24850800,13.77; 24854400,11.6; 24858000,8.39;
        24861600,15.12; 24865200,10.41; 24868800,12.42; 24872400,9.33; 24876000,
        10.19; 24879600,13.29; 24883200,10.09; 24886800,11.77; 24890400,10.2;
        24894000,9.81; 24897600,8.08; 24901200,12.55; 24904800,8.81; 24908400,
        3.9; 24912000,0; 24915600,0; 24919200,0; 24922800,0; 24926400,0;
        24930000,0; 24933600,0; 24937200,0; 24940800,0; 24944400,0; 24948000,0;
        24951600,0; 24955200,0; 24958800,0; 24962400,0; 24966000,0; 24969600,0;
        24973200,0; 24976800,0; 24980400,0; 24984000,0; 24987600,0; 24991200,0;
        24994800,0; 24998400,0; 25002000,0; 25005600,0; 25009200,0; 25012800,0;
        25016400,0; 25020000,0; 25023600,0; 25027200,0; 25030800,0; 25034400,0;
        25038000,0; 25041600,0; 25045200,0; 25048800,0; 25052400,0; 25056000,0;
        25059600,0; 25063200,8.99; 25066800,8.92; 25070400,8.12; 25074000,7.87;
        25077600,8.3; 25081200,5.7; 25084800,8.26; 25088400,9.65; 25092000,9.48;
        25095600,8.08; 25099200,11.29; 25102800,10.51; 25106400,11.65; 25110000,
        5.53; 25113600,9.7; 25117200,9.07; 25120800,7.35; 25124400,9.82;
        25128000,9.94; 25131600,9.39; 25135200,10.27; 25138800,8.88; 25142400,
        7.65; 25146000,10.03; 25149600,9.23; 25153200,9.86; 25156800,8.78;
        25160400,7.64; 25164000,9.16; 25167600,7.98; 25171200,7.97; 25174800,
        7.03; 25178400,6.22; 25182000,9.24; 25185600,9.28; 25189200,9.88;
        25192800,7.96; 25196400,10.13; 25200000,10.2; 25203600,10.65; 25207200,
        14.39; 25210800,8.32; 25214400,9.67; 25218000,6.8; 25221600,13.89;
        25225200,9.21; 25228800,10.37; 25232400,7.72; 25236000,8.43; 25239600,
        8.16; 25243200,9.76; 25246800,8.11; 25250400,9.09; 25254000,8.21;
        25257600,7.64; 25261200,8.35; 25264800,8.08; 25268400,10.93; 25272000,
        10.8; 25275600,10.96; 25279200,9.22; 25282800,8.63; 25286400,9.83;
        25290000,6.93; 25293600,13.88; 25297200,11.69; 25300800,11.07; 25304400,
        7.84; 25308000,8.36; 25311600,7.92; 25315200,8.26; 25318800,12.61;
        25322400,11.12; 25326000,10.52; 25329600,8.24; 25333200,9.17; 25336800,
        10.88; 25340400,11.34; 25344000,8.52; 25347600,8.42; 25351200,9.07;
        25354800,8.96; 25358400,12.79; 25362000,11.05; 25365600,8.73; 25369200,
        12.76; 25372800,9.7; 25376400,10.8; 25380000,9.02; 25383600,14.12;
        25387200,9.4; 25390800,14.64; 25394400,4.92; 25398000,7.59; 25401600,
        11.02; 25405200,10.89; 25408800,9.37; 25412400,10.76; 25416000,7.38;
        25419600,11.48; 25423200,13.4; 25426800,10.15; 25430400,11.02; 25434000,
        9.64; 25437600,9.71; 25441200,7.85; 25444800,11.83; 25448400,7.02;
        25452000,13.84; 25455600,14.07; 25459200,10.97; 25462800,11.12;
        25466400,14.33; 25470000,8.53; 25473600,7.59; 25477200,13.46; 25480800,
        11.85; 25484400,7.95; 25488000,10.55; 25491600,10.11; 25495200,11.66;
        25498800,9.58; 25502400,8.36; 25506000,11.04; 25509600,10.76; 25513200,
        9.63; 25516800,11.03; 25520400,10.73; 25524000,7.17; 25527600,13.01;
        25531200,16.38; 25534800,16.85; 25538400,13.34; 25542000,20.47;
        25545600,17.61; 25549200,19.97; 25552800,21.32; 25556400,22.71;
        25560000,18.37; 25563600,25.03; 25567200,21.11; 25570800,22.97;
        25574400,17.45; 25578000,12.35; 25581600,8.08; 25585200,5.39; 25588800,
        3.47; 25592400,5.78; 25596000,45.64; 25599600,5.9; 25603200,1.95;
        25606800,9.09; 25610400,6.56; 25614000,9.49; 25617600,8.82; 25621200,
        7.23; 25624800,5.42; 25628400,3.74; 25632000,8.67; 25635600,11.96;
        25639200,3.24; 25642800,11.29; 25646400,11.74; 25650000,15.13; 25653600,
        10.22; 25657200,11.82; 25660800,10.75; 25664400,7.57; 25668000,9.34;
        25671600,8.07; 25675200,4.14; 25678800,12.64; 25682400,7.73; 25686000,
        5.32; 25689600,7.77; 25693200,8.79; 25696800,10.99; 25700400,6.09;
        25704000,9.68; 25707600,7.48; 25711200,11.16; 25714800,7.46; 25718400,
        7.57; 25722000,8.44; 25725600,1.62; 25729200,7.71; 25732800,8.57;
        25736400,8.16; 25740000,9.66; 25743600,5.75; 25747200,10.27; 25750800,
        9.97; 25754400,7.89; 25758000,8.48; 25761600,10.57; 25765200,8.01;
        25768800,9.29; 25772400,7.82; 25776000,11.22; 25779600,11.12; 25783200,
        6.59; 25786800,7.93; 25790400,8.25; 25794000,11.43; 25797600,8.37;
        25801200,14.15; 25804800,6.68; 25808400,16.38; 25812000,13.55; 25815600,
        11.75; 25819200,15.77; 25822800,11.01; 25826400,15.96; 25830000,7.25;
        25833600,19.04; 25837200,22.35; 25840800,6.94; 25844400,10.8; 25848000,
        16.92; 25851600,9.75; 25855200,8.8; 25858800,13.15; 25862400,3.7;
        25866000,9.63; 25869600,6.03; 25873200,21.5; 25876800,4.68; 25880400,
        11.53; 25884000,7.75; 25887600,11.33; 25891200,10.43; 25894800,16.19;
        25898400,0; 25902000,10.27; 25905600,13.1; 25909200,24.11; 25912800,
        14.24; 25916400,21.7; 25920000,9.01; 25923600,10.24; 25927200,15.66;
        25930800,12.04; 25934400,7.22; 25938000,7.75; 25941600,7.7; 25945200,
        8.61; 25948800,8.26; 25952400,9.43; 25956000,7.24; 25959600,16.9;
        25963200,9.09; 25966800,18.32; 25970400,10.83; 25974000,0.53; 25977600,
        20.14; 25981200,19.89; 25984800,13.22; 25988400,7.83; 25992000,13.3;
        25995600,11.5; 25999200,20.12; 26002800,9.11; 26006400,11.52; 26010000,
        16.57; 26013600,8.92; 26017200,7.68; 26020800,7.07; 26024400,8.09;
        26028000,7.23; 26031600,8.27; 26035200,8.01; 26038800,7.74; 26042400,
        7.12; 26046000,7.81; 26049600,12.52; 26053200,9.66; 26056800,20.78;
        26060400,14.05; 26064000,6.24; 26067600,17.23; 26071200,4.16; 26074800,
        25.92; 26078400,17.63; 26082000,10.34; 26085600,10.81; 26089200,13.89;
        26092800,10.92; 26096400,12.9; 26100000,7.38; 26103600,14.26; 26107200,
        7.07; 26110800,7.6; 26114400,7.59; 26118000,7.22; 26121600,10; 26125200,
        7.98; 26128800,8.89; 26132400,7.15; 26136000,7.77; 26139600,9.03;
        26143200,8.34; 26146800,11.17; 26150400,7.72; 26154000,8.28; 26157600,
        19.01; 26161200,8.1; 26164800,16.73; 26168400,6.2; 26172000,8.92;
        26175600,15.71; 26179200,6.77; 26182800,8.1; 26186400,3.72; 26190000,
        9.99; 26193600,7.85; 26197200,8.09; 26200800,5.84; 26204400,6.43;
        26208000,7.55; 26211600,8.03; 26215200,6.97; 26218800,8.61; 26222400,
        8.31; 26226000,7.58; 26229600,7.82; 26233200,7.13; 26236800,7.98;
        26240400,6.32; 26244000,12.33; 26247600,5.78; 26251200,7.88; 26254800,
        7.24; 26258400,13.32; 26262000,8.43; 26265600,12.15; 26269200,13.91;
        26272800,7.76; 26276400,14.43; 26280000,13.04; 26283600,6.68; 26287200,
        0; 26290800,0; 26294400,0.76; 26298000,6.92; 26301600,8.16; 26305200,
        7.82; 26308800,7.3; 26312400,7.11; 26316000,9.35; 26319600,3.53;
        26323200,7.98; 26326800,9.29; 26330400,8.33; 26334000,7.62; 26337600,
        6.98; 26341200,9.5; 26344800,10.28; 26348400,9.76; 26352000,12.99;
        26355600,3.7; 26359200,3.37; 26362800,7.46; 26366400,5.13; 26370000,
        8.45; 26373600,3.15; 26377200,4.77; 26380800,4.77; 26384400,6.85;
        26388000,13.33; 26391600,5.24; 26395200,9.97; 26398800,10.73; 26402400,
        13.19; 26406000,9.04; 26409600,9.93; 26413200,16.08; 26416800,2.05;
        26420400,17.83; 26424000,7.73; 26427600,10.54; 26431200,12.14; 26434800,
        6.05; 26438400,7.49; 26442000,7.38; 26445600,7.76; 26449200,6.44;
        26452800,7.06; 26456400,8.9; 26460000,16.02; 26463600,17.61; 26467200,
        13; 26470800,7.12; 26474400,7.72; 26478000,6.67; 26481600,7.1; 26485200,
        7.29; 26488800,8.3; 26492400,7.9; 26496000,5.63; 26499600,7.99;
        26503200,7.99; 26506800,9.06; 26510400,10.31; 26514000,6.34; 26517600,
        8.75; 26521200,7.61; 26524800,9.29; 26528400,7.17; 26532000,7.45;
        26535600,6.15; 26539200,6.99; 26542800,6.5; 26546400,8.45; 26550000,
        10.95; 26553600,7.1; 26557200,10.22; 26560800,9.25; 26564400,9.63;
        26568000,5.61; 26571600,10.88; 26575200,8.13; 26578800,7.2; 26582400,
        14.41; 26586000,10.18; 26589600,10.19; 26593200,10.38; 26596800,4.44;
        26600400,9.48; 26604000,11.04; 26607600,7.04; 26611200,9.31; 26614800,
        8.53; 26618400,12.46; 26622000,5.35; 26625600,5.09; 26629200,6.84;
        26632800,3.47; 26636400,5.83; 26640000,3.19; 26643600,6.83; 26647200,
        8.3; 26650800,6.86; 26654400,8.89; 26658000,5.67; 26661600,7.98;
        26665200,13.45; 26668800,3.94; 26672400,10.9; 26676000,4.62; 26679600,
        9.35; 26683200,10.4; 26686800,11.18; 26690400,12.19; 26694000,9.31;
        26697600,9.48; 26701200,13.87; 26704800,9.7; 26708400,8.62; 26712000,10;
        26715600,11.15; 26719200,7.59; 26722800,8.9; 26726400,5.69; 26730000,
        10.35; 26733600,10.32; 26737200,4.23; 26740800,9.31; 26744400,12.76;
        26748000,8.05; 26751600,7.11; 26755200,11.89; 26758800,5.24; 26762400,
        16.54; 26766000,8.77; 26769600,5.76; 26773200,7.03; 26776800,7.72;
        26780400,4.02; 26784000,9.81; 26787600,3.9; 26791200,6.95; 26794800,
        8.49; 26798400,17.93; 26802000,7.16; 26805600,9.54; 26809200,5.07;
        26812800,5.76; 26816400,4.65; 26820000,5.06; 26823600,6.35; 26827200,
        6.14; 26830800,5.96; 26834400,5.07; 26838000,7.69; 26841600,6.69;
        26845200,8.78; 26848800,8.62; 26852400,7.43; 26856000,9.59; 26859600,
        6.57; 26863200,9.51; 26866800,7.3; 26870400,7.39; 26874000,8.03;
        26877600,7.29; 26881200,8.67; 26884800,4.33; 26888400,6.44; 26892000,
        7.1; 26895600,4.05; 26899200,7.11; 26902800,6.23; 26906400,6.52;
        26910000,7.52; 26913600,6.98; 26917200,6.39; 26920800,5.34; 26924400,
        8.3; 26928000,7.32; 26931600,8.46; 26935200,5.63; 26938800,6.07;
        26942400,9.03; 26946000,7.28; 26949600,7.74; 26953200,6.85; 26956800,
        6.98; 26960400,5.91; 26964000,6.19; 26967600,20.49; 26971200,11.62;
        26974800,11.62; 26978400,10.16; 26982000,19.24; 26985600,6.92; 26989200,
        13.8; 26992800,6.68; 26996400,8.8; 27000000,6.94; 27003600,7.54;
        27007200,7.72; 27010800,10.14; 27014400,8.63; 27018000,6.86; 27021600,
        10.61; 27025200,12.15; 27028800,8.22; 27032400,5.05; 27036000,8.02;
        27039600,11.4; 27043200,17.38; 27046800,10; 27050400,2.35; 27054000,
        3.41; 27057600,8.44; 27061200,3.94; 27064800,8.35; 27068400,6.3;
        27072000,5.76; 27075600,4.63; 27079200,9.55; 27082800,7.04; 27086400,
        9.88; 27090000,5.23; 27093600,9.81; 27097200,6.32; 27100800,9; 27104400,
        6.13; 27108000,8.47; 27111600,7.04; 27115200,7.82; 27118800,7.7;
        27122400,6.66; 27126000,6.96; 27129600,7.53; 27133200,8.27; 27136800,
        7.23; 27140400,7.16; 27144000,7.32; 27147600,7.94; 27151200,6.29;
        27154800,6.1; 27158400,8; 27162000,6.69; 27165600,6.68; 27169200,7.31;
        27172800,6.14; 27176400,8.32; 27180000,9.02; 27183600,5.24; 27187200,
        7.29; 27190800,6.53; 27194400,5.72; 27198000,7.1; 27201600,5.31;
        27205200,5.63; 27208800,12.5; 27212400,7.78; 27216000,4.39; 27219600,
        7.04; 27223200,14.14; 27226800,6.07; 27230400,7.49; 27234000,6.95;
        27237600,6.39; 27241200,6.62; 27244800,4.72; 27248400,7.39; 27252000,
        6.46; 27255600,5.82; 27259200,6.1; 27262800,6.9; 27266400,7.14;
        27270000,4.78; 27273600,6.8; 27277200,6.89; 27280800,7.02; 27284400,
        6.74; 27288000,7.02; 27291600,7.01; 27295200,8.49; 27298800,9.03;
        27302400,5.98; 27306000,7.79; 27309600,12.18; 27313200,7.55; 27316800,
        10.76; 27320400,7.1; 27324000,11.02; 27327600,8.98; 27331200,8.21;
        27334800,12.07; 27338400,6.05; 27342000,7.54; 27345600,4.26; 27349200,
        5.31; 27352800,6; 27356400,7.56; 27360000,9.08; 27363600,6.87; 27367200,
        7.76; 27370800,7.23; 27374400,6.55; 27378000,3.56; 27381600,3.66;
        27385200,8.59; 27388800,9.5; 27392400,8.25; 27396000,7.05; 27399600,
        6.65; 27403200,7.11; 27406800,7.08; 27410400,6.54; 27414000,1.88;
        27417600,7.75; 27421200,13.33; 27424800,8.86; 27428400,10.32; 27432000,
        12.2; 27435600,10.85; 27439200,19.1; 27442800,9.58; 27446400,12.09;
        27450000,19.03; 27453600,17.21; 27457200,6.57; 27460800,16.14; 27464400,
        8.67; 27468000,8.08; 27471600,14.03; 27475200,10.36; 27478800,11.81;
        27482400,10; 27486000,8.45; 27489600,7.73; 27493200,7.28; 27496800,5.97;
        27500400,8.79; 27504000,11.43; 27507600,15.01; 27511200,9.14; 27514800,
        8.98; 27518400,15.4; 27522000,9.68; 27525600,6.78; 27529200,5.8;
        27532800,3.96; 27536400,7.34; 27540000,8.08; 27543600,6.96; 27547200,
        6.33; 27550800,8.22; 27554400,11.96; 27558000,8.2; 27561600,19.43;
        27565200,9.28; 27568800,8.74; 27572400,7.05; 27576000,9.33; 27579600,
        6.69; 27583200,7.28; 27586800,7.12; 27590400,6.59; 27594000,7.16;
        27597600,6.97; 27601200,7.04; 27604800,10.66; 27608400,8.82; 27612000,
        7.61; 27615600,7.17; 27619200,8.07; 27622800,5.54; 27626400,7.58;
        27630000,7.05; 27633600,7.41; 27637200,7.09; 27640800,13.31; 27644400,
        5.71; 27648000,9.99; 27651600,6.26; 27655200,7.41; 27658800,7.81;
        27662400,8.06; 27666000,6.83; 27669600,11.3; 27673200,7.54; 27676800,
        8.68; 27680400,6.65; 27684000,6.33; 27687600,12.12; 27691200,7.3;
        27694800,7.31; 27698400,10.27; 27702000,8.69; 27705600,7.15; 27709200,
        14.12; 27712800,5.29; 27716400,12.82; 27720000,8.6; 27723600,10.06;
        27727200,5.7; 27730800,8.91; 27734400,8.48; 27738000,7.49; 27741600,
        9.77; 27745200,7.17; 27748800,9.61; 27752400,8.17; 27756000,14.34;
        27759600,9.56; 27763200,14.22; 27766800,6.91; 27770400,13.21; 27774000,
        6.39; 27777600,7.1; 27781200,8.74; 27784800,17.83; 27788400,9.94;
        27792000,8.85; 27795600,11.08; 27799200,7.56; 27802800,16.93; 27806400,
        7.26; 27810000,10.07; 27813600,19.08; 27817200,7.46; 27820800,16.98;
        27824400,7.25; 27828000,12.06; 27831600,17.33; 27835200,8.26; 27838800,
        18.29; 27842400,7.4; 27846000,16.44; 27849600,7.38; 27853200,8.23;
        27856800,8.87; 27860400,15.06; 27864000,15.62; 27867600,7.52; 27871200,
        15.05; 27874800,16.42; 27878400,6.95; 27882000,10.61; 27885600,14.99;
        27889200,7.83; 27892800,19.53; 27896400,7.78; 27900000,7.35; 27903600,
        7.21; 27907200,6.85; 27910800,14.24; 27914400,7.84; 27918000,12.77;
        27921600,7.12; 27925200,18.41; 27928800,10.89; 27932400,12.26; 27936000,
        8.02; 27939600,8.13; 27943200,16.51; 27946800,7.04; 27950400,15.34;
        27954000,7.2; 27957600,10.94; 27961200,10.73; 27964800,16.31; 27968400,
        7.17; 27972000,11.93; 27975600,7.84; 27979200,7.44; 27982800,7.2;
        27986400,12.65; 27990000,7.94; 27993600,14.41; 27997200,13.04; 28000800,
        11.94; 28004400,6.57; 28008000,12.83; 28011600,6.34; 28015200,14.01;
        28018800,14.21; 28022400,6.56; 28026000,9.96; 28029600,8.22; 28033200,
        7.55; 28036800,7.45; 28040400,7.19; 28044000,7.53; 28047600,6.52;
        28051200,15.54; 28054800,9.47; 28058400,12.53; 28062000,5.71; 28065600,
        14.47; 28069200,10.39; 28072800,12.08; 28076400,7.58; 28080000,13.83;
        28083600,9.35; 28087200,11.76; 28090800,7.81; 28094400,13.04; 28098000,
        8.4; 28101600,17.26; 28105200,21.67; 28108800,15.77; 28112400,14.04;
        28116000,22.02; 28119600,13.37; 28123200,34.42; 28126800,28.28;
        28130400,8.85; 28134000,10.72; 28137600,11.79; 28141200,10.8; 28144800,
        11.36; 28148400,24.92; 28152000,24.15; 28155600,30.8; 28159200,28.12;
        28162800,28.32; 28166400,26.62; 28170000,25.33; 28173600,20.84;
        28177200,15.13; 28180800,16.81; 28184400,26.47; 28188000,9.36; 28191600,
        21.41; 28195200,10.52; 28198800,30.36; 28202400,5.87; 28206000,18.82;
        28209600,8.03; 28213200,12.09; 28216800,12.8; 28220400,11.36; 28224000,
        11.34; 28227600,11.34; 28231200,12.13; 28234800,12.51; 28238400,12.23;
        28242000,12.42; 28245600,11.97; 28249200,11.14; 28252800,11.18;
        28256400,11.84; 28260000,12; 28263600,11.37; 28267200,9.39; 28270800,
        10.34; 28274400,9.85; 28278000,9.31; 28281600,10.7; 28285200,10.65;
        28288800,10.53; 28292400,11.5; 28296000,8.13; 28299600,10.94; 28303200,
        7.5; 28306800,7.39; 28310400,8.76; 28314000,10.4; 28317600,8.5;
        28321200,7.91; 28324800,10.73; 28328400,9.06; 28332000,9.19; 28335600,
        10.54; 28339200,9.9; 28342800,10.82; 28346400,11.59; 28350000,10.64;
        28353600,9.37; 28357200,9.3; 28360800,11.76; 28364400,9.54; 28368000,
        9.12; 28371600,8.33; 28375200,7.93; 28378800,6.94; 28382400,9.79;
        28386000,8.49; 28389600,8.14; 28393200,9.33; 28396800,9.39; 28400400,
        11.42; 28404000,8.95; 28407600,9.7; 28411200,9.3; 28414800,7.75;
        28418400,9.88; 28422000,9.49; 28425600,9.79; 28429200,9.94; 28432800,
        10.35; 28436400,7.85; 28440000,8.33; 28443600,9.66; 28447200,7.2;
        28450800,7.69; 28454400,6.77; 28458000,5.52; 28461600,11.42; 28465200,
        11.12; 28468800,7.53; 28472400,10.39; 28476000,11.69; 28479600,11.89;
        28483200,8.43; 28486800,9.57; 28490400,9.29; 28494000,9.71; 28497600,
        9.01; 28501200,10.32; 28504800,11.38; 28508400,10.37; 28512000,9.28;
        28515600,6.83; 28519200,10.91; 28522800,5.94; 28526400,5.69; 28530000,
        9.89; 28533600,5.36; 28537200,6.46; 28540800,3.98; 28544400,7.86;
        28548000,9.72; 28551600,11.34; 28555200,8.7; 28558800,11.28; 28562400,
        10.81; 28566000,11.58; 28569600,4.84; 28573200,3.86; 28576800,5.65;
        28580400,6.91; 28584000,8.06; 28587600,13.54; 28591200,9.66; 28594800,
        10.56; 28598400,10.11; 28602000,7.14; 28605600,9.62; 28609200,10.9;
        28612800,6.64; 28616400,5.19; 28620000,4.58; 28623600,3.88; 28627200,
        6.18; 28630800,5.2; 28634400,5.72; 28638000,4.66; 28641600,5.62;
        28645200,5.5; 28648800,5.21; 28652400,2.13; 28656000,4.04; 28659600,5.7;
        28663200,3.14; 28666800,4.16; 28670400,6.78; 28674000,15.71; 28677600,
        10.84; 28681200,13.51; 28684800,7.63; 28688400,11.03; 28692000,7.17;
        28695600,9.12; 28699200,8.53; 28702800,2.95; 28706400,7.3; 28710000,
        6.02; 28713600,6.72; 28717200,6.44; 28720800,5.54; 28724400,6.13;
        28728000,7.97; 28731600,5.31; 28735200,6.82; 28738800,7.25; 28742400,
        6.47; 28746000,6.41; 28749600,5.28; 28753200,5.84; 28756800,6.77;
        28760400,4.06; 28764000,6.54; 28767600,6.52; 28771200,5.07; 28774800,
        6.61; 28778400,5.39; 28782000,7.7; 28785600,17.18; 28789200,6.76;
        28792800,7.33; 28796400,10.64; 28800000,11.58; 28803600,5.25; 28807200,
        6.54; 28810800,8.83; 28814400,7.7; 28818000,7.96; 28821600,5.24;
        28825200,7.38; 28828800,7.16; 28832400,8.15; 28836000,6.13; 28839600,
        6.84; 28843200,9.32; 28846800,6.28; 28850400,5.96; 28854000,6.08;
        28857600,5.4; 28861200,5.28; 28864800,5.49; 28868400,19.36; 28872000,
        16.63; 28875600,7.63; 28879200,6.56; 28882800,7.25; 28886400,5.02;
        28890000,7.83; 28893600,6.37; 28897200,6.93; 28900800,15.49; 28904400,
        5.8; 28908000,6.41; 28911600,5.01; 28915200,5.87; 28918800,6.07;
        28922400,6.06; 28926000,6.07; 28929600,5.5; 28933200,5.51; 28936800,6.4;
        28940400,5.03; 28944000,5.41; 28947600,6.29; 28951200,5.93; 28954800,
        4.63; 28958400,5.4; 28962000,5.82; 28965600,5.02; 28969200,6.39;
        28972800,6.81; 28976400,5.84; 28980000,5.92; 28983600,6.61; 28987200,
        6.14; 28990800,5.72; 28994400,6.1; 28998000,6.51; 29001600,5.65;
        29005200,6.76; 29008800,7.47; 29012400,5.48; 29016000,5.82; 29019600,
        6.09; 29023200,5.09; 29026800,6.31; 29030400,6.15; 29034000,6.3;
        29037600,6.33; 29041200,6.05; 29044800,5.74; 29048400,6.42; 29052000,
        5.83; 29055600,6.05; 29059200,5.57; 29062800,7.46; 29066400,5.46;
        29070000,7.12; 29073600,6.36; 29077200,2.18; 29080800,6.47; 29084400,
        5.39; 29088000,6.42; 29091600,6.41; 29095200,6.41; 29098800,5.43;
        29102400,7.66; 29106000,4.48; 29109600,4.44; 29113200,8.39; 29116800,
        7.34; 29120400,8.46; 29124000,9.02; 29127600,6.27; 29131200,3.02;
        29134800,8.41; 29138400,8.57; 29142000,6.49; 29145600,5.05; 29149200,
        6.18; 29152800,6.28; 29156400,6.28; 29160000,10.61; 29163600,4.49;
        29167200,8.03; 29170800,4.65; 29174400,10.82; 29178000,8.77; 29181600,
        8.11; 29185200,8.19; 29188800,8.88; 29192400,9.49; 29196000,9.61;
        29199600,13.38; 29203200,8.12; 29206800,7.37; 29210400,7.81; 29214000,
        30.77; 29217600,5.74; 29221200,7.19; 29224800,9.27; 29228400,10.47;
        29232000,7.32; 29235600,12.39; 29239200,9.61; 29242800,9.16; 29246400,
        4.62; 29250000,6.85; 29253600,6.06; 29257200,8.51; 29260800,10.06;
        29264400,6.27; 29268000,8.05; 29271600,11.56; 29275200,11.05; 29278800,
        9.85; 29282400,9.62; 29286000,9.78; 29289600,12.17; 29293200,11.07;
        29296800,10.18; 29300400,9.51; 29304000,15.33; 29307600,9.94; 29311200,
        8.19; 29314800,11.34; 29318400,7.61; 29322000,11.01; 29325600,10.46;
        29329200,12.33; 29332800,12.21; 29336400,10.06; 29340000,12.29;
        29343600,11.02; 29347200,12.37; 29350800,11.95; 29354400,12.21;
        29358000,12.07; 29361600,13.62; 29365200,13.44; 29368800,12.08;
        29372400,15.13; 29376000,12.63; 29379600,12.03; 29383200,11.61;
        29386800,10.42; 29390400,10.57; 29394000,10.94; 29397600,12.6; 29401200,
        13.69; 29404800,14.42; 29408400,15.66; 29412000,12.51; 29415600,13.93;
        29419200,17.89; 29422800,16.1; 29426400,15.33; 29430000,15.65; 29433600,
        17.68; 29437200,16.53; 29440800,13.5; 29444400,14.65; 29448000,16.33;
        29451600,13.65; 29455200,13.57; 29458800,14.59; 29462400,14.85;
        29466000,13.65; 29469600,15.93; 29473200,18.76; 29476800,36.45;
        29480400,17.49; 29484000,13.01; 29487600,13.98; 29491200,13.24;
        29494800,13.24; 29498400,14.59; 29502000,12.24; 29505600,12.3; 29509200,
        11.76; 29512800,10.28; 29516400,12.79; 29520000,13.52; 29523600,12.98;
        29527200,14.63; 29530800,13.11; 29534400,12.19; 29538000,13.08;
        29541600,14.31; 29545200,12.85; 29548800,13.53; 29552400,15.15;
        29556000,12.15; 29559600,12.7; 29563200,13.05; 29566800,12.21; 29570400,
        11.35; 29574000,10.49; 29577600,9.54; 29581200,9.63; 29584800,11.7;
        29588400,9.99; 29592000,8.17; 29595600,13.39; 29599200,13.72; 29602800,
        13.2; 29606400,10.33; 29610000,15.24; 29613600,9.41; 29617200,14.29;
        29620800,9.31; 29624400,11.75; 29628000,10.94; 29631600,11.38; 29635200,
        11.88; 29638800,12.18; 29642400,14.13; 29646000,15.43; 29649600,15.84;
        29653200,14.23; 29656800,14.58; 29660400,15.73; 29664000,14.16;
        29667600,13.75; 29671200,13.07; 29674800,12.5; 29678400,13.46; 29682000,
        11.86; 29685600,12.49; 29689200,16.11; 29692800,13.35; 29696400,8.81;
        29700000,11.92; 29703600,11.57; 29707200,12.86; 29710800,13.57;
        29714400,15.52; 29718000,16.33; 29721600,17.11; 29725200,15.19;
        29728800,15.34; 29732400,12.71; 29736000,12.2; 29739600,11.9; 29743200,
        12.04; 29746800,7.9; 29750400,15.58; 29754000,12.99; 29757600,13.24;
        29761200,13.71; 29764800,14.31; 29768400,12.75; 29772000,9; 29775600,
        14.94; 29779200,12.17; 29782800,11.07; 29786400,11.01; 29790000,11.11;
        29793600,10.21; 29797200,11.1; 29800800,14.97; 29804400,16.07; 29808000,
        11.33; 29811600,12.65; 29815200,10.99; 29818800,9.56; 29822400,12.23;
        29826000,6.53; 29829600,8.57; 29833200,9.38; 29836800,7.05; 29840400,
        7.87; 29844000,5.31; 29847600,11.38; 29851200,9.05; 29854800,10.82;
        29858400,7.9; 29862000,10.02; 29865600,13.61; 29869200,10.98; 29872800,
        7.97; 29876400,11.21; 29880000,10.78; 29883600,10.27; 29887200,7.67;
        29890800,12.8; 29894400,9.34; 29898000,7.96; 29901600,4.81; 29905200,
        5.62; 29908800,7.81; 29912400,6.86; 29916000,7.31; 29919600,8.47;
        29923200,5.87; 29926800,6.41; 29930400,11.11; 29934000,7.89; 29937600,
        9.11; 29941200,7.62; 29944800,8.73; 29948400,7.77; 29952000,11.27;
        29955600,5.63; 29959200,7.6; 29962800,6.97; 29966400,6.06; 29970000,
        9.72; 29973600,11.76; 29977200,7.27; 29980800,7.26; 29984400,5.75;
        29988000,6.32; 29991600,6.41; 29995200,7.59; 29998800,9.64; 30002400,
        11.14; 30006000,12.73; 30009600,7.45; 30013200,6.89; 30016800,4.01;
        30020400,11.02; 30024000,7.35; 30027600,14.28; 30031200,5.72; 30034800,
        2.02; 30038400,8.78; 30042000,6.69; 30045600,14.06; 30049200,5.02;
        30052800,9.33; 30056400,7.1; 30060000,11.23; 30063600,7.09; 30067200,
        14.82; 30070800,9.68; 30074400,14.08; 30078000,12.12; 30081600,14.8;
        30085200,10.71; 30088800,17.1; 30092400,19.96; 30096000,14.94; 30099600,
        16.66; 30103200,7.19; 30106800,10.82; 30110400,7.57; 30114000,9.94;
        30117600,11.22; 30121200,5.87; 30124800,4.48; 30128400,10.16; 30132000,
        10.94; 30135600,8.34; 30139200,9.37; 30142800,8.9; 30146400,9.25;
        30150000,8.95; 30153600,8.61; 30157200,6.75; 30160800,10.92; 30164400,
        5.92; 30168000,8.61; 30171600,7.63; 30175200,5.13; 30178800,8.85;
        30182400,5.75; 30186000,7.33; 30189600,9.69; 30193200,7.75; 30196800,
        8.32; 30200400,10.12; 30204000,7.89; 30207600,10.29; 30211200,10.08;
        30214800,10.17; 30218400,8.93; 30222000,10.91; 30225600,6.07; 30229200,
        6.08; 30232800,8.14; 30236400,6.64; 30240000,8.09; 30243600,8.55;
        30247200,6.64; 30250800,7.88; 30254400,6.83; 30258000,6.85; 30261600,
        6.98; 30265200,6.69; 30268800,8.13; 30272400,7.37; 30276000,7.48;
        30279600,8.49; 30283200,6.97; 30286800,9.1; 30290400,10.2; 30294000,
        8.43; 30297600,12; 30301200,10.33; 30304800,9.47; 30308400,9.5;
        30312000,11.3; 30315600,13.7; 30319200,9.66; 30322800,9.88; 30326400,
        11.56; 30330000,11.94; 30333600,10.41; 30337200,9.15; 30340800,11.38;
        30344400,13.44; 30348000,27.73; 30351600,20.02; 30355200,21.25;
        30358800,9.14; 30362400,8.79; 30366000,12.24; 30369600,6.89; 30373200,
        9.49; 30376800,10.47; 30380400,10.32; 30384000,9.49; 30387600,7.89;
        30391200,11.61; 30394800,8.59; 30398400,7.37; 30402000,9.92; 30405600,
        8.19; 30409200,7.78; 30412800,9.85; 30416400,9.52; 30420000,10.71;
        30423600,8.52; 30427200,13.2; 30430800,11.34; 30434400,7.14; 30438000,
        7.5; 30441600,15.6; 30445200,5.39; 30448800,10.41; 30452400,11.98;
        30456000,14.1; 30459600,16.2; 30463200,17.79; 30466800,10.03; 30470400,
        12.07; 30474000,15.24; 30477600,10.94; 30481200,13.76; 30484800,11.99;
        30488400,15.38; 30492000,13.97; 30495600,13.28; 30499200,13.52;
        30502800,16.21; 30506400,11.92; 30510000,13.49; 30513600,19.2; 30517200,
        12.61; 30520800,15.53; 30524400,11.86; 30528000,12.25; 30531600,12.8;
        30535200,13.91; 30538800,11.19; 30542400,14.96; 30546000,12.14;
        30549600,12.47; 30553200,12.45; 30556800,13.29; 30560400,12.97;
        30564000,15.54; 30567600,13.28; 30571200,14.45; 30574800,14.11;
        30578400,14.75; 30582000,14.76; 30585600,13.15; 30589200,11.55;
        30592800,15.88; 30596400,16.99; 30600000,13.27; 30603600,11.63;
        30607200,11.41; 30610800,15.75; 30614400,12.57; 30618000,11.65;
        30621600,16.03; 30625200,11.4; 30628800,12.27; 30632400,13.36; 30636000,
        15.42; 30639600,15; 30643200,13.58; 30646800,10.85; 30650400,15.76;
        30654000,12.48; 30657600,12.22; 30661200,14.03; 30664800,13.22;
        30668400,12.62; 30672000,14.28; 30675600,14.63; 30679200,16.41;
        30682800,14.38; 30686400,13.74; 30690000,14.19; 30693600,12.06;
        30697200,13.64; 30700800,14.39; 30704400,13.89; 30708000,13.87;
        30711600,18.15; 30715200,17.98; 30718800,11.59; 30722400,14.38;
        30726000,8.09; 30729600,13.24; 30733200,15.82; 30736800,16.91; 30740400,
        17.46; 30744000,16.21; 30747600,19.39; 30751200,15.25; 30754800,13.08;
        30758400,14.19; 30762000,14.37; 30765600,15.2; 30769200,11.81; 30772800,
        14.33; 30776400,11.42; 30780000,10.18; 30783600,19.2; 30787200,15.34;
        30790800,11; 30794400,23.61; 30798000,18.57; 30801600,14.13; 30805200,
        13.37; 30808800,13.58; 30812400,13.44; 30816000,13.24; 30819600,12.75;
        30823200,13.25; 30826800,13.66; 30830400,11.65; 30834000,14.66;
        30837600,15.44; 30841200,12.22; 30844800,14.72; 30848400,13; 30852000,
        14.87; 30855600,13.97; 30859200,15.45; 30862800,10.34; 30866400,12.04;
        30870000,11.44; 30873600,12.97; 30877200,14.42; 30880800,13.9; 30884400,
        14.45; 30888000,15.67; 30891600,14.23; 30895200,16.06; 30898800,15.53;
        30902400,14.42; 30906000,15.25; 30909600,15.87; 30913200,16.03;
        30916800,15.29; 30920400,16.48; 30924000,16.07; 30927600,16.58;
        30931200,17.03; 30934800,13.88; 30938400,13.89; 30942000,14.27;
        30945600,12.64; 30949200,9.35; 30952800,12.35; 30956400,11.54; 30960000,
        12.32; 30963600,12.82; 30967200,13.07; 30970800,15.51; 30974400,11.05;
        30978000,16.12; 30981600,13.32; 30985200,13.32; 30988800,11.49;
        30992400,14.05; 30996000,10.51; 30999600,15.93; 31003200,16.76;
        31006800,14.32; 31010400,16.24; 31014000,13.26; 31017600,15.31;
        31021200,14.93; 31024800,15.75; 31028400,17.42; 31032000,13.72;
        31035600,14.71; 31039200,12.21; 31042800,15.73; 31046400,13.34;
        31050000,15.51; 31053600,15.97; 31057200,12.86; 31060800,17.93;
        31064400,16.56; 31068000,15.74; 31071600,12.22; 31075200,12.83;
        31078800,14.99; 31082400,15.36; 31086000,13.99; 31089600,14.57;
        31093200,15.49; 31096800,16.3; 31100400,16.17; 31104000,16.32; 31107600,
        15.76; 31111200,14.96; 31114800,14.92; 31118400,15.8; 31122000,16.16;
        31125600,11.65; 31129200,14.31; 31132800,14.02; 31136400,14.74;
        31140000,15.89; 31143600,16.69; 31147200,13.39; 31150800,14.82;
        31154400,17.26; 31158000,13.28; 31161600,12.89; 31165200,10; 31168800,
        14.96; 31172400,14.52; 31176000,14.54; 31179600,14.19; 31183200,15.01;
        31186800,16.59; 31190400,15.43; 31194000,12.65; 31197600,15.41;
        31201200,13.45; 31204800,15.78; 31208400,12.54; 31212000,14.42;
        31215600,13.93; 31219200,12.82; 31222800,13.46; 31226400,11.84;
        31230000,18.41; 31233600,13.01; 31237200,14.04; 31240800,15.43;
        31244400,18.06])
    "Table with profiles for internal gains"
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-211,192})));

  Modelica.Blocks.Math.Gain gain(k=-1000)
    annotation (Placement(transformation(extent={{-200,190},{-194,196}})));
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
  connect(vol1.ports[1], eRC_AHU.port_a4) annotation (Line(points={{135.95,100},
          {-34,100},{-34,248}}, color={0,127,255}));
  connect(vol1.ports[2], tabs1.port_a2) annotation (Line(points={{136.65,100},{
          186,100},{186,120}},
                           color={0,127,255}));
  connect(vol1.ports[3], tabs2.port_a2) annotation (Line(points={{137.35,100},{
          392,100},{392,122}},
                           color={0,127,255}));
  connect(vol.ports[2], eRC_AHU.port_b4) annotation (Line(points={{120.65,76},{
          -23.0909,76},{-23.0909,248}}, color={0,127,255}));
  connect(vol.ports[3], tabs1.port_b2) annotation (Line(points={{121.35,76},{
          194,76},{194,120.4}},
                              color={0,127,255}));
  connect(vol.ports[4], tabs2.port_b2) annotation (Line(points={{122.05,76},{
          400,76},{400,122.4}},
                              color={0,127,255}));
  connect(vol1.ports[1], eRC_AHU1.port_a4) annotation (Line(points={{135.95,100},
          {84,100},{84,160}}, color={0,127,255}));
  connect(vol.ports[2], eRC_AHU1.port_b4) annotation (Line(points={{120.65,76},
          {94.9091,76},{94.9091,160}}, color={0,127,255}));
  connect(eRC_AHU1.port_a5, eRC_AHU.port_a5) annotation (Line(points={{105.818,
          160},{106,160},{106,128},{-12.1818,128},{-12.1818,248}}, color={238,
          46,47}));
  connect(thermalZone2South.intGains, internalGains1.y) annotation (Line(points=
         {{344.4,210.32},{343.2,210.32},{343.2,197.7},{345,197.7}}, color={0,0,
          127}));
  connect(eRC_AHU1.port_a2, thermalZone2South.ports[1]) annotation (Line(points
        ={{144.545,214},{231.272,214},{231.272,213.56},{318.71,213.56}}, color=
          {0,127,255}));
  connect(eRC_AHU1.port_b1, thermalZone2South.ports[2]) annotation (Line(points
        ={{144.545,190},{332,190},{332,213.56},{325.29,213.56}}, color={0,127,
          255}));
  connect(eRC_AHU.port_b1, thermalZone1North.ports[1]) annotation (Line(points=
          {{26.5455,278},{142,278},{142,304.12},{136.71,304.12}}, color={0,127,
          255}));
  connect(eRC_AHU.port_a2, thermalZone1North.ports[2]) annotation (Line(points=
          {{26.5455,302},{80,302},{80,304.12},{143.29,304.12}}, color={0,127,
          255}));
  connect(eRC_AHU1.genericAHUBus, mainBus.ahu2Bus) annotation (Line(
      points={{84,226.3},{84,419.145},{161.115,419.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(eRC_AHU.genericAHUBus, mainBus.ahu1Bus) annotation (Line(
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
  connect(eRC_AHU1.port_b5, eRC_AHU.port_b5) annotation (Line(points={{116.182,
          160},{116,160},{116,120},{-1.81818,120},{-1.81818,248}}, color={238,
          46,47}));
  connect(eRC_AHU.port_a5, vol2.ports[4]) annotation (Line(points={{-12.1818,
          248},{-12,248},{-12,126},{-176,126},{-176,-19.4}}, color={238,46,47}));
  connect(eRC_AHU1.port_b5, vol3.ports[4]) annotation (Line(points={{116.182,
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
  connect(eRC_AHU.port_a1, boundaryOutsideAir.ports[1]) annotation (Line(points
        ={{-94,278},{-108,278},{-108,282},{-130,282},{-130,250}}, color={0,127,
          255}));
  connect(boundaryExhaustAir.ports[1], eRC_AHU.port_b2) annotation (Line(points
        ={{-136,302},{-116,302},{-116,302},{-94,302}}, color={0,127,255}));
  connect(x_pTphi.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-161,
          270},{-158,270},{-158,194},{-94,194}}, color={0,0,127}));
  connect(boundaryOutsideAir1.T_in, boundaryOutsideAir.T_in) annotation (Line(
        points={{-94,186},{-154,186},{-154,246},{-152,246}}, color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1], eRC_AHU1.port_a1)
    annotation (Line(points={{-72,190},{24,190}}, color={0,127,255}));
  connect(eRC_AHU1.port_b2, boundaryExhaustAir1.ports[1]) annotation (Line(
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
  connect(htcLoads_in_kW.y[1], gain.u) annotation (Line(points={{-203.3,192},{
          -201.95,192},{-201.95,193},{-200.6,193}}, color={0,0,127}));
  connect(gain.y, limiterAHU1.u) annotation (Line(points={{-193.7,193},{-193.7,
          198},{-188.8,198}}, color={0,0,127}));
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
