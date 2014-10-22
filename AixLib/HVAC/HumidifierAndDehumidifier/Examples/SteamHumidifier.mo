within AixLib.HVAC.HumidifierAndDehumidifier.Examples;

model SteamHumidifier
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  Anlagensimulation_WS1314.HumidifierAndDehumidifier.SteamHumidifier steamHumidifier annotation(Placement(transformation(extent = {{-30, -2}, {-6, 20}})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX source(h = 56e3, m = 2.78e-4, X = 0.013) annotation(Placement(transformation(extent = {{-102, 0}, {-82, 20}})));
  Anlagensimulation_WS1314.Sources.BoundaryMoistAir_phX sink(X = 0.04, h = 1e5, p = 100000) annotation(Placement(transformation(extent = {{102, 0}, {80, 22}})));
  inner Anlagensimulation_WS1314.BaseParameters baseParameters(T0 = 303.15) annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Sources.Constant massFlow_steamIn(k = 2.78e-6) annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
  Modelica.Blocks.Sources.Constant temperature_steamIn(k = 273.15 + 100) annotation(Placement(transformation(extent = {{40, 40}, {20, 60}})));
  Anlagensimulation_WS1314.Ductwork.Duct duct(l = 10) annotation(Placement(transformation(extent = {{30, 4}, {52, 18}})));
equation
  connect(massFlow_steamIn.y, steamHumidifier.Massflow_steamIn) annotation(Line(points = {{-39, 50}, {-22.8, 50}, {-22.8, 19.34}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(temperature_steamIn.y, steamHumidifier.Temperature_steamIn) annotation(Line(points = {{19, 50}, {-13.2, 50}, {-13.2, 19.34}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(duct.portMoistAir_b, sink.portMoistAir_a) annotation(Line(points = {{52, 11}, {80, 11}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(source.portMoistAir_a, steamHumidifier.portMoistAir_a) annotation(Line(points = {{-82, 10}, {-58, 10}, {-58, 9}, {-30, 9}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(steamHumidifier.portMoistAir_b, duct.portMoistAir_a) annotation(Line(points = {{-6, 9}, {14, 9}, {14, 11}, {30, 11}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 1000, Interval = 1, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example shows how the steam humidifier works.</p>
 <p>In this particular set-up not all of the steam is absorbed because it would lead to over saturation.</p>
 </html>", revisions = "<html>
 <p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
 </html>"));
end SteamHumidifier;