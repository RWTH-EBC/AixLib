within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneEquipped
  "Ready-to-use reduced order building model with ventilation, infiltration and internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.PartialThermalZone(ROM(
      redeclare package Medium = Modelica.Media.Air.SimpleAir));
  AixLib.Building.Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    humanSenHea(
    ActivityType=3,
    T0=zoneParam.T_start,
    NrPeople=zoneParam.nrPeople,
    RatioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople) if ATot > 0
    "Internal gains from persons" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{64,-36},{84,-16}})));
  AixLib.Building.Components.Sources.InternalGains.Machines.Machines_DIN18599 machinesSenHea(
    ratioConv=zoneParam.ratioConvectiveHeatMachines,
    T0=zoneParam.T_start,
    ActivityType=2,
    NrPeople=zoneParam.nrPeopleMachines) if ATot > 0
    "Internal gains from machines"
    annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
  AixLib.Building.Components.Sources.InternalGains.Lights.Lights_relative lights(
    ratioConv=zoneParam.ratioConvectiveHeatLighting,
    T0=zoneParam.T_start,
    LightingPower=zoneParam.lightingPower,
    RoomArea=zoneParam.AZone) if    ATot > 0
                        "Internal gains from light"
    annotation (Placement(transformation(extent={{64,-76},{84,-57}})));
  Controls.VentilationController.VentilationController ventCont(
    useConstantOutput=zoneParam.useConstantACHrate,
    baseACH=zoneParam.baseACH,
    maxUserACH=zoneParam.maxUserACH,
    maxOverheatingACH=zoneParam.maxOverheatingACH,
    maxSummerACH=zoneParam.maxSummerACH,
    winterReduction=zoneParam.winterReduction,
    Tmean_start=zoneParam.T_start) if ATot > 0 or zoneParam.VAir > 0
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-70,-72},{-50,-52}})));
  Modelica.Blocks.Math.Add addInfVen if                  ATot > 0 or zoneParam.VAir > 0
    "Combines infiltration and ventilation" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-34,-38})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if        ATot > 0 or zoneParam.VAir > 0
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-66,-28},{-46,-8}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[zoneParam.nOrientations](
    each outSkyCon=true,
    each outGroCon=true,
    each lat=zoneParam.lat,
    azi=zoneParam.aziExtWalls,
    til=zoneParam.aziExtWalls)
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,10},{-68,26}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[zoneParam.nOrientations](
    each lat=zoneParam.lat,
    azi=zoneParam.aziExtWalls,
    til=zoneParam.tiltExtWalls)
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,31},{-68,48}})));
  SolarGain.CorrectionGDoublePane corGDouPan(n=zoneParam.nOrientations, UWin=
        zoneParam.UWin)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-50,34},{-36,48}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    withLongwave=true,
    aWin=0.03,
    eExt=0.9,
    eWin=0.9,
    n=zoneParam.nOrientations,
    wfWall=zoneParam.wfWall,
    wfWin=zoneParam.wfWin,
    wfGro=zoneParam.wfGro,
    TGro=zoneParam.Tsoil,
    alphaWallOut=zoneParam.alphaWallOut,
    alphaRadWall=zoneParam.alphaRadWall,
    alphaWinOut=zoneParam.alphaWinOut,
    alphaRadWin=zoneParam.alphaRadWin,
    aExt=zoneParam.aExt)
              "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-36,-2},{-16,18}})));
  Modelica.Blocks.Math.Add solRad[zoneParam.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,14},{-44,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem if sum(zoneParam.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4,8},{8,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin if
                                                                         sum(zoneParam.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4,24},{8,36}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin if sum(zoneParam.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{26,25},{16,35}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall if sum(zoneParam.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{26,19},{16,9}})));
  Modelica.Blocks.Sources.Constant constSunblind[zoneParam.nOrientations](each
      k=0) "Sets sunblind signal to zero (open)" annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,31})));
  Modelica.Blocks.Sources.Constant alphaWall(k=(zoneParam.alphaWallOut +
        zoneParam.alphaRadWall)*sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={21,1})));
  Modelica.Blocks.Sources.Constant alphaWin(k=(zoneParam.alphaWinOut +
        zoneParam.alphaRadWin)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={21,43})));
  Building.Components.DryAir.VarAirExchange airExc(
    V=100,
    c=1,
    rho=1) if ATot > 0 or zoneParam.VAir > 0 "Heat flow due to ventilation"
                                             annotation (Placement(transformation(extent={{-22,-26},{-6,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature ventTempPre if ATot > 0 or zoneParam.VAir > 0
    "Prescribed temperature for ventilation"  annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-32,-18})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor if zoneParam.AFloor > 0
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={62,18})));
  Modelica.Blocks.Sources.Constant TSoil(k=zoneParam.Tsoil) if zoneParam.AFloor > 0
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=180,origin={43,8})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[zoneParam.nOrientationsRoof](
    each outSkyCon=false,
    each outGroCon=false,
    each lat=zoneParam.lat,
    azi=zoneParam.aziRoof,
    til=zoneParam.tiltRoof)
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,53},{-68,69}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[zoneParam.nOrientationsRoof](
    each lat=zoneParam.lat,
    azi=zoneParam.aziRoof,
    til=zoneParam.tiltRoof)
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,78},{-68,95}})));
  EquivalentAirTemperature.VDI6007 eqAirTempRoof(
    eExt=0.9,
    wfGro=0,
    n=zoneParam.nOrientationsRoof,
    aExt=zoneParam.aRoof,
    wfWall=zoneParam.wfRoof,
    alphaWallOut=zoneParam.alphaRoofOut,
    alphaRadWall=zoneParam.alphaRadRoof,
    wfWin=fill(0, zoneParam.nOrientationsRoof),
    TGro=273.15) "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{-36,64},{-16,84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof if zoneParam.ARoof > 0
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=0,
    origin={45,86})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof if zoneParam.ARoof > 0
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={61,79})));
  Modelica.Blocks.Sources.Constant alphaRoof(k=(zoneParam.alphaRoofOut +
        zoneParam.alphaRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={74,79})));
  Modelica.Blocks.Sources.Constant constSunblindRoof[zoneParam.nOrientationsRoof]
    (each k=0) "Sets sunblind signal to zero (open)" annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,95})));
  Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
