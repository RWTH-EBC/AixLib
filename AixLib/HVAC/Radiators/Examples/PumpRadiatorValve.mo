within AixLib.HVAC.Radiators.Examples;
model PumpRadiatorValve
  import AixLib;
  extends Modelica.Icons.Example;
  Pumps.Pump pump(MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1(), V_flow_max = 2, ControlStrategy = 2, V_flow(fixed = false), Head_max = 2) annotation(Placement(transformation(extent = {{-54, 10}, {-34, 30}})));
  Pipes.StaticPipe pipe(l = 10, D = 0.01) annotation(Placement(transformation(extent = {{4, 10}, {24, 30}})));
  Pipes.StaticPipe pipe1(l = 10, D = 0.01) annotation(Placement(transformation(extent = {{-10, -30}, {-30, -10}})));
  Modelica.Blocks.Sources.BooleanConstant NightSignal(k = false) annotation(Placement(transformation(extent = {{-76, 50}, {-56, 70}})));
  inner BaseParameters baseParameters annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Sources.Boundary_p PointFixedPressure(use_p_in = false) annotation(Placement(transformation(extent = {{-98, 10}, {-78, 30}})));
  Valves.SimpleValve simpleValve(Kvs = 0.4) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  Radiator radiator(RadiatorType = AixLib.DataBase.Radiators.ThermX2_ProfilV_979W()) annotation(Placement(transformation(extent = {{112, 10}, {134, 30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp annotation(Placement(transformation(extent = {{100, 58}, {112, 70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp annotation(Placement(transformation(extent = {{148, 58}, {136, 70}})));
  Modelica.Blocks.Sources.Constant Source_Temp(k = 273.15 + 20) annotation(Placement(transformation(extent = {{60, 80}, {80, 100}})));
  Modelica.Blocks.Sources.Sine Source_opening(freqHz = 1 / 86400, offset = 0.5, startTime = -21600, amplitude = 0.49) annotation(Placement(transformation(extent = {{10, 60}, {30, 80}})));
  HeatGeneration.Boiler boiler annotation(Placement(transformation(extent = {{-26, 10}, {-6, 30}})));
  Modelica.Blocks.Sources.Constant Source_TempSet_Boiler(k = 273.15 + 75) annotation(Placement(transformation(extent = {{0, 60}, {-20, 80}})));
equation
  connect(pipe1.port_b, pump.port_a) annotation(Line(points = {{-30, -20}, {-60, -20}, {-60, 20}, {-54, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(NightSignal.y, pump.IsNight) annotation(Line(points = {{-55, 60}, {-44, 60}, {-44, 30.2}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(PointFixedPressure.port_a, pump.port_a) annotation(Line(points = {{-78, 20}, {-54, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe.port_b, simpleValve.port_a) annotation(Line(points = {{24, 20}, {30, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(simpleValve.port_b, radiator.port_a) annotation(Line(points = {{50, 20}, {112.88, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(radiator.port_b, pipe1.port_a) annotation(Line(points = {{133.12, 20}, {160, 20}, {160, -20}, {-10, -20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(AirTemp.port, radiator.convPort) annotation(Line(points = {{112, 64}, {118.38, 64}, {118.38, 27.6}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiator.radPort, RadTemp.port) annotation(Line(points = {{127.4, 27.8}, {127.4, 64}, {136, 64}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(Source_Temp.y, AirTemp.T) annotation(Line(points = {{81, 90}, {98.8, 90}, {98.8, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_Temp.y, RadTemp.T) annotation(Line(points = {{81, 90}, {150, 90}, {150, 64}, {149.2, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Source_opening.y, simpleValve.opening) annotation(Line(points = {{31, 70}, {40, 70}, {40, 28}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pump.port_b, boiler.port_a) annotation(Line(points = {{-34, 20}, {-26, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boiler.port_b, pipe.port_a) annotation(Line(points = {{-6, 20}, {4, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Source_TempSet_Boiler.y, boiler.T_set) annotation(Line(points = {{-21, 70}, {-34, 70}, {-34, 26}, {-26.8, 26}, {-26.8, 27}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {160, 100}}, preserveAspectRatio = false), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {160, 100}})), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Rkfix2"), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Pump, boiler, valve and radiator in a closed loop.</p>
 <p><h4><font color=\"#008000\">Concept</font></h4></p>
 <p>The example ilustrates how the radiator power depends on the mass flow, i.e. the valve opening.</p>
 <p>The valve doesn&apos;t fully close, because as the radiator it is connected to fixed temperatures the temperature difference between flow and return become infinite at zero mass flow in order to satisfy the power equation. </p>
 <p>Make sure you initialise the temperatures correctly in order to have flow temperature &GT; return temperature &GT; room temperature in order for the equation for over temperature to be correctly calculated.</p>
 </html>"));
end PumpRadiatorValve;

