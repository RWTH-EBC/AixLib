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
    parCol = AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector"
     annotation(Dialog(group = "Efficienc"), choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput TAir(
    quantity="ThermodynamicTemperature",
    unit="K") "Outdoor air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput irr(
    quantity="Irradiance",
    unit="W/m2") "Solar irradiation on a horizontal plane in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin={0,100})));
  Modelica.Blocks.Math.Gain conRelHeaFlowToAbsHeaFlow(final k=A)
    annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
  Modelica.Blocks.Math.Add calcMeaT(k1=0.5, k2=0.5) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-51,3})));

        Modelica.Blocks.Interfaces.RealOutput PEle(final quantity="Power",
      final unit="W") "DC output power of the PV array"
    annotation (Placement(transformation(extent={{100,26},{120,46}})));

  BaseClasses.SolarElectricalEfficiency eleEff(parCol=
        AixLib.DataBase.PhotovoltaicThermal.ElectricalGlazedPVTWithLowEmissionCoating())
    annotation (Placement(transformation(extent={{26,34},{58,66}})));
  Modelica.Blocks.Math.Gain conRelElePowerToAbsElePower(final k=A)
    annotation (Placement(transformation(extent={{70,44},{82,56}})));
  BaseClasses.PVT_SolarThermalEfficiency pvtEff(parCol=
        AixLib.DataBase.PhotovoltaicThermal.ThermalGlazedPVTWithLowEmissionCoating())
    annotation (Placement(transformation(extent={{-70,36},{-38,68}})));
equation
  connect(conRelHeaFlowToAbsHeaFlow.y, heater.Q_flow) annotation (Line(points={
          {-3.4,50},{12,50},{12,-30},{-60,-30},{-60,-40}}, color={0,0,127}));
  connect(senTCold.T, calcMeaT.u1) annotation (Line(points={{-70,-69},{-70,-66},
          {-78,-66},{-78,-10},{-54,-10},{-54,-3}}, color={0,0,127}));
  connect(senTHot.T, calcMeaT.u2) annotation (Line(points={{40,-69},{32,-69},{
          32,-10},{-48,-10},{-48,-3}}, color={0,0,127}));
  connect(calcMeaT.y, eleEff.TCol) annotation (Line(points={{-51,8.5},{-51,18},
          {34,18},{34,33.04}}, color={0,0,127}));
  connect(irr, eleEff.G) annotation (Line(points={{0,100},{0,78},{43.6,
          78},{43.6,66.96}}, color={0,0,127}));
  connect(eleEff.PEle, conRelElePowerToAbsElePower.u)
    annotation (Line(points={{59.28,50},{68.8,50}}, color={0,0,127}));
  connect(conRelElePowerToAbsElePower.y, PEle) annotation (Line(points={{82.6,
          50},{86,50},{86,36},{110,36}}, color={0,0,127}));
  connect(calcMeaT.y, pvtEff.TCol) annotation (Line(points={{-51,8.5},{-51,28},
          {-62,28},{-62,35.04}}, color={0,0,127}));
  connect(pvtEff.QFlow, conRelHeaFlowToAbsHeaFlow.u) annotation (Line(points={
          {-36.72,52},{-26,52},{-26,50},{-17.2,50}}, color={0,0,127}));
  connect(TAir, pvtEff.TAir) annotation (Line(points={{-60,100},{-62,100},{-62,
          68.96}}, color={0,0,127}));
  connect(irr, pvtEff.G) annotation (Line(points={{0,100},{0,70},{-52.4,
          70},{-52.4,68.96}}, color={0,0,127}));
  connect(TAir, eleEff.TAir) annotation (Line(points={{-60,100},{-60,76},{34,76},
          {34,66.96}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<h4>Overview</h4>
<p>Simplified model of a photovoltaic thermal collector, which builds upon the solar thermal model. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit and an electrical power output.</p>
<h4>Concept</h4>
<p>The model maps solar collector efficiency based on the equation </p>
<p><img src=\"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"/> </p>
<p>and similar for the electrical efficiency a linear approximation is used. Values for the linear and quadratic coefficients for the thermal efficiency as well as the coefficients for the linear approximation are derived from the thesis &quot;<a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">Thermal management of PVT collectors: Development and modelling of highly efficient glazed, flat plate PVT collectors with low emissivity coatings and overheating protection</a>&quot; by Markus L&auml;mmle, p.43 Figure 3.12. The underlying data was validated with the following assumptions: </p>
<ul>
<li>solar irradiation G=1000 W/m^2</li>
<li>windspeed Uwind=3m/s</li>
<li>ambient temperature Ta= 25&deg;C</li>
</ul>
<h4>Known Limitations</h4>
<ul>
<li>Connected directly with Sources.TempAndRad, this model only represents a horizontal collector. There is no calculation for radiation on tilted surfaces. </li>
<li>With the standard BaseParameters, this model uses water as working fluid </li>
</ul>
<h4>Example Results</h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector\">AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector</a> </p>
<h5>Parameters </h5>
<p>This model is an extension of <a href=\"modelica://AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>. Therefore the parameters can be found in the base model. </p>
<p><br>September 2023, Philipp Schmitz, Fabian W&uuml;llhorst </p>
<ul>
<li>implemented </li>
</ul>
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
