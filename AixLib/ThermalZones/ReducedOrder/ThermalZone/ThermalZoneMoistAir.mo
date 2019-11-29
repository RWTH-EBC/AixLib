within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneMoistAir "Thermal zone containing moisture balance"
  extends ThermalZone(
    ROM(final use_moisture_balance=true));
  Modelica.Blocks.Math.MultiSum SumQLat_flow(nu=2) if ATot > 0 or
    zoneParam.VAir > 0
    annotation (Placement(transformation(extent={{16,-36},{28,-24}})));
  Utilities.Sources.InternalGains.Moisture.MoistureGains moistureGains(
     final T0=zoneParam.T_start,
     final RoomArea=zoneParam.AZone,
     final specificMoistureProduction=zoneParam.internalGainsMoistureNoPeople) if
          ATot > 0
    "internal moisture gains by plants, etc."
    annotation (Dialog(enable=true,tab="Moisture"),Placement(transformation(extent={{32,-58},
            {38,-52}})));
  Modelica.Blocks.Sources.Constant noMoisturePerson(k=0) if internalGainsMode <> 3
    annotation (Placement(transformation(extent={{46,-34},{38,-26}})));
  Modelica.Blocks.Interfaces.RealOutput X_w if ATot > 0 or zoneParam.VAir > 0
    "Humidity output"
    annotation (Placement(transformation(extent={{100,64},{120,84}}),
        iconTransformation(extent={{100,6},{120,26}})));
  Utilities.Sources.InternalGains.Humans.CO2Source CO2Source if
          ATot > 0
    annotation (Placement(transformation(extent={{22,-64},{28,-58}})));
  Utilities.Sources.InternalGains.Humans.BaseClasses.CO2Balance cO2Balance(rho(
        displayUnit="kg/m3") = 1.25,
      V=ROM.volMoiAir.V) if
          ATot > 0
    annotation (Placement(transformation(extent={{32,-72},{36,-68}})));
  Modelica.Blocks.Math.MultiSum ventSum(nu=1) if
          ATot > 0 "Ventilation rate total"
    annotation (Placement(transformation(extent={{22,-72},{26,-68}})));



  Modelica.Blocks.Math.Gain nrPeople(k=zoneParam.specificPeople*zoneParam.AZone) if
          ATot > 0 "Number of people in Zone"
    annotation (Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=0,
        origin={8,-66})));
  Modelica.Blocks.Interfaces.RealOutput CO2 if ATot > 0 or zoneParam.VAir > 0
    "Indoor Air CO2 concentration in ppm"
    annotation (Placement(transformation(extent={{100,79},{120,99}}),
        iconTransformation(extent={{100,70},{120,90}})));
protected
  Modelica.Blocks.Sources.RealExpression humVolAirROM(y=ROM.volMoiAir.X_w) if
    ATot > 0 or zoneParam.VAir > 0
    annotation (Placement(transformation(extent={{20,-22},{30,-6}})));
  Modelica.Blocks.Sources.RealExpression TRoom(y=TAir) if
          ATot > 0 "Zone Air temperature"
    annotation (Placement(transformation(extent={{6,-78},{10,-70}})));
  Modelica.Blocks.Sources.RealExpression C(y=ROM.volMoiAir.C[1]) if
          ATot > 0 "CO2 concentration in zone"
    annotation (Placement(transformation(extent={{22,-84},{26,-76}})));
  Modelica.Blocks.Sources.RealExpression met(y=zoneParam.activityDegree) if
          ATot > 0 "Metabolic rate of people in zone"
    annotation (Placement(transformation(extent={{6,-84},{10,-76}})));
equation
  if internalGainsMode == 3 then
    connect(humanTotHeaDependent.QLat_flow,SumQLat_flow. u[1]) annotation (Line(points={{83.6,
            -18},{88,-18},{88,-6},{48,-6},{48,-40},{10,-40},{10,-27.9},{16,-27.9}},
        color={0,0,127}));
  else
    connect(noMoisturePerson.y,SumQLat_flow. u[1]);
  end if;
  connect(moistureGains.QLat_flow,SumQLat_flow. u[2]) annotation (Line(points={{38.3,
          -55},{44,-55},{44,-40},{10,-40},{10,-32.1},{16,-32.1}},      color={0,
          0,127}));
  connect(SumQLat_flow.y, ROM.QLat_flow) annotation (Line(points={{29.02,-30},{
          34,-30},{34,34},{37,34}}, color={0,0,127}));
  connect(humVolAirROM.y, X_w) annotation (Line(points={{30.5,-14},{58,-14},{58,
          -4},{98,-4},{98,74},{110,74}}, color={0,0,127}));
  connect(met.y, CO2Source.met) annotation (Line(points={{10.2,-80},{18,-80},{18,
          -62.2},{22,-62.2}}, color={0,0,127}));
  connect(nrPeople.y, CO2Source.nP) annotation (Line(points={{10.2,-66},{12,-66},
          {12,-59.8},{22,-59.8}},
                              color={0,0,127}));
  connect(TRoom.y, CO2Source.TRoom) annotation (Line(points={{10.2,-74},{14,-74},
          {14,-61},{22,-61}},     color={0,0,127}));
  connect(intGains[1], nrPeople.u) annotation (Line(points={{80,-113.333},{80,
          -78},{30,-78},{30,-84},{2,-84},{2,-66},{5.6,-66}},
                                                        color={0,0,127}));
  connect(CO2Source.CO2_flowHuman, cO2Balance.massFlowTracerPeople) annotation (
     Line(points={{28,-61},{30,-61},{30,-69.2},{32,-69.2}}, color={0,0,127}));
  connect(C.y, cO2Balance.C) annotation (Line(points={{26.2,-80},{28,-80},{28,-70.8},
          {32,-70.8}}, color={0,0,127}));
  connect(ventSum.y, cO2Balance.ventSum)
    annotation (Line(points={{26.34,-70},{32,-70}}, color={0,0,127}));
  connect(cO2Balance.CO2_flow, ROM.CO2_flow) annotation (Line(points={{36,-70},
          {50,-70},{50,-2},{84,-2},{84,27}}, color={0,0,127}));
  connect(ROM.CO2, CO2) annotation (Line(points={{87,46},{90,46},{90,89},{110,
          89}},
        color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>July, 2019, by Martin Kremer:<br/>Adapting to new internalGains models. See <a href=\"https://github.com/RWTH-EBC/AixLib/issues/690\">AixLib, issue #690</a>.</li>
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
</html>"));
end ThermalZoneMoistAir;