equation
  connect(ventCont.y, addInfVen.u1) annotation (Line(
      points={{-51,-62},{-37.6,-62},{-37.6,-45.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], humanSenHea.Schedule) annotation (Line(points={{80,
          -113.333},{80,-113.333},{80,-78},{54,-78},{54,-27.1},{64.9,-27.1}},
        color={0,0,127}));
  connect(intGains[2], machinesSenHea.Schedule) annotation (Line(points={{80,-100},
          {80,-100},{80,-78},{54,-78},{54,-46.5},{65,-46.5}}, color={0,0,127}));
  connect(intGains[3], lights.Schedule) annotation (Line(points={{80,-86.6667},
          {80,-86.6667},{80,-78},{54,-78},{54,-66.5},{65,-66.5}},color={0,0,127}));
  connect(intGains[1], ventCont.relOccupation) annotation (Line(points={{80,
          -113.333},{80,-113.333},{80,-78},{0,-78},{-70,-78},{-70,-68}}, color=
          {0,0,127}));
  connect(ventRate, addInfVen.u2) annotation (Line(points={{-40,-100},{-40,-76},
          {-30.4,-76},{-30.4,-45.2}}, color={0,0,127}));
  connect(ventCont.y, mixedTemp.flowRate_flow2) annotation (Line(points={{-51,-62},
          {-49,-62},{-49,-30},{-70,-30},{-70,-25},{-65.6,-25}}, color={0,0,127}));
  connect(ventRate, mixedTemp.flowRate_flow1) annotation (Line(points={{-40,-100},
          {-74,-100},{-74,-15},{-65.6,-15}}, color={0,0,127}));
  connect(ventTemp, mixedTemp.temperature_flow1) annotation (Line(points={{-100,
          -40},{-76,-40},{-76,-10.2},{-65.6,-10.2}}, color={0,0,127}));
  connect(eqAirTemp.TEqAirWin, preTemWin.T) annotation (Line(points={{-15,11.8},
          {-12,11.8},{-12,30},{-5.2,30}}, color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{-15,8},{-10,8},{-10,14},{-5.2,14}},
    color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{-67.2,39.5},{-58,39.5},{-58,42},{-58,45.2},{-51.4,
          45.2}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-67.2,39.5},{-58,39.5},{-58,22},{-55,22}},
                   color={0,0,127}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{-67.2,36.1},{-60,36.1},{-60,36},{-60,36},{-56,36},
          {-56,36.8},{-51.4,36.8}},                   color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-67.2,18},{-60,18},{-60,16},{-55,16}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(
    points={{-67.2,13.2},{-62,13.2},{-62,39.6},{-51.4,39.6}},
                                              color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{-43.5,19},{-42,19},{-42,18},{-42,14},{-38,14}},
    color={0,0,127}));
  connect(preTemWin.port, theConWin.fluid)
    annotation (Line(points={{8,30},{12,30},{16,30}}, color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{16,14},{16,14},{8,14}},      color={191,0,0}));
  connect(alphaWall.y,theConWall. Gc)
    annotation (Line(points={{21,5.4},{21,9}},            color={0,0,127}));
  connect(alphaWin.y,theConWin. Gc)
    annotation (Line(points={{21,38.6},{21,35}},         color={0,0,127}));
  connect(lights.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,-60.8},
          {92,-60.8},{92,50},{86,50}}, color={191,0,0}));
  connect(machinesSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{
          83,-40.8},{92,-40.8},{92,50},{86,50}}, color={191,0,0}));
  connect(humanSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,
          -21},{92,-21},{92,50},{86,50}}, color={191,0,0}));
  connect(humanSenHea.TRoom, ROM.intGainsConv) annotation (Line(points={{65,-17},
          {65,-14},{66,-14},{66,-14},{92,-14},{92,50},{86,50}}, color={191,0,0}));
  connect(humanSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-27},
          {94,-27},{94,54},{86.2,54}}, color={95,95,95}));
  connect(machinesSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,
          -52.01},{94,-52.01},{94,54},{86.2,54}}, color={95,95,95}));
  connect(lights.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-72.01},
          {94,-72.01},{94,54},{86.2,54}}, color={95,95,95}));
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{87,62},{90,62},{
          90,-6},{52,-6},{52,-50},{-70,-50},{-70,-54},{-70,-56}}, color={0,0,
          127}));
  connect(ventTempPre.port, airExc.port_a)
    annotation (Line(points={{-26,-18},{-26,-18},{-22,-18}}, color={191,0,0}));
  connect(mixedTemp.mixedTemperatureOut, ventTempPre.T)
    annotation (Line(points={{-46,-18},{-39.2,-18}}, color={0,0,127}));
  connect(addInfVen.y, airExc.InPort1) annotation (Line(points={{-34,-31.4},{-34,
          -31.4},{-34,-28},{-24,-28},{-24,-23.12},{-21.2,-23.12}}, color={0,0,
          127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{47.4,8},{62,8},{62,10.8}},      color={0,0,127}));
  connect(preTemFloor.port, ROM.floor)
    annotation (Line(points={{62,24},{62,28}}, color={191,0,0}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-18},{
          44,-18},{44,-2},{92,-2},{92,50},{86,50}},
                                               color={191,0,0}));
  for i in 1:zoneParam.nOrientations loop
    connect(weaBus, HDifTil[i].weaBus) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,18},{-84,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
    connect(HDirTil[i].weaBus, weaBus) annotation (Line(
      points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end for;
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
  connect(weaBus.TDryBul, mixedTemp.temperature_flow2) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,-20},{-65.6,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventCont.Tambient) annotation (Line(
      points={{-100,34},{-100,34},{-86,34},{-86,-20},{-78,-20},{-78,-62},{-70,-62}},

      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(corGDouPan.solarRadWinTrans, ROM.solRad) annotation (Line(points={{-35.3,
          41},{8,41},{8,42},{8,42},{8,61},{37,61}},
                                              color={0,0,127}));
  connect(HDifTil.HSkyDifTil, corGDouPan.HSkyDifTil) annotation (Line(points={{-67.2,
          22.8},{-64,22.8},{-64,42.4},{-51.4,42.4}},color={0,0,127}));
  connect(theConWin.solid, ROM.window) annotation (Line(points={{26,30},{30,30},
          {30,50},{37.8,50}}, color={191,0,0}));
  connect(theConWall.solid, ROM.extWall) annotation (Line(points={{26,14},{34,
          14},{34,42},{37.8,42}},
                              color={191,0,0}));
  connect(constSunblind.y, eqAirTemp.sunblind) annotation (Line(points={{-26,
          27.7},{-26,24.85},{-26,20}}, color={0,0,127}));
  for i in 1:zoneParam.nOrientationsRoof loop
    connect(weaBus, HDifTilRoof[i].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,61},{-84,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
    connect(weaBus, HDirTilRoof[i].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,86.5},{-84,86.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  end for;
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{51,86},{61,86},{61,84}}, color={191,0,0}));
  connect(theConRoof.Gc,alphaRoof. y)
    annotation (Line(points={{66,79},{66,79},{69.6,79}},color={0,0,127}));
  connect(theConRoof.solid, ROM.roof)
    annotation (Line(points={{61,74},{60.8,74},{60.8,63}}, color={191,0,0}));
  connect(weaBus.TDryBul, eqAirTempRoof.TDryBul) annotation (Line(
      points={{-100,34},{-94,34},{-86,34},{-86,74},{-48,74},{-48,68},{-38,68}},

      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus.TBlaSky, eqAirTempRoof.TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,74},{-44,74},{-38,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(eqAirTempRoof.TEqAir, preTemRoof.T) annotation (Line(points={{-15,74},
          {4,74},{24,74},{24,86},{37.8,86},{37.8,86}}, color={0,0,127}));
  connect(HDirTilRoof.H, solRadRoof.u1) annotation (Line(points={{-67.2,86.5},{-64,
          86.5},{-64,90},{-59,90}}, color={0,0,127}));
  connect(HDifTilRoof.H, solRadRoof.u2) annotation (Line(points={{-67.2,61},{-64,
          61},{-64,84},{-59,84}}, color={0,0,127}));
  connect(solRadRoof.y, eqAirTempRoof.HSol) annotation (Line(points={{-47.5,87},
          {-44,87},{-44,80},{-38,80}}, color={0,0,127}));
  connect(constSunblindRoof.y, eqAirTempRoof.sunblind) annotation (Line(points=
          {{-26,91.7},{-26,88.85},{-26,86}}, color={0,0,127}));
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
            -100},{100,100}}), graphics={
  Polygon(
    points={{82,100},{-88,100},{-88,54},{34,54},{34,70},{82,70},{82,100}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Polygon(
    points={{62,-8},{98,-8},{98,-76},{62,-76},{62,-76},{62,-76},{62,-8}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{16,-142},{58,-156}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
    textString="Floor Plate"),
  Text(
    extent={{16,-142},{58,-156}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
    textString="Floor Plate"),
  Text(
    extent={{65,-5},{90,-16}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Internal Gains"),
  Rectangle(
    extent={{-79,-7},{-4,-80}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-28,-69},{-5,-80}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Ventilation
Infiltration
"),
  Rectangle(
    extent={{-88,52},{34,-5}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-28,52},{0,40}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Exterior Walls"),
  Polygon(
    points={{36,26},{72,26},{72,0},{36,0},{36,4},{36,0},{36,26}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{49,7},{70,0}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Floor Plate"),
  Text(
    extent={{-8,98},{8,92}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Roof")}));
end ThermalZoneEquipped;
