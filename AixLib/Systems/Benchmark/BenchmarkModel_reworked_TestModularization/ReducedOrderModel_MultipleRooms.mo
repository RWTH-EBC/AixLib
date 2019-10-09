within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReducedOrderModel_MultipleRooms  "Multiple instances of reduced order room with input paramaters"
  extends Modelica.Icons.Example;


  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "D:\AixLib\AixLib\Systems\Benchmark\Model\SimYear_Variante3_angepasst.mat"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-96,52},{-76,72}})));

  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[2](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,20},{-48,40}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[2](
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,52},{-48,72}})));
  ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane        corGDouPan(UWin=2.1,
      n=2)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,46},{26,66}})));
 ThermalZones.ReducedOrder.RC.FourElements thermalZoneFourElements[5](
    redeclare package Medium = Media.Air,
    each hRad=5,
    each hConvWin=1.3,
    each gWin=1,
    each ratioWinConRad=0.09,
    each hConvExt=2.5,
    each nExt=4,
    each RExtRem=0,
    each hConvInt=2.5,
    each nInt=2,
    each hConvFloor=2.5,
    each nFloor=4,
    each RFloorRem=0,
    each hConvRoof=2.5,
    each RRoofRem=0,
    each nRoof=4,
    RExt={{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,
        0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294}},
    CExt={{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000},{
        1000,1030,1000,1000},{1000,1030,1000,1000}},
    CInt={{1000,1000},{1000,1000},{1000,1000},{1000,1000},{1000,1000}},
    RFloor={{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,
        1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429}},
    CFloor={{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,
        4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000}},
    CRoof={{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1},{
        2472,368000,18000,1},{2472,368000,18000,1}},
    each indoorPortWin=false,
    each indoorPortExtWalls=false,
    each indoorPortIntWalls=false,
    each indoorPortFloor=false,
    each indoorPortRoof=false,
    VAir={2700,1800,150,300,4050},
    AInt={90,180,60,90,90},
    AFloor={900,600,50,100,1500},
    ARoof={900,600,50,100,1500},
    RRoof={{0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{
        0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{0.4444,
        0.06957,0.02941,0.0001}},
    RWin={0.01282,0.01923,0.03846,0.01923,0.0085877},
    RInt={{0.175,0.0294},{0.175,0.0294},{0.175,0.0294},{0.175,0.0294},{0.175,
        0.0294}},
    each nOrientations=2,
    AWin={{90,90},{40,40},{20,0},{40,0},{100,100}},
    ATransparent={{72,72},{32,32},{16,0},{32,0},{80,80}},
    AExt={{45,45},{20,20},{30,0},{60,0},{95,95}})
    annotation (Placement(transformation(extent={{42,-8},{90,28}})));
 ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow        eqAirTemp(
    wfGro=0,
    withLongwave=true,
    aExt=0.7,
    hConvWallOut=20,
    hRad=5,
    hConvWinOut=20,
    n=2,
    wfWall={0.3043478260869566,0.6956521739130435},
    wfWin={0.5,0.5},
    TGro=285.15) "Computes equivalent air temperature" annotation (Placement(transformation(extent={{-24,-14},{-4,6}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-38,6},{-28,16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,-6},{20,6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,14},{20,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{38,16},{28,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{36,6},{26,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{48,-42},{68,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{48,-62},{68,-42}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    tableOnFile=false,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,
        200; 50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200;
        61200,0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,
        0,0,0; 86400,0,0,0],
    tableName="final",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"),
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,14},{-14,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{48,-84},{68,-64}})));
  Modelica.Blocks.Sources.Constant hConvWall(k=25*11.5) "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant hConvWin(k=20*14) "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={67,-18})));
  Modelica.Blocks.Sources.Constant TSoil(each k=283.15)
    "Outdoor surface temperature for floor plate" annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={86,-26})));
 ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007        eqAirTempVDI(
    aExt=0.7,
    n=1,
    wfWall={1},
    wfWin={0},
    wfGro=0,
    hConvWallOut=20,
    hRad=5,
    TGro=285.15) "Computes equivalent air temperature for roof" annotation (Placement(transformation(extent={{30,74},{50,94}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={67,64})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={67,47})));
  Modelica.Blocks.Sources.Constant hConvRoof(k=25*11.5) "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{68,90},{62,96}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-100,-10},{-66,22}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
