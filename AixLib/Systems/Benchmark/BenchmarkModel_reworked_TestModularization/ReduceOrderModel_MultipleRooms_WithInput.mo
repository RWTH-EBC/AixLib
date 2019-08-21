within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReduceOrderModel_MultipleRooms_WithInput
  extends Modelica.Icons.Example;



  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
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
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane corGDouPan(UWin=2.1, n=2)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,46},{26,66}})));
 AixLib.ThermalZones.ReducedOrder.RC.FourElements thermalZoneFourElements[5]( redeclare
      package                                                                                                                         Medium =
        AixLib.Media.Air,
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
    RExt={{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294}},
    CExt={{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000}},
    CInt={{1000,1000},{1000,1000},{1000,1000},{1000,1000},{1000,1000}},
    RFloor={{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429}},
    CFloor={{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000}},
    CRoof={{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1}},
    each indoorPortWin=false,
    each indoorPortExtWalls=false,
    each indoorPortIntWalls=false,
    each indoorPortFloor=false,
    each indoorPortRoof=false,
    VAir={2700,1800,150,300,4050},
    AInt={90,180,60,90,90},
    AFloor={900,600,50,100,1350},
    ARoof={900,600,50,100,1350},
    RRoof={{0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{0.4444,
        0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,
        0.02941,0.0001}},
    RWin={0.01923,0.0128,0.03846,0.01923,0.01282},
    RInt={{0.175,0.0294},{0.175,0.0294},{0.175,0.0294},{0.175,0.029},{0.175,0.0294}},
    nOrientations={3,3,3,3,3},
    AWin={{60,60,60},{40,40,0},{20,0,0},{40,0,0},{80,60,60}},
    ATransparent={{48,48,48},{32,32,0},{16,0,0},{32,0,0},{64,48,48}},
    AExt={{30,30,30},{20,20,0},{10,0,0},{20,0,0},{40,30,30}})
    annotation (Placement(transformation(extent={{42,-8},{90,28}})));
 AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
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
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
        50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
        0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
        86400,0,0,0],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,14},{-14,20}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-100,-10},{-66,22}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{48,-84},{68,-64}})));
  Modelica.Blocks.Sources.Constant hConvWall(k=25*11.5) "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant hConvWin(k=20*14) "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor [5]
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={67,-12})));
  Modelica.Blocks.Sources.Constant TSoil [5](each k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=180,origin={84,-22})));
 AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007 eqAirTempVDI(
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

equation
  connect(eqAirTemp.TEqAirWin, preTem1.T)
    annotation (Line(points={{-3,-0.2},{0,-0.2},{0,20},{6.8,20}},
    color={0,0,127}));
  connect(eqAirTemp.TEqAir, preTem.T)
    annotation (Line(points={{-3,-4},{4,-4},{4,0},{6.8,0}},
    color={0,0,127}));
  connect(weaDat.weaBus, weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,18},{-84,18},{-84,12},
    {-83,12},{-83,6}},color={255,204,51},
    thickness=0.5), Text(string="%second",index=1,extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul)
    annotation (Line(points={{-83,6},{-83,-2},{-38,-2},{-38,-10},{-26,-10}},
    color={255,204,51},
    thickness=0.5), Text(string="%first",index=-1,extent={{-6,3},{-6,3}}));
  connect(intGai.y[1], perRad.Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-32},{48,-32}},
    color={0,0,127}));
  connect(intGai.y[2], perCon.Q_flow)
    annotation (Line(points={{22.8,-52},{36,-52},{48,-52}}, color={0,0,127}));
  connect(intGai.y[3], macConv.Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-74},{48,-74}},
    color={0,0,127}));
  connect(const.y, eqAirTemp.sunblind)
    annotation (Line(points={{-13.7,17},{-12,17},{-12,8},{-14,8}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil, corGDouPan.HSkyDifTil)
    annotation (Line(points={{-47,36},{-28,36},{-6,36},{-6,58},{0,58},{0,57.8},{
    4,57.8},{4,58}},
    color={0,0,127}));
  connect(HDirTil.H, corGDouPan.HDirTil)
    annotation (Line(points={{-47,62},{4,62},{4,62}},  color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-47,62},{-42,62},{-42,14},{-39,14}},
    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-47,30},{-44,30},{-44,8},{-39,8}},
    color={0,0,127}));
  connect(HDifTil.HGroDifTil, corGDouPan.HGroDifTil)
    annotation (Line(points={{-47,24},{-4,24},{-4,54},{4,54}},
    color={0,0,127}));
  connect(solRad.y, eqAirTemp.HSol)
    annotation (Line(points={{-27.5,11},{-26,11},{-26,2}},
    color={0,0,127}));
  connect(weaDat.weaBus, HDifTil[1].weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,30},{-68,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus, HDifTil[2].weaBus)
    annotation (Line(points={{-76,62},{-74,62},{-74,30},{-68,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus, HDirTil[1].weaBus)
    annotation (Line(
    points={{-76,62},{-76,62},{-68,62}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[2].weaBus)
    annotation (Line(
    points={{-76,62},{-76,62},{-68,62}},
    color={255,204,51},
    thickness=0.5));
  connect(perRad.port, thermalZoneFourElements.intGainsRad)
    annotation (
    Line(points={{68,-32},{100,-32},{100,18},{90,18}},
    color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements.window)
    annotation (Line(points={{38,21},{40,21},{40,14},{42,14}},   color=
    {191,0,0}));
  connect(preTem1.port, theConWin.fluid)
    annotation (Line(points={{20,20},{28,20},{28,21}}, color={191,0,0}));
  connect(thermalZoneFourElements.extWall, theConWall.solid)
    annotation (Line(points={{42,6},{40,6},{40,1},{36,1}},
    color={191,0,0}));
  connect(theConWall.fluid, preTem.port)
    annotation (Line(points={{26,1},{24,1},{24,0},{20,0}}, color={191,0,0}));
  connect(hConvWall.y, theConWall.Gc)
    annotation (Line(points={{0,4.4},{0,-4},{31,-4}},     color={0,0,127}));
  connect(hConvWin.y, theConWin.Gc)
    annotation (Line(points={{0,-4.4},{0,26},{33,26}},   color={0,0,127}));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky)
    annotation (Line(
    points={{-83,6},{-58,6},{-58,2},{-32,2},{-32,-4},{-26,-4}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(macConv.port, thermalZoneFourElements.intGainsConv)
    annotation (
    Line(points={{68,-74},{96,-74},{96,14},{90,14}},          color={191,
    0,0}));
  connect(perCon.port, thermalZoneFourElements.intGainsConv)
    annotation (
    Line(points={{68,-52},{96,-52},{96,14},{90,14}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements.floor)
    annotation (Line(points={{67,-6},{66,-6},{66,-8}}, color={191,0,0}));
  connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));connect(TSoil[1].y, preTemFloor[1].T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(preTemRoof.port, theConRoof.fluid)
    annotation (Line(points={{67,58},{67,58},{67,52}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements.roof)
    annotation (Line(points={{67,42},{64.9,42},{64.9,28}}, color={191,0,0}));
  connect(eqAirTempVDI.TEqAir, preTemRoof.T)
    annotation (Line(
    points={{51,84},{67,84},{67,71.2}}, color={0,0,127}));
  connect(theConRoof.Gc,hConvRoof.y)
    annotation (Line(points={{72,47},{-4.4,47},{-4.4,0}},
                                                        color={0,0,127}));
  connect(eqAirTempVDI.TDryBul, eqAirTemp.TDryBul)
    annotation (Line(points={{28,78},{-96,78},{-96,-2},{-38,-2},{-38,-10},{-26,-10}},
    color={0,0,127}));
  connect(eqAirTempVDI.TBlaSky, eqAirTemp.TBlaSky)
    annotation (Line(points={{28,84},{-34,84},{-98,84},{-98,-8},{-58,-8},{-58,2},
          {-32,2},{-32,-4},{-26,-4}},
    color={0,0,127}));
  connect(eqAirTempVDI.HSol[1], weaBus.HGloHor)
    annotation (Line(points={{28,90},{-100,90},{-100,6},{-83,6}},
    color={0,0,127}),Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(HDirTil.inc, corGDouPan.inc)
    annotation (Line(points={{-47,58},{-28,58},{-10,58},{-10,50},{4,50}},
    color={0,0,127}));
  connect(const1.y, eqAirTempVDI.sunblind[1])
    annotation (Line(points={{61.7,93},{56,93},{56,98},{40,98},{40,96}},
                                      color={0,0,127}));
  connect(corGDouPan.solarRadWinTrans, thermalZoneFourElements.solRad)
    annotation (Line(points={{27,56},{40,56},{40,25},{41,25}}, color={0,0,127}));
  annotation ( Documentation(info="<html>
  <p>This example shows the application of
  <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">
  AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>
  in combination with
  <a href=\"AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow\">
 AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow</a>
  and
  <a href=\"AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane\">
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane</a>.
  Solar radiation on tilted surface is calculated using models of
  AixLib. The thermal zone is a simple room defined in Guideline
  VDI 6007 Part 1 (VDI, 2012). All models, parameters and inputs
  except sunblinds, separate handling of heat transfer through
  windows, an extra wall element for ground floor (with additional
  area), an extra wall element for roof (with additional area) and
  solar radiation are similar to the ones defined for the
  guideline&apos;s test room. For solar radiation, the example
  relies on the standard weather file in AixLib.</p>
  <p>The idea of the example is to show a typical application of
  all sub-models and to use the example in unit tests. The results
  are reasonable, but not related to any real use case or measurement
  data.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI
  6007-1 March 2012. Calculation of transient thermal response of
  rooms and buildings - modelling of rooms.</p>
  </html>", revisions="<html>
  <ul>
  <li>
  April 27, 2016, by Michael Wetter:<br/>
  Removed call to <code>Modelica.Utilities.Files.loadResource</code>
  as this did not work for the regression tests.
  </li>
  <li>February 25, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),
  experiment(Tolerance=1e-6, StopTime=3.1536e+007, Interval=3600),
  __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/SimpleRoomFourElements.mos"
        "Simulate and plot"));
end ReduceOrderModel_MultipleRooms_WithInput;
