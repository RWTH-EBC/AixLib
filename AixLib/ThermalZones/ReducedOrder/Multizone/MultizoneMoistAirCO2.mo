within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneMoistAirCO2 "Multizone model with humidity and co2 balance"
  extends Multizone(redeclare model thermalZone =
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneMoistCO2AirExchange,
      zone(
      use_C_flow=use_C_flow,
      actDeg=actDeg,
      XCO2_amb=XCO2_amb,
      areaBod=areaBod,
      metOnePerSit=metOnePerSit));

  // co2 parameters
  parameter Real actDeg=1.8 "Activity degree (Met units)";
  parameter Modelica.SIunits.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)";
  parameter Modelica.SIunits.Area areaBod=1.8
    "Body surface area source SIA 2024:2015";
  parameter Modelica.SIunits.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]";
  parameter Boolean use_C_flow=false
    "Set to true to enable input connector for trace substance";

  Modelica.Blocks.Interfaces.RealInput ventHum[numZones] if ASurTot > 0 or
    VAir > 0 "Ventilation and infiltration humidity"
     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-100,36}),  iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,24})));
  Modelica.Blocks.Interfaces.RealOutput X_w[size(zone, 1)] if ASurTot > 0 or
    VAir > 0 "Humidity output"
    annotation (Placement(transformation(extent={{100,84},{120,104}}),
        iconTransformation(extent={{80,42},{100,62}})));

  Modelica.Blocks.Interfaces.RealOutput CO2Con[size(zone, 1)] if use_C_flow
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
equation
  connect(zone.ventHum, ventHum) annotation (Line(points={{35.27,55.765},{10,
          55.765},{10,56},{-18,56},{-18,36},{-100,36}},             color={0,0,
          127}));
  connect(zone.X_w, X_w) annotation (Line(points={{82.1,72.78},{94,72.78},{94,94},
          {110,94}}, color={0,0,127}));
  connect(zone.CO2Con, CO2Con) annotation (Line(points={{82.1,58.02},{82.1,40},
          {110,40}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  This model enhances the existing multi-zone model considering
  moisture balance in the zone. Moisture is considered in internal
  gains.
</p>
<p>
  This is a ready-to-use multizone model with a variable number of
  thermal zones. It defines connectors and a replaceable vector of
  <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  and subsequently in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  The model needs parameters describing general properties of the
  building (indoor air volume, net floor area, overall surface area)
  and a vector with length of number of zones containing <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records to define zone properties. The user can redeclare the thermal
  zone model choosing from <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  Further parameters for medium, initialization and dynamics originate
  from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
  A typical use case is a simulation of a multizone building for
  district simulations where the model is connected via heat ports and
  fluid ports to a heating system. The multizone model serves as
  boundary condition for the heating system and calculates the
  building's reaction to external and internal heat sources.
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
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end MultizoneMoistAirCO2;
