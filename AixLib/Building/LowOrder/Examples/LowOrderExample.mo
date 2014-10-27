within AixLib.Building.LowOrder.Examples;


model LowOrderExample
  extends Modelica.Icons.Example;
  import AixLib;
  output Real TRoom;
  output Real heatDemand;
  output Real coolDemand;
  ThermalZone thermalZone(zoneParam = AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting()) annotation(Placement(transformation(extent = {{-10, -12}, {16, 14}})));
  Components.Weather.Weather weather(fileName = "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt", Air_temp = true, Sky_rad = true, Ter_rad = true, Outopt = 1) annotation(Placement(transformation(extent = {{-60, 42}, {-30, 62}})));
  Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1 idealHeaterCoolerVar1_1 annotation(Placement(transformation(extent = {{-22, -52}, {-2, -32}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 1) annotation(Placement(transformation(extent = {{-88, -32}, {-74, -18}})));
  Modelica.Blocks.Sources.Constant infiltrationTemperature(k = 288.15) annotation(Placement(transformation(extent = {{-88, -10}, {-74, 4}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = true, tableName = "UserProfiles", fileName = "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt", columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{14, -71}, {28, -57}})));
  Modelica.Blocks.Sources.CombiTimeTable heatingCooling(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesHeat", fileName = "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfilesHeatSimple.txt", columns = {2, 3}, tableOnFile = false, table = [0, 295.15, 295.2; 3600, 295.1, 295.2; 7200, 295.1, 295.2; 10800, 295.1, 295.2; 14400, 295.1, 295.2; 18000, 295.1, 295.2; 21600, 295.1, 295.2; 25200, 300.1, 300.2; 28800, 300.1, 300.2; 32400, 300.1, 300.2; 36000, 300.1, 300.2; 39600, 300.1, 300.2; 43200, 300.1, 300.2; 46800, 300.1, 300.2; 50400, 300.1, 300.2; 54000, 300.1, 300.2; 57600, 300.1, 300.2; 61200, 300.1, 300.2; 64800, 300.1, 300.2; 68400, 295.1, 295.2; 72000, 295.1, 295.2; 75600, 295.1, 295.2; 79200, 295.1, 295.2; 82800, 295.1, 295.2; 86400, 295.1, 295.2]) annotation(Placement(transformation(extent = {{-56, -75}, {-42, -61}})));
equation
  TRoom = thermalZone.thermalZonePhysics.reducedOrderModel.airload.T;
  heatDemand = idealHeaterCoolerVar1_1.heatMeter.q_kwh;
  coolDemand = idealHeaterCoolerVar1_1.coolMeter.q_kwh;
  connect(weather.SolarRadiation_OrientedSurfaces, thermalZone.solarRad_in) annotation(Line(points = {{-52.8, 41}, {-52.8, 8.8}, {-7.4, 8.8}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(idealHeaterCoolerVar1_1.HeatCoolRoom, thermalZone.internalGainsConv) annotation(Line(points = {{-3, -42}, {3, -42}, {3, -10.7}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationRate.y, thermalZone.infiltrationRate) annotation(Line(points = {{-73.3, -25}, {-2.2, -25}, {-2.2, -10.44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationTemperature.y, thermalZone.infiltrationTemperature) annotation(Line(points = {{-73.3, -3}, {-40.65, -3}, {-40.65, -4.07}, {-6.75, -4.07}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(weather.WeatherDataVector, thermalZone.weather) annotation(Line(points = {{-45.1, 41}, {-45.1, 1}, {-6.62, 1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(internalGains.y, thermalZone.internalGains) annotation(Line(points = {{28.7, -64}, {34, -64}, {34, -34}, {13.4, -34}, {13.4, -10.44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatingCooling.y[1], idealHeaterCoolerVar1_1.soll_heat) annotation(Line(points = {{-41.3, -68}, {-9, -68}, {-9, -46.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatingCooling.y[2], idealHeaterCoolerVar1_1.soll_cool) annotation(Line(points = {{-41.3, -68}, {-16.8, -68}, {-16.8, -46.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example for setting up a simulation for a thermal zone.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Calculation of room temperatures and heating and cooling demands.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June 24, 2014  </i>by Moritz Lauster:<br>Implemented</li>
 </ul>
 </html>"), experiment(StopTime = 3.1536e+007, Interval = 3600), __Dymola_experimentSetupOutput);
end LowOrderExample;
