within AixLib.BoundaryConditions.InternalGains.Humans;
model HumanTotalHeatTemperatureDependent
  "Model for total heat and moisture output of humans depending on the room temperature"
  extends HumanSensibleHeatTemperatureDependent;

  BaseClasses.TemperatureDependentMoistureOutputSIA2024
    temperatureDependentMoistuerOutputSIA2024_1(activityDegree=activityDegree)
    "Temperature dependent moisture output per person"
    annotation (Placement(transformation(extent={{-60,66},{-40,86}})));
  Modelica.Blocks.Interfaces.RealOutput QLat_flow(final quantity="Power", final unit="W")
    "latent heat of moisture gains"
    annotation (Placement(transformation(extent={{86,70},{106,90}})));
  Modelica.Blocks.Math.Gain toKgPerSecond(k=1/(3600*1000))
    "Converter from g/h to kg/s"
    annotation (Placement(transformation(extent={{14,70},{34,90}})));
  Modelica.Blocks.Math.MultiProduct productMoistureOutput(nu=2)
    "Product of moisture output per person and number of people"
    annotation (Placement(transformation(extent={{-28,70},{-8,90}})));
  Modelica.Blocks.Math.Product latentHeat
    "Converter from mass flow moisture to latent heat"
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  Modelica.Blocks.Sources.RealExpression specificLatentHeat(y=h_fg)
    "Latent heat per kg moisture"
    annotation (Placement(transformation(extent={{-88,14},{-68,34}})));
protected
  constant Modelica.Units.SI.SpecificHeatCapacity cp_steam=AixLib.Utilities.Psychrometrics.Constants.cpSte
    "Specific heat capacity of steam";
  constant Modelica.Units.SI.SpecificEnthalpy EnthalpyOfEvaporation=AixLib.Utilities.Psychrometrics.Constants.h_fg
    "Enthalpy of evaporation";
  constant Modelica.Units.SI.SpecificEnergy h_fg=
      Media.Air.enthalpyOfCondensingGas(273.15 + 37)
    "Latent heat of water vapor";
equation
  connect(to_degC.y, temperatureDependentMoistuerOutputSIA2024_1.T) annotation (
     Line(points={{-71.5,51},{-71.5,52},{-68,52},{-68,76},{-62,76}}, color={0,0,
          127}));
  connect(productMoistureOutput.y, toKgPerSecond.u)
    annotation (Line(points={{-6.3,80},{12,80}}, color={0,0,127}));
  connect(toKgPerSecond.y, latentHeat.u1) annotation (Line(points={{35,80},{44,
          80},{44,64},{-18,64},{-18,58},{-12,58}}, color={0,0,127}));
  connect(specificLatentHeat.y, latentHeat.u2) annotation (Line(points={{-67,24},
          {-20,24},{-20,46},{-12,46}}, color={0,0,127}));
  connect(latentHeat.y, QLat_flow) annotation (Line(points={{11,52},{46,52},{46,80},{96,80}},
                        color={0,0,127}));
  connect(temperatureDependentMoistuerOutputSIA2024_1.moistOutput, productMoistureOutput.u[1]) annotation (Line(points={{-39,76},{-34,76},{-34,83.5},{-28,83.5}}, color={0,0,127}));
  connect(gain.y, productMoistureOutput.u[2]) annotation (Line(points={{-47.4,0},{-32,0},{-32,76.5},{-28,76.5}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  This model enhances the existing human model by moisture release and
  latent heat release. It is based on the SIA 2024 and uses the same
  temperature dependent heat output.
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  It is possible to set an activity degree to consider different types
  of activity of the persons in the room.
</p>
<p>
  The heat output depends on the air temperature in the room where the
  activity takes place.
</p>
<p>
  A schedule of the activity is also required as constant presence of
  people in a room is not realistic. The schedule describes the
  presence of only one person, and can take values from 0 to 1.
</p>
<p>
  <b><span style=\"color: #008000\">Assumptions</span></b>
</p>
<p>
  The surface for radiation exchange is computed from the number of
  persons in the room, which leads to a surface area of zero, when no
  one is present. In particular cases this might lead to an error as
  depending of the rest of the system a division by this surface will
  be introduced in the system of equations -&gt; division by zero.For
  this reason a limitiation for the surface has been intoduced: as a
  minimum the surface area of one human and as a maximum a value of
  1e+23 m2 (only needed for a complete parametrization of the model).
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  [1]: SIA 2024: Space usage data for energy and building services
  engineering - 2015
</p>
<ul>
  <li>
    <i>Oktober 14, 2019&#160;</i> by Martin Kremer:<br/>
    Adapted to latest changes in IPBSA providing latent heat output at
    37 degree Celsius
  </li>
  <li>
    <i>July 18, 2019&#160;</i> by Martin Kremer:<br/>
    Revision of latent heat output due to influence on room
    temperature.
  </li>
  <li>
    <i>July 10, 2019&#160;</i> by Martin Kremer:<br/>
    Revised due to changes on human model
  </li>
  <li>
    <i>March, 2019&#160;</i> by Martin Kremer:<br/>
    First implementation on issue #695.
  </li>
</ul>
</html>"), Icon(graphics={Polygon(
          points={{40,-40},{44,-40},{44,-48},{52,-48},{52,-52},{44,-52},{44,-60},{40,-60},{40,-52},{32,-52},{32,-48},{40,-48},{40,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}));
end HumanTotalHeatTemperatureDependent;
