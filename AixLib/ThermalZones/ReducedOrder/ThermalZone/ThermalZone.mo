within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZone
  "Thermal zone model with internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone;

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
  Modelica.Blocks.Sources.Constant constSunblindWall[zoneParam.nOrientations](
    each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,27})));
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
    annotation (Placement(transformation(extent={{-36,66},{-16,86}})));
  Modelica.Blocks.Sources.Constant constSunblindRoof[zoneParam.nOrientationsRoof](
     each k=0)
     "Sets sunblind signal to zero (open)"
     annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-26,95})));
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
    annotation (Placement(transformation(extent={{-84,55},{-68,71}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[zoneParam.nOrientationsRoof](
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,78},{-68,95}})));

protected
  Modelica.Blocks.Sources.Constant alphaRoof(
    final k=(zoneParam.alphaRoofOut +
    zoneParam.alphaRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={74,79})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof if
    zoneParam.ARoof > 0
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={61,79})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof if
    zoneParam.ARoof > 0
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=0,
    origin={45,86})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor if
    zoneParam.AFloor > 0
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={62,18})));
  Modelica.Blocks.Sources.Constant TSoil(final k=zoneParam.TSoil) if
    zoneParam.AFloor > 0
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=180,origin={43,8})));
  Modelica.Blocks.Sources.Constant alphaWall(
    final k=(zoneParam.alphaWallOut +
    zoneParam.alphaRadWall) * sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={25,0})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall if
    sum(zoneParam.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{30,18},{20,8}})));
  Modelica.Blocks.Sources.Constant alphaWin(final k=(zoneParam.alphaWinOut +
        zoneParam.alphaRadWall)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={25,43})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin if
    sum(zoneParam.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{30,24},{20,34}})));
  Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
  Modelica.Blocks.Math.Add solRadWall[zoneParam.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,14},{-44,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWall if
    sum(zoneParam.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{4,2},{16,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin if
    sum(zoneParam.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{4,23},{16,35}})));

