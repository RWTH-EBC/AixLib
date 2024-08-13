within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Ashrae140_ideal_heater_w_radiator
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{108,-28},{128,-8}})));
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
  Modelica.Blocks.Sources.RealExpression realExpression11(y=thermalZone1.ROM.intWallRC.thermCapInt[
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
    nPorts=1,
    m_flow=1,
    T=328.15) annotation (Placement(transformation(extent={{-76,-148},{-56,-128}})));
  Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{92,-150},{72,-130}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
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
    N=2,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{-16,-150},{4,-130}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    dp_nominal=100000)
    "Pipe"
    annotation (Placement(transformation(extent={{40,-150},{60,-130}})));
  Modelica.Blocks.Interfaces.RealInput T_flow_in
    "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-142,-136},{-102,-96}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{-256,-6},{-236,14}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{-220,
            -6},{-200,14}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{-256,-36},{-236,-16}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{-218,
            -36},{-198,-16}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-256,-60},{-236,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_m "Value of Real output"
    annotation (Placement(transformation(extent={{-218,-60},{-198,-40}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-256,-86},{-236,-66}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-218,-86},{-198,-66}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{262,-102},{274,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{222,-98},{242,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{222,-112},{242,-92}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{222,-128},{242,-108}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{224,-144},{244,-124}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{296,-112},{316,-92}})));
  Modelica.Blocks.Sources.RealExpression realExpression36(y=radiator.multiLayer_HE[
        2].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{-172,-6},{-152,14}})));
  Modelica.Blocks.Sources.RealExpression realExpression37(y=radiator.multiLayer_HE[
        2].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{-172,-36},{-152,-16}})));
  Modelica.Blocks.Sources.RealExpression realExpression38(y=radiator.multiLayer_HE[
        2].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{-172,-60},{-152,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside2
    "Value of Real output" annotation (Placement(transformation(extent={{-136,
            -6},{-116,14}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside2
    "Value of Real output" annotation (Placement(transformation(extent={{-134,
            -36},{-114,-16}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_m2 "Value of Real output"
    annotation (Placement(transformation(extent={{-134,-60},{-114,-40}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-104,-94},{-94,-84}})));
  Modelica.Blocks.Sources.RealExpression realExpression39(y=radiator.multiLayer_HE[
        2].heatConv_Radiator.port_b.T)
    annotation (Placement(transformation(extent={{-344,20},{-324,40}})));
  Modelica.Blocks.Interfaces.RealOutput heatConv_RadiatorT
    "Value of Real output" annotation (Placement(transformation(extent={{-306,
            20},{-286,40}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression40(y=radiator.multiLayer_HE[
        2].twoStar_RadEx.radPort.T)
    annotation (Placement(transformation(extent={{-344,48},{-324,68}})));
  Modelica.Blocks.Interfaces.RealOutput RadheatRadT "Value of Real output"
    annotation (Placement(transformation(extent={{-306,48},{-286,68}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression50(y=radiator.multiLayer_HE[
        2].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-346,-4},{-326,16}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_input_q
    "Value of Real output" annotation (Placement(transformation(extent={{-310,
            -4},{-290,16}}), iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=radiator.multiLayer_HE[
        2].radiator_wall.port_b.Q_flow)
    annotation (Placement(transformation(extent={{-346,-34},{-326,-14}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside_q
    "Value of Real output" annotation (Placement(transformation(extent={{-308,
            -34},{-288,-14}}), iconTransformation(extent={{282,-88},{302,-68}})));
equation
  connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
      points={{-108,40},{-46,40},{-46,-3.6},{-24,-3.6}},
      color={255,204,51},
      thickness=0.5));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{34.8,2.2},{94,
          2.2},{94,-18},{118,-18}},               color={0,0,127}));
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
  connect(realExpression5.y, sol_in)
    annotation (Line(points={{145,-124},{172,-124}}, color={0,0,127}));
  connect(realExpression6.y, preTemRoof)
    annotation (Line(points={{137,88},{164,88}}, color={0,0,127}));
  connect(realExpression7.y, preTemWin)
    annotation (Line(points={{141,44},{166,44}}, color={0,0,127}));
  connect(realExpression8.y, preTemWall)
    annotation (Line(points={{139,66},{166,66}}, color={0,0,127}));
  connect(realExpression11.y, T_IntWall)
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
  connect(radiator.port_b,res. port_a)
    annotation (Line(points={{4,-140},{40,-140}},   color={0,127,255}));
  connect(res.port_b,sink. ports[1])
    annotation (Line(points={{60,-140},{72,-140}},  color={0,127,255}));
  connect(source.ports[1],radiator. port_a)
    annotation (Line(points={{-56,-138},{-54,-138},{-54,-140},{-16,-140}},
                                                       color={0,127,255}));
  connect(radiator.ConvectiveHeat, thermalZone1.intGainsConv) annotation (Line(
        points={{-8,-138},{-8,-86},{14,-86},{14,-90},{44,-90},{44,-19.84},{
          32.56,-19.84}}, color={191,0,0}));
  connect(radiator.RadiativeHeat, thermalZone1.intGainsRad) annotation (Line(
        points={{-2,-138},{34,-138},{34,-92},{46,-92},{46,-11.14},{32.56,-11.14}},
        color={0,0,0}));
  connect(realExpression30.y, T_radwall_inside1)
    annotation (Line(points={{-235,4},{-210,4}}, color={0,0,127}));
  connect(realExpression31.y, T_radwall_outside1)
    annotation (Line(points={{-235,-26},{-208,-26}}, color={0,0,127}));
  connect(realExpression32.y, T_radwall_m)
    annotation (Line(points={{-235,-50},{-208,-50}}, color={0,0,127}));
  connect(realExpression34.y, T_flow_out)
    annotation (Line(points={{-235,-76},{-208,-76}}, color={0,0,127}));
  connect(multiSum.y,solar_radiation)  annotation (Line(points={{275.02,-96},{
          290,-96},{290,-102},{306,-102}},
                                         color={0,0,127}));
  connect(realExpression4.y, multiSum.u[1]) annotation (Line(points={{243,-88},
          {256,-88},{256,-97.575},{262,-97.575}}, color={0,0,127}));
  connect(realExpression13.y,multiSum. u[2]) annotation (Line(points={{243,-102},
          {256,-102},{256,-96.525},{262,-96.525}}, color={0,0,127}));
  connect(realExpression14.y,multiSum. u[3]) annotation (Line(points={{243,-118},
          {258,-118},{258,-95.475},{262,-95.475}}, color={0,0,127}));
  connect(realExpression15.y,multiSum. u[4]) annotation (Line(points={{245,-134},
          {258,-134},{258,-94.425},{262,-94.425}}, color={0,0,127}));
  connect(realExpression36.y, T_radwall_inside2)
    annotation (Line(points={{-151,4},{-126,4}}, color={0,0,127}));
  connect(realExpression37.y, T_radwall_outside2)
    annotation (Line(points={{-151,-26},{-124,-26}}, color={0,0,127}));
  connect(realExpression38.y, T_radwall_m2)
    annotation (Line(points={{-151,-50},{-124,-50}}, color={0,0,127}));
  connect(const.y, source.T_in) annotation (Line(points={{-93.5,-89},{-93.5,-90},
          {-88,-90},{-88,-134},{-78,-134}}, color={0,0,127}));
  connect(realExpression39.y, heatConv_RadiatorT)
    annotation (Line(points={{-323,30},{-296,30}}, color={0,0,127}));
  connect(realExpression40.y, RadheatRadT)
    annotation (Line(points={{-323,58},{-296,58}}, color={0,0,127}));
  connect(realExpression50.y, T_radwall_input_q)
    annotation (Line(points={{-325,6},{-300,6}}, color={0,0,127}));
  connect(realExpression16.y, T_radwall_outside_q)
    annotation (Line(points={{-325,-24},{-298,-24}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Ashrae140_ideal_heater_w_radiator;
