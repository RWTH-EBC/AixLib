within AixLib.HVAC.Storage.Examples;

model StorageBoiler
  extends Modelica.Icons.Example;
  import AixLib;
  Storage storage(n = 10, V_HE = 0.05, kappa = 0.4, beta = 350e-6, A_HE = 20, lambda_ins = 0.04, s_ins = 0.1, alpha_in = 1500, alpha_out = 15, d = 1, h = 2, k_HE = 1500) annotation(Placement(transformation(extent = {{-56, 14}, {-36, 34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent = {{-94, 14}, {-74, 34}})));
  Pumps.Pump pump annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-32, 62})));
  HeatGeneration.Boiler boiler(Q_flow_max = 50000, boilerEfficiencyB = AixLib.DataBase.Boiler.BoilerCondensing()) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-16, 76})));
  Sources.Boundary_p boundary_p annotation(Placement(transformation(extent = {{-86, 70}, {-66, 90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {6, 60})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 80) annotation(Placement(transformation(extent = {{-3, -3}, {3, 3}}, rotation = 180, origin = {13, 69})));
  inner BaseParameters baseParameters(T_ref = 273.15) annotation(Placement(transformation(extent = {{60, 76}, {80, 96}})));
  Pipes.StaticPipe pipe(D = 0.05, l = 5) annotation(Placement(transformation(extent = {{-26, -10}, {-6, 10}})));
  HydraulicResistances.HydraulicResistance hydraulicResistance(zeta = 1000) annotation(Placement(transformation(extent = {{8, -10}, {28, 10}})));
  Sources.Boundary_ph boundary_ph1(use_p_in = true, h = 0.8e5) annotation(Placement(transformation(extent = {{-104, -20}, {-84, 0}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000, offset = 1e5, height = 0.00001e5) annotation(Placement(transformation(extent = {{-136, -14}, {-116, 6}})));
  Sources.Boundary_ph boundary_ph2(use_p_in = false) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-72, 46})));
  Pipes.StaticPipe pipe1(D = 0.05, l = 5) annotation(Placement(transformation(extent = {{-66, -20}, {-46, 0}})));
equation
  connect(fixedTemperature.port, storage.heatPort) annotation(Line(points = {{-74, 24}, {-54, 24}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(pump.port_a, boiler.port_b) annotation(Line(points = {{-32, 72}, {-32, 76}, {-26, 76}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundary_p.port_a, pump.port_a) annotation(Line(points = {{-66, 80}, {-32, 80}, {-32, 72}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(booleanExpression.y, pump.IsNight) annotation(Line(points = {{-5, 60}, {-14, 60}, {-14, 62}, {-21.8, 62}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(const.y, boiler.T_set) annotation(Line(points = {{9.7, 69}, {-5.2, 69}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pipe.port_b, hydraulicResistance.port_a) annotation(Line(points = {{-6, 0}, {8, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(hydraulicResistance.port_b, boiler.port_a) annotation(Line(points = {{28, 0}, {52, 0}, {52, 76}, {-6, 76}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pump.port_b, storage.port_a_heatGenerator) annotation(Line(points = {{-32, 52}, {-32, 32.8}, {-37.6, 32.8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe.port_a, storage.port_b_heatGenerator) annotation(Line(points = {{-26, 0}, {-32, 0}, {-32, 16}, {-37.6, 16}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(ramp.y, boundary_ph1.p_in) annotation(Line(points = {{-115, -4}, {-106, -4}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(boundary_ph2.port_a, storage.port_b_consumer) annotation(Line(points = {{-62, 46}, {-46, 46}, {-46, 34}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundary_ph1.port_a, pipe1.port_a) annotation(Line(points = {{-84, -10}, {-66, -10}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe1.port_b, storage.port_a_consumer) annotation(Line(points = {{-46, -10}, {-46, 14}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 86400, Interval = 60), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>This is a simple example of a storage and a boiler.</p>
 </html>", revisions = "<html>
 <p>13.12.2013, by <i>Sebastian Stinner</i>: implemented</p>
 </html>"));
end StorageBoiler;