within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model SimpleRoom
    extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  TABS.Tabs                               tabs(
    redeclare package Medium = MediumWater,
    parameterPipe=DataBase.Pipes.Copper.Copper_133x3(lambda=100),
    area=thermalZone1.zoneParam.AZone,
    thickness=0.2,
    alpha=10) annotation (Placement(transformation(extent={{20,-58},{60,-18}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone
                                                    thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=BaseClasses.ERCMainBuilding_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=293.15,
    use_NaturalAirExchange=true,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{6,22},{56,68}})));
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
        rotation=180,
        origin={93,26})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-88,44},{-54,76}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Fluid.Sources.Outside            out(
    redeclare package Medium = MediumAir,
    nPorts=1) annotation (Placement(transformation(extent={{-100,10},{-88,22}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,26},{-88,38}})));
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.MainBus2Zones bus annotation (Placement(
        transformation(extent={{-18,72},{18,116}}), iconTransformation(extent={
            {110,388},{170,444}})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-35,-71})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-19,-71})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={41,-83})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={63,-93})));
  Modelica.Blocks.Sources.RealExpression HeatPower(y=1000*4.18*(bus.tabs1Bus.hotThrottleBus.VFlowInMea
        *(bus.tabs1Bus.hotThrottleBus.TFwrdInMea - bus.tabs1Bus.hotThrottleBus.TRtrnOutMea)
         + bus.ahu1Bus.heaterBus.hydraulicBus.VFlowInMea*(bus.ahu1Bus.heaterBus.hydraulicBus.TFwrdInMea
         - bus.ahu1Bus.heaterBus.hydraulicBus.TRtrnOutMea)))
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
         + bus.ahu1Bus.coolerBus.hydraulicBus.VFlowInMea*(bus.ahu1Bus.coolerBus.hydraulicBus.TFwrdInMea
         - bus.ahu1Bus.coolerBus.hydraulicBus.TRtrnOutMea)))
    annotation (Placement(transformation(extent={{72,-62},{92,-42}})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={5,-81})));
  Fluid.Sources.Boundary_pT        bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={21,-81})));
  ERC_AHU               eRC_AHU(
    redeclare package MediumWater = MediumWater,
    redeclare package MediumAir = MediumAir,
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=12000/3600*1.2,
    m2_flow_nominal=1,
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
              Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per))),
        dynamicHX(
        dp1_nominal=100,
        dp2_nominal=1000,
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
        Q_nom=150000)),
    dynamicHX(
      dp1_nominal=150,
      dp2_nominal=150,
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
    annotation (Placement(transformation(extent={{-80,-4},{-4,40}})));
equation
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-71,60},{6,60},{6,58.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
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
      points={{-80,90},{-70,90},{-70,60},{-71,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{85.3,
          26},{68,26},{68,25.68},{51,25.68}}, color={0,0,127}));
  connect(tabs.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{40,-16},
          {40,-8},{62,-8},{62,45.92},{56.5,45.92}},              color={191,0,0}));
  connect(bouWatercold.ports[1], tabs.port_a2)
    annotation (Line(points={{40.3,-90},{48,-90},{48,-58}},
                                                          color={0,127,255}));
  connect(bouWatercold1.ports[1], tabs.port_b2)
    annotation (Line(points={{56,-92.3},{56,-57.6}},  color={0,127,255}));
  connect(tabs.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{19.8,-37.8},{0.09,-37.8},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalZone1.TAir, bus.TZone1Mea) annotation (Line(points={{58.5,63.4},
          {58.5,94.11},{0.09,94.11}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(tabs.port_a1, bouWaterhot2.ports[1]) annotation (Line(points={{24,-58},
          {24,-68},{4,-68},{4,-74},{5,-74}}, color={0,127,255}));
  connect(tabs.port_b1, bouWaterhot3.ports[1]) annotation (Line(points={{32,-58},
          {32,-70},{21,-70},{21,-74}}, color={0,127,255}));
  connect(bou1.ports[1], eRC_AHU.port_b2)
    annotation (Line(points={{-88,32},{-80,32}}, color={0,127,255}));
  connect(out.ports[1], eRC_AHU.port_a1)
    annotation (Line(points={{-88,16},{-80,16}}, color={0,127,255}));
  connect(eRC_AHU.port_a2, thermalZone1.ports[1]) annotation (Line(points={{-3.65455,
          32},{-2,32},{-2,36},{4,36},{4,26},{2,26},{2,18},{4,18},{4,16},{36,16},
          {36,28.44},{28.0625,28.44}}, color={0,127,255}));
  connect(eRC_AHU.port_b1, thermalZone1.ports[2]) annotation (Line(points={{-3.65455,
          16},{36,16},{36,28.44},{33.9375,28.44}}, color={0,127,255}));
  connect(eRC_AHU.port_a4, bouWatercold.ports[2]) annotation (Line(points={{-42,
          -4},{-42,-22},{-86,-22},{-86,-90},{41.7,-90}}, color={0,127,255}));
  connect(eRC_AHU.port_b4, bouWatercold1.ports[2]) annotation (Line(points={{-35.0909,
          -4},{-34,-4},{-34,-12},{64,-12},{64,-82},{56,-82},{56,-93.7}}, color=
          {0,127,255}));
  connect(eRC_AHU.port_a5, bouWaterhot.ports[1]) annotation (Line(points={{
          -28.1818,-4},{-28.1818,-58},{-35,-58},{-35,-64}}, color={0,127,255}));
  connect(eRC_AHU.port_b5, bouWaterhot1.ports[1]) annotation (Line(points={{
          -21.6182,-4},{-20,-4},{-20,-58},{-19,-58},{-19,-64}}, color={0,127,
          255}));
  connect(eRC_AHU.genericAHUBus, bus.ahu1Bus) annotation (Line(
      points={{-42,40.2},{-42,58},{0.09,58},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(out.weaBus, weaBus) annotation (Line(
      points={{-100,16.12},{-102,16.12},{-102,16},{-112,16},{-112,60},{-71,60}},

      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SimpleRoom;
