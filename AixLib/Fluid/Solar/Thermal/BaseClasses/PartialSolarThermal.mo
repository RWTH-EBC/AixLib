within AixLib.Fluid.Solar.Thermal.BaseClasses;
partial model PartialSolarThermal "Partial model of a solar thermal device"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    vol(final V=volPip),
    a=pressureDropCoeff,
    dp_start=pressureDropCoeff*(m_flow_start /
      Medium.density(Medium.setState_pTX(
                       p_start,
                       T_start,
                       Medium.reference_X)))^2);

  parameter Modelica.Units.SI.Area A=2 "Area of solar thermal collector"
    annotation (Dialog(group="Construction measures"));
  parameter Modelica.Units.SI.Volume volPip "Water volume of piping"
    annotation (Dialog(group="Construction measures"));
  parameter Real pressureDropCoeff(unit="(Pa.s2)/m6") = 2500/(A*2.5e-5)^2
    "Pressure drop coefficient, delta_p[Pa] = PD * Q_flow[m^3/s]^2";
  Modelica.Blocks.Interfaces.RealInput TAir(quantity="ThermodynamicTemperature",
      unit="K") "Outdoor air temperature in K" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput Irr(quantity="Irradiance", unit="W/m2")
    "Solar irradiation on a horizontal plane in W/m2" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  AixLib.Fluid.Solar.Thermal.BaseClasses.ThermalEfficiency solTheEff
    "Specific heat output of solar thermal"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.Gain conRelHeaFlowToAbsHeaFlow(final k=A)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Math.Add calcMeaT(final k1=0.5, final k2=0.5) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,10})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W") "Heat added to medium"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));

equation
  connect(TAir, solTheEff.TAir) annotation (Line(points={{-60,100},{-60,68},{-56,68},
          {-56,62},{-55,62}},     color={0,0,127}));
  connect(solTheEff.G, Irr) annotation (Line(points={{-49,62},{-49,68},{0,68},{0,100}},
                 color={0,0,127}));
  connect(conRelHeaFlowToAbsHeaFlow.y, heater.Q_flow) annotation (Line(points={{1,
          50},{12,50},{12,-30},{-60,-30},{-60,-40}}, color={0,0,127}));
  connect(senTCold.T, calcMeaT.u1) annotation (Line(points={{-70,-69},{-70,-66},{-78,
          -66},{-78,-10},{-56,-10},{-56,-2}}, color={0,0,127}));
  connect(senTHot.T, calcMeaT.u2) annotation (Line(points={{40,-69},{32,-69},{32,-10},
          {-44,-10},{-44,-2}}, color={0,0,127}));
  connect(calcMeaT.y, solTheEff.TCol) annotation (Line(points={{-50,21},{-50,28},{
          -55,28},{-55,38}},   color={0,0,127}));
  connect(solTheEff.q_flow, conRelHeaFlowToAbsHeaFlow.u)
    annotation (Line(points={{-39,50},{-22,50}},   color={0,0,127}));
  connect(conRelHeaFlowToAbsHeaFlow.y, Q_flow)
    annotation (Line(points={{1,50},{12,50},{12,70},{110,70}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>Partial model of a solar thermal collector.</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Fabian Wuellhorst:<br/>
    Created based on existing solar thermal model. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
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
end PartialSolarThermal;
