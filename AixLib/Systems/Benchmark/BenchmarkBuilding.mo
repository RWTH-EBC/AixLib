within AixLib.Systems.Benchmark;
model BenchmarkBuilding "Benchmark building model"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={200,-60})));
  Model.Generation.HeatpumpSystem heatpumpSystem(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-40,-80},{70,-34}})));
  EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare package Medium =
        Medium, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{20,-24},{-20,24}},
        rotation=0,
        origin={120,-56})));
  EONERC_MainBuilding.HeatExchangerSystem heatExchangerSystem(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-130,-40},{-60,8}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-208,-66})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-86,62})));
  EONERC_MainBuilding.Controller.CtrSWU ctrSWU
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=4)
    annotation (Placement(transformation(extent={{52,-20},{72,0}})));
  EONERC_MainBuilding.Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=308.15,
    k=0.01,
    Ti=100,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-124,38},{-104,18}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Model.Generation.HighTemperatureSystem highTemperatureSystem(redeclare
      package Medium = Medium, m_flow_nominal=10,
    T_start=323.15)
    annotation (Placement(transformation(extent={{-188,-80},{-144,-34}})));
  EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus heatPumpSystemBus1
    annotation (Placement(transformation(extent={{6,-34},{26,-14}})));
  Model.Generation.BaseClasses.HighTemperatureSystemBus
    highTemperatureSystemBus1
    annotation (Placement(transformation(extent={{-178,-36},{-158,-16}})));
  Model.Generation.GeothermalProbe geothermalProbe(
    redeclare package Medium = Medium,             m_flow_nominal=1,
    nParallel=3)
    annotation (Placement(transformation(extent={{110,-118},{130,-98}})));
  Model.Generation.Tabs tabs(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*1000)
    annotation (Placement(transformation(extent={{140,120},{180,160}})));
  Model.Generation.BaseClasses.TabsBus tabsBus1 annotation (Placement(
        transformation(extent={{118,128},{138,148}}), iconTransformation(extent=
           {{-48,46},{-28,66}})));
  HydraulicModules.Controller.CtrMix ctrMix1(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{96,130},{116,150}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{100,120},{110,130}})));
  Model.Generation.Tabs tabs1(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*1000)
    annotation (Placement(transformation(extent={{240,120},{280,160}})));
  HydraulicModules.Controller.CtrMix ctrMix2(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{196,130},{216,150}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{200,120},{210,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus2 annotation (Placement(
        transformation(extent={{218,128},{238,148}}), iconTransformation(extent=
           {{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs2(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*1000)
    annotation (Placement(transformation(extent={{344,120},{384,160}})));
  HydraulicModules.Controller.CtrMix ctrMix3(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{296,130},{316,150}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{300,120},{310,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus3 annotation (Placement(
        transformation(extent={{318,128},{338,148}}), iconTransformation(extent=
           {{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs3(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*1000)
    annotation (Placement(transformation(extent={{440,120},{480,160}})));
  HydraulicModules.Controller.CtrMix ctrMix4(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{396,130},{416,150}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{400,120},{410,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus4 annotation (Placement(
        transformation(extent={{418,128},{438,148}}), iconTransformation(extent=
           {{-48,46},{-28,66}})));
  Model.Generation.Tabs tabs4(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*1000)
    annotation (Placement(transformation(extent={{540,120},{580,160}})));
  HydraulicModules.Controller.CtrMix ctrMix5(
    TflowSet=298.15,
    k=0.01,
    Ti=60,
    Td=0) annotation (Placement(transformation(extent={{496,130},{516,150}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{500,120},{510,130}})));
  Model.Generation.BaseClasses.TabsBus tabsBus5 annotation (Placement(
        transformation(extent={{518,128},{538,148}}), iconTransformation(extent=
           {{-48,46},{-28,66}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{122,272},{154,300}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{40,302},{60,322}})));

  Modelica.Blocks.Sources.Constant const5(k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{40,242},{60,262}})));
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
    annotation(Placement(transformation(extent={{118,223},{132,237}})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{54,262},{88,294}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone1(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{240,272},{272,298}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone2(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{346,272},{374,298}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone3(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{444,272},{470,300}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone4(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{538,274},{568,304}})));
  ModularAHU.GenericAHU                genericAHU(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Medium,
    T_amb=293.15,
    m1_flow_nominal=3000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=true,
    useHumidifierRet=false,
    useHumidifier=true,
    perheater(redeclare HydraulicModules.Admix partialHydraulicModule(
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
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
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
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
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
      Twater_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      Twater_in=288.15))
    annotation (Placement(transformation(extent={{-120,154},{0,220}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir(
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Media.Air,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,184})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(nPorts=1, redeclare package
      Medium = Media.Air) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,208})));
  ModularAHU.Controller.CtrAHUBasic ctrAHUBasic(
    TFlowSet=293.15,
    ctrPh(k=0.01, rpm_pump=4000),
    ctrRh(k=0.01, rpm_pump=4000),
    ctrCo(k=0.01, rpm_pump=4000))
    annotation (Placement(transformation(extent={{-100,240},{-80,260}})));
  Fluid.FixedResistances.HydraulicDiameter res1(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{208,176},{228,196}})));
  Fluid.FixedResistances.HydraulicDiameter res2(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={210,208})));
  Fluid.FixedResistances.HydraulicDiameter res3(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={148,234})));
  Fluid.FixedResistances.HydraulicDiameter res4(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={134,222})));
  Fluid.FixedResistances.HydraulicDiameter res5(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{288,174},{308,194}})));
  Fluid.FixedResistances.HydraulicDiameter res6(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={296,208})));
  Fluid.FixedResistances.HydraulicDiameter res7(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{390,176},{410,196}})));
  Fluid.FixedResistances.HydraulicDiameter res8(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={400,208})));
  Fluid.FixedResistances.HydraulicDiameter res9(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{520,176},{540,196}})));
  Fluid.FixedResistances.HydraulicDiameter res10(
    redeclare package Medium = Media.Air,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={530,208})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{100,-60},{80,-60},{80,-59.5556},{70,-59.5556}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{70,-49.3333},{94,-49.3333},{94,-36},{100,-36}},
                                                    color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_b2)
    annotation (Line(points={{-76,62},{-76,8},{-75,8}},   color={0,127,255}));
  connect(ctrSWU.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{100,-10},{120,-10},{120,-31.6},{120.2,-31.6}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.mode, integerExpression.y)
    annotation (Line(points={{80,-10},{73,-10}}, color={255,127,0}));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-104.7,23.4},{-118,23.4},{-118,8},{-110,8}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-104.7,29.1},{-85,29.1},{-85,8}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{0,-110},{14,-110},{14,-77.4444},{15,-77.4444}}, color={191,0,0}));
  connect(highTemperatureSystem.port_b, heatExchangerSystem.port_a1)
    annotation (Line(points={{-144,-66.2},{-142,-66.2},{-142,-66},{-138,-66},{
          -138,-20.8},{-130,-20.8}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, heatExchangerSystem.port_b1)
    annotation (Line(points={{-188,-66.2},{-188,-66},{-194,-66},{-194,-11.2},{
          -130,-11.2}}, color={0,127,255}));
  connect(boundary1.ports[1], highTemperatureSystem.port_a) annotation (Line(
        points={{-198,-66},{-196,-66},{-196,-66.2},{-188,-66.2}}, color={0,127,
          255}));
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{190,-60},{166,-60},{166,-60},{140,-60}},
                                                   color={0,127,255}));
  connect(heatpumpSystem.heatPumpSystemBus, heatPumpSystemBus1) annotation (
      Line(
      points={{15,-34},{16,-34},{16,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(highTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystemBus1) annotation (Line(
      points={{-165.78,-34},{-165.78,-30},{-168,-30},{-168,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(geothermalProbe.port_a, switchingUnit.port_b3) annotation (Line(
        points={{110,-108},{112,-108},{112,-80}}, color={0,127,255}));
  connect(geothermalProbe.port_b, switchingUnit.port_a3) annotation (Line(
        points={{130,-108},{130,-80},{128,-80}}, color={0,127,255}));
  connect(tabs.tabsBus, tabsBus1) annotation (Line(
      points={{139.8,138.364},{130.9,138.364},{130.9,138},{128,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix1.hydraulicBus, tabsBus1.admixBus) annotation (Line(
      points={{115.3,138.9},{115.65,138.9},{115.65,138.05},{128.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, tabsBus1.valSet) annotation (Line(points={{110.5,125},{128,
          125},{128,126},{128.05,126},{128.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs1.tabsBus, tabsBus2) annotation (Line(
      points={{239.8,138.364},{230.9,138.364},{230.9,138},{228,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix2.hydraulicBus, tabsBus2.admixBus) annotation (Line(
      points={{215.3,138.9},{215.65,138.9},{215.65,138.05},{228.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, tabsBus2.valSet) annotation (Line(points={{210.5,125},{228,
          125},{228,126},{228.05,126},{228.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs2.tabsBus, tabsBus3) annotation (Line(
      points={{343.8,138.364},{330.9,138.364},{330.9,138},{328,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix3.hydraulicBus, tabsBus3.admixBus) annotation (Line(
      points={{315.3,138.9},{315.65,138.9},{315.65,138.05},{328.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y, tabsBus3.valSet) annotation (Line(points={{310.5,125},{328,
          125},{328,126},{328.05,126},{328.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs3.tabsBus, tabsBus4) annotation (Line(
      points={{439.8,138.364},{430.9,138.364},{430.9,138},{428,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix4.hydraulicBus, tabsBus4.admixBus) annotation (Line(
      points={{415.3,138.9},{415.65,138.9},{415.65,138.05},{428.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y, tabsBus4.valSet) annotation (Line(points={{410.5,125},{428,
          125},{428,126},{428.05,126},{428.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs4.tabsBus, tabsBus5) annotation (Line(
      points={{539.8,138.364},{530.9,138.364},{530.9,138},{528,138}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix5.hydraulicBus, tabsBus5.admixBus) annotation (Line(
      points={{515.3,138.9},{515.65,138.9},{515.65,138.05},{528.05,138.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const4.y, tabsBus5.valSet) annotation (Line(points={{510.5,125},{528,
          125},{528,126},{528.05,126},{528.05,138.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switchingUnit.port_b2, tabs.port_a2) annotation (Line(points={{140,
          -60},{152,-60},{152,120}}, color={0,127,255}));
  connect(tabs4.port_a2, tabs.port_a2) annotation (Line(points={{552,120},{552,
          100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs1.port_a2, tabs.port_a2) annotation (Line(points={{252,120},{254,
          120},{254,100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs2.port_a2, tabs.port_a2) annotation (Line(points={{356,120},{354,
          120},{354,100},{152,100},{152,120}}, color={0,127,255}));
  connect(tabs3.port_a2, tabs.port_a2) annotation (Line(points={{452,120},{452,
          100},{152,100},{152,120}}, color={0,127,255}));
  connect(switchingUnit.port_a1, tabs.port_b2) annotation (Line(points={{140,-36},
          {176,-36},{176,120.364}},      color={0,127,255}));
  connect(tabs4.port_b2, tabs.port_b2) annotation (Line(points={{576,120.364},{
          576,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs1.port_b2, tabs.port_b2) annotation (Line(points={{276,120.364},{
          276,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs2.port_b2, tabs.port_b2) annotation (Line(points={{380,120.364},{
          380,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(tabs3.port_b2, tabs.port_b2) annotation (Line(points={{476,120.364},{
          476,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(heatExchangerSystem.port_a3, tabs4.port_b1) annotation (Line(points={
          {-65,8},{-64,8},{-64,40},{568,40},{568,120}}, color={238,46,47}));
  connect(heatExchangerSystem.port_b2, tabs4.port_a1) annotation (Line(points={
          {-75,8},{-75,60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs.port_a1, tabs4.port_a1) annotation (Line(points={{144,120},{144,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs1.port_a1, tabs4.port_a1) annotation (Line(points={{244,120},{244,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs2.port_a1, tabs4.port_a1) annotation (Line(points={{348,120},{348,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs3.port_a1, tabs4.port_a1) annotation (Line(points={{444,120},{444,
          60},{544,60},{544,120}}, color={238,46,47}));
  connect(tabs.port_b1, tabs4.port_b1) annotation (Line(points={{168,120},{168,
          40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs1.port_b1, tabs4.port_b1) annotation (Line(points={{268,120},{268,
          40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs2.port_b1, tabs4.port_b1) annotation (Line(points={{372,120},{370,
          120},{370,40},{568,40},{568,120}}, color={238,46,47}));
  connect(tabs3.port_b1, tabs4.port_b1) annotation (Line(points={{468,120},{470,
          120},{470,40},{568,40},{568,120}}, color={238,46,47}));
  connect(weaDat.weaBus,thermalZone. weaBus) annotation (Line(
      points={{60,312},{98,312},{98,286},{122,286}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{60,312},{71,312},{71,278}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(thermalZone.ventTemp,weaBus. TDryBul) annotation (Line(points={{119.92,
          280.54},{96.35,280.54},{96.35,278},{71,278}},
                                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone.ventRate) annotation (Line(points={{61,252},{
          126.8,252},{126.8,274.24}},
                                 color={0,0,127}));
  connect(internalGains.y,thermalZone. intGains)
    annotation (Line(points={{132.7,230},{150.8,230},{150.8,274.24}},
                                                          color={0,0,127}));
  connect(tabs.heatPort, thermalZone.intGainsConv) annotation (Line(points={{160,
          161.818},{162,161.818},{162,279},{154,279}},     color={191,0,0}));
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{60,312},{216,312},{216,285},{240,285}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.ventTemp, weaBus.TDryBul) annotation (Line(points={{237.92,
          279.93},{214.35,279.93},{214.35,278},{71,278}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone1.ventRate) annotation (Line(points={{61,252},{
          244.8,252},{244.8,274.08}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{132.7,
          230},{268.8,230},{268.8,274.08}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone2.weaBus) annotation (Line(
      points={{60,312},{322,312},{322,285},{346,285}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone2.ventTemp, weaBus.TDryBul) annotation (Line(points={{344.18,
          279.93},{320.35,279.93},{320.35,278},{71,278}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone2.ventRate) annotation (Line(points={{61,252},{
          350.2,252},{350.2,274.08}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone2.intGains) annotation (Line(points={{132.7,
          230},{371.2,230},{371.2,274.08}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone3.weaBus) annotation (Line(
      points={{60,312},{420,312},{420,286},{444,286}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone3.ventTemp, weaBus.TDryBul) annotation (Line(points={{442.31,
          280.54},{418.35,280.54},{418.35,278},{71,278}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone3.ventRate) annotation (Line(points={{61,252},{
          447.9,252},{447.9,274.24}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone3.intGains) annotation (Line(points={{132.7,
          230},{467.4,230},{467.4,274.24}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone4.weaBus) annotation (Line(
      points={{60,312},{514,312},{514,289},{538,289}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone4.ventTemp, weaBus.TDryBul) annotation (Line(points={{536.05,
          283.15},{512.35,283.15},{512.35,278},{71,278}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone4.ventRate) annotation (Line(points={{61,252},{
          542.5,252},{542.5,276.4}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone4.intGains) annotation (Line(points={{132.7,
          230},{565,230},{565,276.4}},       color={0,0,127}));
  connect(thermalZone1.intGainsConv, tabs1.heatPort) annotation (Line(points={{272,
          278.5},{270,278.5},{270,161.818},{260,161.818}}, color={191,0,0}));
  connect(thermalZone2.intGainsConv, tabs2.heatPort) annotation (Line(points={{374,
          278.5},{378,278.5},{378,260},{364,260},{364,161.818}}, color={191,0,0}));
  connect(thermalZone3.intGainsConv, tabs3.heatPort) annotation (Line(points={{470,279},
          {468,279},{468,276},{472,276},{472,161.818},{460,161.818}},
        color={191,0,0}));
  connect(thermalZone4.intGainsConv, tabs4.heatPort) annotation (Line(points={{568,
          281.5},{570,281.5},{570,161.818},{560,161.818}}, color={191,0,0}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-40,-49.3333},{-75,-49.3333},{-75,-40}}, color={0,127,255}));
  connect(heatExchangerSystem.port_b3, heatpumpSystem.port_a2) annotation (Line(
        points={{-65,-39.52},{-65,-59.5556},{-40,-59.5556}}, color={0,127,255}));
  connect(boundaryOutsideAir.ports[1],genericAHU. port_a1)
    annotation (Line(points={{-130,184},{-120,184}},
                                                 color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU. port_b2)
    annotation (Line(points={{-130,208},{-120,208}},
                                                 color={0,127,255}));
  connect(highTemperatureSystem.port_b, genericAHU.port_a5) annotation (Line(
        points={{-144,-66.2},{-140,-66.2},{-140,130},{-38.1818,130},{-38.1818,
          154}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, genericAHU.port_b5) annotation (Line(
        points={{-188,-66.2},{-192,-66.2},{-192,140},{-27.8182,140},{-27.8182,
          154}}, color={0,127,255}));
  connect(genericAHU.port_a3, genericAHU.port_a5) annotation (Line(points={{
          -103.636,154},{-103.636,130},{-38.1818,130},{-38.1818,154}}, color={0,
          127,255}));
  connect(genericAHU.port_b3, genericAHU.port_b5) annotation (Line(points={{
          -92.7273,154},{-92.7273,142},{-92.7273,140},{-27.8182,140},{-27.8182,
          154}}, color={0,127,255}));
  connect(genericAHU.port_a4, tabs.port_a2) annotation (Line(points={{-60,154},
          {-62,154},{-62,100},{152,100},{152,120}}, color={0,127,255}));
  connect(genericAHU.port_b4, tabs.port_b2) annotation (Line(points={{-49.0909,
          154},{-49.0909,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(boundaryOutsideAir.T_in, weaBus.TDryBul) annotation (Line(points={{
          -152,180},{-186,180},{-186,278},{71,278}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAHUBasic.genericAHUBus, genericAHU.genericAHUBus) annotation (Line(
      points={{-80,250.1},{-60,250.1},{-60,220.3}},
      color={255,204,51},
      thickness=0.5));
  connect(genericAHU.port_b1, res1.port_a) annotation (Line(points={{0.545455,
          184},{120,184},{120,186},{208,186}}, color={0,127,255}));
  connect(res1.port_b, thermalZone1.ports[1]) annotation (Line(points={{228,186},
          {252.24,186},{252.24,275.64}}, color={0,127,255}));
  connect(genericAHU.port_a2, res2.port_b)
    annotation (Line(points={{0.545455,208},{200,208}}, color={0,127,255}));
  connect(res2.port_a, thermalZone1.ports[2]) annotation (Line(points={{220,208},
          {259.76,208},{259.76,275.64}}, color={0,127,255}));
  connect(genericAHU.port_a2, res3.port_b) annotation (Line(points={{0.545455,
          208},{148,208},{148,224}}, color={0,127,255}));
  connect(genericAHU.port_b1, res4.port_a) annotation (Line(points={{0.545455,
          184},{134.24,184},{134,212}}, color={0,127,255}));
  connect(res4.port_b, thermalZone.ports[1]) annotation (Line(points={{134,232},
          {134.24,232},{134.24,275.92}}, color={0,127,255}));
  connect(res3.port_a, thermalZone.ports[2]) annotation (Line(points={{148,244},
          {144,244},{144,275.92},{141.76,275.92}}, color={0,127,255}));
  connect(genericAHU.port_b1, res5.port_a)
    annotation (Line(points={{0.545455,184},{288,184}}, color={0,127,255}));
  connect(genericAHU.port_a2, res6.port_b)
    annotation (Line(points={{0.545455,208},{286,208}}, color={0,127,255}));
  connect(res5.port_b, thermalZone2.ports[1]) annotation (Line(points={{308,184},
          {356.71,184},{356.71,275.64}}, color={0,127,255}));
  connect(res6.port_a, thermalZone2.ports[2]) annotation (Line(points={{306,208},
          {324,208},{324,206},{363.29,206},{363.29,275.64}}, color={0,127,255}));
  connect(genericAHU.port_b1, res7.port_a) annotation (Line(points={{0.545455,
          184},{194,184},{194,186},{390,186}}, color={0,127,255}));
  connect(genericAHU.port_a2, res8.port_b)
    annotation (Line(points={{0.545455,208},{390,208}}, color={0,127,255}));
  connect(res7.port_b, thermalZone3.ports[1]) annotation (Line(points={{410,186},
          {453.945,186},{453.945,275.92}}, color={0,127,255}));
  connect(res8.port_a, thermalZone3.ports[2]) annotation (Line(points={{410,208},
          {460.055,208},{460.055,275.92}}, color={0,127,255}));
  connect(genericAHU.port_b1, res9.port_a) annotation (Line(points={{0.545455,
          184},{324,184},{324,186},{520,186}}, color={0,127,255}));
  connect(genericAHU.port_a2, res10.port_b)
    annotation (Line(points={{0.545455,208},{520,208}}, color={0,127,255}));
  connect(res9.port_b, thermalZone4.ports[1]) annotation (Line(points={{540,186},
          {548,186},{548,188},{549.475,188},{549.475,278.2}}, color={0,127,255}));
  connect(res10.port_a, thermalZone4.ports[2]) annotation (Line(points={{540,
          208},{544,208},{544,210},{556.525,210},{556.525,278.2}}, color={0,127,
          255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{360,200}})), Icon(
        coordinateSystem(extent={{-200,-120},{360,200}})),
    experiment(
      StopTime=86400,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Cvode"));
end BenchmarkBuilding;
