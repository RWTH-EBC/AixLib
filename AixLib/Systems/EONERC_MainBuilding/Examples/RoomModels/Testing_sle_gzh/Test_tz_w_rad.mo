within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test_tz_w_rad
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{80,-8},{100,12}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare AixLib.Systems.EONERC_MainBuilding.BaseClasses.ASHRAE140_900
      zoneParam(T_start(displayUnit="K") = 290.15),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start(displayUnit="K") = 290.65,
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
    annotation (Placement(transformation(extent={{274,38},{294,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        1].Q_flow)
    annotation (Placement(transformation(extent={{274,62},{294,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        4].Q_flow)
              annotation (Placement(transformation(extent={{272,84},{292,104}})));
  Modelica.Blocks.Interfaces.RealOutput int_sol "Value of Real output"
    annotation (Placement(transformation(extent={{312,38},{332,58}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Interfaces.RealOutput ext_sol "Value of Real output"
    annotation (Placement(transformation(extent={{312,62},{332,82}}),
        iconTransformation(extent={{272,-68},{292,-48}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sol "Value of Real output"
    annotation (Placement(transformation(extent={{310,84},{330,104}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=thermalZone1.ROM.thermSplitterSolRad.portIn[
        1].Q_flow)
    annotation (Placement(transformation(extent={{274,12},{294,32}})));
  Modelica.Blocks.Interfaces.RealOutput sol_in "Value of Real output"
    annotation (Placement(transformation(extent={{312,12},{332,32}}),
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
  Modelica.Blocks.Sources.RealExpression realExpression11(y=thermalZone1.ROM.intWallRC.thermCapInt[
        1].T) annotation (Placement(transformation(extent={{196,82},{216,102}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.extWallRC.thermCapExt[
        1].T) annotation (Placement(transformation(extent={{194,58},{214,78}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{196,36},{216,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=thermalZone1.ROM.roofRC.thermCapExt[
        1].T)
    annotation (Placement(transformation(extent={{198,16},{218,36}})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output"
    annotation (Placement(transformation(extent={{234,82},{254,102}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output"
    annotation (Placement(transformation(extent={{232,58},{252,78}}),
        iconTransformation(extent={{280,-112},{300,-92}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output"
    annotation (Placement(transformation(extent={{234,36},{254,56}}),
        iconTransformation(extent={{282,-134},{302,-114}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output"
    annotation (Placement(transformation(extent={{236,16},{256,36}}),
        iconTransformation(extent={{284,-178},{304,-158}})));
  Modelica.Blocks.Interfaces.RealOutput T_amb "Value of Real output"
    annotation (Placement(transformation(extent={{-34,44},{-14,64}}),
        iconTransformation(extent={{284,-178},{304,-158}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-101,38},{-67,70}}), iconTransformation(
    extent={{-110,50},{-90,70}})));
  Fluid.Sources.MassFlowSource_T
                           source(
    redeclare package Medium = Media.Water,
    use_T_in=true,
    m_flow=0.02761,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{-4,-132},{16,-112}})));
  Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = Media.Water, nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{164,-136},{144,-116}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=1,
    dp_nominal=100000)
    "Pipe"
    annotation (Placement(transformation(extent={{112,-134},{132,-114}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=radiator.ConvectiveHeat.Q_flow)
    annotation (Placement(transformation(extent={{-278,-2},{-258,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression18(y=radiator.RadiativeHeat.Q_flow)
    annotation (Placement(transformation(extent={{-278,-20},{-258,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-348,-32},{-328,-12}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-302,-46},{-282,-26}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-338,-66},{-318,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=radiator.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-380,-66},{-360,-46}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-262,-48},{-250,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-288,-78},{-268,-58}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-278,42},{-258,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=radiator.port_a.m_flow)
    annotation (Placement(transformation(extent={{-278,78},{-258,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression21(y=radiator.FlowTemperature.T)
    annotation (Placement(transformation(extent={{-278,58},{-258,78}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Value of Real output"
    annotation (Placement(transformation(extent={{-242,-2},{-222,18}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad "Value of Real output"
    annotation (Placement(transformation(extent={{-242,-20},{-222,0}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-214,-64},{-194,-44}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-240,42},{-220,62}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow "Value of Real output"
    annotation (Placement(transformation(extent={{-240,78},{-220,98}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_sensor "Value of Real output"
    annotation (Placement(transformation(extent={{-240,58},{-220,78}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{-198,78},{-178,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{-198,62},{-178,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-198,46},{-178,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression22(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-200,28},{-180,48}})));
  Modelica.Blocks.Sources.RealExpression realExpression23(y=radiator.multiLayer_HE[
        1].convective.Q_flow)
    annotation (Placement(transformation(extent={{-198,12},{-178,32}})));
  Modelica.Blocks.Sources.RealExpression realExpression24(y=radiator.multiLayer_HE[
        1].FlowTemperature.T)
    annotation (Placement(transformation(extent={{-198,-20},{-178,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression25(y=radiator.multiLayer_HE[
        1].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-198,-34},{-178,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression26(y=radiator.multiLayer_HE[
        1].radiative.Q_flow)
    annotation (Placement(transformation(extent={{-198,-2},{-178,18}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{-162,78},
            {-142,98}}),     iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{-162,62},
            {-142,82}}),       iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,46},{-142,66}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,28},{-142,48}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,12},{-142,32}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,-20},{-142,0}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,-34},{-142,-14}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad1 "Value of Real output"
    annotation (Placement(transformation(extent={{-162,-2},{-142,18}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression28(y=thermalZone1.ROM.convIntWall.solid.T)
    annotation (Placement(transformation(extent={{264,-66},{284,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression29(y=thermalZone1.ROM.convExtWall.solid.T)
    annotation (Placement(transformation(extent={{264,-42},{284,-22}})));
  Modelica.Blocks.Sources.RealExpression realExpression27(y=thermalZone1.ROM.convRoof.solid.T)
              annotation (Placement(transformation(extent={{262,-20},{282,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression33(y=thermalZone1.ROM.convWin.solid.T)
    annotation (Placement(transformation(extent={{264,-92},{284,-72}})));
  Modelica.Blocks.Interfaces.RealOutput int_sur "Value of Real output"
    annotation (Placement(transformation(extent={{302,-66},{322,-46}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Interfaces.RealOutput ext_sur "Value of Real output"
    annotation (Placement(transformation(extent={{302,-42},{322,-22}}),
        iconTransformation(extent={{272,-68},{292,-48}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sur "Value of Real output"
    annotation (Placement(transformation(extent={{300,-20},{320,0}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Interfaces.RealOutput win_sur
                                               "Value of Real output"
    annotation (Placement(transformation(extent={{302,-92},{322,-72}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{178,-22},{190,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{138,-18},{158,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{138,-32},{158,-12}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{138,-48},{158,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression17(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{140,-64},{160,-44}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{212,-32},{232,-12}})));
  Modelica.Blocks.Interfaces.RealOutput TRad
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{72,-30},{92,-10}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    T_start(displayUnit="K") = 293.15,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
        NominalPower=496,
        RT_nom=Modelica.Units.Conversions.from_degC({55,45,20}),
        PressureDrop=1017878,
        Exponent=1.2776,
        VolumeWater=3.6,
        MassSteel=17.01,
        DensitySteel=7900,
        CapacitySteel=551,
        LambdaSteel=60,
        Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator10,
        length=2.6,
        height=0.3),
    N=16,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{52,-130},{72,-110}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=radiator.multiLayer_HE[
        2].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-312,-104},{-292,-84}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_2 "Value of Real output"
    annotation (Placement(transformation(extent={{-276,-104},{-256,-84}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=radiator.multiLayer_HE[
        3].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-312,-126},{-292,-106}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_3 "Value of Real output"
    annotation (Placement(transformation(extent={{-276,-126},{-256,-106}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression35(y=radiator.multiLayer_HE[
        4].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-316,-150},{-296,-130}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_4 "Value of Real output"
    annotation (Placement(transformation(extent={{-280,-150},{-260,-130}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression37(y=radiator.multiLayer_HE[
        5].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-314,-176},{-294,-156}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_5 "Value of Real output"
    annotation (Placement(transformation(extent={{-276,-176},{-256,-156}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression36(y=radiator.multiLayer_HE[
        6].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-318,-200},{-298,-180}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_6 "Value of Real output"
    annotation (Placement(transformation(extent={{-280,-200},{-260,-180}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression38(y=radiator.multiLayer_HE[
        7].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-226,-100},{-206,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression39(y=radiator.multiLayer_HE[
        8].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-226,-122},{-206,-102}})));
  Modelica.Blocks.Sources.RealExpression realExpression40(y=radiator.multiLayer_HE[
        9].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-230,-146},{-210,-126}})));
  Modelica.Blocks.Sources.RealExpression realExpression41(y=radiator.multiLayer_HE[
        10].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-228,-172},{-208,-152}})));
  Modelica.Blocks.Sources.RealExpression realExpression42(y=radiator.multiLayer_HE[
        11].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-232,-196},{-212,-176}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_7 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,-100},{-170,-80}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_8 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,-122},{-170,-102}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_9 "Value of Real output"
    annotation (Placement(transformation(extent={{-194,-146},{-174,-126}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_10
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-190,-172},{-170,-152}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_11
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-194,-196},{-174,-176}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression46(y=radiator.multiLayer_HE[
        12].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-146,-98},{-126,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression47(y=radiator.multiLayer_HE[
        13].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-146,-120},{-126,-100}})));
  Modelica.Blocks.Sources.RealExpression realExpression48(y=radiator.multiLayer_HE[
        14].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-150,-144},{-130,-124}})));
  Modelica.Blocks.Sources.RealExpression realExpression49(y=radiator.multiLayer_HE[
        15].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-148,-170},{-128,-150}})));
  Modelica.Blocks.Sources.RealExpression realExpression50(y=radiator.multiLayer_HE[
        16].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-152,-194},{-132,-174}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_12
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-110,-98},{-90,-78}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_13
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-110,-120},{-90,-100}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_14
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-114,-144},{-94,-124}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_15
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-110,-170},{-90,-150}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_16
                                                       "Value of Real output"
    annotation (Placement(transformation(extent={{-114,-194},{-94,-174}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealInput T_in "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-40,-142},{0,-102}})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-108,40},{-46,40},{-46,-3.6},{-24,-3.6}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{34.8,2.2},{
          62.4,2.2},{62.4,2},{90,2}},             color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{26,
          -68.3},{26,-56.83},{26.4,-56.83},{26.4,-45.36}}, color={0,0,127}));
  connect(boundaryExhaustAir.ports[1], thermalZone1.ports[1]) annotation (Line(
        points={{-36,-68},{4,-68},{4,-41.88}},              color={0,127,255}));
  connect(realExpression1.y, roof_sol)
    annotation (Line(points={{293,94},{320,94}},   color={0,0,127}));
  connect(realExpression2.y, ext_sol)
    annotation (Line(points={{295,72},{322,72}},   color={0,0,127}));
  connect(realExpression3.y, int_sol)
    annotation (Line(points={{295,48},{322,48}},   color={0,0,127}));
  connect(realExpression5.y, sol_in)
    annotation (Line(points={{295,22},{322,22}},     color={0,0,127}));
  connect(realExpression6.y, preTemRoof)
    annotation (Line(points={{137,88},{164,88}}, color={0,0,127}));
  connect(realExpression7.y, preTemWin)
    annotation (Line(points={{141,44},{166,44}}, color={0,0,127}));
  connect(realExpression8.y, preTemWall)
    annotation (Line(points={{139,66},{166,66}}, color={0,0,127}));
  connect(realExpression11.y, T_IntWall)
    annotation (Line(points={{217,92},{244,92}}, color={0,0,127}));
  connect(realExpression9.y,T_ExtWall)
    annotation (Line(points={{215,68},{242,68}}, color={0,0,127}));
  connect(realExpression10.y, T_Win)
    annotation (Line(points={{217,46},{244,46}},   color={0,0,127}));
  connect(realExpression12.y, T_Roof)
    annotation (Line(points={{219,26},{246,26}},   color={0,0,127}));
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
  connect(res.port_b,sink. ports[1])
    annotation (Line(points={{132,-124},{132,-126},{144,-126}},
                                                    color={0,127,255}));
  connect(realExpression13.y, Q_conv)
    annotation (Line(points={{-257,8},{-232,8}}, color={0,0,127}));
  connect(realExpression18.y, Q_rad)
    annotation (Line(points={{-257,-10},{-232,-10}}, color={0,0,127}));
  connect(realExpression43.y,add. u1) annotation (Line(points={{-327,-22},{-314,
          -22},{-314,-30},{-304,-30}}, color={0,0,127}));
  connect(realExpression44.y,gain. u)
    annotation (Line(points={{-359,-56},{-340,-56}}, color={0,0,127}));
  connect(gain.y,add. u2) annotation (Line(points={{-317,-56},{-310,-56},{-310,
          -50},{-312,-50},{-312,-42},{-304,-42}}, color={0,0,127}));
  connect(add.y,multiProduct. u[1]) annotation (Line(points={{-281,-36},{-268,
          -36},{-268,-43.05},{-262,-43.05}}, color={0,0,127}));
  connect(realExpression45.y,multiProduct. u[2]) annotation (Line(points={{-267,
          -68},{-262,-68},{-262,-52},{-266,-52},{-266,-40.95},{-262,-40.95}},
        color={0,0,127}));
  connect(multiProduct.y,Q_flow_sum)  annotation (Line(points={{-248.98,-42},{
          -220,-42},{-220,-54},{-204,-54}}, color={0,0,127}));
  connect(realExpression34.y,T_flow_out)
    annotation (Line(points={{-257,52},{-230,52}},   color={0,0,127}));
  connect(realExpression19.y, m_flow)
    annotation (Line(points={{-257,88},{-230,88}}, color={0,0,127}));
  connect(realExpression21.y, T_flow_sensor)
    annotation (Line(points={{-257,68},{-230,68}}, color={0,0,127}));
  connect(T_flow_out,T_flow_out)
    annotation (Line(points={{-230,52},{-230,52}}, color={0,0,127}));
  connect(realExpression30.y,T_radwall_inside1)
    annotation (Line(points={{-177,88},{-152,88}},
                                                 color={0,0,127}));
  connect(realExpression31.y,T_radwall_outside1)
    annotation (Line(points={{-177,72},{-152,72}},   color={0,0,127}));
  connect(realExpression32.y,T_radiator_m_1)
    annotation (Line(points={{-177,56},{-152,56}},
                                                 color={0,0,127}));
  connect(realExpression22.y, Q_flow1)
    annotation (Line(points={{-179,38},{-152,38}}, color={0,0,127}));
  connect(realExpression23.y, Q_conv1)
    annotation (Line(points={{-177,22},{-152,22}}, color={0,0,127}));
  connect(realExpression24.y,T_flow_in1)
    annotation (Line(points={{-177,-10},{-152,-10}},
                                                 color={0,0,127}));
  connect(realExpression25.y,T_flow_out1)
    annotation (Line(points={{-177,-24},{-152,-24}},
                                                   color={0,0,127}));
  connect(realExpression26.y, Q_rad1)
    annotation (Line(points={{-177,8},{-152,8}}, color={0,0,127}));
  connect(realExpression27.y,roof_sur)
    annotation (Line(points={{283,-10},{310,-10}}, color={0,0,127}));
  connect(realExpression29.y,ext_sur)
    annotation (Line(points={{285,-32},{312,-32}}, color={0,0,127}));
  connect(realExpression28.y,int_sur)
    annotation (Line(points={{285,-56},{312,-56}}, color={0,0,127}));
  connect(realExpression33.y,win_sur)
    annotation (Line(points={{285,-82},{312,-82}}, color={0,0,127}));
  connect(multiSum.y,solar_radiation)  annotation (Line(points={{191.02,-16},{
          206,-16},{206,-22},{222,-22}}, color={0,0,127}));
  connect(realExpression14.y,multiSum. u[1]) annotation (Line(points={{159,-8},
          {172,-8},{172,-17.575},{178,-17.575}},  color={0,0,127}));
  connect(realExpression15.y,multiSum. u[2]) annotation (Line(points={{159,-22},
          {172,-22},{172,-16.525},{178,-16.525}},  color={0,0,127}));
  connect(realExpression16.y,multiSum. u[3]) annotation (Line(points={{159,-38},
          {172,-38},{172,-15.475},{178,-15.475}},  color={0,0,127}));
  connect(realExpression17.y,multiSum. u[4]) annotation (Line(points={{161,-54},
          {172,-54},{172,-14.425},{178,-14.425}},  color={0,0,127}));
  connect(thermalZone1.TRad, TRad) annotation (Line(points={{34.8,-3.6},{82,
          -3.6},{82,-20}}, color={0,0,127}));
  connect(radiator.port_a, source.ports[1]) annotation (Line(points={{52,-120},
          {50,-120},{50,-122},{16,-122}}, color={0,127,255}));
  connect(radiator.port_b, res.port_a) annotation (Line(points={{72,-120},{106,
          -120},{106,-124},{112,-124}}, color={0,127,255}));
  connect(thermalZone1.intGainsRad, radiator.RadiativeHeat) annotation (Line(
        points={{32.56,-11.14},{66,-11.14},{66,-104},{78,-104},{78,-118},{66,
          -118}}, color={191,0,0}));
  connect(radiator.ConvectiveHeat, thermalZone1.intGainsConv) annotation (Line(
        points={{60,-118},{42,-118},{42,-19.84},{32.56,-19.84}}, color={191,0,0}));
  connect(realExpression4.y, T_radiator_m_2)
    annotation (Line(points={{-291,-94},{-266,-94}}, color={0,0,127}));
  connect(realExpression20.y, T_radiator_m_3)
    annotation (Line(points={{-291,-116},{-266,-116}}, color={0,0,127}));
  connect(realExpression35.y, T_radiator_m_4)
    annotation (Line(points={{-295,-140},{-270,-140}}, color={0,0,127}));
  connect(realExpression37.y, T_radiator_m_5)
    annotation (Line(points={{-293,-166},{-266,-166}}, color={0,0,127}));
  connect(realExpression36.y, T_radiator_m_6)
    annotation (Line(points={{-297,-190},{-270,-190}}, color={0,0,127}));
  connect(realExpression38.y, T_radiator_m_7)
    annotation (Line(points={{-205,-90},{-180,-90}}, color={0,0,127}));
  connect(realExpression39.y, T_radiator_m_8)
    annotation (Line(points={{-205,-112},{-180,-112}}, color={0,0,127}));
  connect(realExpression40.y, T_radiator_m_9)
    annotation (Line(points={{-209,-136},{-184,-136}}, color={0,0,127}));
  connect(realExpression41.y, T_radiator_m_10)
    annotation (Line(points={{-207,-162},{-180,-162}}, color={0,0,127}));
  connect(realExpression42.y, T_radiator_m_11)
    annotation (Line(points={{-211,-186},{-184,-186}}, color={0,0,127}));
  connect(realExpression46.y, T_radiator_m_12)
    annotation (Line(points={{-125,-88},{-100,-88}}, color={0,0,127}));
  connect(realExpression47.y, T_radiator_m_13)
    annotation (Line(points={{-125,-110},{-100,-110}}, color={0,0,127}));
  connect(realExpression48.y, T_radiator_m_14)
    annotation (Line(points={{-129,-134},{-104,-134}}, color={0,0,127}));
  connect(realExpression49.y, T_radiator_m_15)
    annotation (Line(points={{-127,-160},{-100,-160}}, color={0,0,127}));
  connect(realExpression50.y, T_radiator_m_16)
    annotation (Line(points={{-131,-184},{-104,-184}}, color={0,0,127}));
  connect(source.T_in, T_in) annotation (Line(points={{-6,-118},{-14,-118},{-14,
          -122},{-20,-122}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Test_tz_w_rad;
