within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model Ashrae140_ideal_heater_with_capacity
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare AixLib.Systems.EONERC_MainBuilding.BaseClasses.ASHRAE140_900 zoneParam,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=1) "Thermal zone"
    annotation (Placement(transformation(extent={{-24,-50},{32,8}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/City_Aachen_2018.mos"))
    "Weather data reader 2018"
    annotation (Placement(transformation(extent={{-128,30},{-108,50}})));

  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
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
        0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0],
    timeEvents=Modelica.Blocks.Types.TimeEvents.AtDiscontinuities)
    "Table with profiles for internal gains 2018" annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={26,-76})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
        MediumAir, nPorts=1)
                          annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-40,-68})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        3].Q_flow)
    annotation (Placement(transformation(extent={{124,-108},{144,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        1].Q_flow)
    annotation (Placement(transformation(extent={{124,-84},{144,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        4].Q_flow)
              annotation (Placement(transformation(extent={{122,-62},{142,-42}})));
  Modelica.Blocks.Interfaces.RealOutput int_sol "Value of Real output"
    annotation (Placement(transformation(extent={{162,-108},{182,-88}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Interfaces.RealOutput ext_sol "Value of Real output"
    annotation (Placement(transformation(extent={{162,-84},{182,-64}}),
        iconTransformation(extent={{272,-68},{292,-48}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sol "Value of Real output"
    annotation (Placement(transformation(extent={{160,-62},{180,-42}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        4].Q_flow)
              annotation (Placement(transformation(extent={{108,-4},{128,16}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sol1 "Value of Real output"
    annotation (Placement(transformation(extent={{146,-4},{166,16}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=thermalZone1.ROM.thermSplitterSolRad.portIn[
        1].Q_flow)
    annotation (Placement(transformation(extent={{124,-134},{144,-114}})));
  Modelica.Blocks.Interfaces.RealOutput sol_in "Value of Real output"
    annotation (Placement(transformation(extent={{162,-134},{182,-114}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=thermalZone1.preTemRoof.T)
              annotation (Placement(transformation(extent={{116,78},{136,98}})));
  Modelica.Blocks.Interfaces.RealOutput preTemRoof "Value of Real output"
    annotation (Placement(transformation(extent={{154,78},{174,98}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=thermalZone1.preTemWin.T)
              annotation (Placement(transformation(extent={{120,34},{140,54}})));
  Modelica.Blocks.Interfaces.RealOutput preTemWin "Value of Real output"
    annotation (Placement(transformation(extent={{156,34},{176,54}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=thermalZone1.preTemWall.T)
              annotation (Placement(transformation(extent={{118,56},{138,76}})));
  Modelica.Blocks.Interfaces.RealOutput preTemWall "Value of Real output"
    annotation (Placement(transformation(extent={{156,56},{176,76}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=thermalZone1.ROM.intWallRC.thermCapInt[
        1].T) annotation (Placement(transformation(extent={{218,12},{238,32}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.extWallRC.thermCapExt[
        1].T) annotation (Placement(transformation(extent={{216,-12},{236,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{218,-34},{238,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=thermalZone1.ROM.roofRC.thermCapExt[
        1].T)
    annotation (Placement(transformation(extent={{220,-54},{240,-34}})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output"
    annotation (Placement(transformation(extent={{256,12},{276,32}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output"
    annotation (Placement(transformation(extent={{254,-12},{274,8}}),
        iconTransformation(extent={{280,-112},{300,-92}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output"
    annotation (Placement(transformation(extent={{256,-34},{276,-14}}),
        iconTransformation(extent={{282,-134},{302,-114}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output"
    annotation (Placement(transformation(extent={{258,-54},{278,-34}}),
        iconTransformation(extent={{284,-178},{304,-158}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{118,-166},{98,-146}})));
  Modelica.Blocks.Interfaces.RealInput QFlowSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{174,-176},{134,-136}})));
  Modelica.Blocks.Interfaces.RealOutput T_amb "Value of Real output"
    annotation (Placement(transformation(extent={{-34,44},{-14,64}}),
        iconTransformation(extent={{284,-178},{304,-158}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-101,38},{-67,70}}), iconTransformation(
    extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{248,-100},{260,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{208,-96},{228,-76}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{208,-110},{228,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{208,-126},{228,-106}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{210,-142},{230,-122}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{282,-110},{302,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,-128})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,-96})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{38,-100},{48,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=heatCapacitor.T)
    annotation (Placement(transformation(extent={{220,-72},{240,-52}})));
  Modelica.Blocks.Interfaces.RealOutput T_Capacity "Value of Real output"
    annotation (Placement(transformation(extent={{258,-72},{278,-52}}),
        iconTransformation(extent={{284,-178},{304,-158}})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-108,40},{-46,40},{-46,-3.6},{-24,-3.6}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{34.8,2.2},{94,
          2.2},{94,-20},{110,-20}},               color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{26,
          -68.3},{26,-56.83},{26.4,-56.83},{26.4,-45.36}}, color={0,0,127}));
  connect(boundaryExhaustAir.ports[1], thermalZone1.ports[1]) annotation (Line(
        points={{-36,-68},{4,-68},{4,-41.88}},              color={0,127,255}));
  connect(realExpression1.y, roof_sol)
    annotation (Line(points={{143,-52},{170,-52}}, color={0,0,127}));
  connect(realExpression2.y, ext_sol)
    annotation (Line(points={{145,-74},{172,-74}}, color={0,0,127}));
  connect(realExpression3.y, int_sol)
    annotation (Line(points={{145,-98},{172,-98}}, color={0,0,127}));
  connect(realExpression4.y, roof_sol1)
    annotation (Line(points={{129,6},{156,6}}, color={0,0,127}));
  connect(realExpression5.y, sol_in)
    annotation (Line(points={{145,-124},{172,-124}}, color={0,0,127}));
  connect(realExpression6.y, preTemRoof)
    annotation (Line(points={{137,88},{164,88}}, color={0,0,127}));
  connect(realExpression7.y, preTemWin)
    annotation (Line(points={{141,44},{166,44}}, color={0,0,127}));
  connect(realExpression8.y, preTemWall)
    annotation (Line(points={{139,66},{166,66}}, color={0,0,127}));
  connect(realExpression.y,T_IntWall)
    annotation (Line(points={{239,22},{266,22}}, color={0,0,127}));
  connect(realExpression9.y,T_ExtWall)
    annotation (Line(points={{237,-2},{264,-2}}, color={0,0,127}));
  connect(realExpression10.y, T_Win)
    annotation (Line(points={{239,-24},{266,-24}}, color={0,0,127}));
  connect(realExpression12.y, T_Roof)
    annotation (Line(points={{241,-44},{268,-44}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-108,40},{-84,40},{-84,54}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, T_amb) annotation (Line(
      points={{-84,54},{-24,54}},
      color={255,204,51},
      thickness=0.5));
  connect(T_amb, T_amb)
    annotation (Line(points={{-24,54},{-24,54}}, color={0,0,127}));
  connect(multiSum.y,solar_radiation)  annotation (Line(points={{261.02,-94},{
          276,-94},{276,-100},{292,-100}},
                                         color={0,0,127}));
  connect(realExpression11.y, multiSum.u[1]) annotation (Line(points={{229,-86},
          {242,-86},{242,-95.575},{248,-95.575}}, color={0,0,127}));
  connect(realExpression13.y, multiSum.u[2]) annotation (Line(points={{229,-100},
          {242,-100},{242,-94.525},{248,-94.525}}, color={0,0,127}));
  connect(realExpression14.y, multiSum.u[3]) annotation (Line(points={{229,-116},
          {244,-116},{244,-93.475},{248,-93.475}}, color={0,0,127}));
  connect(realExpression15.y, multiSum.u[4]) annotation (Line(points={{231,-132},
          {244,-132},{244,-92.425},{248,-92.425}}, color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, QFlowSet)
    annotation (Line(points={{118,-156},{154,-156}},color={0,0,127}));
  connect(realExpression16.y, T_Capacity)
    annotation (Line(points={{241,-62},{268,-62}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, heatCapacitor.port) annotation (Line(points=
          {{98,-156},{58,-156},{58,-128},{52,-128}}, color={191,0,0}));
  connect(heatCapacitor.port, convection.solid)
    annotation (Line(points={{52,-128},{72,-128},{72,-106}}, color={191,0,0}));
  connect(const.y, convection.Gc)
    annotation (Line(points={{48.5,-95},{62,-95},{62,-96}}, color={0,0,127}));
  connect(convection.fluid, thermalZone1.intGainsConv) annotation (Line(points=
          {{72,-86},{72,-19.84},{32.56,-19.84}}, color={191,0,0}));
  annotation (experiment(
      StartTime=259200,
      StopTime=345600,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Ashrae140_ideal_heater_with_capacity;
