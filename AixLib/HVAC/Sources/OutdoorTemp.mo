within AixLib.HVAC.Sources;
model OutdoorTemp "Outdoor Temperature"
  import AixLib;
  parameter AixLib.DataBase.Weather.WeatherBaseDataDefinition temperatureOT = AixLib.DataBase.Weather.WinterDay()
    "outdoor air tmeperature"                                                                                                     annotation(choicesAllMatching = true);
  Modelica.Blocks.Sources.CombiTimeTable temperature(table = temperatureOT.temperature, offset = {273.15}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput T_out
    "Connector of Real output signals"                                           annotation(Placement(transformation(extent = {{96, -10}, {116, 10}})));
equation
  connect(temperature.y[1], T_out) annotation(Line(points = {{11, 0}, {106, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This source outputs the outdoor air temperature in K from a table given in database.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar</a></p>
 </html>", revisions = "<html>
 <p>04.11.2013, Marcus Fuchs: implemented</p>
 </html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent=  {{-54, 50}, {54, -56}}, lineColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid, fillColor=  {213, 255, 170}), Text(extent=  {{-38, 44}, {38, -46}}, lineColor=  {0, 0, 255}, fillColor=  {213, 255, 170}, fillPattern=  FillPattern.Solid, textString=  "T_out")}));
end OutdoorTemp;
