within AixLib.Fluid.Solar.Thermal;
model PhotovoltaicThermal "Simple Model of a photovoltaic thermal panel"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    vol(final V=volPip),
    a=pressureDropCoeff,
    dp_start=pressureDropCoeff*(m_flow_start *
      Medium.density(Medium.setState_pTX(
                       p_start,
                       T_start,
                       Medium.reference_X)))^2);

  parameter Modelica.Units.SI.Area A=2 "Area of solar thermal collector"
    annotation (Dialog(group="Construction measures"));
  parameter Modelica.Units.SI.Volume volPip "Water volume of piping"
    annotation (Dialog(group="Construction measures"));
  parameter Real pressureDropCoeff(unit="(Pa.s2)/m6")=2500/(A*2.5e-5)^2
    "Pressure drop coefficient, delta_p[Pa] = PD * Q_flow[m^3/s]^2";
  parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
    Collector = AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector"
     annotation(Dialog(group = "Efficienc"), choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput T_air(
    quantity="ThermodynamicTemperature",
    unit="K") "Outdoor air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput Irradiation(
    quantity="Irradiance",
    unit="W/m2") "Solar irradiation on a horizontal plane in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin={0,100})));
  Modelica.Blocks.Math.Gain convertRelHeatFlow2absHeatFlow(final k=A)
    annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
  Modelica.Blocks.Math.Add calcTempMean(k1=0.5, k2=0.5) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-51,3})));

        Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array" annotation (Placement(transformation(extent={{100,26},
            {120,46}})));

  BaseClasses.SolarElectricalEfficiency solarElectricalEfficiency
    annotation (Placement(transformation(extent={{26,34},{58,66}})));
  Modelica.Blocks.Math.Gain convertRelHeatFlow2absHeatFlow1(final k=A)
    annotation (Placement(transformation(extent={{70,44},{82,56}})));
  BaseClasses.PVT_SolarThermalEfficiency pVT_SolarThermalEfficiency
    annotation (Placement(transformation(extent={{-70,36},{-38,68}})));
equation
  connect(convertRelHeatFlow2absHeatFlow.y, heater.Q_flow) annotation (Line(
        points={{-3.4,50},{12,50},{12,-30},{-60,-30},{-60,-40}}, color={0,0,127}));
  connect(senTCold.T, calcTempMean.u1) annotation (Line(points={{-70,-69},{-70,-66},
          {-78,-66},{-78,-10},{-54,-10},{-54,-3}}, color={0,0,127}));
  connect(senTHot.T, calcTempMean.u2) annotation (Line(points={{40,-69},{32,-69},
          {32,-10},{-48,-10},{-48,-3}}, color={0,0,127}));
  connect(calcTempMean.y, solarElectricalEfficiency.T_col) annotation (Line(
        points={{-51,8.5},{-51,18},{34,18},{34,33.04}}, color={0,0,127}));
  connect(T_air, solarElectricalEfficiency.T_air) annotation (Line(points={{-60,
          100},{-60,76},{34,76},{34,66.96}}, color={0,0,127}));
  connect(Irradiation, solarElectricalEfficiency.G) annotation (Line(points={{0,
          100},{0,78},{43.6,78},{43.6,66.96}}, color={0,0,127}));
  connect(solarElectricalEfficiency.P_el, convertRelHeatFlow2absHeatFlow1.u)
    annotation (Line(points={{59.28,50},{68.8,50}}, color={0,0,127}));
  connect(convertRelHeatFlow2absHeatFlow1.y, DCOutputPower) annotation (Line(
        points={{82.6,50},{86,50},{86,36},{110,36}}, color={0,0,127}));
  connect(calcTempMean.y, pVT_SolarThermalEfficiency.T_col) annotation (Line(
        points={{-51,8.5},{-51,28},{-62,28},{-62,35.04}}, color={0,0,127}));
  connect(pVT_SolarThermalEfficiency.Q_flow, convertRelHeatFlow2absHeatFlow.u)
    annotation (Line(points={{-36.72,52},{-26,52},{-26,50},{-17.2,50}},
                                                      color={0,0,127}));
  connect(T_air, pVT_SolarThermalEfficiency.T_air) annotation (Line(points={{-60,100},
          {-62,100},{-62,68.96}},          color={0,0,127}));
  connect(Irradiation, pVT_SolarThermalEfficiency.G) annotation (Line(points={{0,100},
          {0,70},{-52.4,70},{-52.4,68.96}},        color={0,0,127}));
  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Simplified model of a photovoltaic thermal collector, which builds upon the solar thermal model. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit and an electrical power output.</p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The model maps solar collector efficiency based on the equation </p>
