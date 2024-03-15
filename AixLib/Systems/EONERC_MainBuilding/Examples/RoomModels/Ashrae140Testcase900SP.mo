within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model Ashrae140Testcase900SP
  "Model of a ERC-Thermal Zone Including CCA and AHU"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealInput QFlowTabsSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TAhuSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  TABS.Tabs
       tabs1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.1,
    area=48,
    thickness=0.1,
    alpha=20,
    length=50,
    throttlePumpHot(Kv=2, redeclare
        HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
    throttlePumpCold(Kv=10, redeclare
        HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))))
    annotation (Placement(transformation(extent={{86,-102},{106,-80}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare AixLib.Systems.EONERC_MainBuilding.BaseClasses.ASHRAE140_900 zoneParam,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{10,-62},{66,-4}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/ASHRAE140.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-92,18},{-72,38}})));

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
        origin={61,-86})));

  ModularAHU.GenericAHU genericAHU1(
    fanSup(init=Modelica.Blocks.Types.Init.NoInit),
    fanRet(init=Modelica.Blocks.Types.Init.NoInit),
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=129/3600*3,
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
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=10,
        Q_nom=2000)),
    heater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=20,
        Q_nom=2000)),
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
      TLiqWat_in=288.15))
    annotation (Placement(transformation(extent={{-28,-92},{8,-66}})));

  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
        MediumAir, nPorts=1)
                          annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-54,-70})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir1(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-54,-80})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1
    annotation (Placement(transformation(extent={{-70,-68},{-62,-60}})));
  Fluid.Sources.Boundary_pT        bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={3,-117})));
  Fluid.Sources.Boundary_pT        bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={21,-113})));
  Fluid.Sources.Boundary_pT        bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={54,-150})));
  Fluid.Sources.Boundary_pT        bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={30,-150})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={81,-119})));
  Fluid.Sources.Boundary_pT        bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={63,-113})));
  ModularAHU.Controller.CtrAHUBasic ctrAhu(
    useExternalTset=true,
    k=1000,
    Ti=60,
    VFlowSet=3*129/3600,
    ctrCo(
      k=0.03,
      Ti=120,
      rpm_pump=3000),
    ctrRh(
      k=0.03,
      Ti=120,
      rpm_pump=3000))
    annotation (Placement(transformation(extent={{-58,-50},{-38,-30}})));
  Controller.CtrTabsQflow ctrTabsQflow(
    ctrThrottleHotQFlow(
      k=0.00003,
      Ti=280,
      rpm_pump=3000),
    ctrThrottleColdQFlow(
      k=0.00003,
      Ti=280,
      rpm_pump=3000),
    ctrPump(rpm_pump=3000))
    annotation (Placement(transformation(extent={{-58,-28},{-38,-8}})));
  BaseClasses.EnergyCalc coolEnergyCalc annotation (Placement(transformation(
          rotation=0, extent={{60,50},{80,70}})));
  BaseClasses.EnergyCalc hotEnergyCalc annotation (Placement(transformation(
          rotation=0, extent={{60,80},{80,100}})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-60,-18},{-26,14}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  BaseClasses.ZoneBus Bus
    annotation (Placement(transformation(extent={{-2,30},{18,50}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowCold "Value of Real output"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowHeat "Value of Real output"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=thermalZone1.ROM.intWallRC.thermCapInt[
        1].T) annotation (Placement(transformation(extent={{146,36},{166,56}})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output"
    annotation (Placement(transformation(extent={{184,36},{204,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.extWallRC.thermCapExt[
        1].T) annotation (Placement(transformation(extent={{144,12},{164,32}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output"
    annotation (Placement(transformation(extent={{182,12},{202,32}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{146,-10},{166,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output"
    annotation (Placement(transformation(extent={{184,-10},{204,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=tabs1.heatCapacitor.T)
    annotation (Placement(transformation(extent={{146,-34},{166,-14}})));
  Modelica.Blocks.Interfaces.RealOutput T_Tabs "Value of Real output"
    annotation (Placement(transformation(extent={{184,-34},{204,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.roofRC.thermCapExt[
        1].T)
    annotation (Placement(transformation(extent={{148,-54},{168,-34}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output"
    annotation (Placement(transformation(extent={{186,-54},{206,-34}})));
  Modelica.Blocks.Interfaces.RealOutput T_amb "Value of Real output"
    annotation (Placement(transformation(extent={{186,-78},{206,-58}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs "Value of Real output"
    annotation (Placement(transformation(extent={{132,116},{152,136}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{186,-102},{206,-82}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{152,-92},{164,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{112,-88},{132,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{112,-102},{132,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{112,-118},{132,-98}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{114,-134},{134,-114}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Ahu "Value of Real output"
    annotation (Placement(transformation(extent={{132,152},{152,172}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{102,120},{114,132}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{102,156},{114,168}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs_ctr
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{2,134},{22,154}})));
  Modelica.Blocks.Math.Gain gain(k=0.001)
    annotation (Placement(transformation(extent={{-24,134},{-4,154}})));
  Modelica.Blocks.Interfaces.RealOutput TSupMea "Value of Real output"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{106,40},{126,60}})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-72,28},{8,28},{8,-15.6},{10,-15.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-72,28},{-43,28},{-43,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(internalGains.y,thermalZone1. intGains) annotation (Line(points={{61,
          -78.3},{60,-78.3},{60,-72},{60.4,-72},{60.4,-57.36}},
                                            color={0,0,127}));
  connect(tabs1.heatPort,thermalZone1. intGainsConv) annotation (Line(points={{96,
          -78.9},{96,-31.84},{66.56,-31.84}},                       color={191,
          0,0}));
  connect(genericAHU1.port_b1,thermalZone1. ports[1]) annotation (Line(points={{8.16364,
          -80.1818},{36,-80.1818},{36,-53.88},{34.71,-53.88}},   color={0,127,
          255}));
  connect(genericAHU1.port_a2,thermalZone1. ports[2]) annotation (Line(points={{8.16364,
          -70.7273},{46,-70.7273},{46,-53.88},{41.29,-53.88}}, color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU1. port_b2) annotation (Line(
        points={{-50,-70},{-50,-70.7273},{-28,-70.7273}},    color={0,127,255}));
  connect(thermalZone1.TAir,Bus. TZoneMea) annotation (Line(points={{68.8,-9.8},
          {86.4,-9.8},{86.4,40.05},{8.05,40.05}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryOutsideAir1.T_in,weaBus. TDryBul) annotation (Line(points={{-58.8,
          -81.6},{-86,-81.6},{-86,-2},{-43,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.X,boundaryOutsideAir1. X_in) annotation (Line(points={{-61.6,
          -64},{-60,-64},{-60,-78.4},{-58.8,-78.4}},
                                                   color={0,0,127}));
  connect(x_pTphi1.X,boundaryOutsideAir1. X_in) annotation (Line(points={{-61.6,
          -64},{-60,-64},{-60,-78.4},{-58.8,-78.4}},
                                                   color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1],genericAHU1. port_a1) annotation (Line(
        points={{-50,-80},{-50,-80.1818},{-28,-80.1818}}, color={0,127,255}));
  connect(x_pTphi1.T,weaBus. TDryBul) annotation (Line(points={{-70.8,-64},{-86,
          -64},{-86,-2},{-43,-2}},
                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(x_pTphi1.phi,weaBus. relHum) annotation (Line(points={{-70.8,-66.4},{
          -70.8,-66},{-86,-66},{-86,-2},{-43,-2}},
                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.p_in,weaBus. pAtm) annotation (Line(points={{-70.8,-61.6},{
          -70,-61.6},{-70,-62},{-86,-62},{-86,-2},{-43,-2}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouWaterhot.ports[1],genericAHU1. port_a5) annotation (Line(points={{3,-112},
          {-4,-112},{-4,-92},{-3.45455,-92}},       color={0,127,255}));
  connect(bouWaterhot1.ports[1],genericAHU1. port_b5) annotation (Line(points={{21,-108},
          {20,-108},{20,-102},{0,-102},{0,-92},{-0.34545,-92}},        color={0,
          127,255}));
  connect(bouWatercold1.ports[1],genericAHU1. port_a4) annotation (Line(points={{29,-140},
          {-10,-140},{-10,-92}},         color={0,127,255}));
  connect(bouWatercold.ports[1],tabs1. port_b2) annotation (Line(points={{53,-140},
          {104,-140},{104,-101.78}},
                                color={0,127,255}));
  connect(bouWatercold1.ports[2],tabs1. port_a2) annotation (Line(points={{31,-140},
          {30,-140},{30,-132},{100,-132},{100,-102}},
                                                color={0,127,255}));
  connect(genericAHU1.port_b4,bouWatercold. ports[2]) annotation (Line(points={{
          -6.72727,-92},{-6,-92},{-6,-134},{54,-134},{54,-140},{55,-140}},
                                                                         color={
          0,127,255}));
  connect(bouWaterhot2.ports[1],tabs1. port_b1)
    annotation (Line(points={{81,-114},{92,-114},{92,-102}},
                                                          color={0,127,255}));
  connect(bouWaterhot3.ports[1],tabs1. port_a1)
    annotation (Line(points={{63,-108},{88,-108},{88,-102}},
                                                          color={0,127,255}));
  connect(ctrTabsQflow.tabsBus,Bus. tabsBus) annotation (Line(
      points={{-38,-18},{-10,-18},{-10,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs1.tabsBus,Bus. tabsBus) annotation (Line(
      points={{85.9,-90.89},{78,-90.89},{78,40},{44,40},{44,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericAHU1.genericAHUBus,Bus. ahuBus) annotation (Line(
      points={{-10,-65.8818},{-10,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAhu.genericAHUBus,genericAHU1. genericAHUBus) annotation (Line(
      points={{-38,-39.9},{-20,-39.9},{-20,-40},{-10,-40},{-10,-65.8818}},
      color={255,204,51},
      thickness=0.5));
  connect(coolEnergyCalc.vFlow2,Bus. tabsBus.coldThrottleBus.VFlowInMea)
    annotation (Line(points={{65,49},{65,40},{8.05,40},{8.05,40.05}},
                    color={0,0,127}));
  connect(coolEnergyCalc.Tin2,Bus. tabsBus.coldThrottleBus.TFwrdInMea)
    annotation (Line(points={{59,57},{8.05,57},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.Tout2,Bus. tabsBus.coldThrottleBus.TRtrnOutMea)
    annotation (Line(points={{59,53},{52,53},{52,40},{8.05,40},{8.05,40.05}},
                          color={0,0,127}));
  connect(coolEnergyCalc.vFlow1,Bus. ahuBus.coolerBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{65,71},{8.05,71},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.Tin1,Bus. ahuBus.coolerBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{59,67},{59,66},{8.05,66},{8.05,40.05}},
                                    color={0,0,127}));
  connect(coolEnergyCalc.Tout1,Bus. ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{59,63},{8.05,63},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.y1,QFlowCold)  annotation (Line(points={{81,60},{110,
          60}},                        color={0,0,127}));
  connect(hotEnergyCalc.vFlow2,Bus. tabsBus.hotThrottleBus.VFlowInMea)
    annotation (Line(points={{65,79},{66,79},{66,76},{8,76},{8,58},{8.05,58},{
          8.05,40.05}},                                                   color=
         {0,0,127}));
  connect(hotEnergyCalc.Tout2,Bus. tabsBus.hotThrottleBus.TRtrnOutMea)
    annotation (Line(points={{59,83},{8.05,83},{8.05,40.05}},    color={0,0,127}));
  connect(hotEnergyCalc.Tin2,Bus. tabsBus.hotThrottleBus.TFwrdInMea)
    annotation (Line(points={{59,87},{8.05,87},{8.05,40.05}},    color={0,0,127}));
  connect(hotEnergyCalc.vFlow1,Bus. ahuBus.heaterBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{65,101},{66,101},{66,102},{8.05,102},{8.05,40.05}},
                                                                          color=
         {0,0,127}));
  connect(hotEnergyCalc.y1, QFlowHeat)
    annotation (Line(points={{81,90},{110,90}}, color={0,0,127}));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{68.8,-9.8},{
          68.8,-10},{94,-10},{94,-20},{110,-20}}, color={0,0,127}));
  connect(ctrTabsQflow.QFlowSet, QFlowTabsSet) annotation (Line(points={{-58.3,
          -17.9},{-58.3,-16},{-94,-16},{-94,0},{-120,0}}, color={0,0,127}));
  connect(ctrAhu.Tset, TAhuSet)
    annotation (Line(points={{-60,-40},{-120,-40}}, color={0,0,127}));
  connect(realExpression.y, T_IntWall)
    annotation (Line(points={{167,46},{194,46}}, color={0,0,127}));
  connect(realExpression1.y, T_ExtWall)
    annotation (Line(points={{165,22},{192,22}}, color={0,0,127}));
  connect(realExpression2.y, T_Win)
    annotation (Line(points={{167,0},{194,0}}, color={0,0,127}));
  connect(realExpression3.y, T_Tabs)
    annotation (Line(points={{167,-24},{194,-24}}, color={0,0,127}));
  connect(realExpression4.y, T_Roof)
    annotation (Line(points={{169,-44},{196,-44}}, color={0,0,127}));
  connect(T_amb, weaBus.TDryBul) annotation (Line(points={{196,-68},{74,-68},{74,
          0},{-22,0},{-22,18},{-43,18},{-43,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiSum.y, solar_radiation) annotation (Line(points={{165.02,-86},{
          178,-86},{178,-92},{196,-92}}, color={0,0,127}));
  connect(realExpression6.y, multiSum.u[1]) annotation (Line(points={{133,-78},
          {136,-78},{136,-87.575},{152,-87.575}}, color={0,0,127}));
  connect(realExpression9.y, multiSum.u[2]) annotation (Line(points={{133,-92},
          {136,-92},{136,-86.525},{152,-86.525}}, color={0,0,127}));
  connect(realExpression8.y, multiSum.u[3]) annotation (Line(points={{133,-108},
          {152,-108},{152,-85.475}}, color={0,0,127}));
  connect(realExpression7.y, multiSum.u[4]) annotation (Line(points={{135,-124},
          {135,-105},{152,-105},{152,-84.425}}, color={0,0,127}));
  connect(hotEnergyCalc.Tin1, Bus.ahuBus.heaterBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{59,97},{8.05,97},{8.05,40.05}}, color={0,0,127}));
  connect(hotEnergyCalc.Tout1, Bus.ahuBus.heaterBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{59,93},{8.05,93},{8.05,40.05}}, color={0,0,127}));
  connect(Q_Tabs, add1.y)
    annotation (Line(points={{142,126},{114.6,126}}, color={0,0,127}));
  connect(Q_Ahu, add2.y)
    annotation (Line(points={{142,162},{114.6,162}}, color={0,0,127}));
  connect(hotEnergyCalc.y2, add2.u1) annotation (Line(points={{81,99},{82,99},{
          82,164},{100.8,164},{100.8,165.6}}, color={0,0,127}));
  connect(coolEnergyCalc.y2, add2.u2) annotation (Line(points={{81,69},{90,69},
          {90,158},{100.8,158},{100.8,158.4}}, color={0,0,127}));
  connect(hotEnergyCalc.y3, add1.u1) annotation (Line(points={{81,81},{94,81},{
          94,129.6},{100.8,129.6}}, color={0,0,127}));
  connect(coolEnergyCalc.y3, add1.u2) annotation (Line(points={{81,51},{80,51},
          {80,46},{90,46},{90,74},{96,74},{96,122.4},{100.8,122.4}}, color={0,0,
          127}));
  connect(ctrTabsQflow.Q_flow1, gain.u) annotation (Line(points={{-37.2,-9},{
          -14,-9},{-14,74},{-26,74},{-26,144}}, color={0,0,127}));
  connect(gain.y, Q_Tabs_ctr)
    annotation (Line(points={{-3,144},{12,144}}, color={0,0,127}));
  connect(TSupMea, Bus.ahuBus.TSupMea) annotation (Line(points={{110,40},{62,40},
          {62,40.05},{8.05,40.05}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Ashrae140Testcase900SP;
