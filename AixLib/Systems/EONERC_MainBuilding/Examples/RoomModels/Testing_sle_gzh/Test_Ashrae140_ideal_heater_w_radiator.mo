within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test_Ashrae140_ideal_heater_w_radiator
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
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
    annotation (Placement(transformation(extent={{286,-36},{306,-16}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        1].Q_flow)
    annotation (Placement(transformation(extent={{286,-12},{306,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.thermSplitterSolRad.portOut[
        4].Q_flow)
              annotation (Placement(transformation(extent={{284,10},{304,30}})));
  Modelica.Blocks.Interfaces.RealOutput int_sol "Value of Real output"
    annotation (Placement(transformation(extent={{324,-36},{344,-16}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Interfaces.RealOutput ext_sol "Value of Real output"
    annotation (Placement(transformation(extent={{324,-12},{344,8}}),
        iconTransformation(extent={{272,-68},{292,-48}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sol "Value of Real output"
    annotation (Placement(transformation(extent={{322,10},{342,30}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=thermalZone1.ROM.thermSplitterSolRad.portIn[
        1].Q_flow)
    annotation (Placement(transformation(extent={{286,-62},{306,-42}})));
  Modelica.Blocks.Interfaces.RealOutput sol_in "Value of Real output"
    annotation (Placement(transformation(extent={{324,-62},{344,-42}}),
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
        1].T) annotation (Placement(transformation(extent={{200,80},{220,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.extWallRC.thermCapExt[
        1].T) annotation (Placement(transformation(extent={{198,56},{218,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{200,34},{220,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=thermalZone1.ROM.roofRC.thermCapExt[
        1].T)
    annotation (Placement(transformation(extent={{202,14},{222,34}})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output"
    annotation (Placement(transformation(extent={{238,80},{258,100}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output"
    annotation (Placement(transformation(extent={{236,56},{256,76}}),
        iconTransformation(extent={{280,-112},{300,-92}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output"
    annotation (Placement(transformation(extent={{238,34},{258,54}}),
        iconTransformation(extent={{282,-134},{302,-114}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output"
    annotation (Placement(transformation(extent={{240,14},{260,34}}),
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
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=true,
    m_flow=0.02761,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{18,-142},{38,-122}})));
  Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{186,-144},{166,-124}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    dp_nominal=100000)
    "Pipe"
    annotation (Placement(transformation(extent={{134,-144},{154,-124}})));
  Modelica.Blocks.Sources.RealExpression realExpression18(y=radiator.ConvectiveHeat.Q_flow)
    annotation (Placement(transformation(extent={{-338,-2},{-318,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=radiator.RadiativeHeat.Q_flow)
    annotation (Placement(transformation(extent={{-338,-20},{-318,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-312,42},{-292,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=radiator.port_a.m_flow)
    annotation (Placement(transformation(extent={{-312,78},{-292,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression21(y=radiator.FlowTemperature.T)
    annotation (Placement(transformation(extent={{-312,58},{-292,78}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Value of Real output"
    annotation (Placement(transformation(extent={{-276,-2},{-256,18}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad "Value of Real output"
    annotation (Placement(transformation(extent={{-276,-20},{-256,0}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-274,42},{-254,62}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow "Value of Real output"
    annotation (Placement(transformation(extent={{-274,78},{-254,98}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_sensor "Value of Real output"
    annotation (Placement(transformation(extent={{-274,58},{-254,78}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{-226,80},{-206,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{-226,64},{-206,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-226,48},{-206,68}})));
  Modelica.Blocks.Sources.RealExpression realExpression22(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-228,30},{-208,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression23(y=radiator.multiLayer_HE[
        1].convective.Q_flow)
    annotation (Placement(transformation(extent={{-226,14},{-206,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression24(y=radiator.multiLayer_HE[
        1].FlowTemperature.T)
    annotation (Placement(transformation(extent={{-226,-18},{-206,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression25(y=radiator.multiLayer_HE[
        1].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-226,-32},{-206,-12}})));
  Modelica.Blocks.Sources.RealExpression realExpression26(y=radiator.multiLayer_HE[
        1].radiative.Q_flow)
    annotation (Placement(transformation(extent={{-226,0},{-206,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{-190,80},
            {-170,100}}),    iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{-190,64},
            {-170,84}}),       iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,48},{-170,68}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,30},{-170,50}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,14},{-170,34}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,-18},{-170,2}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,-32},{-170,-12}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad1 "Value of Real output"
    annotation (Placement(transformation(extent={{-190,0},{-170,20}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-306,-54},{-286,-34}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-260,-68},{-240,-48}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-296,-88},{-276,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=radiator.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-338,-88},{-318,-68}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-220,-70},{-208,-58}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-246,-100},{-226,-80}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-172,-86},{-152,-66}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{326,82},{338,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{286,86},{306,106}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{286,72},{306,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{286,56},{306,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression17(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{288,40},{308,60}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{360,72},{380,92}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    T_start(displayUnit="K") = 293.15,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
        NominalPower=1157,
        RT_nom=Modelica.Units.Conversions.from_degC({55,45,20}),
        PressureDrop=1017878,
        Exponent=1.34,
        VolumeWater=10.2,
        MassSteel=46.1,
        DensitySteel=7900,
        CapacitySteel=551,
        LambdaSteel=60,
        Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator22,
        length=2.4,
        height=0.9),
    N=1,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{82,-144},{102,-124}})));
  Modelica.Blocks.Sources.Step step(
    startTime=7200,
    offset=313.15,
    height=5)
    annotation (Placement(transformation(extent={{-58,-154},{-38,-134}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-304,2},{-292,14}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-304,-16},{-292,-4}})));
  Modelica.Blocks.Interfaces.RealOutput TRad1
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{94,-14},{114,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.convIntWall.solid.T)
    annotation (Placement(transformation(extent={{190,-62},{210,-42}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=thermalZone1.ROM.convExtWall.solid.T)
    annotation (Placement(transformation(extent={{190,-38},{210,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression27(y=thermalZone1.ROM.convRoof.solid.T)
              annotation (Placement(transformation(extent={{188,-16},{208,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression28(y=thermalZone1.ROM.convWin.solid.T)
    annotation (Placement(transformation(extent={{190,-88},{210,-68}})));
  Modelica.Blocks.Interfaces.RealOutput int_sur "Value of Real output"
    annotation (Placement(transformation(extent={{228,-62},{248,-42}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
  Modelica.Blocks.Interfaces.RealOutput ext_sur "Value of Real output"
    annotation (Placement(transformation(extent={{228,-38},{248,-18}}),
        iconTransformation(extent={{272,-68},{292,-48}})));
  Modelica.Blocks.Interfaces.RealOutput roof_sur "Value of Real output"
    annotation (Placement(transformation(extent={{226,-16},{246,4}}),
        iconTransformation(extent={{270,-46},{290,-26}})));
  Modelica.Blocks.Interfaces.RealOutput win_sur
                                               "Value of Real output"
    annotation (Placement(transformation(extent={{228,-88},{248,-68}}),
        iconTransformation(extent={{272,-92},{292,-72}})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-108,40},{-46,40},{-46,-3.6},{-24,-3.6}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{34.8,2.2},{68,
          2.2},{68,34}},                          color={0,0,127}));
  connect(internalGains.y, thermalZone1.intGains) annotation (Line(points={{26,
          -68.3},{26,-56.83},{26.4,-56.83},{26.4,-45.36}}, color={0,0,127}));
  connect(boundaryExhaustAir.ports[1], thermalZone1.ports[1]) annotation (Line(
        points={{-36,-68},{4,-68},{4,-41.88}},              color={0,127,255}));
  connect(realExpression1.y, roof_sol)
    annotation (Line(points={{305,20},{332,20}},   color={0,0,127}));
  connect(realExpression2.y, ext_sol)
    annotation (Line(points={{307,-2},{334,-2}},   color={0,0,127}));
  connect(realExpression3.y, int_sol)
    annotation (Line(points={{307,-26},{334,-26}}, color={0,0,127}));
  connect(realExpression5.y, sol_in)
    annotation (Line(points={{307,-52},{334,-52}},   color={0,0,127}));
  connect(realExpression6.y, preTemRoof)
    annotation (Line(points={{137,88},{164,88}}, color={0,0,127}));
  connect(realExpression7.y, preTemWin)
    annotation (Line(points={{141,44},{166,44}}, color={0,0,127}));
  connect(realExpression8.y, preTemWall)
    annotation (Line(points={{139,66},{166,66}}, color={0,0,127}));
  connect(realExpression11.y, T_IntWall)
    annotation (Line(points={{221,90},{248,90}}, color={0,0,127}));
  connect(realExpression9.y,T_ExtWall)
    annotation (Line(points={{219,66},{246,66}}, color={0,0,127}));
  connect(realExpression10.y, T_Win)
    annotation (Line(points={{221,44},{248,44}},   color={0,0,127}));
  connect(realExpression12.y, T_Roof)
    annotation (Line(points={{223,24},{250,24}},   color={0,0,127}));
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
    annotation (Line(points={{154,-134},{166,-134}},color={0,127,255}));
  connect(realExpression34.y,T_flow_out)
    annotation (Line(points={{-291,52},{-264,52}},   color={0,0,127}));
  connect(realExpression20.y, m_flow)
    annotation (Line(points={{-291,88},{-264,88}}, color={0,0,127}));
  connect(realExpression21.y, T_flow_sensor)
    annotation (Line(points={{-291,68},{-264,68}}, color={0,0,127}));
  connect(T_flow_out,T_flow_out)
    annotation (Line(points={{-264,52},{-264,52}}, color={0,0,127}));
  connect(realExpression30.y,T_radwall_inside1)
    annotation (Line(points={{-205,90},{-180,90}},
                                                 color={0,0,127}));
  connect(realExpression31.y,T_radwall_outside1)
    annotation (Line(points={{-205,74},{-180,74}},   color={0,0,127}));
  connect(realExpression32.y,T_radiator_m_1)
    annotation (Line(points={{-205,58},{-180,58}},
                                                 color={0,0,127}));
  connect(realExpression22.y, Q_flow1)
    annotation (Line(points={{-207,40},{-180,40}}, color={0,0,127}));
  connect(realExpression23.y, Q_conv1)
    annotation (Line(points={{-205,24},{-180,24}}, color={0,0,127}));
  connect(realExpression24.y,T_flow_in1)
    annotation (Line(points={{-205,-8},{-180,-8}},
                                                 color={0,0,127}));
  connect(realExpression25.y,T_flow_out1)
    annotation (Line(points={{-205,-22},{-180,-22}},
                                                   color={0,0,127}));
  connect(realExpression26.y, Q_rad1)
    annotation (Line(points={{-205,10},{-180,10}}, color={0,0,127}));
  connect(realExpression43.y, add.u1) annotation (Line(points={{-285,-44},{-272,
          -44},{-272,-52},{-262,-52}}, color={0,0,127}));
  connect(realExpression44.y, gain.u)
    annotation (Line(points={{-317,-78},{-298,-78}}, color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(points={{-275,-78},{-268,-78},{-268,
          -72},{-270,-72},{-270,-64},{-262,-64}}, color={0,0,127}));
  connect(add.y, multiProduct.u[1]) annotation (Line(points={{-239,-58},{-226,
          -58},{-226,-65.05},{-220,-65.05}}, color={0,0,127}));
  connect(realExpression45.y, multiProduct.u[2]) annotation (Line(points={{-225,
          -90},{-220,-90},{-220,-74},{-224,-74},{-224,-62.95},{-220,-62.95}},
        color={0,0,127}));
  connect(multiProduct.y, Q_flow_sum) annotation (Line(points={{-206.98,-64},{
          -178,-64},{-178,-76},{-162,-76}}, color={0,0,127}));
  connect(multiSum.y,solar_radiation)  annotation (Line(points={{339.02,88},{
          354,88},{354,82},{370,82}},    color={0,0,127}));
  connect(realExpression14.y,multiSum. u[1]) annotation (Line(points={{307,96},
          {320,96},{320,86.425},{326,86.425}},    color={0,0,127}));
  connect(realExpression15.y,multiSum. u[2]) annotation (Line(points={{307,82},
          {320,82},{320,87.475},{326,87.475}},     color={0,0,127}));
  connect(realExpression16.y,multiSum. u[3]) annotation (Line(points={{307,66},
          {320,66},{320,88.525},{326,88.525}},     color={0,0,127}));
  connect(realExpression17.y,multiSum. u[4]) annotation (Line(points={{309,50},
          {320,50},{320,89.575},{326,89.575}},     color={0,0,127}));
  connect(radiator.port_a, source.ports[1]) annotation (Line(points={{82,-134},
          {80,-134},{80,-132},{38,-132}}, color={0,127,255}));
  connect(radiator.port_b, res.port_a)
    annotation (Line(points={{102,-134},{134,-134}}, color={0,127,255}));
  connect(radiator.RadiativeHeat, thermalZone1.intGainsRad) annotation (Line(
        points={{96,-132},{110,-132},{110,-34},{62,-34},{62,-12},{48,-12},{48,
          -11.14},{32.56,-11.14}}, color={0,0,0}));
  connect(radiator.ConvectiveHeat, thermalZone1.intGainsConv) annotation (Line(
        points={{90,-132},{76,-132},{76,-19.84},{32.56,-19.84}}, color={191,0,0}));
  connect(step.y, source.T_in) annotation (Line(points={{-37,-144},{8,-144},{8,
          -128},{16,-128}}, color={0,0,127}));
  connect(realExpression18.y, gain1.u)
    annotation (Line(points={{-317,8},{-305.2,8}}, color={0,0,127}));
  connect(gain1.y, Q_conv)
    annotation (Line(points={{-291.4,8},{-266,8}}, color={0,0,127}));
  connect(realExpression19.y, gain2.u)
    annotation (Line(points={{-317,-10},{-305.2,-10}}, color={0,0,127}));
  connect(gain2.y, Q_rad)
    annotation (Line(points={{-291.4,-10},{-266,-10}}, color={0,0,127}));
  ERROR annotation (Line(points={{34.8,-3.6},{53.4,-3.6},{53.4,-6},{72,-6}},
        color={0,0,127}));
  connect(thermalZone1.TRad, TRad1) annotation (Line(points={{34.8,-3.6},{104,
          -3.6},{104,-4}}, color={0,0,127}));
  connect(realExpression27.y, roof_sur)
    annotation (Line(points={{209,-6},{236,-6}}, color={0,0,127}));
  connect(realExpression13.y, ext_sur)
    annotation (Line(points={{211,-28},{238,-28}}, color={0,0,127}));
  connect(realExpression4.y, int_sur)
    annotation (Line(points={{211,-52},{238,-52}}, color={0,0,127}));
  connect(realExpression28.y, win_sur)
    annotation (Line(points={{211,-78},{238,-78}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Test_Ashrae140_ideal_heater_w_radiator;
