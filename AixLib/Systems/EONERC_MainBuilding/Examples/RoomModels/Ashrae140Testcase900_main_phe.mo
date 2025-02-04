within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model Ashrae140Testcase900_main_phe
  TABS.Tabs tabs1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    area=48,
    thickness=0.1,
    alpha=20,
    length=50,
    dT_nom_hx=2,
    Q_nom_hx=3500,
    throttlePumpHot(Kv=2, redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
    throttlePumpCold(Kv=2, redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per))))
    annotation (Placement(transformation(extent={{54,-76},{90,-38}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare AixLib.Systems.EONERC_MainBuilding.BaseClasses.ASHRAE140_900 zoneParam,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    use_C_flow=true,
    use_moisture_balance=true,
    use_MechanicalAirExchange=false,
    use_NaturalAirExchange=true,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone" annotation (Placement(transformation(extent={{12,10},{68,68}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/ASHRAE140.mos")) "Weather data reader"
    annotation (Placement(transformation(extent={{-110,124},{-90,144}})));
  ModularAHU.GenericAHU genericAHU1(
    fanSup(init=Modelica.Blocks.Types.Init.NoInit),
    fanRet(init=Modelica.Blocks.Types.Init.NoInit),
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=129/3600*3*1.225,
    m2_flow_nominal=0.1,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm PumpInterface(pump(
              redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=50,
        dp2_nominal=1000,
        tau1=5,
        tau2=15,
        dT_nom=30,
        Q_nom=60000)),
    cooler(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=7,
        Q_nom=1500)),
    heater(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=25,
        Q_nom=4000)),
    final dynamicHX(
      dp1_nominal=150,
      dp2_nominal=150,
      dT_nom=10,
      Q_nom=2000),
    humidifier(
      dp_nominal=20,
      mWat_flow_nominal=1,
      TLiqWat_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      TLiqWat_in=288.15)) annotation (Placement(transformation(extent={{-52,-70},{8,-24}})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium = MediumAir, nPorts=1) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-64,-32})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir1(
    use_X_in=true,
    use_Xi_in=false,
    C={6.12157E-4},
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-64,-48})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1
    annotation (Placement(transformation(extent={{-84,-46},{-76,-38}})));
  Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-9,-85})));
  Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={7,-85})));
  Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={52,-160})));
  Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-22,-160})));
  Fluid.Sources.Boundary_pT bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={69,-87})));
  Fluid.Sources.Boundary_pT bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={53,-87})));
  ModularAHU.Controller.CtrAHUBasic ctrAhu(
    TFlowSet=293.15,
    usePreheater=false,
    useExternalTset=true,
    useExternalVflow=true,
    k=1000,
    Ti=60,
    VFlowSet=3*129/3600,
    ctrCo(
      k=0.015,
      Ti=200,
      Td=0,
      rpm_pump=1500),
    ctrRh(
      k=0.015,
      Ti=200,
      Td=0,
      rpm_pump=1500)) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Controller.CtrTabsQflow ctrTabsQflow(
    k=0.00007,
    Ti=200,
    rpm_pump=1500,
    ctrThrottleColdQFlow(k=0.0001)) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  BaseClasses.EnergyCalc coolEnergyCalc
    annotation (Placement(transformation(rotation=0, extent={{132,76},{152,96}})));
  BaseClasses.EnergyCalc hotEnergyCalc
    annotation (Placement(transformation(rotation=0, extent={{134,108},{154,128}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=thermalZone1.ROM.intWallRC.thermCapInt[1].T)
    annotation (Placement(transformation(extent={{114,14},{134,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.extWallRC.thermCapExt[1].T)
    annotation (Placement(transformation(extent={{114,-12},{134,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{114,-34},{134,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=tabs1.heatCapacitor.T)
    annotation (Placement(transformation(extent={{114,-198},{134,-178}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.roofRC.thermCapExt[1].T)
    annotation (Placement(transformation(extent={{114,-56},{134,-36}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{152,-108},{164,-96}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=thermalZone1.ROM.radHeatSol[1].Q_flow)
    annotation (Placement(transformation(extent={{114,-88},{134,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=thermalZone1.ROM.radHeatSol[4].Q_flow)
    annotation (Placement(transformation(extent={{114,-136},{134,-116}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=thermalZone1.ROM.radHeatSol[3].Q_flow)
    annotation (Placement(transformation(extent={{114,-118},{134,-98}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.radHeatSol[2].Q_flow)
    annotation (Placement(transformation(extent={{114,-102},{134,-82}})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(extent={{218,73},{230,85}})));
  Modelica.Blocks.Math.Add add2 annotation (Placement(transformation(extent={{218,93},{230,105}})));
  Modelica.Blocks.Math.Gain gain(k=0.001) annotation (Placement(transformation(extent={{-72,36},{-62,46}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=-tabs1.pipe.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{114,-156},{134,-136}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=tabs1.pipe.heatPort.T)
    annotation (Placement(transformation(extent={{114,-178},{134,-158}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains4(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,0.1,0,0; 10740,0,0.1,0,0;
        10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,0,0; 17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,
        0; 21600,0,0.1,0,0; 25140,0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0; 32340,0,0.1,
        0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1; 39540,1,1,1,1; 39600,0.4,0.4,1,1; 43140,
        0.4,0.4,1,1; 43200,0,0.1,0,0; 46740,0,0.1,0,0; 46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1;
        53940,0.6,0.6,1,1; 54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1; 61140,0.4,0.4,1,1; 61200,0,0.1,
        0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0; 68340,0,0.1,0,0; 68400,0,0.1,0,0; 71940,0,0.1,0,0; 72000,0,
        0.1,0,0; 75540,0,0.1,0,0; 75600,0,0.1,0,0; 79140,0,0.1,0,0; 79200,0,0.1,0,0; 82740,0,0.1,0,0; 82800,
        0,0.1,0,0; 86340,0,0.1,0,0; 86400,0,0,0,0; 89940,0,0,0,0; 90000,0,0,0,0; 93540,0,0,0,0; 93600,0,0,0,
        0; 97140,0,0,0,0; 97200,0,0,0,0; 100740,0,0,0,0; 100800,0,0,0,0; 104340,0,0,0,0; 104400,0,0,0,0;
        107940,0,0,0,0; 108000,0,0,0,0; 111540,0,0,0,0; 111600,0,0,0,0; 115140,0,0,0,0; 115200,0,0,0,0;
        118740,0,0,0,0; 118800,0,0,0,0; 122340,0,0,0,0; 122400,0,0,0,0; 125940,0,0,0,0; 126000,0,0,0,0;
        129540,0,0,0,0; 129600,0,0,0,0; 133140,0,0,0,0; 133200,0,0,0,0; 136740,0,0,0,0; 136800,0,0,0,0;
        140340,0,0,0,0; 140400,0,0,0,0; 143940,0,0,0,0; 144000,0,0,0,0; 147540,0,0,0,0; 147600,0,0,0,0;
        151140,0,0,0,0; 151200,0,0,0,0; 154740,0,0,0,0; 154800,0,0,0,0; 158340,0,0,0,0; 158400,0,0,0,0;
        161940,0,0,0,0; 162000,0,0,0,0; 165540,0,0,0,0; 165600,0,0,0,0; 169140,0,0,0,0; 169200,0,0,0,0;
        172740,0,0,0,0; 172800,0,0,0,0; 176340,0,0,0,0; 176400,0,0,0,0; 179940,0,0,0,0; 180000,0,0,0,0;
        183540,0,0,0,0; 183600,0,0,0,0; 187140,0,0,0,0; 187200,0,0,0,0; 190740,0,0,0,0; 190800,0,0,0,0;
        194340,0,0,0,0; 194400,0,0,0,0; 197940,0,0,0,0; 198000,0,0,0,0; 201540,0,0,0,0; 201600,0,0,0,0;
        205140,0,0,0,0; 205200,0,0,0,0; 208740,0,0,0,0; 208800,0,0,0,0; 212340,0,0,0,0; 212400,0,0,0,0;
        215940,0,0,0,0; 216000,0,0,0,0; 219540,0,0,0,0; 219600,0,0,0,0; 223140,0,0,0,0; 223200,0,0,0,0;
        226740,0,0,0,0; 226800,0,0,0,0; 230340,0,0,0,0; 230400,0,0,0,0; 233940,0,0,0,0; 234000,0,0,0,0;
        237540,0,0,0,0; 237600,0,0,0,0; 241140,0,0,0,0; 241200,0,0,0,0; 244740,0,0,0,0; 244800,0,0,0,0;
        248340,0,0,0,0; 248400,0,0,0,0; 251940,0,0,0,0; 252000,0,0,0,0; 255540,0,0,0,0; 255600,0,0,0,0;
        259140,0,0,0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,0,0.1,0,0; 266400,0,
        0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,0,0.1,0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0;
        277200,0,0.1,0,0; 280740,0,0.1,0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,0,
        0.1,0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,0.6,0.6,1,1; 295200,1,1,1,1;
        298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,0.4,0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,
        0,0.1,0,0; 309540,0,0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,1,1,1,1;
        316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0; 323940,0,0.1,0,0; 324000,0,0.1,0,0;
        327540,0,0.1,0,0; 327600,0,0.1,0,0; 331140,0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,
        0.1,0,0; 338340,0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0; 345540,0,0.1,0,0;
        345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0; 352740,0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,
        0.1,0,0; 356400,0,0.1,0,0; 359940,0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0;
        367140,0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0; 374340,0,0.1,0,0; 374400,0,
        0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,1; 381540,0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1;
        385200,0.4,0.4,1,1; 388740,0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,0,0;
        395940,0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,1,1,1; 403140,1,1,1,1; 403200,
        0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,0.1,0,0; 410340,0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,
        0,0; 414000,0,0.1,0,0; 417540,0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,0.1,0,0;
        424740,0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,0.1,0,0; 431940,0,0.1,0,0; 432000,0,
        0.1,0,0; 435540,0,0.1,0,0; 435600,0,0.1,0,0; 439140,0,0.1,0,0; 439200,0,0.1,0,0; 442740,0,0.1,0,0;
        442800,0,0.1,0,0; 446340,0,0.1,0,0; 446400,0,0.1,0,0; 449940,0,0.1,0,0; 450000,0,0.1,0,0; 453540,0,
        0.1,0,0; 453600,0,0.1,0,0; 457140,0,0.1,0,0; 457200,0,0.1,0,0; 460740,0,0.1,0,0; 460800,0,0.1,0,0;
        464340,0,0.1,0,0; 464400,0.6,0.6,1,1; 467940,0.6,0.6,1,1; 468000,1,1,1,1; 471540,1,1,1,1; 471600,
        0.4,0.4,1,1; 475140,0.4,0.4,1,1; 475200,0,0.1,0,0; 478740,0,0.1,0,0; 478800,0,0.1,0,0; 482340,0,0.1,
        0,0; 482400,0.6,0.6,1,1; 485940,0.6,0.6,1,1; 486000,1,1,1,1; 489540,1,1,1,1; 489600,0.4,0.4,1,1;
        493140,0.4,0.4,1,1; 493200,0,0.1,0,0; 496740,0,0.1,0,0; 496800,0,0.1,0,0; 500340,0,0.1,0,0; 500400,
        0,0.1,0,0; 503940,0,0.1,0,0; 504000,0,0.1,0,0; 507540,0,0.1,0,0; 507600,0,0.1,0,0; 511140,0,0.1,0,0;
        511200,0,0.1,0,0; 514740,0,0.1,0,0; 514800,0,0.1,0,0; 518340,0,0.1,0,0; 518400,0,0.1,0,0; 521940,0,
        0.1,0,0; 522000,0,0.1,0,0; 525540,0,0.1,0,0; 525600,0,0.1,0,0; 529140,0,0.1,0,0; 529200,0,0.1,0,0;
        532740,0,0.1,0,0; 532800,0,0.1,0,0; 536340,0,0.1,0,0; 536400,0,0.1,0,0; 539940,0,0.1,0,0; 540000,0,
        0.1,0,0; 543540,0,0.1,0,0; 543600,0,0.1,0,0; 547140,0,0.1,0,0; 547200,0,0.1,0,0; 550740,0,0.1,0,0;
        550800,0.6,0.6,1,1; 554340,0.6,0.6,1,1; 554400,1,1,1,1; 557940,1,1,1,1; 558000,0.4,0.4,1,1; 561540,
        0.4,0.4,1,1; 561600,0,0.1,0,0; 565140,0,0.1,0,0; 565200,0,0.1,0,0; 568740,0,0.1,0,0; 568800,0.6,0.6,
        1,1; 572340,0.6,0.6,1,1; 572400,1,1,1,1; 575940,1,1,1,1; 576000,0.4,0.4,1,1; 579540,0.4,0.4,1,1;
        579600,0,0.1,0,0; 583140,0,0.1,0,0; 583200,0,0.1,0,0; 586740,0,0.1,0,0; 586800,0,0.1,0,0; 590340,0,
        0.1,0,0; 590400,0,0.1,0,0; 593940,0,0.1,0,0; 594000,0,0.1,0,0; 597540,0,0.1,0,0; 597600,0,0.1,0,0;
        601140,0,0.1,0,0; 601200,0,0.1,0,0; 604740,0,0.1,0,0]) "Table with profiles for internal gains"
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-4,136})));
  BasicCarnot basicCarnot annotation (Placement(transformation(extent={{-86,-134},{-60,-108}})));
  Modelica.Blocks.Math.MultiSum multiSum1(nu=6)
    annotation (Placement(transformation(extent={{142,158},{154,170}})));
  Modelica.Blocks.Math.MultiSum multiSum2(nu=2)
    annotation (Placement(transformation(extent={{140,178},{152,190}})));
  Modelica.Blocks.Math.Gain gain1(k=0.001)
    annotation (Placement(transformation(extent={{168,178},{180,190}})));
  Modelica.Blocks.Math.Gain gain2(k=0.001)
    annotation (Placement(transformation(extent={{168,156},{178,166}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (Placement(transformation(extent=
            {{-62,102},{-28,134}}), iconTransformation(extent={{-40,90},{-20,110}})));
  BaseClasses.ZoneBus Bus annotation (Placement(transformation(extent={{18,90},{38,110}}),
        iconTransformation(extent={{18,90},{38,110}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowCold "Value of Real output" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={172,86}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={172,86})));
  Modelica.Blocks.Interfaces.RealOutput QFlowHeat "Value of Real output" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={170,118}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={170,118})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output" annotation (Placement(
        transformation(extent={{144,14},{164,34}}), iconTransformation(extent={{144,14},{164,34}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output" annotation (Placement(
        transformation(extent={{144,-12},{164,8}}), iconTransformation(extent={{144,-12},{164,8}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output" annotation (Placement(transformation(
          extent={{144,-34},{164,-14}}), iconTransformation(extent={{144,-34},{164,-14}})));
  Modelica.Blocks.Interfaces.RealOutput T_Tabs "Value of Real output" annotation (Placement(transformation(
          extent={{144,-198},{164,-178}}), iconTransformation(extent={{144,-198},{164,-178}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output" annotation (Placement(transformation(
          extent={{144,-56},{164,-36}}), iconTransformation(extent={{144,-56},{164,-36}})));
  Modelica.Blocks.Interfaces.RealOutput T_amb "Value of Real output" annotation (Placement(transformation(
          extent={{-114,126},{-134,106}}), iconTransformation(extent={{-114,126},{-134,106}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output" annotation (Placement(
        transformation(extent={{172,-112},{192,-92}}), iconTransformation(extent={{172,-112},{192,-92}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature" annotation (Placement(
        transformation(extent={{144,50},{164,70}}), iconTransformation(extent={{144,50},{164,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs "Value of Real output" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={256,79}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={256,79})));
  Modelica.Blocks.Interfaces.RealOutput Q_Ahu "Value of Real output" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={256,101}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={256,101})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs_ctr "Connector of Real output signal" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,40})));
  Modelica.Blocks.Interfaces.RealOutput Q_tabs_del "Value of Real output" annotation (Placement(
        transformation(extent={{144,-156},{164,-136}}), iconTransformation(extent={{100,-120},{120,-100}})));
  Modelica.Blocks.Interfaces.RealOutput T_Tabs_Pipe "Value of Real output" annotation (Placement(
        transformation(extent={{144,-178},{164,-158}}), iconTransformation(extent={{100,-158},{120,-138}})));
  Modelica.Blocks.Interfaces.RealOutput P_HP annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-79,-161}), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-79,-161})));
  Modelica.Blocks.Interfaces.RealOutput P_Pumps annotation (Placement(transformation(extent={{188,154},{202,
            168}}), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={1,-161})));
  Modelica.Blocks.Interfaces.RealOutput P_Fans annotation (Placement(transformation(extent={{188,176},{202,
            190}}), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-41,-161})));
    replaceable package MediumWater =
                          Media.Water
    annotation (choicesAllMatching=true);
    replaceable package MediumAir =
                        Media.Air (      extraPropertiesNames={"C_flow"})
    annotation (choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput T_sup_in(final unit="K", displayUnit="degC") annotation (Placement(
        transformation(rotation=0, extent={{-170,-111},{-150,-85}}), iconTransformation(extent={{-170,-111},
            {-150,-85}})));
  Modelica.Blocks.Interfaces.RealInput T_sup_ahu_set annotation (Placement(transformation(rotation=0,
          extent={{-170,7},{-150,33}}), iconTransformation(extent={{-170,7},{-150,33}})));
  Modelica.Blocks.Interfaces.RealInput VflowSet annotation (Placement(transformation(rotation=0, extent={{
            -170,-53},{-150,-27}}), iconTransformation(extent={{-170,-53},{-150,-27}})));
  Modelica.Blocks.Interfaces.RealInput QFlowSet annotation (Placement(transformation(rotation=0, extent={{
            -170,67},{-150,93}}), iconTransformation(extent={{-170,67},{-150,93}})));
equation
  connect(weaDat.weaBus,thermalZone1.weaBus) annotation (Line(
      points={{-90,134},{-46,134},{-46,96},{-22,96},{-22,56.4},{12,56.4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-90,134},{-45,134},{-45,118}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(tabs1.heatPort,thermalZone1.intGainsConv) annotation (Line(points={{72,-36.1},{72,6},{76,6},{76,
          40.16},{68.56,40.16}},                                    color={191,
          0,0}));
  connect(genericAHU1.port_b1,thermalZone1.ports[1]) annotation (Line(points={{8.27273,-49.0909},{8.27273,
          -50},{36,-50},{36,-12},{48,-12},{48,18.12},{36.71,18.12}},
                                                                 color={0,127,
          255}));
  connect(genericAHU1.port_a2,thermalZone1.ports[2]) annotation (Line(points={{8.27273,-32.3636},{32,
          -32.3636},{32,18.12},{43.29,18.12}},                 color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU1.port_b2) annotation (Line(
        points={{-60,-32},{-57,-32},{-57,-32.3636},{-52,-32.3636}},
                                                             color={0,127,255}));
  connect(thermalZone1.TAir,Bus. TZoneMea) annotation (Line(points={{70.8,62.2},{78,62.2},{78,74},{28.05,74},
          {28.05,100.05}},                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryOutsideAir1.T_in,weaBus. TDryBul) annotation (Line(points={{-68.8,-49.6},{-100,-49.6},{
          -100,118},{-46,118},{-46,118.08},{-44.915,118.08}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.X,boundaryOutsideAir1. X_in) annotation (Line(points={{-75.6,-42},{-72,-42},{-72,-46.4},
          {-68.8,-46.4}},                          color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1],genericAHU1. port_a1) annotation (Line(
        points={{-60,-48},{-60,-49.0909},{-52,-49.0909}}, color={0,127,255}));
  connect(x_pTphi1.T,weaBus. TDryBul) annotation (Line(points={{-84.8,-42},{-100,-42},{-100,118},{-44,118},
          {-44,118.08},{-44.915,118.08}},
                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(x_pTphi1.phi,weaBus. relHum) annotation (Line(points={{-84.8,-44.4},{-88,-44.4},{-88,112},{-46,
          112},{-46,116},{-44.915,116},{-44.915,118.08}},
                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.p_in,weaBus. pAtm) annotation (Line(points={{-84.8,-39.6},{-84,-39.6},{-84,-40},{-88,-40},
          {-88,112},{-44.915,112},{-44.915,118.08}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouWaterhot.ports[1],genericAHU1. port_a5) annotation (Line(points={{-9,-80},{-9,-76},{-11.0909,
          -76},{-11.0909,-70}},                     color={0,127,255}));
  connect(bouWaterhot1.ports[1],genericAHU1. port_b5) annotation (Line(points={{7,-80},{6,-80},{6,-74},{
          -5.90909,-74},{-5.90909,-70}},                               color={0,
          127,255}));
  connect(bouWatercold1.ports[1],genericAHU1. port_a4) annotation (Line(points={{-23,-150},{-23,-148},{-22,
          -148},{-22,-70}},              color={0,127,255}));
  connect(bouWatercold.ports[1],tabs1. port_b2) annotation (Line(points={{51,-150},{51,-126},{86,-126},{86,
          -74},{86.4,-74},{86.4,-75.62}},
                                color={0,127,255}));
  connect(bouWatercold1.ports[2],tabs1. port_a2) annotation (Line(points={{-21,-150},{-21,-108},{78,-108},{
          78,-98},{79.2,-98},{79.2,-76}},       color={0,127,255}));
  connect(genericAHU1.port_b4,bouWatercold. ports[2]) annotation (Line(points={{-16.5455,-70},{-16.5455,
          -126},{52,-126},{52,-138},{53,-138},{53,-150}},                color={
          0,127,255}));
  connect(bouWaterhot2.ports[1],tabs1. port_b1)
    annotation (Line(points={{69,-82},{64.8,-82},{64.8,-76}},
                                                          color={0,127,255}));
  connect(bouWaterhot3.ports[1],tabs1. port_a1)
    annotation (Line(points={{53,-82},{53,-80},{57.6,-80},{57.6,-76}},
                                                          color={0,127,255}));
  connect(ctrTabsQflow.tabsBus,Bus. tabsBus) annotation (Line(
      points={{-40,70},{-22,70},{-22,74},{28.05,74},{28.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs1.tabsBus,Bus. tabsBus) annotation (Line(
      points={{53.82,-56.81},{22,-56.81},{22,-12},{-22,-12},{-22,74},{28.05,74},{28.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericAHU1.genericAHUBus,Bus. ahuBus) annotation (Line(
      points={{-22,-23.7909},{-22,74},{28.05,74},{28.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAhu.genericAHUBus,genericAHU1. genericAHUBus) annotation (Line(
      points={{-40,10.1},{-22,10.1},{-22,-23.7909}},
      color={255,204,51},
      thickness=0.5));
  connect(coolEnergyCalc.vFlow2,Bus. tabsBus.coldThrottleBus.VFlowInMea)
    annotation (Line(points={{137,75},{112,75},{112,100},{28.05,100},{28.05,100.05}},
                    color={0,0,127}));
  connect(coolEnergyCalc.Tin2,Bus. tabsBus.coldThrottleBus.TFwrdInMea)
    annotation (Line(points={{131,83},{112,83},{112,100.05},{28.05,100.05}},
                                                                 color={0,0,127}));
  connect(coolEnergyCalc.Tout2,Bus. tabsBus.coldThrottleBus.TRtrnOutMea)
    annotation (Line(points={{131,79},{112,79},{112,100.05},{28.05,100.05}},
                          color={0,0,127}));
  connect(coolEnergyCalc.vFlow1,Bus. ahuBus.coolerBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{137,97},{136,97},{136,100},{28.05,100},{28.05,100.05}},
                                                                 color={0,0,127}));
  connect(coolEnergyCalc.Tin1,Bus. ahuBus.coolerBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{131,93},{112,93},{112,100.05},{28.05,100.05}},
                                    color={0,0,127}));
  connect(coolEnergyCalc.Tout1,Bus. ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{131,89},{112,89},{112,100.05},{28.05,100.05}},
                                                                 color={0,0,127}));
  connect(coolEnergyCalc.y1,QFlowCold)  annotation (Line(points={{153,86},{172,86}},
                                       color={0,0,127}));
  connect(hotEnergyCalc.vFlow2,Bus. tabsBus.hotThrottleBus.VFlowInMea)
    annotation (Line(points={{139,107},{92,107},{92,100},{28.05,100},{28.05,100.05}},
                                                                          color=
         {0,0,127}));
  connect(hotEnergyCalc.Tout2,Bus. tabsBus.hotThrottleBus.TRtrnOutMea)
    annotation (Line(points={{133,111},{118,111},{118,108},{92,108},{92,100},{28.05,100},{28.05,100.05}},
                                                                 color={0,0,127}));
  connect(hotEnergyCalc.Tin2,Bus. tabsBus.hotThrottleBus.TFwrdInMea)
    annotation (Line(points={{133,115},{118,115},{118,108},{92,108},{92,100},{28.05,100},{28.05,100.05}},
                                                                 color={0,0,127}));
  connect(hotEnergyCalc.vFlow1,Bus. ahuBus.heaterBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{139,129},{118,129},{118,108},{92,108},{92,100},{28.05,100},{28.05,100.05}},
        color={0,0,127}));
  connect(hotEnergyCalc.y1,QFlowHeat)
    annotation (Line(points={{155,118},{170,118}},
                                                color={0,0,127}));
  connect(realExpression.y,T_IntWall)
    annotation (Line(points={{135,24},{154,24}}, color={0,0,127}));
  connect(realExpression1.y,T_ExtWall)
    annotation (Line(points={{135,-2},{154,-2}}, color={0,0,127}));
  connect(realExpression2.y,T_Win)
    annotation (Line(points={{135,-24},{154,-24}},
                                                 color={0,0,127}));
  connect(realExpression3.y,T_Tabs)
    annotation (Line(points={{135,-188},{154,-188}},
                                                   color={0,0,127}));
  connect(realExpression4.y,T_Roof)
    annotation (Line(points={{135,-46},{154,-46}}, color={0,0,127}));
  connect(T_amb,weaBus. TDryBul) annotation (Line(points={{-124,116},{-120,116},{-120,118.08},{-44.915,
          118.08}},                               color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression6.y,multiSum. u[1]) annotation (Line(points={{135,-78},{144,-78},{144,-102},{152,
          -102},{152,-103.575}},                  color={0,0,127}));
  connect(realExpression9.y,multiSum. u[2]) annotation (Line(points={{135,-92},{144,-92},{144,-102.525},{
          152,-102.525}},                         color={0,0,127}));
  connect(realExpression8.y,multiSum. u[3]) annotation (Line(points={{135,-108},{144,-108},{144,-102},{152,
          -102},{152,-101.475}},     color={0,0,127}));
  connect(realExpression7.y,multiSum. u[4]) annotation (Line(points={{135,-126},{144,-126},{144,-102},{152,
          -102},{152,-100.425}},                color={0,0,127}));
  connect(multiSum.y,solar_radiation)  annotation (Line(points={{165.02,-102},{182,-102}},
                                         color={0,0,127}));
  connect(thermalZone1.TAir,TAirRoom)  annotation (Line(points={{70.8,62.2},{70,62.2},{70,62},{144,62},{144,
          60},{154,60}},                                          color={0,0,
          127}));
  connect(coolEnergyCalc.y3,add1. u2) annotation (Line(points={{153,77},{153,75.4},{216.8,75.4}},
                                                    color={0,0,127}));
  connect(coolEnergyCalc.y2,add2. u2) annotation (Line(points={{153,95},{184.9,95},{184.9,95.4},{216.8,95.4}},
                                             color={0,0,127}));
  connect(hotEnergyCalc.y3,add1. u1) annotation (Line(points={{155,109},{196,109},{196,82.6},{216.8,82.6}},
                                   color={0,0,127}));
  connect(hotEnergyCalc.y2,add2. u1) annotation (Line(points={{155,127},{206,127},{206,102.6},{216.8,102.6}},
                                            color={0,0,127}));
  connect(Q_Ahu,add2. y)
    annotation (Line(points={{256,101},{250,101},{250,99},{230.6,99}},
                                                     color={0,0,127}));
  connect(Q_Tabs,add1. y)
    annotation (Line(points={{256,79},{230.6,79}},   color={0,0,127}));
  connect(ctrTabsQflow.Q_flow1,gain. u) annotation (Line(points={{-39.2,79},{-34,79},{-34,54},{-74,54},{-74,
          41},{-73,41}},                          color={0,0,127}));
  connect(gain.y,Q_Tabs_ctr)
    annotation (Line(points={{-61.5,41},{-61.5,40},{-48,40}},
                                                 color={0,0,127}));
  connect(hotEnergyCalc.Tin1,Bus. ahuBus.heaterBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{133,125},{118,125},{118,108},{92,108},{92,100},{28.05,100},{28.05,100.05}},
                                                              color={0,0,127}));
  connect(hotEnergyCalc.Tout1,Bus. ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{133,121},{118,121},{118,108},{92,108},{92,100},{28.05,100},{28.05,100.05}},
                                                              color={0,0,127}));
  connect(realExpression5.y,Q_tabs_del)
    annotation (Line(points={{135,-146},{154,-146}}, color={0,0,127}));
  connect(realExpression10.y,T_Tabs_Pipe)
    annotation (Line(points={{135,-168},{154,-168}}, color={0,0,127}));
  connect(internalGains4.y,thermalZone1. intGains) annotation (Line(points={{-4,128.3},{-4,4},{62.4,4},{
          62.4,14.64}},                               color={0,0,127}));
  connect(basicCarnot.TEvaAct,weaBus. TDryBul) annotation (Line(points={{-88.6,-124.9},{-94,-124.9},{-94,
          -124},{-100,-124},{-100,118},{-50,118},{-50,118.08},{-44.915,118.08}},
                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hotEnergyCalc.y1,basicCarnot. QCon_flow_internal) annotation (Line(points={{155,118},{192,118},{
          192,134},{8,134},{8,-18},{-56,-18},{-56,-105.4},{-72.74,-105.4}},
                                                                color={0,0,127}));
  connect(basicCarnot.P, P_HP)
    annotation (Line(points={{-60,-121},{-54,-121},{-54,-148},{-79,-148},{-79,-161}}, color={0,0,127}));
  connect(Bus.tabsBus.pumpBus.pumpBus.PelMea, multiSum1.u[1]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,162.25}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.tabsBus.hotThrottleBus.pumpBus.PelMea, multiSum1.u[2]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,162.95}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.tabsBus.coldThrottleBus.pumpBus.PelMea, multiSum1.u[3]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,163.65}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.ahuBus.preheaterBus.hydraulicBus.pumpBus.PelMea, multiSum1.u[4]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,164.35}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.ahuBus.coolerBus.hydraulicBus.pumpBus.PelMea, multiSum1.u[5]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,165.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.ahuBus.heaterBus.hydraulicBus.pumpBus.PelMea, multiSum1.u[6]) annotation (Line(
      points={{28.05,100.05},{28.05,162},{142,162},{142,165.75}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.ahuBus.powerFanSupMea, multiSum2.u[1]) annotation (Line(
      points={{28.05,100.05},{28.05,184},{140,184},{140,182.95}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Bus.ahuBus.powerFanRetMea, multiSum2.u[2]) annotation (Line(
      points={{28.05,100.05},{28.05,184},{140,184},{140,185.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiSum2.y, gain1.u) annotation (Line(points={{153.02,184},{166.8,184}}, color={0,0,127}));
  connect(gain1.y, P_Fans)
    annotation (Line(points={{180.6,184},{187.8,184},{187.8,183},{195,183}}, color={0,0,127}));
  connect(multiSum1.y, gain2.u)
    annotation (Line(points={{155.02,164},{155.02,161},{167,161}}, color={0,0,127}));
  connect(gain2.y, P_Pumps) annotation (Line(points={{178.5,161},{195,161}}, color={0,0,127}));
  connect(T_sup_in, basicCarnot.TConAct)
    annotation (Line(points={{-160,-98},{-120,-98},{-120,-114.24},{-88.6,-114.24}}, color={0,0,127}));
  connect(T_sup_in, bouWaterhot.T_in)
    annotation (Line(points={{-160,-98},{-11,-98},{-11,-91}}, color={0,0,127}));
  connect(T_sup_in, bouWaterhot3.T_in)
    annotation (Line(points={{-160,-98},{50,-98},{50,-93},{51,-93}}, color={0,0,127}));
  connect(T_sup_ahu_set, ctrAhu.Tset)
    annotation (Line(points={{-160,20},{-120,20},{-120,10},{-62,10}}, color={0,0,127}));
  connect(VflowSet, ctrAhu.VflowSet)
    annotation (Line(points={{-160,-40},{-120,-40},{-120,6},{-68,6},{-68,5},{-62,5}}, color={0,0,127}));
  connect(QFlowSet, ctrTabsQflow.QFlowSet) annotation (Line(points={{-160,80},{-120,80},{-120,70},{-92,70},
          {-92,70.1},{-60.3,70.1}}, color={0,0,127}));
  connect(T_Tabs_Pipe, T_Tabs_Pipe) annotation (Line(points={{154,-168},{154,-168}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-160},{100,100}})), Icon(coordinateSystem(extent={{
            -100,-160},{100,100}})));
end Ashrae140Testcase900_main_phe;
