within AixLib.Systems.Benchmark.Model;
model Weather_new
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
  ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
                                  corGDouPan(UWin=2.1, n=2)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,46},{26,66}})));
  ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow
                                             eqAirTemp(
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
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,14},{-14,20}})));
  Modelica.Blocks.Sources.Constant hConvWall(k=25*11.5) "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant hConvWin(k=20*14) "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=180,origin={80,-14})));
  ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007
                                   eqAirTempVDI(
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
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=270,
                origin={69,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b therm_roof
    annotation (Placement(transformation(extent={{96,86},{116,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b therm_window
    annotation (Placement(transformation(extent={{94,26},{114,46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b therm_wall
    annotation (Placement(transformation(extent={{94,-46},{114,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b therm_floor
    annotation (Placement(transformation(extent={{92,-98},{112,-78}})));
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
  connect(TSoil.y, preTemFloor.T) annotation (Line(points={{75.6,-14},{74,-14},
          {74,-22.8},{69,-22.8}}, color={0,0,127}));
  connect(theConRoof.solid, therm_roof) annotation (Line(points={{67,42},{86,42},
          {86,96},{106,96}}, color={191,0,0}));
  connect(theConWin.solid, therm_window)
    annotation (Line(points={{38,21},{104,21},{104,36}}, color={191,0,0}));
  connect(theConWall.solid, therm_wall) annotation (Line(points={{36,1},{102,1},
          {102,2},{104,2},{104,-36}}, color={191,0,0}));
  connect(preTemFloor.port, therm_floor) annotation (Line(points={{69,-36},{86,
          -36},{86,-88},{102,-88}}, color={191,0,0}));
  connect(therm_wall, therm_wall)
    annotation (Line(points={{104,-36},{104,-36}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Weather_new;
