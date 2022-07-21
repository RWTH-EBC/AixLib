within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007_C1;
model CDD_TABS "VDI 6007 Test Case 3 model"
  extends Modelica.Icons.Example;

  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord RoomRecord=
      BaseClasses.RoomTypes.RoomType_M()
  annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;

  parameter Modelica.Units.SI.Temperature T_start=296.25;
  parameter Modelica.Units.SI.Area ATabs=13.3;
  parameter Modelica.Units.SI.Power PowerTabs=-745;
  parameter Integer location(min = 1, max = 2) = 1 "Location of validation" annotation(choices(choice = 1 "Hamburg", choice = 2 "Mannheim"));


  RC.TwoElements thermalZoneTwoElements(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    VAir=RoomRecord.VAir,
    hRad=RoomRecord.hRad,
    nOrientations=RoomRecord.nOrientations,
    AWin=RoomRecord.AWin,
    ATransparent=RoomRecord.ATransparent,
    hConWin=RoomRecord.hConWin,
    RWin=RoomRecord.RWin,
    gWin=RoomRecord.gWin,
    ratioWinConRad=RoomRecord.ratioWinConRad,
    AExt=RoomRecord.AExt,
    hConExt=RoomRecord.hConExt,
    nExt=RoomRecord.nExt,
    RExt=RoomRecord.RExt,
    RExtRem=RoomRecord.RExtRem,
    CExt=RoomRecord.CExt,
    AInt=RoomRecord.AInt,
    hConInt=RoomRecord.hConInt,
    nInt=RoomRecord.nInt,
    RInt=RoomRecord.RInt,
    CInt=RoomRecord.CInt,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    nPorts=3)
    "Thermal zone"
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));

  Modelica.Blocks.Sources.CombiTimeTable intGai(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0,0,0,0,0,0; 3600,0,0,0,0,0,0; 7200,0,0,0,0,0,0; 10800,0,0,0,0,0,0;
        14400,0,0,0,0,0,0; 18000,0,0,0,0,0,0; 21600,0,0,0,0,0,0; 25200,0,0,0,0,0,
        0; 25200,80,80,75,75,120,120; 28800,160,160,150,150,120,120; 32400,160,160,
        150,150,120,120; 36000,160,160,150,150,120,120; 39600,160,160,150,150,120,
        120; 43200,80,80,75,75,120,120; 46800,160,160,150,150,120,120; 50400,160,
        160,150,150,120,120; 54000,160,160,150,150,120,120; 57600,80,80,75,75,120,
        120; 61200,0,0,0,0,60,60; 61200,0,0,0,0,0,0; 64800,0,0,0,0,0,0; 72000,0,
        0,0,0,0,0; 75600,0,0,0,0,0,0; 79200,0,0,0,0,0,0; 82800,0,0,0,0,0,0; 86400,
        0,0,0,0,0,0],
    columns={2,3,4,5,6,7}) "Table with internal gains"
    annotation (Placement(transformation(extent={{8,-50},{24,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SonConv
    "Convective heat flow machines"
    annotation (Placement(transformation(extent={{54,-82},{74,-62}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{54,-100},{74,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow persons"
    annotation (Placement(transformation(extent={{52,-44},{72,-24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow IluConv
    "Convective heat flow machines"
    annotation (Placement(transformation(extent={{54,-64},{74,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow IluRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{56,-136},{76,-116}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SonRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{54,-118},{74,-98}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                         preTem
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-70,8},{-58,20}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer"
    annotation (Placement(transformation(extent={{-42,20},{-52,10}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*10.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={-48,-4})));
  Modelica.Blocks.Sources.CombiTimeTable VentRate(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,15; 3600,15; 7200,15; 10800,15; 14400,15; 18000,15; 21600,15; 25200,
        15; 25200,60; 28800,60; 32400,60; 36000,60; 39600,60; 43200,60; 46800,60;
        50400,60; 54000,60; 57600,60; 61200,15; 61200,15; 64800,15; 72000,15; 75600,
        15; 79200,15; 82800,15; 86400,15],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{-128,-82},{-112,-66}})));
  Modelica.Blocks.Math.Gain gain(k=0.000330375898)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{-94,-81},{-80,-67}})));
  Fluid.Sources.MassFlowSource_T ventilationIn(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = MediumAir,
    nPorts=1)
    "Fan"
    annotation (Placement(transformation(extent={{-60,-92},{-40,-72}})));
  Fluid.Sources.MassFlowSource_T ventilationOut(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    use_T_in=false,
    nPorts=1)
    "Fan"
    annotation (Placement(transformation(extent={{-62,-124},{-42,-104}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-90,-113},{-76,-99}})));
  Modelica.Blocks.Sources.Constant g_sunblind(k=0.15)
    "g value for sunblind closed"
    annotation (Placement(
    transformation(
    extent={{-3,-3},{3,3}},
    rotation=-90,
    origin={-29,61})));
  Modelica.Blocks.Sources.Constant sunblind_open(k=1)
    "g value for sunblind open"
    annotation (Placement(
    transformation(
    extent={{-3,-3},{3,3}},
    rotation=-90,
    origin={-43,61})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=100)
    "Threshold for sunblind for one direction"
    annotation (Placement(transformation(
    extent={{-5,-5},{5,5}},
    rotation=-90,
    origin={-69,63})));
  Modelica.Blocks.Math.Product product1
    "Solar radiation times g value for sunblind (open or closed) for one
    direction"
    annotation (Placement(transformation(extent={{-16,69},{-6,79}})));
  Modelica.Blocks.Logical.Switch switch1
    "Determines g value for sunblind (open or closed) for one direction"
    annotation (Placement(transformation(
    extent={{-6,-6},{6,6}},
    rotation=-90,
    origin={-36,42})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{160,-32},{180,-12}})));
  Modelica.Blocks.Math.MultiSum
                            multiSum(k={0.5,0.5,-1},nu=3)
    "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{118,59},{132,73}})));
  Modelica.Blocks.Sources.Constant ToKelvin(k=273.15)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={82,64})));
  Modelica.Blocks.Sources.CombiTimeTable OutdoorTemp_Mannheim(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,19.9; 3600,18.9; 7200,18; 10800,17.2; 14400,16.7; 18000,16.4; 21600,
        16.5; 25200,17; 28800,18; 32400,19.3; 36000,20.9; 39600,22.5; 43200,24.1;
        46800,25.4; 50400,26.4; 54000,26.9; 57600,27; 61200,26.7; 64800,26.2; 68400,
        25.4; 72000,24.5; 75600,23.5; 79200,22.3; 82800,21.1; 86400,22; 90000,20.9;
        93600,19.9; 97200,19.3; 100800,18.9; 104400,19; 108000,19.4; 111600,20.3;
        115200,21.6; 118800,23.1; 122400,24.7; 126000,26.3; 129600,27.8; 133200,
        29.1; 136800,30; 140400,30.4; 144000,30.5; 147600,30.1; 151200,29.5; 154800,
        28.5; 158400,27.4; 162000,26.1; 165600,24.7; 169200,23.3; 172800,25; 176400,
        23.9; 180000,22.9; 183600,22.3; 187200,21.9; 190800,22; 194400,22.4; 198000,
        23.3; 201600,24.6; 205200,26.1; 208800,27.7; 212400,29.3; 216000,30.8; 219600,
        32.1; 223200,33; 226800,33.4; 230400,33.5; 234000,33.1; 237600,32.5; 241200,
        31.5; 244800,30.4; 248400,29.1; 252000,27.7; 255600,26.3; 259200,27; 262800,
        25.9; 266400,24.9; 270000,24.3; 273600,23.9; 277200,24; 280800,24.4; 284400,
        25.3; 288000,26.6; 291600,28.1; 295200,29.7; 298800,31.3; 302400,32.8; 306000,
        34.1; 309600,35; 313200,35.4; 316800,35.5; 320400,35.1; 324000,34.5; 327600,
        33.5; 331200,32.4; 334800,31.1; 338400,29.7; 342000,28.3; 345600,27.4; 349200,
        26.2; 352800,25.3; 356400,24.5; 360000,24.1; 363600,23.9; 367200,24.2; 370800,
        24.9; 374400,26.1; 378000,27.6; 381600,29.3; 385200,31; 388800,32.6; 392400,
        34; 396000,34.9; 399600,35.4; 403200,35.5; 406800,35.2; 410400,34.5; 414000,
        33.7; 417600,32.6; 421200,31.4; 424800,30; 428400,28.7; 432000,23.2; 435600,
        22.2; 439200,21.4; 442800,20.7; 446400,20.2; 450000,19.9; 453600,20; 457200,
        20.5; 460800,21.6; 464400,23.1; 468000,24.8; 471600,26.5; 475200,28.1; 478800,
        29.4; 482400,30.2; 486000,30.5; 489600,30.4; 493200,30; 496800,29.4; 500400,
        28.6; 504000,27.7; 507600,26.6; 511200,25.5; 514800,24.3],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{-138,18},{-122,34}})));
  Modelica.Blocks.Sources.CombiTimeTable OutdoorTemp_Hamburg(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,12.4; 3600,11.1; 7200,10.1; 10800,9.3; 14400,8.8; 18000,8.6; 21600,
        8.9; 25200,9.9; 28800,11.4; 32400,13.2; 36000,15.3; 39600,17.4; 43200,19.2;
        46800,20.7; 50400,21.7; 54000,22; 57600,21.8; 61200,21.3; 64800,20.5; 68400,
        19.5; 72000,18.2; 75600,16.8; 79200,15.3; 82800,13.8; 86400,14.9; 90000,
        13.6; 93600,12.5; 97200,11.9; 100800,11.7; 104400,12; 108000,12.9; 111600,
        14.3; 115200,16; 118800,18; 122400,20.2; 126000,22.2; 129600,23.9; 133200,
        25.3; 136800,26.2; 140400,26.5; 144000,26.3; 147600,25.7; 151200,24.6; 154800,
        23.3; 158400,21.7; 162000,20; 165600,18.2; 169200,16.5; 172800,18.4; 176400,
        17.1; 180000,16; 183600,15.4; 187200,15.2; 190800,15.5; 194400,16.4; 198000,
        17.8; 201600,19.5; 205200,21.5; 208800,23.7; 212400,25.7; 216000,27.4; 219600,
        28.8; 223200,29.7; 226800,30; 230400,29.8; 234000,29.2; 237600,28.1; 241200,
        26.8; 244800,25.2; 248400,23.5; 252000,21.7; 255600,20; 259200,19.9; 262800,
        18.6; 266400,17.5; 270000,16.9; 273600,16.7; 277200,17; 280800,17.9; 284400,
        19.3; 288000,21; 291600,23; 295200,25.2; 298800,27.2; 302400,28.9; 306000,
        30.3; 309600,31.2; 313200,31.5; 316800,31.3; 320400,30.7; 324000,29.6; 327600,
        28.3; 331200,26.7; 334800,25; 338400,23.2; 342000,21.5; 345600,19.9; 349200,
        18.5; 352800,17.4; 356400,16.6; 360000,16.3; 363600,16.3; 367200,16.9; 370800,
        18.2; 374400,19.9; 378000,22; 381600,24.2; 385200,26.3; 388800,28.2; 392400,
        29.7; 396000,30.7; 399600,31; 403200,30.8; 406800,30.2; 410400,29.3; 414000,
        28; 417600,26.5; 421200,24.9; 424800,23.2; 428400,21.5; 432000,17.3; 435600,
        16; 439200,14.9; 442800,14.1; 446400,13.5; 450000,13.1; 453600,13.2; 457200,
        13.9; 460800,15.3; 464400,17.1; 468000,19.2; 471600,21.4; 475200,23.5; 478800,
        25.1; 482400,26.1; 486000,26.5; 489600,26.3; 493200,25.9; 496800,25.1; 500400,
        24.1; 504000,22.9; 507600,21.6; 511200,20.2; 514800,18.7],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{-138,-8},{-122,8}})));
  Modelica.Blocks.Math.Sum  sum1(nin=2)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{-102,5},{-88,19}})));
  Modelica.Blocks.Sources.Constant ToKelvin1(k=273.15)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={-116,-14})));
  Modelica.Blocks.Sources.CombiTimeTable SollTemp(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,299.15; 3600,299.15; 7200,299.15; 10800,299.15; 14400,299.15; 18000,
        299.15; 21600,299.15; 21600,294.15; 25200,294.15; 28800,294.15; 32400,294.15;
        36000,294.15; 39600,294.15; 43200,294.15; 46800,294.15; 50400,294.15; 54000,
        294.15; 57600,294.15; 61200,294.15; 61200,299.15; 64800,299.15; 72000,299.15;
        75600,299.15; 79200,299.15; 82800,299.15; 86400,299.15],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{-122,-146},{-106,-130}})));
  Modelica.Blocks.Sources.CombiTimeTable tableSolRadWindow(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=[0,0; 3600,0; 10800,0; 14400,0; 14400,17; 18000,17; 18000,38; 21600,38;
        21600,59; 25200,59; 25200,98; 28800,98; 28800,186; 32400,186; 32400,287;
        36000,287; 36000,359; 39600,359; 39600,385; 43200,385; 43200,359; 46800,
        359; 46800,287; 50400,287; 50400,186; 54000,186; 54000,98; 57600,98; 57600,
        59; 61200,59; 61200,38; 64800,38; 64800,17; 68400,17; 68400,0; 72000,0;
        82800,0; 86400,0],
    columns={2})
    "Solar radiation"
    annotation (Placement(transformation(extent={{-146,66},{-130,82}})));
  Modelica.Blocks.Math.Mean OutOpTemp(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{164,60},{176,72}})));
  Modelica.Blocks.Math.Mean OutAirTemp(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{186,36},{198,48}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={154,-118})));
  Modelica.Blocks.Math.Mean OutCoolingLoad(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{184,-124},{196,-112}})));
  Modelica.Blocks.Math.Sum  sum2(nin=2)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{164,35},{178,49}})));
  Modelica.Blocks.Sources.Constant ToCelsius(k=-273.15)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={148,54})));
  Modelica.Blocks.Math.Gain gain3(k=1)
    "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-114,67},{-100,81}})));
  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.ControlledTABS
    controlled_TABS(
    RoomNo=1,
    Area={ATabs},
    HeatLoad={PowerTabs},
    Spacing={0.35},
    WallTypeFloor={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    WallTypeCeiling={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PBpipe()},
    Controlled=true,
    Reduced=true)
    annotation (Placement(transformation(extent={{-78,-192},{-18,-132}})));

  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.RCTABS rCTABS(
    UpperTABS=
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_upHalf_UFH(),
    LowerTABS=
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=ATabs,
    OrientationTabs=-0.017453292519943,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-150})));

