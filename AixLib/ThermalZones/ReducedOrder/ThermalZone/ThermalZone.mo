within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZone
  "Thermal zone model with internal gains"
  extends
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone;

  replaceable model corG = SolarGain.CorrectionGDoublePane
    constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission"
    annotation(choicesAllMatching=true);

  replaceable Utilities.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    humanSenHea(
    final ActivityType=3,
    final T0=zoneParam.T_start,
    final NrPeople=zoneParam.nrPeople,
    final RatioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople) if ATot > 0
    "Internal gains from persons" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{64,-36},{84,-16}})));
  replaceable Utilities.Sources.InternalGains.Machines.Machines_DIN18599
    machinesSenHea(
    final ratioConv=zoneParam.ratioConvectiveHeatMachines,
    final T0=zoneParam.T_start,
    final ActivityType=2,
    final NrPeople=zoneParam.nrPeopleMachines) if ATot > 0
    "Internal gains from machines"
    annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
  replaceable Utilities.Sources.InternalGains.Lights.Lights_relative lights(
    final ratioConv=zoneParam.ratioConvectiveHeatLighting,
    final T0=zoneParam.T_start,
    final LightingPower=zoneParam.lightingPower,
    final RoomArea=zoneParam.AZone) if ATot > 0 "Internal gains from light"
    annotation (Placement(transformation(extent={{64,-76},{84,-57}})));
  corG corGMod(
    final n=zoneParam.nOrientations,
    final UWin=zoneParam.UWin) if
    sum(zoneParam.ATransparent) > 0 "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-12,37},{0,49}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTempWall(
    withLongwave=true,
    final n=zoneParam.nOrientations,
    final wfWall=zoneParam.wfWall,
    final wfWin=zoneParam.wfWin,
    final wfGro=zoneParam.wfGro,
    final alphaWallOut=zoneParam.alphaWallOut,
    final alphaRad=zoneParam.alphaRadWall,
    final alphaWinOut=zoneParam.alphaWinOut,
    final aExt=zoneParam.aExt,
    final TGro=zoneParam.TSoil) if
       (sum(zoneParam.AExt) + sum(zoneParam.AWin)) > 0
    "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-36,-2},{-16,18}})));
  EquivalentAirTemperature.VDI6007 eqAirTempRoof(
    final wfGro=0,
    final n=zoneParam.nOrientationsRoof,
    final aExt=zoneParam.aRoof,
    final wfWall=zoneParam.wfRoof,
    final alphaWallOut=zoneParam.alphaRoofOut,
    final alphaRad=zoneParam.alphaRadRoof,
    final wfWin=fill(0, zoneParam.nOrientationsRoof),
    final TGro=273.15) if zoneParam.ARoof > 0
    "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{-36,84},{-16,104}})));
  Modelica.Blocks.Sources.Constant constSunblindRoof[zoneParam.nOrientationsRoof](
     each k=0)
     "Sets sunblind signal to zero (open)"
     annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,113})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilWall[zoneParam.nOrientations](
    each final outSkyCon=true,
    each final outGroCon=true,
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziExtWalls,
    final til=zoneParam.tiltExtWalls)
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,10},{-68,26}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilWall[zoneParam.nOrientations](
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziExtWalls,
    final til=zoneParam.tiltExtWalls)
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,31},{-68,48}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[zoneParam.nOrientationsRoof](
    each final  outSkyCon=false,
    each final outGroCon=false,
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,73},{-68,89}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[zoneParam.nOrientationsRoof](
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,96},{-68,113}})));

  Modelica.Blocks.Math.Product
                           sunblindCorrection[zoneParam.nOrientations] if
    sum(zoneParam.ATransparent) > 0
    annotation (Placement(transformation(extent={{14,50},{22,58}})));
  Windows.BaseClasses.SunblindEquippedWindow sunblindEquippedWindow(
    n=zoneParam.nOrientations,
    lim=zoneParam.maxIrr,
    shadingFactor=zoneParam.shadingFactor) if
    sum(zoneParam.ATransparent) > 0
    annotation (Placement(transformation(extent={{-10,56},{-2,64}})));
