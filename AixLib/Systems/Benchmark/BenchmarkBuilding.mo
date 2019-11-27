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
    annotation (Placement(transformation(extent={{122,338},{154,366}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{40,368},{60,388}})));

  Modelica.Blocks.Sources.Constant const5(k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{40,308},{60,328}})));
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
    annotation (Placement(transformation(extent={{240,338},{272,364}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone2(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{346,338},{374,364}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone3(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{444,338},{470,366}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone4(
    redeclare package Medium = Media.Air,
    zoneParam=AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{538,340},{568,370}})));
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
      TLiqWat_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      TLiqWat_in=288.15))
    annotation (Placement(transformation(extent={{-120,220},{0,286}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir(
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
  ModularAHU.Controller.CtrAHUBasic ctrAHUBasic(
    TFlowSet=293.15,
    k=1,
    ctrPh(
      k=0.01,
      rpm_pump=4000,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(
      k=0.01,
      rpm_pump=4000,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrCo(
      k=0.01,
      rpm_pump=4000,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{-100,306},{-80,326}})));
  ModularAHU.VentilationUnit                ventilationUnit(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{32,236},{70,276}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic(
    TFlowSet=293.15,
    k=0.001,
    ctrCo(initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{22,286},{36,300}})));
  ModularAHU.VentilationUnit                ventilationUnit1(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{202,236},{240,276}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic1(
    TFlowSet=293.15,
    k=0.001,
    ctrCo(initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{194,286},{208,300}})));
  ModularAHU.VentilationUnit                ventilationUnit2(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{300,236},{338,276}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic2(
    TFlowSet=293.15,
    k=0.001,
    ctrCo(initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{292,286},{306,300}})));
  ModularAHU.VentilationUnit                ventilationUnit3(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{400,236},{438,276}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic3(
    TFlowSet=293.15,
    k=0.001,
    ctrCo(initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{394,286},{408,300}})));
  ModularAHU.VentilationUnit                ventilationUnit4(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(redeclare HydraulicModules.Admix partialHydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{510,242},{548,282}})));
  ModularAHU.Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic4(
    TFlowSet=293.15,
    k=0.001,
    ctrCo(initType=Modelica.Blocks.Types.InitPID.InitialOutput),
    ctrRh(initType=Modelica.Blocks.Types.InitPID.InitialOutput))
    annotation (Placement(transformation(extent={{502,286},{516,300}})));
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
      points={{60,378},{98,378},{98,352},{122,352}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{60,378},{71,378},{71,344}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(thermalZone.ventTemp,weaBus. TDryBul) annotation (Line(points={{119.92,
          346.54},{96.35,346.54},{96.35,344},{71,344}},
                                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone.ventRate) annotation (Line(points={{61,318},{
          126.8,318},{126.8,340.24}},
                                 color={0,0,127}));
  connect(internalGains.y,thermalZone. intGains)
    annotation (Line(points={{102.7,328},{150.8,328},{150.8,340.24}},
                                                          color={0,0,127}));
  connect(tabs.heatPort, thermalZone.intGainsConv) annotation (Line(points={{160,
          161.818},{162,161.818},{162,345},{154,345}},     color={191,0,0}));
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{60,378},{216,378},{216,351},{240,351}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.ventTemp, weaBus.TDryBul) annotation (Line(points={{237.92,
          345.93},{214.35,345.93},{214.35,344},{71,344}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone1.ventRate) annotation (Line(points={{61,318},{
          244.8,318},{244.8,340.08}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{102.7,
          328},{268.8,328},{268.8,340.08}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone2.weaBus) annotation (Line(
      points={{60,378},{322,378},{322,351},{346,351}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone2.ventTemp, weaBus.TDryBul) annotation (Line(points={{344.18,
          345.93},{320.35,345.93},{320.35,344},{71,344}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone2.ventRate) annotation (Line(points={{61,318},{
          350.2,318},{350.2,340.08}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone2.intGains) annotation (Line(points={{102.7,
          328},{371.2,328},{371.2,340.08}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone3.weaBus) annotation (Line(
      points={{60,378},{420,378},{420,352},{444,352}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone3.ventTemp, weaBus.TDryBul) annotation (Line(points={{442.31,
          346.54},{418.35,346.54},{418.35,344},{71,344}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone3.ventRate) annotation (Line(points={{61,318},{
          447.9,318},{447.9,340.24}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone3.intGains) annotation (Line(points={{102.7,
          328},{467.4,328},{467.4,340.24}},  color={0,0,127}));
  connect(weaDat.weaBus, thermalZone4.weaBus) annotation (Line(
      points={{60,378},{514,378},{514,355},{538,355}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone4.ventTemp, weaBus.TDryBul) annotation (Line(points={{536.05,
          349.15},{512.35,349.15},{512.35,344},{71,344}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const5.y, thermalZone4.ventRate) annotation (Line(points={{61,318},{
          542.5,318},{542.5,342.4}},
                                 color={0,0,127}));
  connect(internalGains.y, thermalZone4.intGains) annotation (Line(points={{102.7,
          328},{565,328},{565,342.4}},       color={0,0,127}));
  connect(thermalZone1.intGainsConv, tabs1.heatPort) annotation (Line(points={{272,
          344.5},{270,344.5},{270,161.818},{260,161.818}}, color={191,0,0}));
  connect(thermalZone2.intGainsConv, tabs2.heatPort) annotation (Line(points={{374,
          344.5},{378,344.5},{378,326},{364,326},{364,161.818}}, color={191,0,0}));
  connect(thermalZone3.intGainsConv, tabs3.heatPort) annotation (Line(points={{470,345},
          {468,345},{468,342},{472,342},{472,161.818},{460,161.818}},
        color={191,0,0}));
  connect(thermalZone4.intGainsConv, tabs4.heatPort) annotation (Line(points={{568,
          347.5},{570,347.5},{570,161.818},{560,161.818}}, color={191,0,0}));
  connect(heatpumpSystem.port_b2, heatExchangerSystem.port_a2) annotation (Line(
        points={{-40,-49.3333},{-75,-49.3333},{-75,-40}}, color={0,127,255}));
  connect(heatExchangerSystem.port_b3, heatpumpSystem.port_a2) annotation (Line(
        points={{-65,-39.52},{-65,-59.5556},{-40,-59.5556}}, color={0,127,255}));
  connect(boundaryOutsideAir.ports[1],genericAHU. port_a1)
    annotation (Line(points={{-130,250},{-120,250}},
                                                 color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU. port_b2)
    annotation (Line(points={{-130,274},{-120,274}},
                                                 color={0,127,255}));
  connect(highTemperatureSystem.port_b, genericAHU.port_a5) annotation (Line(
        points={{-144,-66.2},{-140,-66.2},{-140,130},{-38.1818,130},{-38.1818,
          220}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, genericAHU.port_b5) annotation (Line(
        points={{-188,-66.2},{-192,-66.2},{-192,140},{-27.8182,140},{-27.8182,
          220}}, color={0,127,255}));
  connect(genericAHU.port_a3, genericAHU.port_a5) annotation (Line(points={{
          -103.636,220},{-103.636,130},{-38.1818,130},{-38.1818,220}}, color={0,
          127,255}));
  connect(genericAHU.port_b3, genericAHU.port_b5) annotation (Line(points={{
          -92.7273,220},{-92.7273,140},{-27.8182,140},{-27.8182,220}},
                 color={0,127,255}));
  connect(genericAHU.port_a4, tabs.port_a2) annotation (Line(points={{-60,220},
          {-62,220},{-62,100},{152,100},{152,120}}, color={0,127,255}));
  connect(genericAHU.port_b4, tabs.port_b2) annotation (Line(points={{-49.0909,
          220},{-49.0909,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(boundaryOutsideAir.T_in, weaBus.TDryBul) annotation (Line(points={{-152,
          246},{-186,246},{-186,344},{71,344}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAHUBasic.genericAHUBus, genericAHU.genericAHUBus) annotation (Line(
      points={{-80,316.1},{-60,316.1},{-60,286.3}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit.port_a3, tabs.port_a2) annotation (Line(points={{39.6,
          236},{39.6,100},{152,100},{152,120}}, color={0,127,255}));
  connect(ventilationUnit.port_b3, tabs.port_b2) annotation (Line(points={{47.2,
          236},{44,236},{44,80},{176,80},{176,120.364}}, color={0,127,255}));
  connect(genericAHU.port_a2, ventilationUnit.port_b2) annotation (Line(points=
          {{0.545455,274},{14,274},{14,268},{32.38,268}}, color={0,127,255}));
  connect(genericAHU.port_b1, ventilationUnit.port_a1) annotation (Line(points=
          {{0.545455,250},{32,250},{32,256}}, color={0,127,255}));
  connect(ventilationUnit.port_a4, genericAHU.port_a5) annotation (Line(points=
          {{54.8,236},{52,236},{52,174},{-38.1818,174},{-38.1818,220}}, color={
          0,127,255}));
  connect(ventilationUnit.port_b4, genericAHU.port_b5) annotation (Line(points=
          {{62.02,236},{60,236},{60,184},{-27.8182,184},{-27.8182,220}}, color=
          {0,127,255}));
  connect(ctrVentilationUnitBasic.genericAHUBus, ventilationUnit.genericAHUBus)
    annotation (Line(
      points={{36,293.07},{51,293.07},{51,280.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit1.port_a3, tabs.port_a2) annotation (Line(points={{
          209.6,236},{209.6,100},{152,100},{152,120}}, color={0,127,255}));
  connect(ventilationUnit1.port_b3, tabs.port_b2) annotation (Line(points={{
          217.2,236},{216,236},{216,80},{176,80},{176,120.364}}, color={0,127,
          255}));
  connect(genericAHU.port_a2, ventilationUnit1.port_b2) annotation (Line(points
        ={{0.545455,274},{102,274},{102,268},{202.38,268}}, color={0,127,255}));
  connect(genericAHU.port_b1, ventilationUnit1.port_a1) annotation (Line(points
        ={{0.545455,250},{202,250},{202,256}}, color={0,127,255}));
  connect(ventilationUnit1.port_a4, genericAHU.port_a5) annotation (Line(points
        ={{224.8,236},{224,236},{224,174},{-38.1818,174},{-38.1818,220}}, color
        ={0,127,255}));
  connect(ventilationUnit1.port_b4, genericAHU.port_b5) annotation (Line(points
        ={{232.02,236},{232,236},{232,184},{-27.8182,184},{-27.8182,220}},
        color={0,127,255}));
  connect(ctrVentilationUnitBasic1.genericAHUBus, ventilationUnit1.genericAHUBus)
    annotation (Line(
      points={{208,293.07},{221,293.07},{221,280.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit2.port_a3, tabs.port_a2) annotation (Line(points={{
          307.6,236},{307.6,100},{152,100},{152,120}}, color={0,127,255}));
  connect(ventilationUnit2.port_b3, tabs.port_b2) annotation (Line(points={{
          315.2,236},{314,236},{314,80},{176,80},{176,120.364}}, color={0,127,
          255}));
  connect(genericAHU.port_a2, ventilationUnit2.port_b2) annotation (Line(points
        ={{0.545455,274},{150,274},{150,268},{300.38,268}}, color={0,127,255}));
  connect(genericAHU.port_b1, ventilationUnit2.port_a1) annotation (Line(points
        ={{0.545455,250},{300,250},{300,256}}, color={0,127,255}));
  connect(ventilationUnit2.port_a4, genericAHU.port_a5) annotation (Line(points
        ={{322.8,236},{322,236},{322,174},{-38.1818,174},{-38.1818,220}}, color
        ={0,127,255}));
  connect(ventilationUnit2.port_b4, genericAHU.port_b5) annotation (Line(points
        ={{330.02,236},{330,236},{330,184},{-27.8182,184},{-27.8182,220}},
        color={0,127,255}));
  connect(ctrVentilationUnitBasic2.genericAHUBus, ventilationUnit2.genericAHUBus)
    annotation (Line(
      points={{306,293.07},{319,293.07},{319,280.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit3.port_a3, tabs.port_a2) annotation (Line(points={{
          407.6,236},{407.6,100},{152,100},{152,120}}, color={0,127,255}));
  connect(ventilationUnit3.port_b3, tabs.port_b2) annotation (Line(points={{
          415.2,236},{416,236},{416,80},{176,80},{176,120.364}}, color={0,127,
          255}));
  connect(genericAHU.port_a2, ventilationUnit3.port_b2) annotation (Line(points
        ={{0.545455,274},{202,274},{202,268},{400.38,268}}, color={0,127,255}));
  connect(genericAHU.port_b1, ventilationUnit3.port_a1) annotation (Line(points
        ={{0.545455,250},{400,250},{400,256}}, color={0,127,255}));
  connect(ventilationUnit3.port_a4, genericAHU.port_a5) annotation (Line(points
        ={{422.8,236},{424,236},{424,174},{-38.1818,174},{-38.1818,220}}, color
        ={0,127,255}));
  connect(ventilationUnit3.port_b4, genericAHU.port_b5) annotation (Line(points
        ={{430.02,236},{432,236},{432,184},{-27.8182,184},{-27.8182,220}},
        color={0,127,255}));
  connect(ctrVentilationUnitBasic3.genericAHUBus, ventilationUnit3.genericAHUBus)
    annotation (Line(
      points={{408,293.07},{419,293.07},{419,280.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit4.port_a3, tabs.port_a2) annotation (Line(points={{
          517.6,242},{517.6,100},{152,100},{152,120}}, color={0,127,255}));
  connect(ventilationUnit4.port_b3, tabs.port_b2) annotation (Line(points={{
          525.2,242},{524,242},{524,80},{176,80},{176,120.364}}, color={0,127,
          255}));
  connect(genericAHU.port_a2, ventilationUnit4.port_b2)
    annotation (Line(points={{0.545455,274},{510.38,274}}, color={0,127,255}));
  connect(genericAHU.port_b1, ventilationUnit4.port_a1) annotation (Line(points
        ={{0.545455,250},{510,250},{510,262}}, color={0,127,255}));
  connect(ventilationUnit4.port_a4, genericAHU.port_a5) annotation (Line(points
        ={{532.8,242},{532,242},{532,174},{-38.1818,174},{-38.1818,220}}, color
        ={0,127,255}));
  connect(ventilationUnit4.port_b4, genericAHU.port_b5) annotation (Line(points
        ={{540.02,242},{540,242},{540,184},{-27.8182,184},{-27.8182,220}},
        color={0,127,255}));
  connect(ctrVentilationUnitBasic4.genericAHUBus, ventilationUnit4.genericAHUBus)
    annotation (Line(
      points={{516,293.07},{529,293.07},{529,286.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationUnit.port_b1, thermalZone.ports[1]) annotation (Line(
        points={{70.38,256},{134.24,256},{134.24,341.92}}, color={0,127,255}));
  connect(ventilationUnit.port_a2, thermalZone.ports[2]) annotation (Line(
        points={{70,268},{92,268},{92,266},{141.76,266},{141.76,341.92}}, color
        ={0,127,255}));
  connect(ventilationUnit1.port_b1, thermalZone1.ports[1]) annotation (Line(
        points={{240.38,256},{252.24,256},{252.24,341.64}}, color={0,127,255}));
  connect(ventilationUnit1.port_a2, thermalZone1.ports[2]) annotation (Line(
        points={{240,268},{259.76,268},{259.76,341.64}}, color={0,127,255}));
  connect(ventilationUnit2.port_b1, thermalZone2.ports[1]) annotation (Line(
        points={{338.38,256},{356.71,256},{356.71,341.64}}, color={0,127,255}));
  connect(ventilationUnit2.port_a2, thermalZone2.ports[2]) annotation (Line(
        points={{338,268},{363.29,268},{363.29,341.64}}, color={0,127,255}));
  connect(ventilationUnit3.port_b1, thermalZone3.ports[1]) annotation (Line(
        points={{438.38,256},{453.945,256},{453.945,341.92}}, color={0,127,255}));
  connect(ventilationUnit3.port_a2, thermalZone3.ports[2]) annotation (Line(
        points={{438,268},{460.055,268},{460.055,341.92}}, color={0,127,255}));
  connect(ventilationUnit4.port_b1, thermalZone4.ports[1]) annotation (Line(
        points={{548.38,262},{552,262},{552,344.2},{549.475,344.2}}, color={0,
          127,255}));
  connect(ventilationUnit4.port_a2, thermalZone4.ports[2]) annotation (Line(
        points={{548,274},{548,310},{548,344.2},{556.525,344.2}}, color={0,127,
          255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{360,200}})), Icon(
        coordinateSystem(extent={{-200,-120},{360,200}})),
    experiment(
      StopTime=86400,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Dassl"));
end BenchmarkBuilding;
