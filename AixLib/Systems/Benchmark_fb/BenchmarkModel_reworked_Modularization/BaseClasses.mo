within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
package BaseClasses
  extends Modelica.Icons.Package;

  model thermalZone_Benchmark "Thermal zone model with internal gains"
    extends
      AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone(
       zoneParam=DataBase_ThermalZone.thermalZone_Benchmark_Workshop());

    replaceable model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
      constrainedby
      AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
      "Model for correction of solar transmission"
      annotation(choicesAllMatching=true);

    replaceable AixLib.Utilities.Sources.InternalGains.Humans.HumanSensibleHeatTemperatureIndependent
      humanSenHea(
      final T0=zoneParam.T_start) if     ATot > 0
      "Internal gains from persons" annotation (choicesAllMatching=true,
        Placement(transformation(extent={{64,-36},{84,-16}})));
    replaceable AixLib.Utilities.Sources.InternalGains.Machines.MachinesAreaSpecific
      machinesSenHea(
      final ratioConv=zoneParam.ratioConvectiveHeatMachines,
      final T0=zoneParam.T_start,
      final InternalGainsMachinesSpecific=zoneParam.internalGainsMachinesSpecific,
      final RoomArea=zoneParam.AZone) if ATot > 0
      "Internal gains from machines"
      annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
    replaceable AixLib.Utilities.Sources.InternalGains.Lights.LightsAreaSpecific lights(
      final ratioConv=zoneParam.ratioConvectiveHeatLighting,
      final T0=zoneParam.T_start,
      final LightingPower=zoneParam.lightingPowerSpecific,
      final RoomArea=zoneParam.AZone) if ATot > 0 "Internal gains from light"
      annotation (Placement(transformation(extent={{64,-76},{84,-57}})));
    corG corGMod(
      final n=zoneParam.nOrientations,
      final UWin=zoneParam.UWin) if
      sum(zoneParam.ATransparent) > 0 "Correction factor for solar transmission"
      annotation (Placement(transformation(extent={{-12,37},{0,49}})));
    AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTempWall(
      withLongwave=false,
      final n=zoneParam.nOrientations,
      final wfWall=zoneParam.wfWall,
      final wfWin=zoneParam.wfWin,
      final wfGro=zoneParam.wfGro,
      final hConWallOut=zoneParam.hConWallOut,
      final hRad=zoneParam.hRadWall,
      final hConWinOut=zoneParam.hConWinOut,
      final aExt=zoneParam.aExt,
      final TGro=zoneParam.TSoil) if (sum(zoneParam.AExt) + sum(zoneParam.AWin)) > 0 "Computes equivalent air temperature"
      annotation (Placement(transformation(extent={{-36,-2},{-16,18}})));
    Modelica.Blocks.Sources.Constant constSunblindWall[zoneParam.nOrientations](
      each k=0)
      "Sets sunblind signal to zero (open)"
      annotation (Placement(
          transformation(
          extent={{3,-3},{-3,3}},
          rotation=90,
          origin={-26,27})));
    AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007 eqAirTempRoof(
      final wfGro=0,
      final n=zoneParam.nOrientationsRoof,
      final aExt=zoneParam.aRoof,
      final wfWall=zoneParam.wfRoof,
      final hConWallOut=zoneParam.hConRoofOut,
      final hRad=zoneParam.hRadRoof,
      final wfWin=fill(0, zoneParam.nOrientationsRoof),
      final TGro=273.15,
      withLongwave=false) if
                            zoneParam.ARoof > 0 "Computes equivalent air temperature for roof"
      annotation (Placement(transformation(extent={{-36,66},{-16,86}})));
    Modelica.Blocks.Sources.Constant constSunblindRoof[zoneParam.nOrientationsRoof](
       each k=0)
       "Sets sunblind signal to zero (open)"
       annotation (Placement(
          transformation(
          extent={{3,-3},{-3,3}},
          rotation=90,
          origin={-26,95})));
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

    AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTill[zoneParam.nOrientations](
      each til=1.5707963267949,
      lat=zoneParam.lat,
      azi=zoneParam.aziExtWalls,
      outSkyCon=true,
      outGroCon=true)
      annotation (Placement(transformation(extent={{-112,-2},{-92,18}})));
  protected
    Modelica.Blocks.Sources.Constant hConRoof(final k=(zoneParam.hConRoofOut + zoneParam.hRadRoof)*zoneParam.ARoof)
      "Outdoor coefficient of heat transfer for roof" annotation (Placement(transformation(extent={{2,-4},{
              -6,4}})));
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
    Modelica.Blocks.Sources.Constant hConWall(final k=(zoneParam.hConWallOut + zoneParam.hRadWall)*sum(zoneParam.AExt))
      "Outdoor coefficient of heat transfer for walls" annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90,
          origin={-2,-14})));
    Modelica.Thermal.HeatTransfer.Components.Convection theConWall if
      sum(zoneParam.AExt) > 0
      "Outdoor convective heat transfer of walls"
      annotation (Placement(transformation(extent={{30,18},{20,8}})));
    Modelica.Blocks.Sources.Constant hConWin(final k=(zoneParam.hConWinOut + zoneParam.hRadWall)*sum(zoneParam.AWin))
      "Outdoor coefficient of heat transfer for windows" annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90,
          origin={16,-18})));
    Modelica.Thermal.HeatTransfer.Components.Convection theConWin if
      sum(zoneParam.AWin) > 0
      "Outdoor convective heat transfer of windows"
      annotation (Placement(transformation(extent={{30,24},{20,34}})));
    Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
      "Sums up solar radiation of both directions"
      annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
    Modelica.Blocks.Math.Add solRadWall[zoneParam.nOrientations]
      "Sums up solar radiation of both directions"
      annotation (Placement(transformation(extent={{-54,20},{-44,30}})));
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

    connect(HDirTilWall.inc, corGMod.inc) annotation (Line(points={{-67.2,36.1},{-60,
            36.1},{-60,36},{-56,36},{-56,39.4},{-13.2,39.4}}, color={0,0,127}));
    connect(solRadWall.y, eqAirTempWall.HSol) annotation (Line(points={{-43.5,
            25},{-42,25},{-42,14},{-38,14}},      color={0,0,127}));
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
    connect(theConRoof.Gc, hConRoof.y) annotation (Line(points={{66,79},{66,0},
            {-6.4,0}},                                                                    color={0,0,127}));
    connect(eqAirTempRoof.TEqAir,preTemRoof. T) annotation (Line(points={{-15,76},
            {-16,76},{24,76},{24,86},{37.8,86}},         color={0,0,127}));
    connect(theConRoof.solid, ROM.roof)
      annotation (Line(points={{61,74},{60.9,74},{60.9,64}}, color={191,0,0}));
    for i in 1:zoneParam.nOrientations loop
      connect(HDirTilWall[i].weaBus, weaBus) annotation (Line(
          points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
          connect(HDifTill[i].weaBus, weaBus) annotation (Line(
          points={{-112,8},{-86,8},{-86,46},{-86,34},{-100,34}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
            connect(HDirTilWall[i].H, solRadWall[i].u1);
            connect(HDifTill[i].H, solRadWall[i].u2);

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
    connect(hConWall.y, theConWall.Gc) annotation (Line(points={{-2,-9.6},{25,
            -9.6},{25,8}},                                                                color={0,0,127}));
    connect(hConWin.y, theConWin.Gc) annotation (Line(points={{16,-22.4},{16,34},
            {25,34}},                                                                   color={0,0,127}));
    connect(humanSenHea.ConvHeat, ROM.intGainsConv) annotation (Line(points={{83,
            -21},{84,-21},{84,-22},{86,-22},{92,-22},{92,50},{86,50},{86,50}},
          color={191,0,0}));
          connect(HDifTill.HSkyDifTil, corGMod.HSkyDifTil) annotation (Line(points={{-91,14},
              {-64,14},{-64,44.2},{-13.2,44.2}},             color={0,0,127}));

  connect(HDifTill.HGroDifTil, corGMod.HGroDifTil) annotation (Line(points={{-91,2},
            {-64,2},{-64,41.8},{-13.2,41.8}},                color={0,0,127}));

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
</html>",    revisions="<html>
 <ul>
  <li>
  March 01, 2019, by Niklas Huelsenbeck:<br/>
  Integration of new Internal Gains models, HumanSensibleHeatAreaSpecific and MachinesAreaSpecific
  </li>
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
            textString="Windows")}),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end thermalZone_Benchmark;

  model HighOrderModel_Benchmark_Workshop
     parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=TypOW,
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      calcMethod=2,
      outside=true,
      withWindow=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=true,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=60,
      withDoor=false,
      T0=T0_IW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      windowarea=60,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      withWindow=true,
      windowarea=60,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      final withSunblind=false,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withWindow=false,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
  public
      AixLib.Utilities.Interfaces.RadPort
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
     AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
  equation
    connect(thermStar_Demux.portRad, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}}, color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-76.35,4},{-86,4},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
          color={0,0,127}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-62,4},{-54,4},{-54,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,-62},
            {-32,-41.8},{-30.7,-41.8}},                                                                                                 color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,-60},
            {28,-60},{28,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{60,4},{46,4},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,74},{26,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,76},{-32,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{
            -112,28}},
          color={0,0,127}));

      connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));

      connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
        annotation (Line(
          points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
          color={255,128,0}));
      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));
      connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
         Line(
          points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}},
          color={255,128,0}));
      connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
        annotation (Line(
          points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
            52}},
          color={255,128,0}));

      connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
         Line(
          points={{4,-69.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
          color={255,128,0}));
      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}}, color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
    connect(outerWall_East.WindSpeedPort, outerWall_South.WindSpeedPort)
      annotation (Line(points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,33.3333},{
            -76.35,33.3333},{-76.35,33.3333}}, color={0,0,127}));
    connect(WindSpeedPort, floor.WindSpeedPort) annotation (Line(points={{-112,28},
            {-108,28},{-108,20},{-40.8,20},{-40.8,-66.1003}},     color={0,0,
            127}));
    connect(SolarRadiationPort[5], floor.SolarRadiationPort) annotation (Line(
          points={{-110,68},{-102,68},{-102,58},{-43,58},{-43,-66.6004}}, color=
           {255,128,0}));
    connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,75.8},{-23.2,75.8}}, color={0,0,
            127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{43.6,-16.6667},{43.6,73.6}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_North.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{59.3,-16.6667},{59.3,33.3333}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{-26.125,-16.6667},{-26.125,
            -59.6},{8.4,-59.6}}, color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,-61.8},{-40.8,-61.8}}, color={0,
            0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_South.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{-61.3,-16.6667},{-61.3,33.3333}},
          color={0,0,127}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighOrderModel_Benchmark_Workshop;

  model HighOrderModel_Benchmark_Canteen
     parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=TypOW,
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      calcMethod=2,
      outside=true,
      withWindow=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=60,
      withDoor=false,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      windowarea=60,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      withWindow=true,
      windowarea=Win_Area,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      final withSunblind=false,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withWindow=false,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
  public
      AixLib.Utilities.Interfaces.RadPort
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
     AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
  equation
    connect(thermStar_Demux.portRad, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}}, color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-76.35,4},{-86,4},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
          color={0,0,127}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-62,4},{-54,4},{-54,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,-62},
            {-32,-41.8},{-30.7,-41.8}},                                                                                                 color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,-60},
            {28,-60},{28,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{60,4},{46,4},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,74},{26,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,76},{-32,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{
            -112,28}},
          color={0,0,127}));

      connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));

      connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
        annotation (Line(
          points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
          color={255,128,0}));
      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));
      connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
         Line(
          points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}},
          color={255,128,0}));
      connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
        annotation (Line(
          points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
            52}},
          color={255,128,0}));

      connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
         Line(
          points={{4,-69.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
          color={255,128,0}));
      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}}, color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
    connect(outerWall_East.WindSpeedPort, outerWall_South.WindSpeedPort)
      annotation (Line(points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,33.3333},{
            -76.35,33.3333},{-76.35,33.3333}}, color={0,0,127}));
    connect(WindSpeedPort, floor.WindSpeedPort) annotation (Line(points={{-112,28},
            {-108,28},{-108,20},{-40.8,20},{-40.8,-66.1003}},     color={0,0,
            127}));
    connect(SolarRadiationPort[5], floor.SolarRadiationPort) annotation (Line(
          points={{-110,68},{-102,68},{-102,58},{-43,58},{-43,-66.6004}}, color=
           {255,128,0}));
    connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,75.8},{-23.2,75.8}}, color={0,0,
            127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{43.6,-16.6667},{43.6,73.6}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_North.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{59.3,-16.6667},{59.3,33.3333}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{-26.125,-16.6667},{-26.125,
            -59.6},{8.4,-59.6}}, color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,-61.8},{-40.8,-61.8}}, color={0,
            0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_South.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{-61.3,-16.6667},{-61.3,33.3333}},
          color={0,0,127}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighOrderModel_Benchmark_Canteen;

  model HighOrderModel_Benchmark_ConferenceRoom
     parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      calcMethod=2,
      outside=false,
      withWindow=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-78,-36},{-64,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=60,
      withDoor=false,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      windowarea=60,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      withWindow=true,
      windowarea=Win_Area,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      final withSunblind=true,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withWindow=false,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
  public
      AixLib.Utilities.Interfaces.RadPort
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
     AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{74,58},{94,78}})));
  equation
    connect(thermStar_Demux.portRad, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}}, color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-78.35,4},{-86,4},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-64,4},
            {-54,4},{-54,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,-62},
            {-32,-41.8},{-30.7,-41.8}},                                                                                                 color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,-60},
            {28,-60},{28,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{60,4},{46,4},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,74},{26,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,76},
            {-32,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                  color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));

      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));
      connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
        annotation (Line(
          points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
            52}},
          color={255,128,0}));

      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}}, color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
    connect(WindSpeedPort, floor.WindSpeedPort) annotation (Line(points={{-112,28},
            {-108,28},{-108,20},{-40.8,20},{-40.8,-66.1003}},     color={0,0,
            127}));
    connect(SolarRadiationPort[5], floor.SolarRadiationPort) annotation (Line(
          points={{-110,68},{-102,68},{-102,58},{-43,58},{-43,-66.6004}}, color=
           {255,128,0}));
    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{-62.25,-16.6667},{-26.125,-16.6667},{-26.125,
            -59.6},{8.4,-59.6}}, color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (
        Line(points={{-62.25,-16.6667},{-62.25,-61.8},{-40.8,-61.8}}, color={0,
            0,127}));
    connect(outerWall_North.thermStarComb_inside, outerWall_East.thermStarComb_inside)
      annotation (Line(points={{60,4},{46,4},{46,-60},{-20,-60},{26,-60},{26,
            -60}}, color={191,0,0}));
    connect(floor.solarRadWin, outerWall_North.solarRadWinTrans) annotation (
        Line(points={{-40.8,-61.8},{8,-61.8},{8,-62},{58,-62},{58,-40},{58.25,
            -40},{58.25,-16.6667}}, color={0,0,127}));
    connect(WindSpeedPort, ceiling.WindSpeedPort) annotation (Line(points={{
            -112,28},{-23.2,28},{-23.2,80.1}}, color={0,0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{8.4,-16.6667},{8.4,-59.6}},
          color={0,0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_South.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{-63.3,-16.6667},{-63.3,33.3333}},
          color={0,0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{58.25,73.6},{43.6,73.6}},
          color={0,0,127}));
    connect(const.y, outerWall_North.solarRadWin) annotation (Line(points={{95,
            68},{98,68},{98,64},{59.3,64},{59.3,33.3333}}, color={0,0,127}));
    connect(WindSpeedPort, outerWall_North.WindSpeedPort) annotation (Line(
          points={{-112,28},{-42,28},{-42,24},{74.35,24},{74.35,33.3333}},
          color={0,0,127}));
    connect(outerWall_North.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(points={{58.25,-16.6667},{58.25,75.8},{-23.2,75.8}}, color={0,0,
            127}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighOrderModel_Benchmark_ConferenceRoom;

  model HighOrderModel_Benchmark_MultipersonOffice
     parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=TypOW,
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      calcMethod=2,
      outside=true,
      withWindow=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-34},{-62,46}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=60,
      withDoor=false,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      windowarea=60,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      withWindow=false,
      windowarea=60,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=false,
      WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
      final withSunblind=false,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withWindow=false,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
  public
      AixLib.Utilities.Interfaces.RadPort
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
     AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-24,34},{-4,54}})));
  equation
    connect(thermStar_Demux.portRad, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}}, color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-76.35,6},{-86,6},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-76.35,35.3333},{-86,35.3333},{-86,28},{-112,28}},
          color={0,0,127}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-62,6},
            {-54,6},{-54,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,-62},
            {-32,-41.8},{-30.7,-41.8}},                                                                                                 color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,-60},
            {28,-60},{28,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{60,4},{46,4},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,74},{26,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,76},{-32,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));

      connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
        annotation (Line(
          points={{-110,60},{-86,60},{-86,42.6667},{-78.1,42.6667}},
          color={255,128,0}));
      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));

      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}}, color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
    connect(WindSpeedPort, floor.WindSpeedPort) annotation (Line(points={{-112,28},
            {-108,28},{-108,20},{-40.8,20},{-40.8,-66.1003}},     color={0,0,
            127}));
    connect(SolarRadiationPort[5], floor.SolarRadiationPort) annotation (Line(
          points={{-110,68},{-102,68},{-102,58},{-43,58},{-43,-66.6004}}, color=
           {255,128,0}));
    connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(points={{-60.25,-14.6667},{-60.25,75.8},{-23.2,75.8}}, color={0,0,
            127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(points={{-60.25,-14.6667},{43.6,-14.6667},{43.6,73.6}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_North.solarRadWin)
      annotation (Line(points={{-60.25,-14.6667},{59.3,-14.6667},{59.3,33.3333}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{-60.25,-14.6667},{-26.125,-14.6667},{-26.125,
            -59.6},{8.4,-59.6}}, color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (
        Line(points={{-60.25,-14.6667},{-60.25,-61.8},{-40.8,-61.8}}, color={0,
            0,127}));
    connect(const.y, outerWall_South.solarRadWin) annotation (Line(points={{-3,
            44},{-12,44},{-12,38},{-61.3,38},{-61.3,35.3333}}, color={0,0,127}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighOrderModel_Benchmark_MultipersonOffice;

  model HighOrderModel_Benchmark_OpenplanOffice
     parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.SIunits.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=TypOW,
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      calcMethod=2,
      outside=true,
      withWindow=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=false,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=60,
      withDoor=false,
      T0=T0_IW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withWindow=true,
      WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
      windowarea=Win_Area,
      T0=T0_IW,
      outside=true,
      final withSunblind=false,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      withWindow=true,
      windowarea=Win_Area,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      final withSunblind=false,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      calcMethod=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withWindow=false,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1 - ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      calcMethod=2)
      annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
  public
      AixLib.Utilities.Interfaces.RadPort
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
     AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
  equation
    connect(thermStar_Demux.portRad, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}}, color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-76.35,4},{-86,4},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
          color={0,0,127}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-62,4},{-54,4},{-54,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,-62},
            {-32,-41.8},{-30.7,-41.8}},                                                                                                 color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,-60},
            {28,-60},{28,-56},{-30.7,-56},{-30.7,-41.8}},                                                                                                         color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{60,4},{46,4},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{26,74},{26,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-32,76},{-32,60},{46,60},{46,-56},{-30.7,-56},{-30.7,-41.8}}, color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{
            -112,28}},
          color={0,0,127}));

      connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
        annotation (Line(
          points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
          color={255,128,0}));
      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));
      connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
        annotation (Line(
          points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
            52}},
          color={255,128,0}));

      connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
         Line(
          points={{4,-69.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
          color={255,128,0}));
      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
    connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}}, color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
    connect(outerWall_East.WindSpeedPort, outerWall_South.WindSpeedPort)
      annotation (Line(points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,33.3333},{
            -76.35,33.3333},{-76.35,33.3333}}, color={0,0,127}));
    connect(WindSpeedPort, floor.WindSpeedPort) annotation (Line(points={{-112,28},
            {-108,28},{-108,20},{-40.8,20},{-40.8,-66.1003}},     color={0,0,
            127}));
    connect(SolarRadiationPort[5], floor.SolarRadiationPort) annotation (Line(
          points={{-110,68},{-102,68},{-102,58},{-43,58},{-43,-66.6004}}, color=
           {255,128,0}));
    connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,75.8},{-23.2,75.8}}, color={0,0,
            127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{43.6,-16.6667},{43.6,73.6}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_North.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{59.3,-16.6667},{59.3,33.3333}},
          color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(points={{-60.25,-16.6667},{-26.125,-16.6667},{-26.125,
            -59.6},{8.4,-59.6}}, color={0,0,127}));
    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (
        Line(points={{-60.25,-16.6667},{-60.25,-61.8},{-40.8,-61.8}}, color={0,
            0,127}));
    connect(outerWall_North.solarRadWinTrans, outerWall_South.solarRadWin)
      annotation (Line(points={{58.25,-16.6667},{-61.3,-16.6667},{-61.3,33.3333}},
          color={0,0,127}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighOrderModel_Benchmark_OpenplanOffice;

  model ConvRealtoRad

    AixLib.Utilities.Interfaces.SolarRad_out
                                      SolarRadiation
      annotation (Placement(transformation(extent={{90,2},{110,22}})));
    Modelica.Blocks.Interfaces.RealInput DiffRad
      annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
    Modelica.Blocks.Interfaces.RealInput DirRad
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealInput Dummy
      annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));

  equation

    SolarRadiation.I_diff = DiffRad;
    SolarRadiation.I_dir = DirRad;
    SolarRadiation.I_gr=Dummy;
    SolarRadiation.AOI = Dummy;
    SolarRadiation.I = DiffRad+DirRad;

  end ConvRealtoRad;

  package DataBase_ThermalZone
    record thermalZone_Benchmark_Workshop
      extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
        withAirCap=true,
        T_start=293.15,
        VAir=2700,
        AZone=900,
        hRad=5,
        lat=0.83864990429999,
        nOrientations=3,
        AWin={60,60,60},
        ATransparent={48,48,48},
        hConWin=2,
        RWin=0.0042735,
        gWin=0.6,
        UWin=1.3,
        ratioWinConRad=0.5,
        AExt={30,30,30},
        hConExt=25,
        nExt=4,
        RExt={0.0003268,0.00533,0.03175,0.00056},
        RExtRem=0.00000010,
        CExt={1620000,21600000,1112400,8100000},
        AInt=90,
        hConInt=25,
        nInt=2,
        RInt={0.0003268,0.00194},
        CInt={1620000,7875000},
        AFloor=900,
        hConFloor=25,
        nFloor=4,
        RFloor={0.0000476,0.00127,0.00012,0.00167},
        RFloorRem=0.00000001,
        CFloor={108000000,4449600,517500000,7560000},
        ARoof=900,
        hConRoof=25,
        nRoof=4,
        RRoof={0.00003,0.00008,0.00049,0.0000000001},
        RRoofRem=0.0000000001,
        CRoof={16200000,331200000,2224800,0.00000000000001},
        nOrientationsRoof=1,
        tiltRoof={0},
        aziRoof={0},
        wfRoof={1},
        aRoof=0.48,
        aExt=0.48,
        TSoil=283.15,
        hConWallOut=25.0,
        hRadWall=5,
        hConWinOut=25.0,
        hConRoofOut=25,
        hRadRoof=5,
        tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949},
        aziExtWalls={0,3.1415926535898,4.7123889803847},
        wfWall={0.33,0.33,0.33},
        wfWin={0.33,0.33,0.33},
        wfGro=0.01,
            specificPeople=1/14,
        activityDegree=1.2,
        fixedHeatFlowRatePersons=70,
        ratioConvectiveHeatPeople=0.5,
        internalGainsMoistureNoPeople=0.5,
        internalGainsMachinesSpecific=7.0,
        ratioConvectiveHeatMachines=0.6,
        lightingPowerSpecific=12.5,
        ratioConvectiveHeatLighting=0.6,
        useConstantACHrate=false,
        baseACH=0.2,
        maxUserACH=1,
        maxOverheatingACH={3.0,2.0},
        maxSummerACH={1.0,273.15 + 10,273.15 + 17},
        winterReduction={0.2,273.15,273.15 + 10},
        withAHU=false,
        minAHU=0,
        maxAHU=12,
        hHeat=167500,
        lHeat=0,
        KRHeat=1000,
        TNHeat=1,
        HeaterOn=false,
        hCool=0,
        lCool=-1,
        KRCool=1000,
        TNCool=1,
        CoolerOn=false,
        TThresholdHeater=273.15 + 15,
        TThresholdCooler=273.15 + 22,
        withIdealThresholds=false);
      annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",     info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"),        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end thermalZone_Benchmark_Workshop;

    record thermalZone_Benchmark_Canteen
       extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
        withAirCap=true,
        T_start=293.15,
        VAir=1800,
        AZone=600,
        hRad=5,
        lat=0.83864990429999,
        nOrientations=2,
        AWin={40,40},
        ATransparent={32,32},
        hConWin=2,
        RWin=0.0096154,
        gWin=0.6,
        UWin=1.3,
        ratioWinConRad=0.5,
        AExt={20,20},
        hConExt=25,
        nExt=4,
        RExt={0.0007353,0.012,0.0714286,0.00125},
        RExtRem=0.00000010,
        CExt={720000,9600000,494400,3600000},
        AInt=180,
        hConInt=25,
        nInt=2,
        RInt={0.0001634,0.0009722},
        CInt={3240000,15750000},
        AFloor=600,
        hConFloor=25,
        nFloor=4,
        RFloor={0.000071429,0.0019047,0.00018116,0.0025},
        RFloorRem=0.00000001,
        CFloor={72000000,2966400,345000000,5040000},
        ARoof=600,
        hConRoof=25,
        nRoof=4,
        RRoof={0.00005,0.000116,0.00074,0.000000000001},
        RRoofRem=0.0000000001,
        CRoof={10800000,220800000,1483200,0.0000000001},
        nOrientationsRoof=1,
        tiltRoof={0},
        aziRoof={0},
        wfRoof={1},
        aRoof=0.48,
        aExt=0.48,
        TSoil=283.15,
        hConWallOut=25.0,
        hRadWall=5,
        hConWinOut=25.0,
        hConRoofOut=25,
        hRadRoof=5,
        tiltExtWalls={1.5707963267949,1.5707963267949},
        aziExtWalls={0,3.1415926535898},
        wfWall={0.49,0.49},
        wfWin={0.49,0.49},
        wfGro=0.01,
        specificPeople=1/14,
        activityDegree=1.2,
        fixedHeatFlowRatePersons=70,
        ratioConvectiveHeatPeople=0.5,
        internalGainsMoistureNoPeople=0.5,
        internalGainsMachinesSpecific=7.0,
        ratioConvectiveHeatMachines=0.6,
        lightingPowerSpecific=12.5,
        ratioConvectiveHeatLighting=0.6,
        useConstantACHrate=false,
        baseACH=0.2,
        maxUserACH=1,
        maxOverheatingACH={3.0,2.0},
        maxSummerACH={1.0,273.15 + 10,273.15 + 17},
        winterReduction={0.2,273.15,273.15 + 10},
        withAHU=false,
        minAHU=0,
        maxAHU=12,
        hHeat=167500,
        lHeat=0,
        KRHeat=1000,
        TNHeat=1,
        HeaterOn=false,
        hCool=0,
        lCool=-1,
        KRCool=1000,
        TNCool=1,
        CoolerOn=false,
        TThresholdHeater=273.15 + 15,
        TThresholdCooler=273.15 + 22,
        withIdealThresholds=false);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));

    end thermalZone_Benchmark_Canteen;

    record thermalZone_Benchmark_ConferenceRoom
      extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
        withAirCap=true,
        T_start=293.15,
        VAir=150,
        AZone=50,
        hRad=5,
        lat=0.83864990429999,
        nOrientations=1,
        AWin={20},
        ATransparent={20},
        hConWin=2,
        RWin=0.038461,
        gWin=0.6,
        UWin=1.3,
        ratioWinConRad=0.5,
        AExt={30},
        hConExt=25,
        nExt=4,
        RExt={0.0029411,0.048,0.285714,0.005},
        RExtRem=0.00000010,
        CExt={180000,2400000,123600,900000},
        AInt=60,
        hConInt=25,
        nInt=2,
        RInt={0.0004902,0.0029167},
        CInt={1080000,5250000},
        AFloor=50,
        hConFloor=25,
        nFloor=4,
        RFloor={0.00085714,0.02285714,0.0021739,0.03},
        RFloorRem=0.00000001,
        CFloor={6000000,247200,28750000,420000},
        ARoof=50,
        hConRoof=25,
        nRoof=4,
        RRoof={0.00059,0.00139,0.00889,0.000000000001},
        RRoofRem=0.0000000001,
        CRoof={900000,18400000,123600,0.0000000001},
        nOrientationsRoof=1,
        tiltRoof={0},
        aziRoof={0},
        wfRoof={1},
        aRoof=0.48,
        aExt=0.48,
        TSoil=283.15,
        hConWallOut=25.0,
        hRadWall=5,
        hConWinOut=25.0,
        hConRoofOut=25,
        hRadRoof=5,
        tiltExtWalls={1.5707963267949},
        aziExtWalls={3.1415926535898},
        wfWall={0.99},
        wfWin={0.99},
        wfGro=0.01,
        specificPeople=1/14,
        activityDegree=1.2,
        fixedHeatFlowRatePersons=70,
        ratioConvectiveHeatPeople=0.5,
        internalGainsMoistureNoPeople=0.5,
        internalGainsMachinesSpecific=7.0,
        ratioConvectiveHeatMachines=0.6,
        lightingPowerSpecific=12.5,
        ratioConvectiveHeatLighting=0.6,
        useConstantACHrate=false,
        baseACH=0.2,
        maxUserACH=1,
        maxOverheatingACH={3.0,2.0},
        maxSummerACH={1.0,273.15 + 10,273.15 + 17},
        winterReduction={0.2,273.15,273.15 + 10},
        withAHU=false,
        minAHU=0,
        maxAHU=12,
        hHeat=167500,
        lHeat=0,
        KRHeat=1000,
        TNHeat=1,
        HeaterOn=false,
        hCool=0,
        lCool=-1,
        KRCool=1000,
        TNCool=1,
        CoolerOn=false,
        TThresholdHeater=273.15 + 15,
        TThresholdCooler=273.15 + 22,
        withIdealThresholds=false);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end thermalZone_Benchmark_ConferenceRoom;

    record thermalZone_Benchmark_MultipersonOffice
       extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
        withAirCap=true,
        T_start=293.15,
        VAir=300,
        AZone=100,
        hRad=5,
        lat=0.83864990429999,
        nOrientations=1,
        AWin={40},
        ATransparent={32},
        hConWin=2,
        RWin=0.02404,
        gWin=0.6,
        UWin=1.3,
        ratioWinConRad=0.5,
        AExt={60},
        hConExt=25,
        nExt=4,
        RExt={0.0014706,0.024,0.142857,0.0025},
        RExtRem=0.00000010,
        CExt={360000,4800000,247200,1800000},
        AInt=90,
        hConInt=25,
        nInt=2,
        RInt={0.0003268,0.001944},
        CInt={1620000,7875000},
        AFloor=100,
        hConFloor=25,
        nFloor=4,
        RFloor={0.000428571,0.011428571,0.001087,0.015},
        RFloorRem=0.00000001,
        CFloor={12000000,494400,57500000,840000},
        ARoof=100,
        hConRoof=25,
        nRoof=4,
        RRoof={0.00029,0.0007,0.0044,0.000000000001},
        RRoofRem=0.0000000001,
        CRoof={1800000,36800000,247200,0.0000000001},
        nOrientationsRoof=1,
        tiltRoof={0},
        aziRoof={0},
        wfRoof={1},
        aRoof=0.48,
        aExt=0.48,
        TSoil=283.15,
        hConWallOut=25.0,
        hRadWall=5,
        hConWinOut=25.0,
        hConRoofOut=25,
        hRadRoof=5,
        tiltExtWalls={1.5707963267949},
        aziExtWalls={0},
        wfWall={0.99},
        wfWin={0.99},
        wfGro=0.01,
        specificPeople=1/14,
        activityDegree=1.2,
        fixedHeatFlowRatePersons=70,
        ratioConvectiveHeatPeople=0.5,
        internalGainsMoistureNoPeople=0.5,
        internalGainsMachinesSpecific=7.0,
        ratioConvectiveHeatMachines=0.6,
        lightingPowerSpecific=12.5,
        ratioConvectiveHeatLighting=0.6,
        useConstantACHrate=false,
        baseACH=0.2,
        maxUserACH=1,
        maxOverheatingACH={3.0,2.0},
        maxSummerACH={1.0,273.15 + 10,273.15 + 17},
        winterReduction={0.2,273.15,273.15 + 10},
        withAHU=false,
        minAHU=0,
        maxAHU=12,
        hHeat=167500,
        lHeat=0,
        KRHeat=1000,
        TNHeat=1,
        HeaterOn=false,
        hCool=0,
        lCool=-1,
        KRCool=1000,
        TNCool=1,
        CoolerOn=false,
        TThresholdHeater=273.15 + 15,
        TThresholdCooler=273.15 + 22,
        withIdealThresholds=false);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end thermalZone_Benchmark_MultipersonOffice;

    record thermalZone_Benchmark_OpenplanOffice
       extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
        withAirCap=true,
        T_start=293.15,
        VAir=4050,
        AZone=1350,
        hRad=5,
        lat=0.83864990429999,
        nOrientations=3,
        AWin={80,60,60},
        ATransparent={72,48,48},
        hConWin=2,
        RWin=0.0038461,
        gWin=0.6,
        UWin=1.3,
        ratioWinConRad=0.5,
        AExt={40,30,30},
        hConExt=25,
        nExt=4,
        RExt={0.000294118,0.0048,0.0285714,0.0005},
        RExtRem=0.00000010,
        CExt={1800000,24000000,1236000,9000000},
        AInt=90,
        hConInt=25,
        nInt=2,
        RInt={0.0003268,0.001944},
        CInt={1620000,7875000},
        AFloor=1350,
        hConFloor=25,
        nFloor=4,
        RFloor={0.00003174,0.00084656,0.000080515,0.001111},
        RFloorRem=0.00000001,
        CFloor={162000000,6674400,776250000,11340000},
        ARoof=1350,
        hConRoof=25,
        nRoof=4,
        RRoof={0.00002,0.00005,0.00033,0.0000000001},
        RRoofRem=0.0000000001,
        CRoof={24300000,496800000,3337200,0.00000000000001},
        nOrientationsRoof=1,
        tiltRoof={0},
        aziRoof={0},
        wfRoof={1},
        aRoof=0.48,
        aExt=0.48,
        TSoil=283.15,
        hConWallOut=25.0,
        hRadWall=5,
        hConWinOut=25.0,
        hConRoofOut=25,
        hRadRoof=5,
        tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949},
        aziExtWalls={0,1.5707963267949,3.1415926535898},
        wfWall={0.33,0.33,0.33},
        wfWin={0.33,0.33,0.33},
        wfGro=0.01,
        specificPeople=1/14,
        activityDegree=1.2,
        fixedHeatFlowRatePersons=70,
        ratioConvectiveHeatPeople=0.5,
        internalGainsMoistureNoPeople=0.5,
        internalGainsMachinesSpecific=7.0,
        ratioConvectiveHeatMachines=0.6,
        lightingPowerSpecific=12.5,
        ratioConvectiveHeatLighting=0.6,
        useConstantACHrate=false,
        baseACH=0.2,
        maxUserACH=1,
        maxOverheatingACH={3.0,2.0},
        maxSummerACH={1.0,273.15 + 10,273.15 + 17},
        winterReduction={0.2,273.15,273.15 + 10},
        withAHU=false,
        minAHU=0,
        maxAHU=12,
        hHeat=167500,
        lHeat=0,
        KRHeat=1000,
        TNHeat=1,
        HeaterOn=false,
        hCool=0,
        lCool=-1,
        KRCool=1000,
        TNCool=1,
        CoolerOn=false,
        TThresholdHeater=273.15 + 15,
        TThresholdCooler=273.15 + 22,
        withIdealThresholds=false);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end thermalZone_Benchmark_OpenplanOffice;

  end DataBase_ThermalZone;
end BaseClasses;
