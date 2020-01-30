within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneMoistAir "Thermal zone containing moisture balance"
  extends ThermalZone(
    ROM(final use_moisture_co2_balance=
                                   true));


  Modelica.Blocks.Math.MultiSum SumQLat_flow(nu=2) if ATot > 0 or
    zoneParam.VAir > 0
    annotation (Placement(transformation(extent={{24,-28},{32,-20}})));
  Utilities.Sources.InternalGains.Moisture.MoistureGains moistureGains(
     final T0=zoneParam.T_start,
     final roomArea=zoneParam.AZone,
     final specificMoistureProduction=zoneParam.internalGainsMoistureNoPeople) if
          ATot > 0
    "internal moisture gains by plants, etc."
    annotation (Dialog(enable=true,tab="Moisture"),Placement(transformation(extent={{0,-38},{6,-32}})));
  Modelica.Blocks.Sources.Constant noMoisturePerson(k=0) if internalGainsMode <> 3
    annotation (Placement(transformation(extent={{0,-28},{8,-20}})));
  Modelica.Blocks.Interfaces.RealOutput X_w if ATot > 0 or zoneParam.VAir > 0
    "Humidity output"
    annotation (Placement(transformation(extent={{100,64},{120,84}}),
        iconTransformation(extent={{100,6},{120,26}})));
  Utilities.Sources.InternalGains.Co2.HumanCO2Source CO2Source(activityDegree=
        zoneParam.activityDegree) if
          ATot > 0
    annotation (Placement(transformation(extent={{26,-42},{32,-36}})));
  Utilities.Sources.InternalGains.Co2.CO2Balance CO2Balance(rho(displayUnit=
          "kg/m3") = 1.25, V=ROM.volMoiAir.V) if
          ATot > 0
    annotation (Placement(transformation(extent={{38,-46},{50,-38}})));
  Modelica.Blocks.Math.MultiSum airExchange(nu=1) if ATot > 0
                   "Ventilation rate total"
    annotation (Placement(transformation(extent={{12,-52},{16,-48}})));



  Modelica.Blocks.Math.Gain nrPeople(k=zoneParam.specificPeople*zoneParam.AZone) if
          ATot > 0 "Number of people in Zone"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={7,-45})));
  Modelica.Blocks.Interfaces.RealOutput CO2 if ATot > 0 or zoneParam.VAir > 0
    "Indoor Air CO2 concentration in ppm"
    annotation (Placement(transformation(extent={{100,79},{120,99}}),
        iconTransformation(extent={{100,70},{120,90}})));
protected
  Modelica.Blocks.Sources.RealExpression humVolAirROM(y=ROM.volMoiAir.X_w) if
    ATot > 0 or zoneParam.VAir > 0
    annotation (Placement(transformation(extent={{0,-22},{10,-6}})));
  Modelica.Blocks.Sources.RealExpression XCO2(y=ROM.volMoiAir.C[1]) if
          ATot > 0 "CO2 massfraction in zone"
    annotation (Placement(transformation(extent={{24,-56},{34,-48}})));
  Modelica.Blocks.Sources.RealExpression co2PPM(y=ROM.volMoiAir.C[1]*(28.949/
        44.01)*1E6) if
          ATot > 0 "CO2 massfraction in zone"
    annotation (Placement(transformation(extent={{84,84},{92,96}})));
