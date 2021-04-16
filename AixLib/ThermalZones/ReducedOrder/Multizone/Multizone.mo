within AixLib.ThermalZones.ReducedOrder.Multizone;
model Multizone
  "Multizone model"
  extends AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;



  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0)
    "Ventilation and infiltration temperature"
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final
    quantity="VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-100,-36},{-80,-16}})));



  Modelica.Blocks.Interfaces.RealInput ventHum[numZones] if (ASurTot > 0 or
    VAir > 0) and use_moisture_balance
             "Ventilation and infiltration humidity"
     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-100,40}),  iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,24})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con[size(zone, 1)] if use_C_flow
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput X_w[size(zone, 1)] if
    use_moisture_balance "Humidity output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  connect(zone.ventRate, ventRate) annotation (Line(points={{38.84,60.89},{38.84,
          60.89},{38.84,-20},{-100,-20}},
                                color={0,0,127}));
  connect(ventTemp, zone.ventTemp) annotation (Line(points={{-100,8},{-34,8},{-34,
          66.22},{38.84,66.22}},              color={0,0,127}));
  connect(zone.ventHum, ventHum) annotation (Line(points={{39.05,54.945},{-28.475,
          54.945},{-28.475,40},{-100,40}}, color={0,0,127}));
  connect(zone.CO2Con, CO2Con) annotation (Line(points={{82.1,51.05},{82.1,40},
          {82,40},{82,20},{110,20}},color={0,0,127}));
  connect(zone.X_w, X_w)
    annotation (Line(points={{82.1,55.15},{82.1,0},{110,0}},color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html><ul>
  <li>November 20, 2020, by Katharina Breuer:<br/>
    Combine thermal zone models
  </li>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    Add co2 balance
  </li>
  <li>April, 2019, by Martin Kremer:<br/>
    Add moisture balance
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>June 22, 2015, by Moritz Lauster:<br/>
    First implementation.
  </li>
</ul>
</html>",
        info="<html><p>
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
<p>
  Moisture and CO2 balances are conditional submodels which can be
  activated by setting use_moisture_balance or use_C_flow true.
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
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.Multizone\">AixLib.ThermalZones.ReducedOrder.Examples.Multizone</a>.
</p>
</html>"));
end Multizone;
