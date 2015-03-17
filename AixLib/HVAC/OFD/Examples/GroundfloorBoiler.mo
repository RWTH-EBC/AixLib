within AixLib.HVAC.OFD.Examples;


model GroundfloorBoiler
  import AixLib;
  extends Modelica.Icons.Example;
  Pumps.Pump pump(MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1(), V_flow_max = 2, ControlStrategy = 2, V_flow(fixed = false, start = 0.01), Head(fixed = false, start = 1)) annotation(Placement(transformation(extent = {{86, -16}, {66, -36}})));
  Pipes.StaticPipe Flow(D = 0.016, l = 2, dp(start = 4000)) annotation(Placement(transformation(extent = {{20, -18}, {40, 2}})));
  Pipes.StaticPipe Return(D = 0.016, l = 2, dp(start = 4000)) annotation(Placement(transformation(extent = {{40, -36}, {20, -16}})));
  Modelica.Blocks.Sources.BooleanConstant nightSignal(k = false) annotation(Placement(transformation(extent = {{42, -58}, {62, -38}})));
  inner BaseParameters baseParameters(T0 = 298.15) annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Sources.Boundary_p pointFixedPressure(use_p_in = false) annotation(Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 90, origin = {112, -39})));
  Modelica.Blocks.Sources.Constant roomsSetTemp[5](k = {293.15, 293.15, 293.15, 291.15, 293.15}) annotation(Placement(transformation(extent = {{18, 28}, {38, 48}})));
  HeatGeneration.Boiler boiler(volume(T(start = 328.15, fixed = true))) annotation(Placement(transformation(extent = {{-42, -18}, {-22, 2}})));
  Modelica.Blocks.Sources.Constant sourceSetTemp_Boiler(k = 273.15 + 55) annotation(Placement(transformation(extent = {{-16, 14}, {-36, 34}})));
  Hydraulics.GroundFloor groundFloor(toWCF(dp(start = 100)), toWCR(dp(start = 100)), thCo2F(dp(start = 100)), thCoR2(dp(start = 100)), valveWC(dp(start = 1000)), valveLiving(dp(start = 1000)), valveHobby(dp(start = 1000)), toHoF(dp(start = 100)), toHoR(dp(start = 100)), thCo1F(dp(start = 100)), thCo1R(dp(start = 100)), toCoR(dp(start = 100)), toKiR(dp(start = 100)), thWCF(dp(start = 100)), thWCR(dp(start = 100)), toLiF(dp(start = 100)), toLiR(dp(start = 100)), valveKitchen(dp(start = 1000)), valveCorridor(dp(start = 1000)), thStR(dp(start = 100))) annotation(Placement(transformation(extent = {{94, 10}, {130, 38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedHeatFlow_conv[5] annotation(Placement(transformation(extent = {{109, 66}, {129, 86}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedHeatFlow_rad[5] annotation(Placement(transformation(extent = {{33, 66}, {53, 86}})));
  Modelica.Blocks.Sources.CombiTimeTable roomTemperaturesConv(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = true, tableName = "TemperaturesConv", columns = {2, 3, 4, 5, 6}, offset = {0}, fileName = "modelica://AixLib/Resources/HVAC_OFD_ExampleData/TemperaturesConv.mat") annotation(Placement(transformation(extent = {{71, 66}, {91, 86}})));
  Modelica.Blocks.Sources.CombiTimeTable roomTemperaturesRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = true, tableName = "TemperaturesRad", columns = {2, 3, 4, 5, 6}, offset = {0}, fileName = "modelica://AixLib/Resources/HVAC_OFD_ExampleData/TemperaturesRad.mat") annotation(Placement(transformation(extent = {{1, 66}, {21, 86}})));
  Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{48, -18}, {68, 2}})));
equation
  connect(boiler.port_b, Flow.port_a) annotation(Line(points = {{-22, -8}, {20, -8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(sourceSetTemp_Boiler.y, boiler.T_set) annotation(Line(points = {{-37, 24}, {-50, 24}, {-50, -2}, {-42.8, -2}, {-42.8, -1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(roomTemperaturesConv.y, prescribedHeatFlow_conv.T) annotation(Line(points = {{92, 76}, {107, 76}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Flow.port_b, temperatureSensor.port_a) annotation(Line(points = {{40, -8}, {48, -8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(temperatureSensor.port_b, groundFloor.FLOW) annotation(Line(points = {{68, -8}, {126.123, -8}, {126.123, 9.44}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Return.port_a, pump.port_b) annotation(Line(points = {{40, -26}, {66, -26}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Return.port_b, boiler.port_a) annotation(Line(points = {{20, -26}, {-54, -26}, {-54, -8}, {-42, -8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(roomTemperaturesRad.y, prescribedHeatFlow_rad.T) annotation(Line(points = {{22, 76}, {31, 76}}, color = {0, 0, 127}, smooth = Smooth.Bezier));
  connect(nightSignal.y, pump.IsNight) annotation(Line(points = {{63, -48}, {76, -48}, {76, -36.2}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(roomsSetTemp.y, groundFloor.TSet_GF) annotation(Line(points = {{39, 38}, {56, 38}, {56, 46}, {97.3923, 46}, {97.3923, 37.44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(groundFloor.RETURN, pump.port_a) annotation(Line(points = {{122.523, 9.44}, {122.523, -26}, {86, -26}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pointFixedPressure.port_a, pump.port_a) annotation(Line(points = {{112, -32}, {112, -26}, {86, -26}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(roomTemperaturesConv.y, groundFloor.TIs_GF) annotation(Line(points = {{92, 76}, {98, 76}, {98, 60}, {106.254, 60}, {106.254, 37.44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[1].port, groundFloor.Rad_Livingroom) annotation(Line(points = {{53, 76}, {64, 76}, {64, 30.51}, {92.6154, 30.51}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[2].port, groundFloor.Rad_Hobby) annotation(Line(points = {{53, 76}, {64, 76}, {64, 52}, {140, 52}, {140, 37.58}, {130.969, 37.58}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[3].port, groundFloor.Rad_Corridor) annotation(Line(points = {{53, 76}, {64, 76}, {64, 52}, {140, 52}, {140, 30.86}, {131.385, 30.86}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[4].port, groundFloor.Rad_WC) annotation(Line(points = {{53, 76}, {64, 76}, {64, 52}, {140, 52}, {140, 20.08}, {131.108, 20.08}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[5].port, groundFloor.Rad_Kitchen) annotation(Line(points = {{53, 76}, {64, 76}, {64, 18.12}, {92.9615, 18.12}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[1].port, groundFloor.Con_Livingroom) annotation(Line(points = {{129, 76}, {140, 76}, {140, 52}, {64, 52}, {64, 28.41}, {92.6846, 28.41}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[2].port, groundFloor.Con_Hobby) annotation(Line(points = {{129, 76}, {140, 76}, {140, 34.22}, {131.108, 34.22}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[3].port, groundFloor.Con_Corridor) annotation(Line(points = {{129, 76}, {140, 76}, {140, 27.57}, {131.177, 27.57}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[4].port, groundFloor.Con_WC) annotation(Line(points = {{129, 76}, {140, 76}, {140, 17}, {131.177, 17}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[5].port, groundFloor.Con_Kitchen) annotation(Line(points = {{129, 76}, {140, 76}, {140, 52}, {64, 52}, {64, 15.81}, {92.8923, 15.81}}, color = {191, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {160, 100}}, preserveAspectRatio = false), graphics = {Text(extent=  {{-40, -42}, {98, -128}}, lineColor=  {0, 0, 255}, textString=  "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 In order for the over temperature calculation (if using logaritmic mean value) for the radiator to work we need: flow temperature > return temperature > room temperature.
 Initialize temperature of boiler water volume (e.g. 55 �C) and set the value as fixed -> flow temperature. Lower initialisation temperatures also work, as long as they are higher than the initialization for the return temperature.
 Set initial temperature for system over room temperature, in order to calculate a correct over temperature (e.g. baseParameters.T0  = 25�C) -> return temperature.
 "), Rectangle(extent=  {{-58, 42}, {-8, -30}}, lineColor=  {255, 0, 0}, fillColor=  {255, 255, 85}, fillPattern=  FillPattern.Solid), Text(extent=  {{-48, 46}, {-18, 42}}, lineColor=  {255, 0, 0}, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid, textString=  "Heating System
 ", fontSize=  11), Rectangle(extent=  {{-6, 4}, {132, -64}}, lineColor=  {255, 0, 0}, fillColor=  {170, 255, 170}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-6, 92}, {150, 6}}, lineColor=  {255, 0, 0}, fillColor=  {170, 213, 255}, fillPattern=  FillPattern.Solid), Text(extent=  {{44, -70}, {74, -74}}, lineColor=  {255, 0, 0}, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid, fontSize=  11, textString=  "Supply
 "), Text(extent=  {{54, 96}, {84, 92}}, lineColor=  {255, 0, 0}, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid, fontSize=  11, textString=  "Distribution and Consumption
 ")}), Icon(coordinateSystem(extent = {{-100, -100}, {160, 100}})), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p>04.11.2013, Moritz Lauster</p>
 <ul>
 <li>Implemented full example</li>
 </ul>
 <p>26.11.2013, Ana Constantin</p>
 <ul>
 <li>Implemented first draft</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This example illustrates the usage of the OFD-hydraulics model in combination with heating systems, e.g. a boiler.</p>
 <p>As the hydraulics correspond to a specific building, all boundray conditions have to be chosen accordingly. The heat demand and temperatures in the building have been pre-simulated in a building-physics simulation.</p>
 </html>"));
end GroundfloorBoiler;
