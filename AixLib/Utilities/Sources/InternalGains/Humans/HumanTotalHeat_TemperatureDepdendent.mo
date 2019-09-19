within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanTotalHeat_TemperatureDepdendent
  "Model for total heat and moisture output of humans depending on the room temperature"
  extends HumanSensibleHeat_TemperatureDependent(thermalCollector(m=2));

  BaseClasses.TemperatureDependentMoistureOutput_SIA2024
    temperatureDependentMoistuerOutput_SIA2024_1(activityDegree=activityDegree)
    annotation (Placement(transformation(extent={{-60,66},{-40,86}})));
  Modelica.Blocks.Interfaces.RealOutput MoistGain
    annotation (Placement(transformation(extent={{86,70},{106,90}})));
  Modelica.Blocks.Math.Gain toKgPerSecond(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{14,70},{34,90}})));
  Modelica.Blocks.Math.MultiProduct productMoistureOutput(nu=2)
    annotation (Placement(transformation(extent={{-28,70},{-8,90}})));
  Modelica.Blocks.Math.Product latentHeat
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  Modelica.Blocks.Sources.RealExpression specificLatentHeat(y=
        enthalpyOfEvaporation + cp_steam*(temperatureSensor.T - 273.15))
    annotation (Placement(transformation(extent={{-88,14},{-68,34}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeatLatent(T_ref=T0)
    annotation (Placement(transformation(extent={{18,40},{42,64}})));
  constant Modelica.SIunits.SpecificHeatCapacity cp_steam = AixLib.Utilities.Psychrometrics.Constants.cpSte
    "specific heat capacity of steam";
  constant Modelica.SIunits.SpecificEnthalpy enthalpyOfEvaporation=AixLib.Utilities.Psychrometrics.Constants.h_fg
    "enthalpy of evaporation";
equation
  connect(to_degC.y, temperatureDependentMoistuerOutput_SIA2024_1.Temperature)
    annotation (Line(points={{-71.5,51},{-71.5,52},{-68,52},{-68,76},{-61,76}},
        color={0,0,127}));
  connect(temperatureDependentMoistuerOutput_SIA2024_1.moistOutput,
    productMoistureOutput.u[1]) annotation (Line(points={{-39,76},{-36,76},{-36,
          83.5},{-28,83.5}}, color={0,0,127}));
  connect(nrPeople.y, productMoistureOutput.u[2]) annotation (Line(points={{-57.4,
          -20},{-54,-20},{-54,30},{-28,30},{-28,68},{-34,68},{-34,76.5},{-28,76.5}},
        color={0,0,127}));
  connect(productMoistureOutput.y, toKgPerSecond.u)
    annotation (Line(points={{-6.3,80},{12,80}}, color={0,0,127}));
  connect(toKgPerSecond.y, MoistGain)
    annotation (Line(points={{35,80},{96,80}}, color={0,0,127}));
  connect(ConvectiveHeatLatent.port, thermalCollector.port_a[2])
    annotation (Line(points={{42,52},{52,52},{52,50}}, color={191,0,0}));
  connect(latentHeat.y, ConvectiveHeatLatent.Q_flow)
    annotation (Line(points={{11,52},{18,52}}, color={0,0,127}));
  connect(toKgPerSecond.y, latentHeat.u1) annotation (Line(points={{35,80},{44,
          80},{44,64},{-18,64},{-18,58},{-12,58}}, color={0,0,127}));
  connect(specificLatentHeat.y, latentHeat.u2) annotation (Line(points={{-67,24},
          {-20,24},{-20,46},{-12,46}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model enhances the existing human model by moisture release and latent heat release. It is based on the SIA 2024 and uses the same temperature dependent heat output. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>It is possible to set an activity degree to consider different types of activity of the persons in the room. </p>
<p>The heat output depends on the air temperature in the room where the activity takes place. </p>
<p>A schedule of the activity is also required as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero.For this reason a limitiation for the surface has been intoduced: as a minimum the surface area of one human and as a maximum a value of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
<p>The latent heat release is assumed to be convective only.The moisture production is multiplied with the heat of evaporation (at 0 °C) and the specific heat capacity of steam multiplied with the temperature difference between the room temperature and 0 °C. In consequence the moisture output will not affect the room temperature.</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>[1]: SIA 2024: Space usage data for energy and building services engineering - 2015 </p>
</html>", revisions="<html>
 <ul>
 <li><i>July 18, 2019&nbsp;</i> by Martin Kremer:<br/>Revision of latent heat output due to influence on room temperature.</li>
 <li><i>July 10, 2019&nbsp;</i> by Martin Kremer:<br/>Revised due to changes on human model</li>
 <li><i>March, 2019&nbsp;</i> by Martin Kremer:<br/>First implementation on issue #695.</li>
 </ul>
</html>"));
end HumanTotalHeat_TemperatureDepdendent;
