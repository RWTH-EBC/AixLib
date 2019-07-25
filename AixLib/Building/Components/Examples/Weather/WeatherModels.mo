within AixLib.Building.Components.Examples.Weather;
model WeatherModels
  extends Modelica.Icons.Example;
  Components.Weather.Weather weather(Cloud_cover = true, Wind_dir = true, Wind_speed = true, Air_temp = true, Air_press = true, Mass_frac = true, Rel_hum = true, Sky_rad = true, Ter_rad = true)                                                                                            annotation(Placement(transformation(extent = {{-60, 16}, {6, 60}})));
equation

  annotation(experiment(StopTime = 3.1536e+007, Interval = 3600, Algorithm = "Lsodar"),Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A test to see if the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model is functioning correctly. A input file containing weather data (TRY standard) has to be provided and linked to. Check out the default path in order to set the path correctly considering the current directory.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>May 28, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, Added SkyTemp model to simulation.</li>
 <li><i>December 13, 2011&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
 </ul>
 </html>"));
end WeatherModels;