protected
  Modelica.Blocks.Sources.Constant alphaRoof(
    final k=(zoneParam.alphaRoofOut +
    zoneParam.alphaRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={74,99})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof if
    zoneParam.ARoof > 0
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={61,99})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof if
    zoneParam.ARoof > 0
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=0,
    origin={45,106})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor if
    zoneParam.AFloor > 0
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={74,18})));
  Modelica.Blocks.Sources.Constant TSoil(final k=zoneParam.TSoil) if
    zoneParam.AFloor > 0
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=180,origin={57,8})));
  Modelica.Blocks.Sources.Constant alphaWall(
    final k=(zoneParam.alphaWallOut +
    zoneParam.alphaRadWall) * sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={37,0})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall if
    sum(zoneParam.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{42,18},{32,8}})));
  Modelica.Blocks.Sources.Constant alphaWin(final k=(zoneParam.alphaWinOut +
        zoneParam.alphaRadWall)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={37,43})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin if
    sum(zoneParam.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{42,24},{32,34}})));
  Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,100},{-48,110}})));
  Modelica.Blocks.Math.Add solRadWall[zoneParam.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,14},{-44,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWall if
    sum(zoneParam.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{12,2},{24,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin if
    sum(zoneParam.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{12,23},{24,35}})));

public
  Windows.BaseClasses.SunblindEquippedWall sunblindEquippedWall(
    n=zoneParam.nOrientations,
    lim=zoneParam.maxIrr,
    shadingFactor=zoneParam.shadingFactor)
    annotation (Placement(transformation(extent={{-44,48},{-36,56}})));
