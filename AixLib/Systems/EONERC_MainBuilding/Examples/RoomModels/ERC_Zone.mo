within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model ERC_Zone "Model of a ERC-Thermal Zone Including CCA and AHU"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);
  AixLib.Systems.EONERC_MainBuilding.Tabs
       tabs1(
    redeclare package Medium = MediumWater,
    area=60*60,
    thickness=0.05,
    alpha=20)
    annotation (Placement(transformation(extent={{78,-42},{98,-20}})));
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
    annotation (Placement(transformation(extent={{2,-2},{58,56}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,0.1,
        0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,0,0;
        17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0; 25140,
        0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0; 32340,0,0.1,
        0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1; 39540,1,1,1,1;
        39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0; 46740,0,0.1,0,0;
        46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1; 53940,0.6,0.6,1,1;
        54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1; 61140,0.4,0.4,1,1; 61200,
        0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0; 68340,0,0.1,0,0; 68400,0,0.1,
        0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0; 75540,0,0.1,0,0; 75600,0,0.1,0,0;
        79140,0,0.1,0,0; 79200,0,0.1,0,0; 82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,
        0,0.1,0,0; 86400,0,0.1,0,0; 89940,0,0.1,0,0; 90000,0,0.1,0,0; 93540,0,0.1,
        0,0; 93600,0,0.1,0,0; 97140,0,0.1,0,0; 97200,0,0.1,0,0; 100740,0,0.1,0,0;
        100800,0,0.1,0,0; 104340,0,0.1,0,0; 104400,0,0.1,0,0; 107940,0,0.1,0,0;
        108000,0,0.1,0,0; 111540,0,0.1,0,0; 111600,0,0.1,0,0; 115140,0,0.1,0,0;
        115200,0,0.1,0,0; 118740,0,0.1,0,0; 118800,0.6,0.6,1,1; 122340,0.6,0.6,1,
        1; 122400,1,1,1,1; 125940,1,1,1,1; 126000,0.4,0.4,1,1; 129540,0.4,0.4,1,
        1; 129600,0,0.1,0,0; 133140,0,0.1,0,0; 133200,0,0.1,0,0; 136740,0,0.1,0,
        0; 136800,0.6,0.6,1,1; 140340,0.6,0.6,1,1; 140400,1,1,1,1; 143940,1,1,1,
        1; 144000,0.4,0.4,1,1; 147540,0.4,0.4,1,1; 147600,0,0.1,0,0; 151140,0,0.1,
        0,0; 151200,0,0.1,0,0; 154740,0,0.1,0,0; 154800,0,0.1,0,0; 158340,0,0.1,
        0,0; 158400,0,0.1,0,0; 161940,0,0.1,0,0; 162000,0,0.1,0,0; 165540,0,0.1,
        0,0; 165600,0,0.1,0,0; 169140,0,0.1,0,0; 169200,0,0.1,0,0; 172740,0,0.1,
        0,0; 172800,0,0.1,0,0; 176340,0,0.1,0,0; 176400,0,0.1,0,0; 179940,0,0.1,
        0,0; 180000,0,0.1,0,0; 183540,0,0.1,0,0; 183600,0,0.1,0,0; 187140,0,0.1,
        0,0; 187200,0,0.1,0,0; 190740,0,0.1,0,0; 190800,0,0.1,0,0; 194340,0,0.1,
        0,0; 194400,0,0.1,0,0; 197940,0,0.1,0,0; 198000,0,0.1,0,0; 201540,0,0.1,
        0,0; 201600,0,0.1,0,0; 205140,0,0.1,0,0; 205200,0.6,0.6,1,1; 208740,0.6,
        0.6,1,1; 208800,1,1,1,1; 212340,1,1,1,1; 212400,0.4,0.4,1,1; 215940,0.4,
        0.4,1,1; 216000,0,0.1,0,0; 219540,0,0.1,0,0; 219600,0,0.1,0,0; 223140,0,
        0.1,0,0; 223200,0.6,0.6,1,1; 226740,0.6,0.6,1,1; 226800,1,1,1,1; 230340,
        1,1,1,1; 230400,0.4,0.4,1,1; 233940,0.4,0.4,1,1; 234000,0,0.1,0,0; 237540,
        0,0.1,0,0; 237600,0,0.1,0,0; 241140,0,0.1,0,0; 241200,0,0.1,0,0; 244740,
        0,0.1,0,0; 244800,0,0.1,0,0; 248340,0,0.1,0,0; 248400,0,0.1,0,0; 251940,
        0,0.1,0,0; 252000,0,0.1,0,0; 255540,0,0.1,0,0; 255600,0,0.1,0,0; 259140,
        0,0.1,0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,
        0,0.1,0,0; 266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,
        0,0.1,0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,
        0,0.1,0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,
        0,0.1,0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,
        0.6,0.6,1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,
        0.4,0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,
        0,0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,
        1,1,1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0; 323940,
        0,0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0; 331140,
        0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0; 338340,
        0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0; 345540,
        0,0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0; 352740,
        0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0; 359940,
        0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0; 367140,
        0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0; 374340,
        0,0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,1; 381540,
        0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,1; 388740,
        0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,0,0; 395940,
        0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,1,1,1; 403140,
        1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,0.1,0,0; 410340,
        0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,0.1,0,0; 417540,
        0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,0.1,0,0; 424740,
        0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,0.1,0,0; 431940,
        0,0.1,0,0; 432000,0,0,0,0; 435540,0,0,0,0; 435600,0,0,0,0; 439140,0,0,0,
        0; 439200,0,0,0,0; 442740,0,0,0,0; 442800,0,0,0,0; 446340,0,0,0,0; 446400,
        0,0,0,0; 449940,0,0,0,0; 450000,0,0,0,0; 453540,0,0,0,0; 453600,0,0,0,0;
        457140,0,0,0,0; 457200,0,0,0,0; 460740,0,0,0,0; 460800,0,0,0,0; 464340,0,
        0,0,0; 464400,0,0,0,0; 467940,0,0,0,0; 468000,0,0,0,0; 471540,0,0,0,0; 471600,
        0,0,0,0; 475140,0,0,0,0; 475200,0,0,0,0; 478740,0,0,0,0; 478800,0,0,0,0;
        482340,0,0,0,0; 482400,0,0,0,0; 485940,0,0,0,0; 486000,0,0,0,0; 489540,0,
        0,0,0; 489600,0,0,0,0; 493140,0,0,0,0; 493200,0,0,0,0; 496740,0,0,0,0; 496800,
        0,0,0,0; 500340,0,0,0,0; 500400,0,0,0,0; 503940,0,0,0,0; 504000,0,0,0,0;
        507540,0,0,0,0; 507600,0,0,0,0; 511140,0,0,0,0; 511200,0,0,0,0; 514740,0,
        0,0,0; 514800,0,0,0,0; 518340,0,0,0,0; 518400,0,0,0,0; 521940,0,0,0,0; 522000,
        0,0,0,0; 525540,0,0,0,0; 525600,0,0,0,0; 529140,0,0,0,0; 529200,0,0,0,0;
        532740,0,0,0,0; 532800,0,0,0,0; 536340,0,0,0,0; 536400,0,0,0,0; 539940,0,
        0,0,0; 540000,0,0,0,0; 543540,0,0,0,0; 543600,0,0,0,0; 547140,0,0,0,0; 547200,
        0,0,0,0; 550740,0,0,0,0; 550800,0,0,0,0; 554340,0,0,0,0; 554400,0,0,0,0;
        557940,0,0,0,0; 558000,0,0,0,0; 561540,0,0,0,0; 561600,0,0,0,0; 565140,0,
        0,0,0; 565200,0,0,0,0; 568740,0,0,0,0; 568800,0,0,0,0; 572340,0,0,0,0; 572400,
        0,0,0,0; 575940,0,0,0,0; 576000,0,0,0,0; 579540,0,0,0,0; 579600,0,0,0,0;
        583140,0,0,0,0; 583200,0,0,0,0; 586740,0,0,0,0; 586800,0,0,0,0; 590340,0,
        0,0,0; 590400,0,0,0,0; 593940,0,0,0,0; 594000,0,0,0,0; 597540,0,0,0,0; 597600,
        0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0])
    "Table with profiles for internal gains"
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={53,-26})));

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
    annotation (Placement(transformation(extent={{-36,-32},{0,-6}})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
        MediumAir, nPorts=1)
                          annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-62,-10})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-68,42},{-34,74}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  BaseClasses.ZoneBus zoneBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir1(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-62,-20})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1
    annotation (Placement(transformation(extent={{-78,-8},{-70,0}})));
  Fluid.Sources.Boundary_pT        bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-5,-57})));
  Fluid.Sources.Boundary_pT        bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={13,-53})));
  Fluid.Sources.Boundary_pT        bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={46,-90})));
  Fluid.Sources.Boundary_pT        bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={22,-90})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={73,-59})));
  Fluid.Sources.Boundary_pT        bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={55,-53})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-80,90},{0,90},{0,44.4},{2,44.4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,90},{-51,90},{-51,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(internalGains.y,thermalZone1. intGains) annotation (Line(points={{53,-18.3},
          {52,-18.3},{52,-12},{52.4,-12},{52.4,2.64}},
                                            color={0,0,127}));
  connect(tabs1.heatPort,thermalZone1. intGainsConv) annotation (Line(points={{88,-19},
          {88,28.16},{58.56,28.16}},                                color={191,
          0,0}));
  connect(genericAHU1.port_b1,thermalZone1. ports[1]) annotation (Line(points={{
          0.163636,-20.1818},{28,-20.1818},{28,6.12},{23.42,6.12}},
                                                                 color={0,127,
          255}));
  connect(genericAHU1.port_a2,thermalZone1. ports[2]) annotation (Line(points={{
          0.163636,-10.7273},{38,-10.7273},{38,6.12},{36.58,6.12}},
                                                               color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU1. port_b2) annotation (Line(
        points={{-58,-10},{-58,-10.7273},{-36,-10.7273}},    color={0,127,255}));
  connect(thermalZone1.TAir, zoneBus.TZoneMea) annotation (Line(points={{60.8,50.2},
          {78.4,50.2},{78.4,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericAHU1.genericAHUBus, zoneBus.ahuBus) annotation (Line(
      points={{-18,-5.88182},{-18,100.05},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs1.tabsBus, zoneBus.tabsBus) annotation (Line(
      points={{77.9,-31.9},{77.9,100.05},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryOutsideAir1.T_in, weaBus.TDryBul) annotation (Line(points={{-66.8,
          -21.6},{-94,-21.6},{-94,58},{-51,58}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-69.6,
          -4},{-68,-4},{-68,-18.4},{-66.8,-18.4}}, color={0,0,127}));
  connect(x_pTphi1.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-69.6,
          -4},{-68,-4},{-68,-18.4},{-66.8,-18.4}}, color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1], genericAHU1.port_a1) annotation (Line(
        points={{-58,-20},{-58,-20.1818},{-36,-20.1818}}, color={0,127,255}));
  connect(x_pTphi1.T, weaBus.TDryBul) annotation (Line(points={{-78.8,-4},{-94,-4},
          {-94,58},{-51,58}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(x_pTphi1.phi, weaBus.relHum) annotation (Line(points={{-78.8,-6.4},{-78.8,
          -6},{-94,-6},{-94,58},{-51,58}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.p_in, weaBus.pAtm) annotation (Line(points={{-78.8,-1.6},{-78,
          -1.6},{-78,-2},{-94,-2},{-94,58},{-51,58}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouWaterhot.ports[1], genericAHU1.port_a5) annotation (Line(points={{-5,-52},
          {-12,-52},{-12,-32},{-11.4545,-32}},      color={0,127,255}));
  connect(bouWaterhot1.ports[1], genericAHU1.port_b5) annotation (Line(points={{
          13,-48},{12,-48},{12,-42},{-8,-42},{-8,-32},{-8.34545,-32}}, color={0,
          127,255}));
  connect(bouWatercold1.ports[1], genericAHU1.port_a4) annotation (Line(points={
          {24,-80},{-18,-80},{-18,-32}}, color={0,127,255}));
  connect(bouWatercold.ports[1], tabs1.port_b2) annotation (Line(points={{48,-80},
          {96,-80},{96,-41.8}}, color={0,127,255}));
  connect(bouWatercold1.ports[2], tabs1.port_a2) annotation (Line(points={{20,-80},
          {22,-80},{22,-72},{92,-72},{92,-42}}, color={0,127,255}));
  connect(genericAHU1.port_b4, bouWatercold.ports[2]) annotation (Line(points={{
          -14.7273,-32},{-14,-32},{-14,-74},{46,-74},{46,-80},{44,-80}}, color={
          0,127,255}));
  connect(bouWaterhot2.ports[1], tabs1.port_b1)
    annotation (Line(points={{73,-54},{84,-54},{84,-42}}, color={0,127,255}));
  connect(bouWaterhot3.ports[1], tabs1.port_a1)
    annotation (Line(points={{55,-48},{80,-48},{80,-42}}, color={0,127,255}));
end ERC_Zone;