protected
  Modelica.Thermal.HeatTransfer.Components.Convection convTABS(dT(start=0))    "Convective heat transfer of exterior walls"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={100,-150})));
equation
  connect(perRad.port, thermalZoneTwoElements.intGainsRad)
    annotation (Line(
    points={{74,-90},{100,-90},{100,24},{92,24}},
    color={191,0,0}));
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-90},{54,-90}},
                                               color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-34},{52,-34}},
                                           color={0,0,127}));
  connect(intGai.y[3],SonConv. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-72},{54,-72}},
                                           color={0,0,127}));
  connect(IluRad.port, thermalZoneTwoElements.intGainsRad) annotation (Line(
        points={{76,-126},{100,-126},{100,24},{92,24}}, color={191,0,0}));
  connect(SonRad.port, thermalZoneTwoElements.intGainsRad) annotation (Line(
        points={{74,-108},{100,-108},{100,24},{92,24}}, color={191,0,0}));
  connect(intGai.y[4], SonRad.Q_flow) annotation (Line(points={{24.8,-42},{40,-42},
          {40,-108},{54,-108}}, color={0,0,127}));
  connect(intGai.y[5], IluConv.Q_flow) annotation (Line(points={{24.8,-42},{40,-42},
          {40,-54},{54,-54}}, color={0,0,127}));
  connect(intGai.y[6], IluRad.Q_flow) annotation (Line(points={{24.8,-42},{40,-42},
          {40,-126},{56,-126}}, color={0,0,127}));
 for i in 1:RoomRecord.nOrientations loop
  end for;
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{-52,15},{-54,15},{-54,14},{-58,14}},
                                                           color={191,0,0}));
  connect(thermalZoneTwoElements.extWall,theConWall. solid)
    annotation (Line(points={{44,12},{-38,12},{-38,15},{-42,15}},color={191,0,0}));
  connect(hConWall.y,theConWall. Gc)
    annotation (Line(points={{-48,0.4},{-47,0.4},{-47,10}},  color={0,0,127}));
  connect(gain.y,ventilationIn. m_flow_in)
    annotation (Line(points={{-79.3,-74},{-62,-74}}, color={0,0,127}));
  connect(gain.y,gain1. u)
    annotation (Line(points={{-79.3,-74},{-74,-74},{-74,-90},{-100,-90},{-100,-106},
          {-91.4,-106}},                   color={0,0,127}));
  connect(gain1.y,ventilationOut. m_flow_in)
    annotation (Line(points={{-75.3,-106},{-64,-106}},
                                                     color={0,0,127}));
  connect(VentRate.y[1], gain.u)
    annotation (Line(points={{-111.2,-74},{-95.4,-74}}, color={0,0,127}));
  connect(sunblind_open.y,switch1. u3)
    annotation (Line(points={{-43,57.7},{-43,52},{-40.8,52},{-40.8,49.2}},
                                  color={0,0,127}));
  connect(g_sunblind.y,switch1. u1)
    annotation (Line(points={{-29,57.7},{-29,52},{-31.2,52},{-31.2,49.2}},
                              color={0,0,127}));
  connect(greaterThreshold1.y,switch1. u2)
    annotation (Line(points={{-69,57.5},{-69,50},{-50,50},{-50,68},{-36,68},{-36,
          49.2}},                                    color={255,0,255}));
  connect(switch1.y,product1. u2)
    annotation (Line(points={{-36,35.4},{-36,32},{-20,32},{-20,71},{-17,71}},
                                color={0,0,127}));
  connect(ventilationIn.ports[1], thermalZoneTwoElements.ports[1]) annotation (
      Line(points={{-40,-82},{-22,-82},{-22,-10},{80,-10},{80,-1.95},{80.9667,
          -1.95}},
        color={0,127,255}));
  connect(ventilationOut.ports[1], thermalZoneTwoElements.ports[2]) annotation (
     Line(points={{-42,-114},{-10,-114},{-10,-12},{83,-12},{83,-1.95}},
        color={0,127,255}));
  connect(IluConv.port, port_a)
    annotation (Line(points={{74,-54},{170,-54},{170,-22}}, color={191,0,0}));
  connect(SonConv.port, port_a)
    annotation (Line(points={{74,-72},{170,-72},{170,-22}}, color={191,0,0}));
  connect(perCon.port, port_a)
    annotation (Line(points={{72,-34},{170,-34},{170,-22}}, color={191,0,0}));
  connect(thermalZoneTwoElements.TRad, multiSum.u[1]) annotation (Line(points={{93,28},
          {106,28},{106,69.2667},{118,69.2667}},        color={0,0,127}));
  connect(thermalZoneTwoElements.TAir, multiSum.u[2]) annotation (Line(points={{93,32},
          {104,32},{104,66},{118,66}},        color={0,0,127}));
  connect(ToKelvin.y, multiSum.u[3]) annotation (Line(points={{86.4,64},{118,64},
          {118,62.7333}},                   color={0,0,127}));
  connect(sum1.y, preTem.T) annotation (Line(points={{-87.3,12},{-77.65,12},{-77.65,
          14},{-71.2,14}}, color={0,0,127}));
  connect(ToKelvin1.y, sum1.u[2]) annotation (Line(points={{-111.6,-14},{-111.6,
          0},{-103.4,0},{-103.4,12.7}}, color={0,0,127}));
  connect(sum1.y, ventilationIn.T_in) annotation (Line(points={{-87.3,12},{-76,12},
          {-76,-78},{-62,-78}}, color={0,0,127}));

  connect(thermalZoneTwoElements.intGainsConv, port_a) annotation (Line(points={
          {92,20},{130,20},{130,-22},{170,-22}}, color={191,0,0}));
  connect(product1.y, thermalZoneTwoElements.solRad[2]) annotation (Line(points=
         {{-5.5,74},{2,74},{2,31},{43,31}}, color={0,0,127}));
  connect(OutOpTemp.u, multiSum.y) annotation (Line(points={{162.8,66},{133.19,
          66}},                    color={0,0,127}));
  connect(heatFlowSensor.Q_flow, OutCoolingLoad.u) annotation (Line(points={{164,
          -118},{182.8,-118}},               color={0,0,127}));
  connect(sum2.y, OutAirTemp.u) annotation (Line(points={{178.7,42},{184.8,42}},
                         color={0,0,127}));
  connect(sum2.u[1], ToCelsius.y) annotation (Line(points={{162.6,41.3},{156.4,
          41.3},{156.4,54},{152.4,54}},
                                  color={0,0,127}));
  connect(thermalZoneTwoElements.TAir, sum2.u[2]) annotation (Line(points={{93,32},
          {128,32},{128,42.7},{162.6,42.7}}, color={0,0,127}));
  connect(product1.y, thermalZoneTwoElements.solRad[1]) annotation (Line(points=
         {{-5.5,74},{0.25,74},{0.25,31},{43,31}}, color={0,0,127}));
  connect(tableSolRadWindow.y[1], gain3.u) annotation (Line(points={{-129.2,74},
          {-115.4,74}},                           color={0,0,127}));
  connect(gain3.y, product1.u1) annotation (Line(points={{-99.3,74},{-58,74},{-58,
          77},{-17,77}}, color={0,0,127}));
  connect(gain3.y, greaterThreshold1.u) annotation (Line(points={{-99.3,74},{-82,
          74},{-82,69},{-69,69}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, thermalZoneTwoElements.window) annotation (
      Line(points={{154,-108},{128,-108},{128,-22},{22,-22},{22,20},{44,20}},
        color={191,0,0}));
    if location == 1 then
    connect(OutdoorTemp_Hamburg.y[1], sum1.u[1]) annotation (Line(points={{-121.2,
            0},{-114,0},{-114,11.3},{-103.4,11.3}},
                                             color={0,0,127}));
  else
    connect(OutdoorTemp_Mannheim.y[1], sum1.u[1]) annotation (Line(points={{-121.2,
            26},{-114,26},{-114,11.3},{-103.4,11.3}},
                                             color={0,0,127}));
  end if;
  connect(SollTemp.y[1], controlled_TABS.T_Soll[1])
    annotation (Line(points={{-105.2,-138},{-79.2,-138}}, color={0,0,127}));
  connect(controlled_TABS.T_Room[1], thermalZoneTwoElements.TAir) annotation (
      Line(points={{-79.2,-147},{-100,-147},{-100,-200},{198,-200},{198,32},{93,
          32}}, color={0,0,127}));
  connect(rCTABS.port_int,convTABS. solid)
    annotation (Line(points={{50,-150},{90,-150}}, color={191,0,0}));
  connect(convTABS.fluid, heatFlowSensor.port_a) annotation (Line(points={{110,
          -150},{148,-150},{148,-128},{154,-128}}, color={191,0,0}));
  connect(controlled_TABS.heatFloor[1], rCTABS.port_heat) annotation (Line(
        points={{-48,-132},{-2,-132},{-2,-160},{40,-160}}, color={191,0,0}));
  connect(rCTABS.alpha_TABS, convTABS.Gc) annotation (Line(points={{29,-142},{
          22,-142},{22,-132},{72,-132},{72,-170},{100,-170},{100,-160}}, color=
          {0,0,127}));
  connect(rCTABS.TAir, thermalZoneTwoElements.TAir) annotation (Line(points={{
          29,-146},{24,-146},{24,-200},{198,-200},{198,32},{93,32}}, color={0,0,
          127}));
    annotation ( Documentation(info="<html>
<p>Test Case 3 of the VDI 6007 Part 1: Calculation of indoor air temperature excited by a convective heat source for room version L. </p>
<p><b>Boundary conditions</b> </p>
<ul>
<li>constant outdoor air temperature 22&deg;C </li>
<li>no solar or short-wave radiation on the exterior wall </li>
<li>no solar or short-wave radiation through the windows </li>
<li>no long-wave radiation exchange between exterior wall, windows and ambient environment </li>
</ul>
<p>This test validates basic functionalities. </p>
<h4>Tabs conditions </h4>
<ul>
<li>The pasive part of the tabs is represented by the model RCTabs (based on the room&apos;s floor characteristics)</li>
<li>The active part of the tabs is represented by the TABS hydraulic system with model controlled_TABS</li>
</ul>
</html>",   revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>
  </li>
  <li>
  July 7, 2016, by Moritz Lauster:<br/>
  Added automatic check against validation thresholds.
  </li>
  <li>
  January 11, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),experiment(
      StartTime=259200,
      StopTime=345600,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
  __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Validation/VDI6007/VDI6007_C1/CDD_TABS.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-160,-200},{200,100}})),
    Icon(coordinateSystem(extent={{-160,-200},{200,100}})));
end CDD_TABS;