equation

  connect(eqAirTemp.TEqAirWin,preTem1. T)
    annotation (Line(points={{-3,-0.2},{0,-0.2},{0,20},{6.8,20}},
    color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{-3,-4},{4,-4},{4,0},{6.8,0}},
    color={0,0,127}));
  connect(weaDat.weaBus,weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,18},{-84,18},{-84,12},
    {-83,12},{-83,6}},color={255,204,51},
    thickness=0.5), Text(string="%second",index=1,extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul,eqAirTemp. TDryBul)
    annotation (Line(points={{-83,6},{-83,-2},{-38,-2},{-38,-10},{-26,-10}},
    color={255,204,51},
    thickness=0.5), Text(string="%first",index=-1,extent={{-6,3},{-6,3}}));
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-32},{48,-32}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{22.8,-52},{36,-52},{48,-52}}, color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-74},{48,-74}},
    color={0,0,127}));
  connect(const.y,eqAirTemp. sunblind)
    annotation (Line(points={{-13.7,17},{-12,17},{-12,8},{-14,8}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil,corGDouPan. HSkyDifTil)
    annotation (Line(points={{-47,36},{-28,36},{-6,36},{-6,58},{0,58},{0,57.8},{
    4,57.8},{4,58}},
    color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{-47,62},{4,62},{4,62}},  color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-47,62},{-42,62},{-42,14},{-39,14}},
    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-47,30},{-44,30},{-44,8},{-39,8}},
    color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(points={{-47,24},{-4,24},{-4,54},{4,54}},
    color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{-27.5,11},{-26,11},{-26,2}},
    color={0,0,127}));
  connect(weaDat.weaBus,HDifTil [1].weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,30},{-68,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus,HDifTil [2].weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,30},{-68,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus,HDirTil [1].weaBus)
    annotation (Line(
    points={{-76,62},{-76,62},{-68,62}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [2].weaBus)
    annotation (Line(
    points={{-76,62},{-76,62},{-68,62}},
    color={255,204,51},
    thickness=0.5));
  connect(preTem1.port,theConWin. fluid)
    annotation (Line(points={{20,20},{28,20},{28,21}}, color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{26,1},{24,1},{24,0},{20,0}}, color={191,0,0}));
  connect(hConvWall.y,theConWall. Gc)
    annotation (Line(points={{0,4.4},{0,-4},{31,-4}},     color={0,0,127}));
  connect(hConvWin.y,theConWin. Gc)
    annotation (Line(points={{0,-4.4},{0,26},{33,26}},   color={0,0,127}));
  connect(weaBus.TBlaSky,eqAirTemp. TBlaSky)
    annotation (Line(
    points={{-83,6},{-58,6},{-58,2},{-32,2},{-32,-4},{-26,-4}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{67,58},{67,58},{67,52}}, color={191,0,0}));
  connect(eqAirTempVDI.TEqAir,preTemRoof. T)
    annotation (Line(
    points={{51,84},{67,84},{67,71.2}}, color={0,0,127}));
  connect(theConRoof.Gc,hConvRoof.y)
    annotation (Line(points={{72,47},{-4.4,47},{-4.4,0}},
                                                        color={0,0,127}));
  connect(eqAirTempVDI.TDryBul,eqAirTemp. TDryBul)
    annotation (Line(points={{28,78},{-96,78},{-96,-2},{-38,-2},{-38,-10},{-26,-10}},
    color={0,0,127}));
  connect(eqAirTempVDI.TBlaSky,eqAirTemp. TBlaSky)
    annotation (Line(points={{28,84},{-34,84},{-98,84},{-98,-8},{-58,-8},{-58,2},
          {-32,2},{-32,-4},{-26,-4}},
    color={0,0,127}));
  connect(eqAirTempVDI.HSol[1],weaBus. HGloHor)
    annotation (Line(points={{28,90},{-100,90},{-100,6},{-83,6}},
    color={0,0,127}),Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{-47,58},{-28,58},{-10,58},{-10,50},{4,50}},
    color={0,0,127}));
  connect(const1.y,eqAirTempVDI. sunblind[1])
    annotation (Line(points={{61.7,93},{56,93},{56,98},{40,98},{40,96}},
                                      color={0,0,127}));
  connect(TSoil.y, preTemFloor.T) annotation (Line(points={{81.6,-26},{74,-26},
          {74,-25.2},{67,-25.2}}, color={0,0,127}));
  connect(preTemFloor.port, thermalZoneFourElements[1].floor)
    annotation (Line(points={{67,-12},{66,-12},{66,-8}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements[2].floor)
    annotation (Line(points={{67,-12},{66,-12},{66,-8}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements[3].floor)
    annotation (Line(points={{67,-12},{66,-12},{66,-8}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements[4].floor)
    annotation (Line(points={{67,-12},{66,-12},{66,-8}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements[5].floor)
    annotation (Line(points={{67,-12},{66,-12},{66,-8}}, color={191,0,0}));
  connect(perRad.port, thermalZoneFourElements[1].intGainsRad) annotation (Line(
        points={{68,-32},{98,-32},{98,18},{90,18}}, color={191,0,0}));
  connect(perRad.port, thermalZoneFourElements[2].intGainsRad) annotation (Line(
        points={{68,-32},{98,-32},{98,18},{90,18}}, color={191,0,0}));
  connect(perRad.port, thermalZoneFourElements[3].intGainsRad) annotation (Line(
        points={{68,-32},{98,-32},{98,18},{90,18}}, color={191,0,0}));
  connect(perRad.port, thermalZoneFourElements[4].intGainsRad) annotation (Line(
        points={{68,-32},{98,-32},{98,18},{90,18}}, color={191,0,0}));
  connect(perRad.port, thermalZoneFourElements[5].intGainsRad) annotation (Line(
        points={{68,-32},{98,-32},{98,18},{90,18}}, color={191,0,0}));
  connect(perCon.port, thermalZoneFourElements[1].intGainsConv) annotation (
      Line(points={{68,-52},{94,-52},{94,14},{90,14}}, color={191,0,0}));
  connect(perCon.port, thermalZoneFourElements[2].intGainsConv) annotation (
      Line(points={{68,-52},{94,-52},{94,14},{90,14}}, color={191,0,0}));
  connect(perCon.port, thermalZoneFourElements[3].intGainsConv) annotation (
      Line(points={{68,-52},{94,-52},{94,14},{90,14}}, color={191,0,0}));
  connect(perCon.port, thermalZoneFourElements[4].intGainsConv) annotation (
      Line(points={{68,-52},{94,-52},{94,14},{90,14}}, color={191,0,0}));
  connect(perCon.port, thermalZoneFourElements[5].intGainsConv) annotation (
      Line(points={{68,-52},{94,-52},{94,14},{90,14}}, color={191,0,0}));
  connect(macConv.port, thermalZoneFourElements[1].intGainsConv) annotation (
      Line(points={{68,-74},{94,-74},{94,14},{90,14}}, color={191,0,0}));
  connect(macConv.port, thermalZoneFourElements[2].intGainsConv) annotation (
      Line(points={{68,-74},{94,-74},{94,14},{90,14}}, color={191,0,0}));
  connect(macConv.port, thermalZoneFourElements[3].intGainsConv) annotation (
      Line(points={{68,-74},{94,-74},{94,14},{90,14}}, color={191,0,0}));
  connect(macConv.port, thermalZoneFourElements[4].intGainsConv) annotation (
      Line(points={{68,-74},{94,-74},{94,14},{90,14}}, color={191,0,0}));
  connect(macConv.port, thermalZoneFourElements[5].intGainsConv) annotation (
      Line(points={{68,-74},{94,-74},{94,14},{90,14}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements[1].roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements[2].roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements[3].roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements[4].roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements[5].roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(theConWall.solid, thermalZoneFourElements[1].extWall)
    annotation (Line(points={{36,1},{40,1},{40,6},{42,6}}, color={191,0,0}));
  connect(theConWall.solid, thermalZoneFourElements[2].extWall)
    annotation (Line(points={{36,1},{40,1},{40,6},{42,6}}, color={191,0,0}));
  connect(theConWall.solid, thermalZoneFourElements[3].extWall)
    annotation (Line(points={{36,1},{40,1},{40,6},{42,6}}, color={191,0,0}));
  connect(theConWall.solid, thermalZoneFourElements[4].extWall)
    annotation (Line(points={{36,1},{40,1},{40,6},{42,6}}, color={191,0,0}));
  connect(theConWall.solid, thermalZoneFourElements[5].extWall)
    annotation (Line(points={{36,1},{40,1},{40,6},{42,6}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements[1].window) annotation (Line(
        points={{38,21},{40,21},{40,14},{42,14}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements[2].window) annotation (Line(
        points={{38,21},{40,21},{40,14},{42,14}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements[3].window) annotation (Line(
        points={{38,21},{40,21},{40,14},{42,14}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements[4].window) annotation (Line(
        points={{38,21},{40,21},{40,14},{42,14}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements[5].window) annotation (Line(
        points={{38,21},{40,21},{40,14},{42,14}}, color={191,0,0}));
  connect(corGDouPan.solarRadWinTrans[1], thermalZoneFourElements[1].solRad[1])
    annotation (Line(points={{27,55.5},{34,55.5},{34,24.5},{41,24.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[2], thermalZoneFourElements[1].solRad[2])
    annotation (Line(points={{27,56.5},{34,56.5},{34,25.5},{41,25.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[1], thermalZoneFourElements[2].solRad[1])
    annotation (Line(points={{27,55.5},{34,55.5},{34,24.5},{41,24.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[2], thermalZoneFourElements[2].solRad[2])
    annotation (Line(points={{27,56.5},{34,56.5},{34,25.5},{41,25.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[1], thermalZoneFourElements[3].solRad[1])
    annotation (Line(points={{27,55.5},{34,55.5},{34,24.5},{41,24.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[2], thermalZoneFourElements[3].solRad[2])
    annotation (Line(points={{27,56.5},{34,56.5},{34,25.5},{41,25.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[1], thermalZoneFourElements[4].solRad[1])
    annotation (Line(points={{27,55.5},{34,55.5},{34,24.5},{41,24.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[2], thermalZoneFourElements[4].solRad[2])
    annotation (Line(points={{27,56.5},{34,56.5},{34,25.5},{41,25.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[1], thermalZoneFourElements[5].solRad[1])
    annotation (Line(points={{27,55.5},{34,55.5},{34,24.5},{41,24.5}}, color={0,
          0,127}));
  connect(corGDouPan.solarRadWinTrans[2], thermalZoneFourElements[5].solRad[2])
    annotation (Line(points={{27,56.5},{34,56.5},{34,25.5},{41,25.5}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReducedOrderModel_MultipleRooms;
