within AixLib.Fluid.Solar.Thermal;
model SolarThermal "Model of a solar thermal panel"
  import AixLib;
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(vol(V=vol));
  parameter Modelica.SIunits.Area A "Area of solar thermal collector"
    annotation(Dialog(group = "Construction measures"));
  parameter Modelica.SIunits.Volume volume "Water volume of piping"
    annotation(Dialog(group = "Construction measures"));
  parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
    Collector = AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector"
     annotation(Dialog(group = "Efficienc"), choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput T_air "Outdoor air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 108})));
  Modelica.Blocks.Interfaces.RealInput Irradiation
    "Solar irradiation on a horizontal plane in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {10, 108})));
  AixLib.Fluid.Solar.Thermal.BaseClasses.SolarThermalEfficiency
    solarThermalEfficiency(Collector=Collector)
    annotation (Placement(transformation(extent={{-76,48},{-56,68}})));
  Modelica.Blocks.Math.Gain gain(k = A) annotation(Placement(transformation(extent = {{-16, 44}, {-4, 56}})));
  Modelica.Blocks.Math.Add calcTempMean(k1=0.5, k2=0.5) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-51,3})));
equation
  connect(T_air, solarThermalEfficiency.T_air) annotation(Line(points = {{-60, 108}, {-60, 78}, {-71, 78}, {-71, 68.6}}, color = {0, 0, 127}));
  connect(solarThermalEfficiency.G, Irradiation) annotation(Line(points = {{-65, 68.6}, {-65, 74}, {10, 74}, {10, 108}}, color = {0, 0, 127}));
  connect(gain.y, heater.Q_flow) annotation (Line(points={{-3.4,50},{12,50},{12,
          -30},{-60,-30},{-60,-40}}, color={0,0,127}));
  connect(senTCold.T, calcTempMean.u1) annotation (Line(points={{-70,-69},{-70,
          -66},{-78,-66},{-78,-10},{-54,-10},{-54,-3}}, color={0,0,127}));
  connect(senTHot.T, calcTempMean.u2) annotation (Line(points={{40,-69},{32,-69},
          {32,-10},{-48,-10},{-48,-3}}, color={0,0,127}));
  connect(calcTempMean.y, solarThermalEfficiency.T_col) annotation (Line(points
        ={{-51,8.5},{-51,18},{-71,18},{-71,47.4}}, color={0,0,127}));
  connect(solarThermalEfficiency.Q_flow, gain.u) annotation (Line(points={{
          -55.2,58},{-36,58},{-36,50},{-17.2,50}}, color={0,0,127}));
  annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>Model of a solar thermal collector. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model maps solar collector efficiency based on the equation</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"
    alt=\"eta = eta_o - c_1 * deltaT / G - c_2 * deltaT^2/ G\"/></p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <ul>
 <li>Connected directly with Sources.TempAndRad, this model only represents a
    horizontal collector. There is no calculation for radiation on tilted
    surfaces. </li>
 <li>With the standard BaseParameters, this model uses water as working
    fluid</li>
 </ul>
 <p><b><font style=\"color: #008000; \">Example Results</font></b></p>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector\">AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector</a></p>
 </html>", revisions="<html>
 <ul>
 <li><i>December 15, 2016</i> by Moritz Lauster:<br/>Moved</li>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>November 19, 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Implemented</li>
 </ul>
 </html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {88, -80}}, lineColor = {255, 128, 0},
            fillPattern =                                                                                                   FillPattern.Solid, fillColor = {255, 128, 0}), Rectangle(extent = {{-70, 70}, {-64, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-70, 70}, {-40, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-40, 70}, {-46, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-44, -72}, {-22, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-4, -72}, {22, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{2, 70}, {-4, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-24, 70}, {2, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-24, 70}, {-18, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, -72}, {62, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{44, 70}, {38, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{18, 70}, {44, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{18, 70}, {24, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{76, -72}, {96, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{82, 70}, {76, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{56, 70}, {82, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{56, 70}, {62, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-88, -72}, {-64, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}));
end SolarThermal;
