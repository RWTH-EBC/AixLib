within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneMoistCO2AirExchange
  "Thermal zone model considering moisture and co2 balance with ventilation, infiltration and internal gains"
  extends ThermalZoneMoistAir(SumQLat_flow(nu=3), ROM(final use_C_flow=use_C_flow));

  // CO2 parameters
  parameter Modelica.SIunits.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)"
    annotation (Dialog(tab="CO2", enable=use_CO2_balance));
  parameter Modelica.SIunits.Area areaBod=1.8
    "Body surface area source SIA 2024:2015"
    annotation (Dialog(tab="CO2", enable=use_CO2_balance));
  parameter Modelica.SIunits.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]"
    annotation (Dialog(tab="CO2", enable=use_CO2_balance));

  Controls.VentilationController.VentilationController ventCont(
    final useConstantOutput=zoneParam.useConstantACHrate,
    final baseACH=zoneParam.baseACH,
    final maxUserACH=zoneParam.maxUserACH,
    final maxOverheatingACH=zoneParam.maxOverheatingACH,
    final maxSummerACH=zoneParam.maxSummerACH,
    final winterReduction=zoneParam.winterReduction,
    final Tmean_start=zoneParam.T_start) if ATot > 0 or zoneParam.VAir > 0
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-70,-72},{-50,-52}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if
    ATot > 0 or zoneParam.VAir > 0
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-66,-28},{-46,-8}})));
  HighOrder.Components.MoistAir.VarMoistAirExchange airExc(final V=zoneParam.VAir) if
    ATot > 0 or zoneParam.VAir > 0 "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-22,-26},{-6,-10}})));

  Modelica.Blocks.Interfaces.RealInput ventTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration temperature"
    annotation (Placement(
        transformation(extent={{-120,-60},{-80,-20}}), iconTransformation(
          extent={{-126,-52},{-100,-26}})));
  Modelica.Blocks.Interfaces.RealInput ventRate(final quantity="VolumeFlowRate",
      final unit="1/h") if
                         ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration rate"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-70,-84})));
  Modelica.Blocks.Interfaces.RealInput ventHum(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0) if ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration humidity" annotation (Placement(
        transformation(extent={{-120,-90},{-80,-50}}), iconTransformation(
          extent={{-126,-80},{-100,-54}})));
  BoundaryConditions.InternalGains.CO2.CO2Balance cO2Balance(
    areaZon=zoneParam.AZone,
    actDeg=zoneParam.activityDegree,
    VZon=zoneParam.VAir,
    final XCO2_amb=XCO2_amb,
    final areaBod=areaBod,
    final metOnePerSit=metOnePerSit,
    spePeo=zoneParam.specificPeople) if
                                  (ATot > 0 or zoneParam.VAir > 0) and
    use_C_flow
    annotation (Placement(transformation(extent={{32,-56},{46,-42}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con if (ATot > 0 or zoneParam.VAir
     > 0) and use_C_flow "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,-66},{120,-46}})));

  Modelica.Blocks.Sources.RealExpression XCO2(y=ROM.volMoiAir.C[1]) if (ATot >
    0 or zoneParam.VAir > 0) and use_C_flow
    "Mass fraction of co2 in ROM in kg_CO2/ kg_TotalAir"
    annotation (Placement(transformation(extent={{4,-60},{16,-46}})));
protected
  Modelica.Blocks.Math.Add addInfVen if ATot > 0 or zoneParam.VAir > 0
    "Combines infiltration and ventilation"
    annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-34,-38})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemVen if
    ATot > 0 or zoneParam.VAir > 0
    "Prescribed temperature for ventilation"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-32,-18})));

