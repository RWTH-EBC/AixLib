within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model TestinInputHighOrder
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
    annotation (Placement(transformation(extent={{48,-66},{68,-46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{48,-88},{68,-68}})));
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
    annotation (Placement(transformation(extent={{2,-86},{18,-70}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,14},{-14,20}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-100,-10},{-66,22}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{50,-104},{70,-84}})));
  Modelica.Blocks.Sources.Constant hConvWall(k=25*11.5) "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant hConvWin(k=20*14) "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={79,-30})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=180,origin={84,-56})));
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

  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows(
    Room_Length=30,
    Room_Height=3,
    Room_Width=20,
    Win_Area=80,
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=1000,
    TOutAirLimit=1273.15)
    annotation (Placement(transformation(extent={{72,10},{92,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-78})));
  Modelica.Blocks.Sources.Constant const2(k=0.15)
    annotation (Placement(transformation(extent={{34,-42},{54,-22}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,28})));
  Utilities.Sources.PrescribedSolarRad prescribedSolarRad(n=5)
    annotation (Placement(transformation(extent={{-70,-58},{-50,-38}})));
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
    annotation (Line(points={{18.8,-78},{28,-78},{28,-56},{48,-56}},
    color={0,0,127}));
  connect(intGai.y[2], perCon.Q_flow)
    annotation (Line(points={{18.8,-78},{48,-78}},          color={0,0,127}));
  connect(intGai.y[3], macConv.Q_flow)
    annotation (Line(points={{18.8,-78},{28,-78},{28,-94},{50,-94}},
    color={0,0,127}));
  connect(const.y, eqAirTemp.sunblind)
    annotation (Line(points={{-13.7,17},{-12,17},{-12,8},{-14,8}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-47,62},{-42,62},{-42,14},{-39,14}},
    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-47,30},{-44,30},{-44,8},{-39,8}},
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
  connect(preTem1.port, theConWin.fluid)
    annotation (Line(points={{20,20},{28,20},{28,21}}, color={191,0,0}));
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
  connect(TSoil.y, preTemFloor.T)
  annotation (Line(points={{79.6,-56},{79,-56},{79,-37.2}}, color={0,0,127}));
  connect(preTemRoof.port, theConRoof.fluid)
    annotation (Line(points={{67,58},{67,58},{67,52}}, color={191,0,0}));
  connect(eqAirTempVDI.TEqAir, preTemRoof.T)
    annotation (Line(
    points={{51,84},{67,84},{67,71.2}}, color={0,0,127}));
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
  connect(const1.y, eqAirTempVDI.sunblind[1])
    annotation (Line(points={{61.7,93},{56,93},{56,98},{40,98},{40,96}},
                                      color={0,0,127}));
  connect(perRad.port, thermalCollector.port_a[1]) annotation (Line(points={{68,-56},
          {72,-56},{72,-78},{76,-78}},      color={191,0,0}));
  connect(perCon.port, thermalCollector.port_a[1])
    annotation (Line(points={{68,-78},{76,-78}}, color={191,0,0}));
  connect(macConv.port, thermalCollector.port_a[2]) annotation (Line(points={{70,-94},
          {72,-94},{72,-78},{76,-78}},      color={191,0,0}));
  connect(thermalCollector.port_b, southFacingWindows.thermRoom) annotation (
      Line(points={{96,-78},{96,22.3},{79.1,22.3}}, color={191,0,0}));
  connect(preTemFloor.port, southFacingWindows.Therm_ground)
    annotation (Line(points={{79,-24},{78.8,-24},{78.8,10.4}},
                                                            color={191,0,0}));
  connect(const2.y, southFacingWindows.AER) annotation (Line(points={{55,-32},{70,
          -32},{70,15},{71,15}}, color={0,0,127}));
  connect(weaBus.winSpe, southFacingWindows.WindSpeedPort) annotation (Line(
      points={{-83,6},{-78,6},{-78,-18},{66,-18},{66,23},{71,23}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(theConRoof.solid, thermalCollector1.port_a[1])
    annotation (Line(points={{67,42},{42,42},{42,28}}, color={191,0,0}));
  connect(theConWin.solid, thermalCollector1.port_a[2])
    annotation (Line(points={{38,21},{42,21},{42,28}}, color={191,0,0}));
  connect(theConWall.solid, thermalCollector1.port_a[3])
    annotation (Line(points={{36,1},{42,1},{42,28}}, color={191,0,0}));
  connect(thermalCollector1.port_b, southFacingWindows.Therm_outside)
    annotation (Line(points={{62,28},{68,28},{68,29.7},{71.5,29.7}}, color={191,
          0,0}));
  connect(theConRoof.Gc, hConvRoof.y) annotation (Line(points={{72,47},{36,47},{
          36,48},{0,48},{0,0},{-4.4,0}}, color={0,0,127}));



  connect(HDirTil[1].inc, prescribedSolarRad.AOI[1]) annotation (Line(points={{-47,
          58},{-90,58},{-90,-55.8},{-69,-55.8}}, color={0,0,127}));
   connect(HDirTil[1].inc, prescribedSolarRad.AOI[2]) annotation (Line(points={{-47,58},
          {-90,58},{-90,-55.4},{-69,-55.4}},     color={0,0,127}));
 connect(HDirTil[1].inc, prescribedSolarRad.AOI[3]) annotation (Line(points={{-47,58},
          {-90,58},{-90,-55},{-69,-55}},         color={0,0,127}));
           connect(HDirTil[1].inc, prescribedSolarRad.AOI[4]) annotation (Line(points={{-47,58},
          {-90,58},{-90,-54.6},{-69,-54.6}},     color={0,0,127}));
           connect(HDirTil[1].inc, prescribedSolarRad.AOI[5]) annotation (Line(points={{-47,58},
          {-90,58},{-90,-54.2},{-69,-54.2}},     color={0,0,127}));

  connect(solRad[1].y, prescribedSolarRad.I_diff[1]) annotation (Line(points={{-27.5,
          11},{-27.5,-48},{-69,-48},{-69,-47.8}}, color={0,0,127}));
  connect(solRad[1].y, prescribedSolarRad.I_diff[2]) annotation (Line(points={{-27.5,
          11},{-27.5,-48},{-69,-48},{-69,-47.4}}, color={0,0,127}));
  connect(solRad[1].y, prescribedSolarRad.I_diff[3]) annotation (Line(points={{-27.5,
          11},{-27.5,-48},{-69,-48},{-69,-47}},   color={0,0,127}));
  connect(solRad[1].y, prescribedSolarRad.I_diff[4]) annotation (Line(points={{-27.5,
          11},{-27.5,-48},{-69,-48},{-69,-46.6}}, color={0,0,127}));
  connect(solRad[1].y, prescribedSolarRad.I_diff[5]) annotation (Line(points={{-27.5,
          11},{-27.5,-48},{-69,-48},{-69,-46.2}}, color={0,0,127}));


  connect(HDirTil[1].H, prescribedSolarRad.I_dir[1]) annotation (Line(points={{-47,
          62},{-88,62},{-88,-43.8},{-69,-43.8}}, color={0,0,127}));
   connect(HDirTil[1].H, prescribedSolarRad.I_dir[2])
                                                     annotation (Line(points={{-47,62},
          {-88,62},{-88,-43.4},{-69,-43.4}},     color={0,0,127}));
   connect(HDirTil[1].H, prescribedSolarRad.I_dir[3])
                                                     annotation (Line(points={{-47,62},
          {-88,62},{-88,-43},{-69,-43}},         color={0,0,127}));
   connect(HDirTil[1].H, prescribedSolarRad.I_dir[4])
                                                     annotation (Line(points={{-47,62},
          {-88,62},{-88,-42.6},{-69,-42.6}},     color={0,0,127}));
   connect(HDirTil[1].H, prescribedSolarRad.I_dir[5])
                                                     annotation (Line(points={{-47,62},
          {-88,62},{-88,-42.2},{-69,-42.2}},     color={0,0,127}));



  connect(weaBus.HHorIR, prescribedSolarRad.I_gr[1]) annotation (Line(
      points={{-83,6},{-83,-53},{-68.9,-53},{-68.9,-51.98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
    connect(weaBus.HHorIR, prescribedSolarRad.I_gr[2]) annotation (Line(
      points={{-83,6},{-83,-53},{-68.9,-53},{-68.9,-51.54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
     connect(weaBus.HHorIR, prescribedSolarRad.I_gr[3]) annotation (Line(
      points={{-83,6},{-83,-53},{-68.9,-53},{-68.9,-51.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

      connect(weaBus.HHorIR, prescribedSolarRad.I_gr[4]) annotation (Line(
      points={{-83,6},{-83,-53},{-68.9,-53},{-68.9,-50.66}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
      connect(weaBus.HHorIR, prescribedSolarRad.I_gr[5]) annotation (Line(
      points={{-83,6},{-83,-53},{-68.9,-53},{-68.9,-50.22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));


  connect(weaBus.HDirNor, prescribedSolarRad.I[1]) annotation (Line(
      points={{-83,6},{-83,-17},{-68.9,-17},{-68.9,-39.98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HDirNor, prescribedSolarRad.I[2]) annotation (Line(
      points={{-83,6},{-83,-17},{-68.9,-17},{-68.9,-39.54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
   connect(weaBus.HDirNor, prescribedSolarRad.I[3]) annotation (Line(
      points={{-83,6},{-83,-17},{-68.9,-17},{-68.9,-39.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
     connect(weaBus.HDirNor, prescribedSolarRad.I[4]) annotation (Line(
      points={{-83,6},{-83,-17},{-68.9,-17},{-68.9,-38.66}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
     connect(weaBus.HDirNor, prescribedSolarRad.I[5]) annotation (Line(
      points={{-83,6},{-83,-17},{-68.9,-17},{-68.9,-38.22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));


  connect(prescribedSolarRad.solarRad_out[1], southFacingWindows.SolarRadiationPort[
    1]) annotation (Line(points={{-51,-48.8},{10,-48.8},{10,25.2},{71,25.2}},
        color={255,128,0}));
  connect(prescribedSolarRad.solarRad_out[2], southFacingWindows.SolarRadiationPort[
    2]) annotation (Line(points={{-51,-48.4},{10,-48.4},{10,25.6},{71,25.6}},
        color={255,128,0}));
  connect(prescribedSolarRad.solarRad_out[3], southFacingWindows.SolarRadiationPort[
    3]) annotation (Line(points={{-51,-48},{10,-48},{10,26},{71,26}}, color={255,
          128,0}));
  connect(prescribedSolarRad.solarRad_out[4], southFacingWindows.SolarRadiationPort[
    4]) annotation (Line(points={{-51,-47.6},{10,-47.6},{10,26.4},{71,26.4}},
        color={255,128,0}));
  connect(prescribedSolarRad.solarRad_out[5], southFacingWindows.SolarRadiationPort[
    5]) annotation (Line(points={{-51,-47.2},{10,-47.2},{10,26.8},{71,26.8}},
        color={255,128,0}));
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
end TestinInputHighOrder;
