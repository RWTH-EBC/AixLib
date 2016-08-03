within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneEquipped
  "Ready-to-use reduced order building model with ventilation, infiltration and internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.PartialThermalZone(ROM(
      redeclare package Medium = Modelica.Media.Air.SimpleAir));
  AixLib.Building.Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    human_SensibleHeat_VDI2078(
    ActivityType=3,
    T0=zoneParam.T_start,
    NrPeople=zoneParam.nrPeople,
    RatioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople)
                        "Internal gains from persons"
    annotation (choicesAllMatching=true, Placement(
        transformation(extent={{64,-36},{84,-16}})));
  AixLib.Building.Components.Sources.InternalGains.Machines.Machines_DIN18599 machines_SensibleHeat_DIN18599(
    ratioConv=zoneParam.ratioConvectiveHeatMachines,
    T0=zoneParam.T_start,
    ActivityType=2,
    NrPeople=zoneParam.nrPeopleMachines)
                        "Internal gains from machines"
    annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
  AixLib.Building.Components.Sources.InternalGains.Lights.Lights_relative lights(
    ratioConv=zoneParam.ratioConvectiveHeatLighting,
    T0=zoneParam.T_start,
    LightingPower=zoneParam.lightingPower,
    RoomArea=zoneParam.zoneArea)
                        "Internal gains from light"
    annotation (Placement(transformation(extent={{64,-76},{84,-57}})));
  Controls.VentilationController.VentilationController ventilationController(
    useConstantOutput=zoneParam.useConstantACHrate,
    baseACH=zoneParam.baseACH,
    maxUserACH=zoneParam.maxUserACH,
    maxOverheatingACH=zoneParam.maxOverheatingACH,
    maxSummerACH=zoneParam.maxSummerACH,
    winterReduction=zoneParam.winterReduction,
    Tmean_start=zoneParam.T_start)
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-70,-72},{-50,-52}})));
  Modelica.Blocks.Math.Add addInfiltrationVentilation
    "Combines infiltration and ventilation"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-34,-38})));
  Utilities.Psychrometrics.MixedTemperature mixedTemperature
    "mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-66,-28},{-46,-8}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[2](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,10},{-68,26}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[2](
    each til(displayUnit="deg") = 1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,31},{-68,48}})));
  SolarGain.CorrectionGDoublePane corGDouPan(n=2, UWin=2.1)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-6,44},{8,58}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    n=2,
    wfGro=0,
    wfWall={0.3043478260869566,0.6956521739130435},
    wfWin={0.5,0.5},
    withLongwave=true,
    aExt=0.7,
    alphaWallOut=20,
    alphaRadWall=5,
    alphaWinOut=20,
    alphaRadWin=5,
    aWin=0.03,
    eExt=0.9,
    TGro=285.15,
    eWin=0.9) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-36,-2},{-16,18}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,14},{-44,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4,2},{8,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4,22},{8,34}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{26,23},{16,33}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{26,13},{16,3}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,31})));
  Modelica.Blocks.Sources.Constant alphaWall(k=(zoneParam.alphaWallOut +
        zoneParam.alphaRadWall)*sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={21,-5})));
  Modelica.Blocks.Sources.Constant alphaWin(k=(zoneParam.alphaWinOut +
        zoneParam.alphaRadWin)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={21,41})));
  Building.Components.DryAir.VarAirExchange airExc(
    V=100,
    c=1,
    rho=1) annotation (Placement(transformation(extent={{-22,-26},{-6,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature ventTempPre
    "Prescriobed temperature for ventilation" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-32,-18})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={62,18})));
  Modelica.Blocks.Sources.Constant TSoil(k=zoneParam.Tsoil)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=180,origin={47,8})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[2](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,53},{-68,69}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[2](
    each til(displayUnit="deg") = 1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,78},{-68,95}})));
  EquivalentAirTemperature.VDI6007 eqAirTempVDI(
    aExt=0.7,
    eExt=0.9,
    wfGro=0,
    alphaWallOut=20,
    alphaRadWall=5,
    n=2,
    wfWall={0.5,0.5},
    wfWin={0,0},
    TGro=285.15) "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{-36,64},{-16,84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={61,88})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={61,73})));
  Modelica.Blocks.Sources.Constant alphaRoof(k=(zoneParam.alphaRoofOut +
        zoneParam.alphaRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={74,73})));
  Modelica.Blocks.Sources.Constant const1[2](each k=0)
    "Sets sunblind signal to zero (open)" annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,95})));
  Modelica.Blocks.Math.Add solRadRoof[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
equation
  connect(ventilationController.y, addInfiltrationVentilation.u1) annotation (
      Line(
      points={{-51,-62},{-37.6,-62},{-37.6,-45.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], human_SensibleHeat_VDI2078.Schedule) annotation (Line(
        points={{80,-113.333},{80,-113.333},{80,-78},{54,-78},{54,-27.1},{64.9,
          -27.1}},
        color={0,0,127}));
  connect(intGains[2], machines_SensibleHeat_DIN18599.Schedule) annotation (
      Line(points={{80,-100},{80,-100},{80,-78},{54,-78},{54,-46.5},{65,-46.5}},
        color={0,0,127}));
  connect(intGains[3], lights.Schedule) annotation (Line(points={{80,-86.6667},
          {80,-86.6667},{80,-78},{54,-78},{54,-66.5},{65,-66.5}},color={0,0,127}));
  connect(intGains[1], ventilationController.relOccupation) annotation (Line(
        points={{80,-113.333},{80,-113.333},{80,-78},{0,-78},{-70,-78},{-70,-68}},
        color={0,0,127}));
  connect(ventRate, addInfiltrationVentilation.u2) annotation (Line(points={{-40,
          -100},{-40,-76},{-30.4,-76},{-30.4,-45.2}}, color={0,0,127}));
  connect(ventilationController.y, mixedTemperature.flowRate_flow2) annotation (
     Line(points={{-51,-62},{-49,-62},{-49,-30},{-70,-30},{-70,-25},{-65.6,-25}},
        color={0,0,127}));
  connect(ventRate, mixedTemperature.flowRate_flow1) annotation (Line(points={{-40,
          -100},{-74,-100},{-74,-15},{-65.6,-15}}, color={0,0,127}));
  connect(ventTemp, mixedTemperature.temperature_flow1) annotation (Line(points=
         {{-100,-40},{-76,-40},{-76,-10.2},{-65.6,-10.2}}, color={0,0,127}));
  connect(eqAirTemp.TEqAirWin,preTem1. T)
    annotation (Line(
    points={{-15,11.8},{-12,11.8},{-12,28},{-5.2,28}},
                                                   color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{-15,8},{-5.2,8}},
    color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{-67.2,39.5},{-58,39.5},{-58,56},{-58,55.2},{-7.4,55.2}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-67.2,39.5},{-58,39.5},{-58,22},{-55,22}},
                   color={0,0,127}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{-67.2,36.1},{-60,36.1},{-60,46},{-60,46.8},{-7.4,46.8}},
                                                      color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-67.2,18},{-60,18},{-60,16},{-55,16}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(
    points={{-67.2,13.2},{-62,13.2},{-62,49.6},{-7.4,49.6}},
                                              color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{-43.5,19},{-42,19},{-42,18},{-42,14},{-38,14}},
    color={0,0,127}));
  connect(preTem1.port,theConWin. fluid)
    annotation (Line(points={{8,28},{16,28}},          color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{16,8},{16,8},{8,8}},         color={191,0,0}));
  connect(alphaWall.y,theConWall. Gc)
    annotation (Line(points={{21,-0.6},{21,3}},           color={0,0,127}));
  connect(alphaWin.y,theConWin. Gc)
    annotation (Line(points={{21,36.6},{21,33}},         color={0,0,127}));
  connect(lights.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,-60.8},
          {92,-60.8},{92,50},{86,50}}, color={191,0,0}));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, ROM.intGainsConv)
    annotation (Line(points={{83,-40.8},{92,-40.8},{92,50},{86,50}}, color={191,
          0,0}));
  connect(human_SensibleHeat_VDI2078.ConvHeat, ROM.intGainsConv) annotation (
      Line(points={{83,-21},{92,-21},{92,50},{86,50}}, color={191,0,0}));
  connect(human_SensibleHeat_VDI2078.TRoom, ROM.intGainsConv) annotation (Line(
        points={{65,-17},{65,-10},{92,-10},{92,50},{86,50}}, color={191,0,0}));
  connect(human_SensibleHeat_VDI2078.RadHeat, ROM.intGainsRad) annotation (Line(
        points={{83,-27},{94,-27},{94,54},{86.2,54}}, color={95,95,95}));
  connect(machines_SensibleHeat_DIN18599.RadHeat, ROM.intGainsRad) annotation (
      Line(points={{83,-52.01},{94,-52.01},{94,54},{86.2,54}}, color={95,95,95}));
  connect(lights.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-72.01},
          {94,-72.01},{94,54},{86.2,54}}, color={95,95,95}));
  connect(ROM.TAir, ventilationController.Tzone) annotation (Line(points={{87,62},
          {90,62},{90,-6},{52,-6},{52,-50},{-70,-50},{-70,-54},{-70,-56}},
        color={0,0,127}));
  connect(ventTempPre.port, airExc.port_a)
    annotation (Line(points={{-26,-18},{-26,-18},{-22,-18}}, color={191,0,0}));
  connect(mixedTemperature.mixedTemperatureOut, ventTempPre.T)
    annotation (Line(points={{-46,-18},{-39.2,-18}}, color={0,0,127}));
  connect(addInfiltrationVentilation.y, airExc.InPort1) annotation (Line(points=
         {{-34,-31.4},{-34,-31.4},{-34,-28},{-24,-28},{-24,-23.12},{-21.2,-23.12}},
        color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{51.4,8},{62,8},{62,10.8}},      color={0,0,127}));
  connect(preTemFloor.port, ROM.floor)
    annotation (Line(points={{62,24},{62,28}}, color={191,0,0}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-18},{44,
          -18},{44,0},{92,0},{92,50},{86,50}}, color={191,0,0}));
  connect(weaBus, HDifTil[1].weaBus) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,18},{-84,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, HDifTil[2].weaBus) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,18},{-84,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,8},{-38,8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul) annotation (Line(
      points={{-100,34},{-86,34},{-86,2},{-38,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, mixedTemperature.temperature_flow2) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,-20},{-65.6,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventilationController.Tambient) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,-20},{-78,-20},{-78,-62},{-70,-62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(corGDouPan.solarRadWinTrans, ROM.solRad) annotation (Line(points={{8.7,
          51},{23.35,51},{23.35,61},{37,61}}, color={0,0,127}));
  connect(HDirTil[1].weaBus, weaBus) annotation (Line(
      points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil[2].weaBus, weaBus) annotation (Line(
      points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDifTil.HSkyDifTil, corGDouPan.HSkyDifTil) annotation (Line(points={{-67.2,
          22.8},{-64,22.8},{-64,52.4},{-7.4,52.4}}, color={0,0,127}));
  connect(theConWin.solid, ROM.window) annotation (Line(points={{26,28},{30,28},
          {30,50},{37.8,50}}, color={191,0,0}));
  connect(theConWall.solid, ROM.extWall) annotation (Line(points={{26,8},{34,8},
          {34,42},{37.8,42}}, color={191,0,0}));
  connect(const.y, eqAirTemp.sunblind) annotation (Line(points={{-26,27.7},{-26,
          24.85},{-26,20}}, color={0,0,127}));
  connect(weaBus, HDifTilRoof[1].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,61},{-84,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, HDifTilRoof[2].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,61},{-84,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, HDirTilRoof[1].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,86.5},{-84,86.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, HDirTilRoof[2].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,86.5},{-84,86.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{61,82},{61,82},{61,78}}, color={191,0,0}));
  connect(theConRoof.Gc,alphaRoof. y)
    annotation (Line(points={{66,73},{66,73},{69.6,73}},color={0,0,127}));
  connect(theConRoof.solid, ROM.roof)
    annotation (Line(points={{61,68},{60.8,68},{60.8,63}}, color={191,0,0}));
  connect(weaBus.TDryBul, eqAirTempVDI.TDryBul) annotation (Line(
      points={{-100,34},{-94,34},{-86,34},{-86,74},{-48,74},{-48,68},{-38,68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus.TBlaSky, eqAirTempVDI.TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,74},{-44,74},{-38,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(eqAirTempVDI.TEqAir, preTemRoof.T) annotation (Line(points={{-15,74},{
          4,74},{24,74},{24,98},{61,98},{61,95.2}}, color={0,0,127}));
  connect(HDirTilRoof.H, solRadRoof.u1) annotation (Line(points={{-67.2,86.5},{-64,
          86.5},{-64,90},{-59,90}}, color={0,0,127}));
  connect(HDifTilRoof.H, solRadRoof.u2) annotation (Line(points={{-67.2,61},{-64,
          61},{-64,84},{-59,84}}, color={0,0,127}));
  connect(solRadRoof.y, eqAirTempVDI.HSol) annotation (Line(points={{-47.5,87},{
          -44,87},{-44,80},{-38,80}}, color={0,0,127}));
  connect(const1.y, eqAirTempVDI.sunblind) annotation (Line(points={{-26,91.7},{
          -26,88.85},{-26,86}}, color={0,0,127}));
  annotation(Documentation(info="<html>
<p>This model combines building physics, models for internal gains and the
calculation of natural ventilation (window opening) and infiltration. It is
thought as a ready-to-use thermal zone model. For convenience, all parameters
are collected in a record (see
<a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\"> ZoneBaseRecord</a>). </p>
<p><b>References</b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012:
Calculation of transient thermal response of rooms and buildings -
Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014):
Low order thermal network models for dynamic simulations of buildings on city
district scale. In: Building and Environment 73, p. 223&ndash;231. DOI:
<a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">
10.1016/j.buildenv.2013.12.016</a>.</li>
</ul>
<p><b>Example Results</b></p>
<p>See <a href=\"Examples\">Examples</a>.</p>
</html>",  revisions="<html>
<ul>
<li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ThermalZoneEquipped;