equation
  if internalGainsMode == 3 then
    connect(humanTotHeaDependent.QLat_flow,SumQLat_flow. u[1]) annotation (Line(points={{83.6,-18},{92,-18},{92,-4},{52,-4},{52,-34},{14,
            -34},{14,-22.6},{24,-22.6}},
        color={0,0,127}));
  else
    connect(noMoisturePerson.y,SumQLat_flow. u[1]) annotation (Line(points={{8.4,-24},{10,-24},{10,-22.6},{24,-22.6}},
                                                                  color={0,0,127}));
  end if;
  connect(moistureGains.QLat_flow,SumQLat_flow. u[2]) annotation (Line(points={{6.3,-35},{10,-35},{10,-25.4},{24,-25.4}},
                                                                       color={0,
          0,127}));
  connect(SumQLat_flow.y, ROM.QLat_flow) annotation (Line(points={{32.68,-24},{36,-24},{36,34},{37,34}},
                                    color={0,0,127}));
  connect(humVolAirROM.y, X_w) annotation (Line(points={{10.5,-14},{48,-14},{48,
          -4},{88,-4},{88,74},{110,74}}, color={0,0,127}));

  connect(nrPeople.y, CO2Source.nP) annotation (Line(points={{10.3,-45},{14,-45},{14,-44},{22,-44},{22,-40.2},{26,-40.2}},
                              color={0,0,127}));
  connect(intGains[1], nrPeople.u) annotation (Line(points={{80,-133.333},{80,-78},{54,-78},{54,-54},{2,-54},{2,-45},{3.4,-45}},
                                                        color={0,0,127}));
  connect(CO2Balance.CO2_flow, ROM.CO2_flow) annotation (Line(points={{50,-42},{50,-2},{84,-2},{84,27}},
                                             color={0,0,127}));
  connect(XCO2.y, CO2Balance.XCO2) annotation (Line(points={{34.5,-52},{36,-52},{36,-44},{38,-44},{38,-43.6}},
                                  color={0,0,127}));
  connect(airExchange.y, CO2Balance.airExchange)
    annotation (Line(points={{16.34,-50},{24,-50},{24,-42},{38,-42}},
                                                    color={0,0,127}));
  connect(CO2Source.CO2People_flow, CO2Balance.CO2People_flow) annotation (Line(
        points={{32,-39},{34,-39},{34,-40.4},{38,-40.4}}, color={0,0,127}));
  connect(co2PPM.y, CO2) annotation (Line(points={{92.4,90},{98,90},{98,89},{
          110,89}}, color={0,0,127}));
  connect(CO2Source.TRoom, ROM.TAir)
    annotation (Line(points={{26,-37.8},{26,-36},{44,-36},{44,-6},{90,-6},{90,62},{87,62}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li> January 09, 2020, by David Jansen:<br/>
  Integration of ideal heater and cooler into the thermal zone. 
  </li>
  <li>July 10, 2019, by Martin Kremer:<br/>
  Adapting to new internalGains models. See <a href=\"https://github.com/RWTH-EBC/AixLib/issues/690\">AixLib, issue #690</a>.
  </li>
  <li>
  April, 2019, by Martin Kremer:<br/>
  First implementation.
  </li>
 </ul>
</html>", info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model enhances the existing thermal zone model considering moisture balance in the zone. Moisture is considered in internal gains. </p>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation and internal gains. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a></p>
<p>Dependent on the paramter <code>internalGainsMode</code> different models for internal gains by humans will be used. For a correct moisture balance the paramter should be set to <code>3</code>.</p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p> There is no moisture exchange through the walls or windows. Only moisture exchange is realized by the internal gains, through the fluid ports and over the ventilation moisture. This leads to a steady increase of moisture in the room, when there is no ventilation.</p>
<p>The moisture balance was formulated considering the latent heat with the aim, that the temperature is not influenced by the moisture.For this reason every humidity source is assumed to be in gaseous state.</p>
<h4>Accuracy</h4>
<p>Due to usage of constant heat capacaty for steam and constant heat of evaporation, the temperature is slightly influenced. Comparing the ThermalZone with dry air to the ThermalZone with moist air, the maximum difference between the simulated air temperature in the zone is 0.07 K for weather data from San Francisco and using the zoneParam for office buildings. See therefore: <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ComparisonThermalZoneMoistAndDryAir\">ExampleComparisonMoistAndDryAir</a></p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone</a>.</p>
</html>"), Diagram(graphics={
        Rectangle(
          extent={{0,-8},{52,-56}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{12,-8},{38,-12}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Moisture and CO2")}));
end ThermalZoneMoistAir;
