within AixLib.Systems.Examples.ZoneWithAHUAndCCA;
model SimpleRoom
    extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  TABS.Tabs                               tabs(
    redeclare package Medium = MediumWater,
    area=thermalZone1.zoneParam.AZone,
    thickness=0.05,
    alpha=15) annotation (Placement(transformation(extent={{42,-60},{82,-20}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone
                                                    thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=AixLib.DataBase.ThermalZones.ASHRAE140_900(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{34,44},{84,88}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-72,70},{-50,90}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  AixLib.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumAir,
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-80,16},{-68,28}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,32},{-68,44}})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-4,-34})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={12,-34})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={68,-96})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={84,-92})));
  Modelica.Blocks.Sources.RealExpression HeatPower(y=1000*4.18*(tabsBus.hotThrottleBus.VFlowInMea
        *(tabsBus.hotThrottleBus.TFwrdInMea - tabsBus.hotThrottleBus.TRtrnOutMea)
         + ahuBus.heaterBus.hydraulicBus.VFlowInMea*(ahuBus.heaterBus.hydraulicBus.TFwrdInMea
         - ahuBus.heaterBus.hydraulicBus.TRtrnOutMea)))
    annotation (Placement(transformation(extent={{-102,-60},{-88,-40}})));
  Modelica.Blocks.Continuous.Integrator integratorHeat
    annotation (Placement(transformation(extent={{-72,-56},{-60,-44}})));
  Modelica.Blocks.Continuous.Integrator integratorCold
    annotation (Placement(transformation(extent={{-74,-96},{-62,-84}})));
  Modelica.Blocks.Interfaces.RealOutput EnergyHeat
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-52,-60},{-32,-40}}),iconTransformation(extent={{126,-22},{
            146,-2}})));
  Modelica.Blocks.Interfaces.RealOutput EnergyCold
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-52,-100},{-32,-80}}),iconTransformation(extent={{120,-62},{
            140,-42}})));
  Modelica.Blocks.Sources.RealExpression ColdPower(y=1000*4.18*(tabsBus.coldThrottleBus.VFlowInMea
        *(tabsBus.coldThrottleBus.TFwrdInMea - tabsBus.coldThrottleBus.TRtrnOutMea)
         + ahuBus.coolerBus.hydraulicBus.VFlowInMea*(ahuBus.coolerBus.hydraulicBus.TFwrdInMea
         - ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)))
    annotation (Placement(transformation(extent={{-102,-100},{-88,-80}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={36,-76})));
  Fluid.Sources.Boundary_pT        bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={52,-76})));
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
        dT_nom=10,
        Q_nom=200000)),
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
        Q_nom=150000)),
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
    annotation (Placement(transformation(extent={{-60,0},{22,46}})));
  ModularAHU.BaseClasses.GenericAHUBus ahuBus "Bus connector for generic ahu"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  TABS.BaseClasses.TabsBus tabsBus "Connector bus"
    annotation (Placement(transformation(extent={{18,90},{38,110}})));
  Modelica.Blocks.Interfaces.RealOutput TAirZone "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,74},{120,94}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="internalGains",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/SIA2024_SingleOffice_week.txt"),
    columns={2,3,4},
    tableOnFile=true,
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
    annotation(Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={89,32})));

  Modelica.Blocks.Interfaces.RealOutput QFlowHeat "Value of Real output"
    annotation (Placement(transformation(extent={{-82,-44},{-62,-24}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowCold "Value of Real output"
    annotation (Placement(transformation(extent={{-82,-84},{-62,-64}})));
equation
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-61,80},{26,80},{26,79.2},{34,79.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(HeatPower.y, integratorHeat.u)
    annotation (Line(points={{-87.3,-50},{-73.2,-50}},
                                                 color={0,0,127}));
  connect(integratorHeat.y, EnergyHeat)
    annotation (Line(points={{-59.4,-50},{-42,-50}},
                                                   color={0,0,127}));
  connect(integratorCold.y, EnergyCold)
    annotation (Line(points={{-61.4,-90},{-42,-90}},
                                                   color={0,0,127}));
  connect(ColdPower.y, integratorCold.u)
    annotation (Line(points={{-87.3,-90},{-75.2,-90}},
                                                 color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,90},{-60,90},{-60,84},{-61,84},{-61,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{-101.2,16.4},{
          -104,16.4},{-104,80},{-61,80}},                  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.p_in, weaBus.pAtm) annotation (Line(points={{-101.2,23.6},{
          -102,23.6},{-102,24},{-104,24},{-104,80},{-61,80}},
                                                           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bou.T_in, x_pTphi.T) annotation (Line(points={{-81.2,24.4},{-86,24.4},
          {-86,48},{-104,48},{-104,20},{-101.2,20}},color={0,0,127}));
  connect(x_pTphi.T, weaBus.TDryBul) annotation (Line(points={{-101.2,20},{-104,
          20},{-104,80},{-61,80}},
                               color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(tabs.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{62,-18},
          {62,0},{100,0},{100,66},{88,66},{88,66.88},{84.5,66.88}},
                                                                 color={191,0,0}));
  connect(bouWatercold.ports[1], tabs.port_a2)
    annotation (Line(points={{68.6,-90},{70,-90},{70,-60}},
                                                          color={0,127,255}));
  connect(bouWatercold1.ports[1], tabs.port_b2)
    annotation (Line(points={{84.6,-86},{84.6,-66},{78,-66},{78,-59.6}},
                                                      color={0,127,255}));
  connect(x_pTphi.X, bou.X_in) annotation (Line(points={{-87.4,20},{-84,20},{
          -84,19.6},{-81.2,19.6}},   color={0,0,127}));
  connect(tabs.port_a1, bouWaterhot2.ports[1]) annotation (Line(points={{46,-60},
          {40,-60},{40,-70},{36,-70}},       color={0,127,255}));
  connect(tabs.port_b1, bouWaterhot3.ports[1]) annotation (Line(points={{54,-60},
          {54,-66},{52,-66},{52,-70}}, color={0,127,255}));
  connect(bou1.ports[1], genericAHU1.port_b2)
    annotation (Line(points={{-68,38},{-64,38},{-64,37.6364},{-60,37.6364}},
                                                 color={0,127,255}));
  connect(bou.ports[1], genericAHU1.port_a1)
    annotation (Line(points={{-68,22},{-64,22},{-64,20.9091},{-60,20.9091}},
                                                 color={0,127,255}));
  connect(genericAHU1.port_a2, thermalZone1.ports[1]) annotation (Line(points={{22.3727,
          37.6364},{50,37.6364},{50,38},{56,38},{56,50.16},{56.0625,50.16}},
                                                  color={0,127,255}));
  connect(genericAHU1.port_b1, thermalZone1.ports[2]) annotation (Line(points={{22.3727,
          20.9091},{50,20.9091},{50,22},{64,22},{64,50.16},{61.9375,50.16}},
                                                            color={0,127,255}));
  connect(genericAHU1.port_a4, bouWatercold.ports[2]) annotation (Line(points={{-19,0},
          {-19,-90},{67.4,-90}},                              color={0,127,255}));
  connect(genericAHU1.port_b4, bouWatercold1.ports[2]) annotation (Line(points={{
          -11.5455,0},{-14,0},{-14,-86},{83.4,-86}},
                   color={0,127,255}));
  connect(genericAHU1.port_a5, bouWaterhot.ports[1]) annotation (Line(points={{
          -4.09091,0},{-4.09091,-22},{-4,-22},{-4,-28}},    color={0,127,255}));
  connect(genericAHU1.port_b5, bouWaterhot1.ports[1]) annotation (Line(points={{2.99091,
          0},{0,0},{0,-22},{12,-22},{12,-28}},                   color={0,127,
          255}));
  connect(genericAHU1.genericAHUBus,ahuBus)  annotation (Line(
      points={{-19,46.2091},{-19,74},{-20,74},{-20,100}},
      color={255,204,51},
      thickness=0.5));
  connect(tabs.tabsBus, tabsBus) annotation (Line(
      points={{41.8,-39.8},{28,-39.8},{28,100}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.TAir, TAirZone) annotation (Line(points={{86.5,83.6},{96,
          83.6},{96,84},{110,84}},               color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{81.3,32},
          {81.3,30},{79,30},{79,47.52}},   color={0,0,127}));
  connect(TAirZone, TAirZone)
    annotation (Line(points={{110,84},{110,84}}, color={0,0,127}));
  connect(HeatPower.y, QFlowHeat) annotation (Line(points={{-87.3,-50},{-82,-50},
          {-82,-34},{-72,-34}}, color={0,0,127}));
  connect(ColdPower.y, QFlowCold) annotation (Line(points={{-87.3,-90},{-80,-90},
          {-80,-74},{-72,-74}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SimpleRoom;