equation
  connect(ventCont.y, addInfVen.u1) annotation (Line(
      points={{-51,-62},{-37.6,-62},{-37.6,-45.2}},
      color={0,0,127},
      smooth=Smooth.None));
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
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{87,62},{90,62},{90,
          -6},{52,-6},{52,-56},{-70,-56}},                        color={0,0,
          127}));
  connect(preTemVen.port, airExc.port_a)
    annotation (Line(points={{-26,-18},{-26,-18},{-22,-18}}, color={191,0,0}));
  connect(mixedTemp.mixedTemperatureOut, preTemVen.T)
    annotation (Line(points={{-46,-18},{-39.2,-18}}, color={0,0,127}));
  connect(addInfVen.y, airExc.ventRate) annotation (Line(points={{-34,-31.4},{-34,
          -31.4},{-34,-28},{-24,-28},{-24,-23.12},{-21.2,-23.12}}, color={0,0,
          127}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-18},{
          44,-18},{44,-2},{92,-2},{92,50},{86,50}},
                                               color={191,0,0}));
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
  connect(ventHum, airExc.HumIn) annotation (Line(points={{-100,-70},{-80,-70},
          {-80,-38},{-46,-38},{-46,-28},{-24,-28},{-24,-22},{-21.2,-22}}, color=
         {0,0,127}));
  connect(airExc.QLat_flow,SumQLat_flow.u[3])  annotation (Line(points={{-5.68,
          -22.96},{4,-22.96},{4,-22},{16,-22}}, color={0,0,127}));
  connect(humVolAirROM.y, airExc.HumOut) annotation (Line(points={{10.5,-14},{
          0.75,-14},{0.75,-13.84},{-6.8,-13.84}}, color={0,0,127}));
  connect(addInfVen.y, cO2Balance.airExc) annotation (Line(points={{-34,-31.4},{
          -24,-31.4},{-24,-48},{2,-48},{2,-46.9},{32,-46.9}}, color={0,0,127}));
  connect(cO2Balance.uRel, intGains[1]) annotation (Line(points={{32,-43.4},{26,
          -43.4},{26,-60},{50,-60},{50,-113.333},{80,-113.333}}, color={0,0,127}));
  connect(cO2Balance.TAir, TAir) annotation (Line(points={{39,-42},{70,-42},{70,
          56},{110,56}}, color={0,0,127}));
  connect(cO2Balance.CO2Con, CO2Con) annotation (Line(points={{46.7,-53.2},{56,-53.2},
          {56,-56},{110,-56}}, color={0,0,127}));
  connect(cO2Balance.XCO2, XCO2.y) annotation (Line(points={{32,-50.4},{32,-53},
          {16.6,-53}}, color={0,0,127}));
  connect(ROM.C_flow[1], cO2Balance.mCO2_flow) annotation (Line(points={{37,56},
          {34,56},{34,-6},{50,-6},{50,-44.8},{46.7,-44.8}}, color={0,0,127}));
  annotation(Documentation(info="<html><p>
  This model enhances the existing thermal zone model considering
  moisture balance in the zone. Moisture is considered in internal
  gains.
</p>
<p>
  Comprehensive ready-to-use model for thermal zones, combining
  caclulation core, handling of solar radiation, internal gains and in
  addition to <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone</a>
  models for infiltration and natural ventilation. Core model is a
  <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>
  model. Conditional removements of the core model are passed-through
  and related models on thermal zone level are as well conditional. All
  models for solar radiation are part of Annex60 library. Internal
  gains are part of AixLib.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  <b>Important!</b>: This model has to be combined with a zoneRecord
  that sets the parameter <i>internalGainsMode</i> to 3. Otherwise no
  moisture gain from persons will be considered.
</p>
<p>
  All parameters are collected in one <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  record. Further parameters for medium, initialization and dynamics
  originate from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
  A typical use case is a single thermal zone including infiltration
  and vnetilation connected via heat ports and fluid ports to a heating
  system. The thermal zone model serves as boundary condition for the
  heating system and calculates the room's reaction to external and
  internal heat sources. The model is used as thermal zone core model
  in <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a>
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>German Association of Engineers: Guideline VDI 6007-1, March
  2012: Calculation of transient thermal response of rooms and
  buildings - Modelling of rooms.
  </li>
  <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D.
  (2014): Low order thermal network models for dynamic simulations of
  buildings on city district scale. In: Building and Environment 73, p.
  223–231. DOI: <a href=
  \"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.
  </li>
</ul>
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistCO2AirExchange\">
  AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistCO2AirExchange</a>.
</p>
<ul>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    Add co2 balance
  </li>
  <li>January 09, 2020, by David Jansen:<br/>
    Integration of ideal heater and cooler into the thermal zone.
  </li>
  <li>July 10, 2019, by Martin Kremer:<br/>
    Adapting to new internalGains models. See <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/690\">AixLib, issue
    #690</a>.
  </li>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
  Rectangle(
    extent={{-79,-8},{-4,-81}},
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
")}));
end ThermalZoneMoistCO2AirExchange;