equation
  connect(intGains[1],humanSenHea. Schedule) annotation (Line(points={{80,
          -113.333},{80,-113.333},{80,-78},{54,-78},{54,-27.1},{64.9,-27.1}},
        color={0,0,127}));
  connect(intGains[2],machinesSenHea. Schedule) annotation (Line(points={{80,-100},
          {80,-100},{80,-78},{54,-78},{54,-46.5},{65,-46.5}}, color={0,0,127}));
  connect(intGains[3],lights. Schedule) annotation (Line(points={{80,-86.6667},
          {80,-86.6667},{80,-78},{54,-78},{54,-66.5},{65,-66.5}},color={0,0,127}));
  connect(lights.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,-60.8},
          {92,-60.8},{92,-60},{92,-60},{92,50},{86,50},{86,50}},
                                       color={191,0,0}));
  connect(machinesSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,
          -40.8},{92,-40.8},{92,-40},{92,-40},{92,50},{86,50},{86,50}},
                                                 color={191,0,0}));
  connect(humanSenHea.TRoom, ROM.intGainsConv) annotation (Line(points={{65,-17},
          {65,-14},{92,-14},{92,50},{86,50},{86,50}},           color={191,0,0}));
  connect(humanSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-27},
          {94,-27},{94,54},{86,54}},   color={95,95,95}));
  connect(machinesSenHea.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,
          -52.01},{94,-52.01},{94,54},{86,54}},   color={95,95,95}));
  connect(lights.RadHeat, ROM.intGainsRad) annotation (Line(points={{83,-72.01},
          {94,-72.01},{94,54},{86,54}},   color={95,95,95}));
  connect(eqAirTempWall.TEqAirWin, preTemWin.T) annotation (Line(points={{-15,
          11.8},{-12,11.8},{-12,24},{-2,24},{-2,28},{-2,29},{0,29},{2.8,29}},
                                                color={0,0,127}));
  connect(eqAirTempWall.TEqAir, preTemWall.T) annotation (Line(points={{-15,8},
          {2.8,8}},                    color={0,0,127}));
  connect(HDirTilWall.H, corGMod.HDirTil) annotation (Line(points={{-67.2,39.5},
          {-58,39.5},{-58,42},{-58,46.6},{-13.2,46.6}}, color={0,0,127}));
  connect(HDirTilWall.H, solRadWall.u1) annotation (Line(points={{-67.2,39.5},{
          -58,39.5},{-58,22},{-55,22}}, color={0,0,127}));
  connect(HDirTilWall.inc, corGMod.inc) annotation (Line(points={{-67.2,36.1},{-60,
          36.1},{-60,36},{-56,36},{-56,39.4},{-13.2,39.4}}, color={0,0,127}));
  connect(HDifTilWall.H, solRadWall.u2) annotation (Line(points={{-67.2,18},{-60,
          18},{-60,16},{-55,16}}, color={0,0,127}));
  connect(HDifTilWall.HGroDifTil, corGMod.HGroDifTil) annotation (Line(points={{
          -67.2,13.2},{-62,13.2},{-62,41.8},{-13.2,41.8}}, color={0,0,127}));
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
  connect(HDifTilWall.HSkyDifTil, corGMod.HSkyDifTil) annotation (Line(points={{
          -67.2,22.8},{-64,22.8},{-64,44.2},{-13.2,44.2}}, color={0,0,127}));
  connect(theConWin.solid, ROM.window) annotation (Line(points={{30,29},{32,29},
          {32,50},{38,50}},   color={191,0,0}));
  connect(theConWall.solid, ROM.extWall) annotation (Line(points={{30,13},{33,13},
          {33,42},{38,42}},   color={191,0,0}));
  connect(constSunblindWall.y, eqAirTempWall.sunblind) annotation (Line(points={{-26,
          23.7},{-26,23.7},{-26,20}},        color={0,0,127}));
  connect(weaBus.TDryBul,eqAirTempRoof. TDryBul) annotation (Line(
      points={{-100,34},{-86,34},{-86,76},{-48,76},{-48,70},{-38,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky,eqAirTempRoof. TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,76},{-38,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDirTilRoof.H,solRadRoof. u1) annotation (Line(points={{-67.2,86.5},{
          -64,86.5},{-64,90},{-59,90}},
                                    color={0,0,127}));
  connect(HDifTilRoof.H,solRadRoof. u2) annotation (Line(points={{-67.2,63},{-64,
          63},{-64,84},{-59,84}}, color={0,0,127}));
  connect(solRadRoof.y,eqAirTempRoof. HSol) annotation (Line(points={{-47.5,87},
          {-44,87},{-44,82},{-38,82}}, color={0,0,127}));
  connect(constSunblindRoof.y,eqAirTempRoof. sunblind) annotation (Line(points={{-26,
          91.7},{-26,88}},                   color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{47.4,8},{62,8},{62,10.8}},      color={0,0,127}));
  connect(preTemFloor.port, ROM.floor)
    annotation (Line(points={{62,24},{62,28}}, color={191,0,0}));
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{51,86},{61,86},{61,84}}, color={191,0,0}));
  connect(theConRoof.Gc,alphaRoof. y)
    annotation (Line(points={{66,79},{66,79},{69.6,79}},color={0,0,127}));
  connect(eqAirTempRoof.TEqAir,preTemRoof. T) annotation (Line(points={{-15,76},
          {-16,76},{24,76},{24,86},{37.8,86}},         color={0,0,127}));
  connect(theConRoof.solid, ROM.roof)
    annotation (Line(points={{61,74},{60.9,74},{60.9,64}}, color={191,0,0}));
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
      points={{-100,34},{-86,34},{-86,63},{-84,63}},
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
  connect(preTemWall.port, theConWall.fluid)
    annotation (Line(points={{16,8},{18,8},{18,13},{20,13}}, color={191,0,0}));
  connect(preTemWin.port, theConWin.fluid)
    annotation (Line(points={{16,29},{20,29}}, color={191,0,0}));
  connect(corGMod.solarRadWinTrans, ROM.solRad) annotation (Line(points={{0.6,43},
          {12,43},{12,61},{37,61}}, color={0,0,127}));
  connect(alphaWall.y, theConWall.Gc)
    annotation (Line(points={{25,4.4},{25,4.4},{25,8}}, color={0,0,127}));
  connect(alphaWin.y, theConWin.Gc) annotation (Line(points={{25,38.6},{25,36.3},
          {25,34}},           color={0,0,127}));
  connect(humanSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,
          -21},{84,-21},{84,-22},{86,-22},{92,-22},{92,50},{86,50},{86,50}},
        color={191,0,0}));
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
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
  Polygon(
    points={{34,-6},{-88,-6},{-88,52},{-20,52},{-20,20},{34,20},{34,-6}},
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
    points={{82,100},{-88,100},{-88,54},{34,54},{34,70},{82,70},{82,100}},
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
  Polygon(
    points={{-18,52},{34,52},{34,22},{-18,22},{-18,30},{-18,22},{-18,52}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-17,35},{0,28}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Windows")}));
end ThermalZone;
