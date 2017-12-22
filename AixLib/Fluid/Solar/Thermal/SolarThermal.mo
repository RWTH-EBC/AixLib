within AixLib.Fluid.Solar.Thermal;
model SolarThermal "Model of a solar thermal panel"
  import AixLib;
  extends AixLib.Fluid.HeatExchangers.BaseClasses.PartialHeatGen(
    volume(redeclare package Medium = Medium),
    massFlowSensor(redeclare package Medium = Medium),
    T_in(redeclare package Medium = Medium));
  parameter Real A = 1 "Area of solar thermal collector in m2";
  parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
    Collector = AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector"                                                                                                     annotation(choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput T_air "Outdoor air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 108})));
  Modelica.Blocks.Interfaces.RealInput Irradiation
    "Solar irradiation on a horizontal plane in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {10, 108})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 34})));
  AixLib.Fluid.Solar.Thermal.BaseClasses.SolarThermalEfficiency
    solarThermalEfficiency(Collector=Collector)
    annotation (Placement(transformation(extent={{-76,48},{-56,68}})));
  Modelica.Blocks.Math.Max max1 annotation(Placement(transformation(extent = {{-46, 40}, {-26, 60}})));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(Placement(transformation(extent = {{-66, 30}, {-58, 38}})));
  Modelica.Blocks.Math.Gain gain(k = A) annotation(Placement(transformation(extent = {{-16, 44}, {-4, 56}})));
equation
  connect(T_air, solarThermalEfficiency.T_air) annotation(Line(points = {{-60, 108}, {-60, 78}, {-71, 78}, {-71, 68.6}}, color = {0, 0, 127}));
  connect(solarThermalEfficiency.G, Irradiation) annotation(Line(points = {{-65, 68.6}, {-65, 74}, {10, 74}, {10, 108}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points={{0,24},{
          -10,10}},                                                                              color = {191, 0, 0}));
  connect(solarThermalEfficiency.Q_flow, max1.u1) annotation(Line(points = {{-55.2, 58}, {-52, 58}, {-52, 56}, {-48, 56}}, color = {0, 0, 127}));
  connect(const.y, max1.u2) annotation(Line(points = {{-57.6, 34}, {-54, 34}, {-54, 44}, {-48, 44}}, color = {0, 0, 127}));
  connect(max1.y, gain.u) annotation(Line(points = {{-25, 50}, {-17.2, 50}}, color = {0, 0, 127}));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-3.4, 50}, {0, 50}, {0, 44}}, color = {0, 0, 127}));
  connect(T_in.T, solarThermalEfficiency.T_col) annotation (Line(
      points={{-70,11},{-71,47.4}},
      color={0,0,127}));
  annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>Model of a solar thermal collector. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"
    alt=\"stars: 3 out of 5\"/></p>
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