<p><img src=\"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"/> </p>
<p>and similar for the electrical efficiency a linear approximation is used. Values for the linear and quadratic coefficients for the thermal efficiency as well as the coefficients for the linear approximation are derived from the thesis &quot;<a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">Thermal management of PVT collectors : development and modelling of highly efficient glazed, flat plate PVT collectors with low emissivity coatings and overheating protection</a>&quot; by Markus L&auml;mmle, p.43 Figure 3.12. The underlying data was validated with the following assumptions: </p>
<ul>
<li>solar irradiation G=1000 W/m^2</li>
<li>windspeed Uwind=3m/s</li>
<li>ambient temperature Ta= 25&deg;C</li>
</ul>
<p><b><span style=\"color: #008000;\">Known Limitations</span></b> </p>
<ul>
<li>Connected directly with Sources.TempAndRad, this model only represents a horizontal collector. There is no calculation for radiation on tilted surfaces. </li>
<li>With the standard BaseParameters, this model uses water as working fluid </li>
</ul>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector\">AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector</a> </p>
<h5>Parameters </h5>
<p>Furbo1996 (<a href=\"http://orbit.dtu.dk/en/publications/optimum-solar-collector-fluid-flow-rates(34823dd4-5b1d-4e16-be04-17f9f6ae05e5).html\">Optimum solar collector fluid flow rates</a>) suggests a default volume flow rate of approx. 0.2 l/(min.m2) to 0.4 l/(min.m2). Taken from a panel manufacturer&apos;s manual (<a href=\"https://www.altestore.com/static/datafiles/Others/SunMaxx%20Technical%20Manual.pdf\">SunMaxx Technical Manual.pdf</a>) the standard volume flow rate seems to be around 1.5 l/(min.m2). This is 3 l/min for collectors of size 0.93 m2 up to 2.79 m2. </p>
<p>&quot;Volume flow rate suggestions according to Furbo1996 and SunMaxx&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot; border=&quot;1&quot; width=&quot;50&percnt;&quot;&gt; </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p>unit </p></td>
<td><p>SunMaxx </p></td>
<td><p>Furbo1996 </p></td>
</tr>
<tr>
<td><p>l/(min.m2) </p></td>
<td><p>1.5 </p></td>
<td><p>0.3 </p></td>
</tr>
<tr>
<td><p>m3/(h.m2) </p></td>
<td><p>0.091 </p></td>
<td><p>0.018 </p></td>
</tr>
<tr>
<td><p>m3/(s.m2) </p></td>
<td><p>2.5e-5 </p></td>
<td><p>5.0e-6 </p></td>
</tr>
<tr>
<td><p>gpm/m2 </p></td>
<td><p>0.40 </p></td>
<td><p>0.079 </p><p><br>Assuming a default size for a unit of 2 m2 we get pressure losses for a module as in the following table (vfr=0.79 gpm): </p><p>&quot;Pressure drop of two flat collector modules&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot; border=&quot;1&quot; width=&quot;50&percnt;&quot;&gt; </p><p>Collector </p><p>pressure drop in psi </p><p>pressure drop in Pa </p><p>Titan Power Plus SU2 </p><p>0.28 </p><p>1900 </p><p>SunMaxx-VHP 30 (40&nbsp;&percnt; Glycol) </p><p>0.43 </p><p>3000 </p><p><br>The pressureloss factor should therefore be around 2500 Pa / (2*2.5e-5 m3/s)^2 = 1e12. </p><ul>
<li><i>Febraury 7, 2018&nbsp;</i> by Peter Matthes:<br>Rename &quot;gain&quot; block into &quot;convertRelHeatFlow2absHeatFlow&quot; to make clearer what it does.<br>Remove redundant <span style=\"font-family: Courier New;\">connect(solarThermalEfficiency.Q_flow,&nbsp;convertRelHeatFlow2absHeatFlow.u)</span><br>Change default pressure drop coefficient from 1e6 to 2500 Pa / (2*2.5e-5 m3/s)^2 = 1e12 Pa.s2/m6.<br>Change default collector area to 2 m2.<br>Extend documentation with some default parameters from references.<br>Grid-align the RealInputs. </li><li><i>Febraury 1, 2018&nbsp;</i> by Philipp Mehrfeld:<br>Delete max block as it is now implemented in the efficiency model </li><li><i>October 25, 2017</i> by Philipp Mehrfeld:<br>Extend now from <a href=\"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator\">AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator</a>.<br>Use mean temperature.<br>Limiter moved in equation section of efficiency model. </li><li><i>December 15, 2016</i> by Moritz Lauster:<br>Moved </li><li><i>November 2014&nbsp;</i> by Marcus Fuchs:<br>Changed model to use Annex 60 base class </li><li><i>November 19, 2013&nbsp;</i> by Marcus Fuchs:<br>Implemented </li>
</ul></td>
</tr>
</table>
</html>"),  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent={{
              -84,80},{84,-80}},                                                                                                                            lineColor = {255, 128, 0},
            fillPattern =                                                                                                   FillPattern.Solid, fillColor = {255, 128, 0}), Rectangle(extent={{
              -76,70},{-70,-72}},                                                                                                                                                                                      lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -76,70},{-46,64}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -46,70},{-52,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -50,-72},{-28,-66}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -10,-72},{16,-66}},                                                                                                                                                          lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -4,70},{-10,-72}},                                                                                                                                                         lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -30,70},{-4,64}},                                                                                                                                                          lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -30,70},{-24,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              34,-72},{56,-66}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              38,70},{32,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              12,70},{38,64}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              12,70},{18,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              70,-72},{90,-66}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              76,70},{70,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              50,70},{76,64}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              50,70},{56,-72}},                                                                                                                                                           lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -90,-72},{-70,-66}},                                                                                                                                                         lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}));
end PhotovoltaicThermal;