equation
  connect(HDirTilWall.H, sunblindEquippedWindow.HDirTil) annotation (Line(
        points={{-67.2,39.5},{-58,39.5},{-58,57.52},{-10.4,57.52}}, color={0,0,
          127}));
  connect(intGains[1],humanSenHea. Schedule) annotation (Line(points={{80,
          -113.333},{80,-113.333},{80,-78},{54,-78},{54,-27.1},{64.9,-27.1}},
        color={0,0,127}));
  connect(intGains[2],machinesSenHea. Schedule) annotation (Line(points={{80,-100},
          {80,-100},{80,-78},{54,-78},{54,-46.5},{65,-46.5}}, color={0,0,127}));
  connect(intGains[3],lights. Schedule) annotation (Line(points={{80,-86.6667},
          {80,-86.6667},{80,-78},{54,-78},{54,-66.5},{65,-66.5}},color={0,0,127}));
  connect(lights.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,-60.8},
          {92,-60.8},{92,50},{98,50}}, color={191,0,0}));
  connect(machinesSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,
          -40.8},{92,-40.8},{92,50},{98,50}},    color={191,0,0}));
  connect(humanSenHea.TRoom, ROM.intGainsConv) annotation (Line(points={{65,-17},
          {65,-14},{92,-14},{92,50},{98,50}},                   color={191,0,0}));
  connect(humanSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-27},
          {94,-27},{94,54},{98,54}},   color={95,95,95}));
  connect(machinesSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,
          -52.01},{94,-52.01},{94,54},{98,54}},   color={95,95,95}));
  connect(lights.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-72.01},
          {94,-72.01},{94,54},{98,54}},   color={95,95,95}));
  connect(eqAirTempWall.TEqAirWin, preTemWin.T) annotation (Line(points={{-15,11.8},
          {-12,11.8},{-12,24},{6,24},{6,29},{10.8,29}},
                                                color={0,0,127}));
  connect(eqAirTempWall.TEqAir, preTemWall.T) annotation (Line(points={{-15,8},{
          10.8,8}},                    color={0,0,127}));
  connect(HDirTilWall.H, corGMod.HDirTil) annotation (Line(points={{-67.2,39.5},
          {-58,39.5},{-58,46.6},{-13.2,46.6}},          color={0,0,127}));
  connect(HDirTilWall.H, solRadWall.u1) annotation (Line(points={{-67.2,39.5},{-58,
          39.5},{-58,22},{-55,22}},     color={0,0,127}));
  connect(HDirTilWall.inc, corGMod.inc) annotation (Line(points={{-67.2,36.1},{-60,
          36.1},{-60,36},{-56,36},{-56,39.4},{-13.2,39.4}}, color={0,0,127}));
  connect(HDifTilWall.H, solRadWall.u2) annotation (Line(points={{-67.2,18},{-60,
          18},{-60,16},{-55,16}}, color={0,0,127}));
  connect(HDifTilWall.HGroDifTil, corGMod.HGroDifTil) annotation (Line(points={{-67.2,
          13.2},{-62,13.2},{-62,41.8},{-13.2,41.8}},       color={0,0,127}));
  connect(solRadWall.y, eqAirTempWall.HSol) annotation (Line(points={{-43.5,19},
          {-42,19},{-42,18},{-42,14},{-38,14}}, color={0,0,127}));
  connect(weaBus.TBlaSky, eqAirTempWall.TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,8},{-38,8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTempWall.TDryBul) annotation (Line(
      points={{-100,34},{-86,34},{-86,2},{-38,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTilWall.HSkyDifTil, corGMod.HSkyDifTil) annotation (Line(points={{-67.2,
          22.8},{-64,22.8},{-64,44.2},{-13.2,44.2}},       color={0,0,127}));
  connect(theConWin.solid, ROM.window) annotation (Line(points={{42,29},{42,50},
          {50,50}},           color={191,0,0}));
  connect(theConWall.solid, ROM.extWall) annotation (Line(points={{42,13},{47,13},
          {47,42},{50,42}},   color={191,0,0}));
  connect(weaBus.TDryBul,eqAirTempRoof. TDryBul) annotation (Line(
      points={{-100,34},{-86,34},{-86,88},{-38,88}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky,eqAirTempRoof. TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,94},{-38,94}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDirTilRoof.H,solRadRoof. u1) annotation (Line(points={{-67.2,104.5},
          {-64,104.5},{-64,108},{-59,108}},
                                    color={0,0,127}));
  connect(HDifTilRoof.H,solRadRoof. u2) annotation (Line(points={{-67.2,81},{
          -64,81},{-64,102},{-59,102}},
                                  color={0,0,127}));
  connect(solRadRoof.y,eqAirTempRoof. HSol) annotation (Line(points={{-47.5,105},
          {-44,105},{-44,100},{-38,100}},
                                       color={0,0,127}));
  connect(constSunblindRoof.y,eqAirTempRoof. sunblind) annotation (Line(points={{-26,
          109.7},{-26,106}},                 color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{61.4,8},{74,8},{74,10.8}},      color={0,0,127}));
  connect(preTemFloor.port, ROM.floor)
    annotation (Line(points={{74,24},{74,28}}, color={191,0,0}));
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{51,106},{61,106},{61,104}},
                                                       color={191,0,0}));
  connect(theConRoof.Gc,alphaRoof. y)
    annotation (Line(points={{66,99},{69.6,99}},        color={0,0,127}));
  connect(eqAirTempRoof.TEqAir,preTemRoof. T) annotation (Line(points={{-15,94},
          {24,94},{24,106},{37.8,106}},                color={0,0,127}));
  connect(theConRoof.solid, ROM.roof)
    annotation (Line(points={{61,94},{72.9,94},{72.9,64}}, color={191,0,0}));
  for i in 1:zoneParam.nOrientations loop
    connect(weaBus,HDifTilWall [i].weaBus) annotation (Line(
        points={{-100,34},{-100,34},{-86,34},{-86,18},{-84,18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(HDirTilWall[i].weaBus, weaBus) annotation (Line(
        points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
  end for;
  for i in 1:zoneParam.nOrientationsRoof loop
    connect(weaBus, HDifTilRoof[i].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,81},{-84,81}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
    connect(weaBus, HDirTilRoof[i].weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,104.5},{-84,104.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  end for;
  connect(preTemWall.port, theConWall.fluid)
    annotation (Line(points={{24,8},{28,8},{28,13},{32,13}}, color={191,0,0}));
  connect(preTemWin.port, theConWin.fluid)
    annotation (Line(points={{24,29},{32,29}}, color={191,0,0}));
  connect(alphaWall.y, theConWall.Gc)
    annotation (Line(points={{37,4.4},{37,8}},          color={0,0,127}));
  connect(alphaWin.y, theConWin.Gc) annotation (Line(points={{37,38.6},{37,34}},
                              color={0,0,127}));
  connect(humanSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,-21},
          {84,-21},{84,-22},{92,-22},{92,50},{98,50}},
        color={191,0,0}));
  connect(sunblindCorrection.y, ROM.solRad) annotation (Line(points={{22.4,54},{
          36,54},{36,61},{49,61}}, color={0,0,127}));
  connect(HDirTilWall.H, sunblindEquippedWall.HDirTil) annotation (Line(points={{-67.2,
          39.5},{-58,39.5},{-58,49.52},{-44.4,49.52}},        color={0,0,127}));
  connect(HDifTilWall.HSkyDifTil, sunblindEquippedWall.HSkyDifTil) annotation (
      Line(points={{-67.2,22.8},{-64,22.8},{-64,54.24},{-44.48,54.24}}, color={0,
          0,127}));
  connect(sunblindCorrection.u2, corGMod.solarRadWinTrans) annotation (Line(
        points={{13.2,51.6},{6.6,51.6},{6.6,43},{0.6,43}}, color={0,0,127}));
  connect(sunblindEquippedWall.eqAirTempWallFac, eqAirTempWall.sunblind)
    annotation (Line(points={{-35.84,52},{-26,52},{-26,20}}, color={0,0,127}));
  connect(sunblindEquippedWindow.windowFac, sunblindCorrection.u1) annotation (
      Line(points={{-1.84,60},{6,60},{6,56.4},{13.2,56.4}}, color={0,0,127}));
  connect(HDifTilWall.HSkyDifTil, sunblindEquippedWindow.HSkyDifTil)
    annotation (Line(points={{-67.2,22.8},{-64,22.8},{-64,62.24},{-10.48,62.24}},
        color={0,0,127}));
  annotation(Documentation(info="<html>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation and internal gains. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a></p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone</a>.</p>
</html>",  revisions="<html>
 <ul>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation based on Annex60 and MSL models.
  </li>
  <li>
  March, 2012, by Moritz Lauster:<br/>
  First implementation.
  </li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            120,120}}),
                    graphics={
  Polygon(
    points={{44,-6},{-88,-6},{-88,68},{-20,68},{-20,20},{44,20},{44,-6}},
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
    extent={{65,-5},{90,-16}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Internal Gains"),
  Polygon(
    points={{82,118},{-88,118},{-88,72},{34,72},{34,88},{82,88},{82,118}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-52,42},{-24,30}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Exterior Walls"),
  Text(
    extent={{-8,98},{8,92}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Roof"),
  Polygon(
    points={{48,26},{84,26},{84,0},{48,0},{48,4},{48,0},{48,26}},
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
  Polygon(
    points={{-18,68},{44,68},{44,22},{-18,22},{-18,30},{-18,22},{-18,68}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-17,35},{0,28}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Windows")}),
    Icon(coordinateSystem(extent={{-100,-100},{120,120}})));
end ThermalZone;
