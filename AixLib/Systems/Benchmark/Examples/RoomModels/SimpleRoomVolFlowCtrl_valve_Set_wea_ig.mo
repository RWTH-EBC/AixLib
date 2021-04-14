within AixLib.Systems.Benchmark.Examples.RoomModels;
model SimpleRoomVolFlowCtrl_valve_Set_wea_ig
    extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  AixLib.Systems.ModularAHU.VentilationUnit
                             ventilationUnit1(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=0.129,
    m2_flow_nominal=1,
    allowFlowReversal2=false,
    cooler(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=1000,
        dT_nom=4,
        Q_nom=2000)),
    heater(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=0.5,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=1000,
        dT_nom=7,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{-80,-12},{-34,38}})));
  AixLib.Systems.Benchmark.Tabs2
        tabs4_1(
    redeclare package Medium = MediumWater,
    area=48,
    thickness=0.05,
    cp=1000,
    alpha=20,
    pipe(cPip=500),
    dynamicHX1(nNodes=6, Q_nom=10000000),
    dynamicHX(nNodes=6, Q_nom=10000000))
    annotation (Placement(transformation(extent={{20,-60},{60,-20}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,54},{-42,86}}),
    iconTransformation(extent={{-150,388},{-130,408}})));

  AixLib.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumAir,
    p=bou1.p + 400,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-108,6},{-94,20}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,22},{-94,36}})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-90})));
  AixLib.Fluid.Sources.Boundary_pT bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,-86})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-126})));
  AixLib.Fluid.Sources.Boundary_pT bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=283.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-126})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{94,60},{114,80}})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,-128})));
  Modelica.Blocks.Interfaces.RealInput valveTabsHotSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,148},{-128,188}})));
  Modelica.Blocks.Interfaces.RealInput valveTabsColdSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,126},{-128,166}})));
  Modelica.Blocks.Interfaces.RealInput valveAHUCoolerSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,106},{-128,146}})));
  Modelica.Blocks.Interfaces.RealInput valveHeaterSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-168,94},{-128,134}})));
  Controller.CtrTabsValveSet ctrTabsValveSet(
    rpm_pump=3500,
    ctrThrottleValveCtr(rpm_pump=3500),
    ctrThrottleValveCtr1(rpm_pump=3500),
    ctrPump(rpm_pump=3000))
    annotation (Placement(transformation(extent={{-106,152},{-86,172}})));
  ModularAHU.Controller.CtrVentilationUnitValveSet ctrVentilationUnitValveSet(VFlowSet=
        3*129/3600)
    annotation (Placement(transformation(extent={{-104,112},{-84,132}})));

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-144,64},{-124,84}})));

  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=BaseClasses.Ashrae140_900(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{6,34},{56,80}})));
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
    annotation(Placement(transformation(extent={{4,-15},{18,-1}})));

equation
  connect(bou.ports[1], ventilationUnit1.port_a1)
    annotation (Line(points={{-94,13},{-80,13}}, color={0,127,255}));
  connect(bou.T_in, weaBus.TDryBul) annotation (Line(points={{-109.4,15.8},{
          -118,15.8},{-118,92},{-59,92},{-59,70}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bou1.ports[1], ventilationUnit1.port_b2) annotation (Line(points={{
          -94,29},{-94,28},{-79.54,28}}, color={0,127,255}));
  connect(bouWaterhot1.ports[1], ventilationUnit1.port_b4) annotation (Line(
        points={{-20,-76},{-44,-76},{-44,-12},{-43.66,-12}}, color={0,127,255}));
  connect(bouWaterhot1.ports[2], tabs4_1.port_b1) annotation (Line(points={{-16,-76},
          {56,-76},{56,-59.6364}},      color={0,127,255}));
  connect(tabs4_1.port_a1, bouWaterhot.ports[1]) annotation (Line(points={{24,-60},
          {24,-80},{22,-80}},        color={0,127,255}));
  connect(bouWatercold.ports[1], tabs4_1.port_a2) annotation (Line(points={{-8,-116},
          {2,-116},{2,-102},{32,-102},{32,-60}},       color={0,127,255}));
  connect(bouWatercold1.ports[1], tabs4_1.port_b2) annotation (Line(points={{48,-116},
          {48,-59.6364}},                 color={0,127,255}));
  connect(bouWatercold1.ports[2], ventilationUnit1.port_b3) annotation (Line(
        points={{52,-116},{52,-112},{-62,-112},{-62,-12},{-61.6,-12}}, color={0,
          127,255}));
  connect(ctrTabsValveSet.tabsBus, tabs4_1.tabsBus) annotation (Line(
      points={{-86,162},{-14,162},{-14,-41.6364},{19.8,-41.6364}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrTabsValveSet.valveHotSet, valveTabsHotSet) annotation (Line(points=
         {{-106.3,166.1},{-118.15,166.1},{-118.15,168},{-148,168}}, color={0,0,
          127}));
  connect(ctrTabsValveSet.valveColdSet, valveTabsColdSet) annotation (Line(
        points={{-106.3,157.9},{-119.15,157.9},{-119.15,146},{-148,146}}, color=
         {0,0,127}));
  connect(ctrVentilationUnitValveSet.genericAHUBus, ventilationUnit1.genericAHUBus)
    annotation (Line(
      points={{-84,122.1},{-70,122.1},{-70,43.25},{-57,43.25}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrVentilationUnitValveSet.VsetCooler, valveAHUCoolerSet) annotation (
     Line(points={{-104.2,130.6},{-117.1,130.6},{-117.1,126},{-148,126}}, color=
         {0,0,127}));
  connect(ctrVentilationUnitValveSet.VsetHeater, valveHeaterSet) annotation (
      Line(points={{-104.1,122.5},{-119.05,122.5},{-119.05,114},{-148,114}},
        color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-124,74},{-92,74},{-92,70},{-59,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bouWaterhot2.ports[1], ventilationUnit1.port_a4) annotation (Line(
        points={{-52,-118},{-52,-12},{-52.4,-12}}, color={0,127,255}));
  connect(bouWatercold.ports[2], ventilationUnit1.port_a3) annotation (Line(
        points={{-4,-116},{-72,-116},{-72,-12},{-70.8,-12}}, color={0,127,255}));
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-59,70},{-26,70},{-26,57},{6,57}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{58.5,70.8},{
          73.25,70.8},{73.25,70},{104,70}}, color={0,0,127}));
  connect(ventilationUnit1.port_b1, thermalZone1.ports[1]) annotation (Line(
        points={{-33.54,13},{32.23,13},{32.23,40.44},{25.125,40.44}}, color={0,
          127,255}));
  connect(ventilationUnit1.port_a2, thermalZone1.ports[2]) annotation (Line(
        points={{-34,28},{24,28},{24,40.44},{36.875,40.44}}, color={0,127,255}));
  connect(tabs4_1.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{40,
          -18.1818},{56,-18.1818},{56,45.5}},      color={191,0,0}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{
          18.7,-8},{52,-8},{52,37.68},{51,37.68}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3600000, __Dymola_Algorithm="Dassl"));
end SimpleRoomVolFlowCtrl_valve_Set_wea_ig;
