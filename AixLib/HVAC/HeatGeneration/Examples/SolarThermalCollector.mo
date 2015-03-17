within AixLib.HVAC.HeatGeneration.Examples;


model SolarThermalCollector
  "Example to demonstrate the function of the solar thermal collector model"
  import AixLib;
  extends Modelica.Icons.Example;
  inner BaseParameters baseParameters annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Sources.Boundary_ph boundary_ph(h = 125823, use_p_in = false, p = 100020) annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Sources.Boundary_ph boundary_ph1(use_p_in = false) annotation(Placement(transformation(extent = {{100, -10}, {80, 10}})));
  Sensors.MassFlowSensor massFlowSensor annotation(Placement(transformation(extent = {{-54, -10}, {-34, 10}})));
  Sensors.TemperatureSensor T1 annotation(Placement(transformation(extent = {{-28, -10}, {-8, 10}})));
  SolarThermal solarThermal(A = 2, Collector = AixLib.DataBase.SolarThermal.VacuumCollector()) annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
  Sources.TempAndRad tempAndRad(temperatureOT = AixLib.DataBase.Weather.SummerDay()) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {8, 86})));
  Pipes.StaticPipe pipe(l = 100) annotation(Placement(transformation(extent = {{54, -10}, {74, 10}})));
  Sensors.TemperatureSensor T2 annotation(Placement(transformation(extent = {{28, -10}, {48, 10}})));
equation
  connect(boundary_ph.port_a, massFlowSensor.port_a) annotation(Line(points = {{-60, 0}, {-54, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(massFlowSensor.port_b, T1.port_a) annotation(Line(points = {{-34, 0}, {-28, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(T1.port_b, solarThermal.port_a) annotation(Line(points = {{-8, 0}, {0, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(solarThermal.port_b, T2.port_a) annotation(Line(points = {{20, 0}, {28, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(T2.port_b, pipe.port_a) annotation(Line(points = {{48, 0}, {54, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe.port_b, boundary_ph1.port_a) annotation(Line(points = {{74, 0}, {80, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(tempAndRad.Rad, solarThermal.Irradiation) annotation(Line(points = {{12, 75.4}, {12, 10.8}, {11, 10.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tempAndRad.T_out, solarThermal.T_air) annotation(Line(points = {{4, 75.4}, {4, 75.4}, {4, 10.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 82600, Interval = 3600), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p><br/>This test demonstrates the solar thermal collector model. Different types of collectors can be tested at fixed boundary conditions. To test the collectors at different fluid temperatures, adjust h at left boundary accordung to this table:</p>
 <p>T in &deg;C | h in J/kg</p>
 <p>20 | 84007</p>
 <p>30 | 125823</p>
 <p>40 | 167616</p>
 <p>50 | 209418</p>
 <p>60 | 251249</p>
 <p>70 | 293123</p>
 <p>80 | 335055</p>
 <p>90 | 377063</p>
 <p>(values are according to wolframalpha.com for water at p = 1 atm ) </p>
 </html>", revisions = "<html>
 <p>26.11.2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end SolarThermalCollector;
