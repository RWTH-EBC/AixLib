within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneEquipped
  "Thermal zone model with ventilation, infiltration and internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone(
      sunblindEquippedWall(n=zoneParam.nOrientations));

  Controls.VentilationController.VentilationController ventCont(
    final useConstantOutput=zoneParam.useConstantACHrate,
    final baseACH=zoneParam.baseACH,
    final maxUserACH=zoneParam.maxUserACH,
    final maxOverheatingACH=zoneParam.maxOverheatingACH,
    final maxSummerACH=zoneParam.maxSummerACH,
    final winterReduction=zoneParam.winterReduction,
    final Tmean_start=zoneParam.T_start) if ATot > 0 or zoneParam.VAir > 0
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-88,-78},{-68,-58}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if
    ATot > 0 or zoneParam.VAir > 0
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-84,-34},{-64,-14}})));
  HighOrder.Components.DryAir.VarAirExchange airExc(final V=zoneParam.VAir) if
    ATot > 0 or zoneParam.VAir > 0 "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-40,-32},{-24,-16}})));

  redeclare Utilities.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    humanSenHea(
    final ActivityType=3,
    final T0=zoneParam.T_start,
    final NrPeople=zoneParam.nrPeople,
    final RatioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople) if ATot > 0
    "Internal gains from persons" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{64,-36},{84,-16}})));

  redeclare Utilities.Sources.InternalGains.Machines.Machines_DIN18599
    machinesSenHea(
    final ratioConv=zoneParam.ratioConvectiveHeatMachines,
    final T0=zoneParam.T_start,
    final ActivityType=2,
    final NrPeople=zoneParam.nrPeopleMachines) if ATot > 0
    "Internal gains from machines"
    annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
  redeclare Utilities.Sources.InternalGains.Lights.Lights_relative lights(
    final ratioConv=zoneParam.ratioConvectiveHeatLighting,
    final T0=zoneParam.T_start,
    final LightingPower=zoneParam.lightingPower,
    final RoomArea=zoneParam.AZone) if ATot > 0 "Internal gains from light"
    annotation (Placement(transformation(extent={{64,-76},{84,-57}})));

  Airflow.AirCurtain.AirCurtainSimplyfied airCurtainSimplyfied(
    VolumeFlowAirCurtain=zoneParam.V_flow_air_curtain,
    TemperatureAdditionAirCurtain=zoneParam.T_add_air_curtain,
    eta_air_curtain=zoneParam.eta_air_curtain,
    TemperatureThreshold=zoneParam.T_thershold_air_curtain,
    PowerAirCurtain=zoneParam.Power_air_curtain) if
    zoneParam.V_flow_air_curtain > 0
    annotation (Placement(transformation(extent={{-2,-50},{20,-28}})));
protected
  Modelica.Blocks.Math.Add addInfVen if ATot > 0 or zoneParam.VAir > 0
    "Combines infiltration and ventilation"
    annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-52,-44})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemVen if
    ATot > 0 or zoneParam.VAir > 0
    "Prescribed temperature for ventilation"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-50,-24})));

equation
  connect(ventCont.y, addInfVen.u1) annotation (Line(
      points={{-69,-68},{-55.6,-68},{-55.6,-51.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], ventCont.relOccupation) annotation (Line(points={{80,
          -133.333},{80,-84},{-88,-84},{-88,-74}},                       color=
          {0,0,127}));
  connect(ventRate, addInfVen.u2) annotation (Line(points={{-40,-120},{-40,-82},
          {-48.4,-82},{-48.4,-51.2}}, color={0,0,127}));
  connect(ventCont.y, mixedTemp.flowRate_flow2) annotation (Line(points={{-69,-68},
          {-67,-68},{-67,-36},{-88,-36},{-88,-31},{-83.6,-31}}, color={0,0,127}));
  connect(ventRate, mixedTemp.flowRate_flow1) annotation (Line(points={{-40,
          -120},{-92,-120},{-92,-21},{-83.6,-21}},
                                             color={0,0,127}));
  connect(ventTemp, mixedTemp.temperature_flow1) annotation (Line(points={{-120,
          -40},{-94,-40},{-94,-16.2},{-83.6,-16.2}}, color={0,0,127}));
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{99,62},{72,62},{
          72,-12},{34,-12},{34,-56},{-88,-56},{-88,-62}},         color={0,0,
          127}));
  connect(preTemVen.port, airExc.port_a)
    annotation (Line(points={{-44,-24},{-40,-24}},           color={191,0,0}));
  connect(mixedTemp.mixedTemperatureOut, preTemVen.T)
    annotation (Line(points={{-64,-24},{-57.2,-24}}, color={0,0,127}));
  connect(addInfVen.y, airExc.InPort1) annotation (Line(points={{-52,-37.4},{
          -52,-34},{-42,-34},{-42,-29.12},{-39.2,-29.12}},         color={0,0,
          127}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-24,-24},{
          26,-24},{26,-8},{74,-8},{74,50},{98,50}},
                                               color={191,0,0}));
  connect(weaBus.TDryBul, mixedTemp.temperature_flow2) annotation (Line(
      points={{-120,34},{-120,28},{-104,28},{-104,-26},{-83.6,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventCont.Tambient) annotation (Line(
      points={{-120,34},{-120,28},{-104,28},{-104,-26},{-96,-26},{-96,-68},{-88,
          -68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(airCurtainSimplyfied.port_b, ROM.intGainsConv) annotation (Line(
        points={{20,-40},{22,-40},{22,-24},{26,-24},{26,-8},{74,-8},{74,50},{98,
          50}}, color={191,0,0}));
  connect(weaBus.TDryBul, airCurtainSimplyfied.Tambient) annotation (Line(
      points={{-120,34},{-120,28},{-104,28},{-104,-10},{-12,-10},{-12,-46},{-3,-46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(ventRate, airCurtainSimplyfied.AHUSchedule) annotation (Line(points={
          {-40,-120},{-40,-90},{-8,-90},{-8,-32},{-2.8,-32}}, color={0,0,127}));
  annotation(Documentation(info="<html>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation, internal gains and in addition to <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone</a> models for infiltration and natural ventilation. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone including infiltration and vnetilation connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a></p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneEquipped\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneEquipped</a>. </p>
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
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}}), graphics={
  Rectangle(
    extent={{-97,-14},{-22,-87}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-46,-75},{-23,-86}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Ventilation
Infiltration
")}),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}})));
end ThermalZoneEquipped;
