within AixLib.HVAC.OFD.Examples;


model GroundfloorHeatPump
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  Pumps.Pump pump(MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1(), V_flow_max = 2, ControlStrategy = 2, V_flow(fixed = false, start = 0.01), Head(fixed = false, start = 1),
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                                                                                                     annotation(Placement(transformation(extent = {{86, -16}, {66, -36}})));
  Pipes.StaticPipe Flow(D = 0.016, l = 2, dp(start = 4000),
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                                      annotation(Placement(transformation(extent = {{20, -18}, {40, 2}})));
  Pipes.StaticPipe Return(D = 0.016, l = 2, dp(start = 4000),
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                                        annotation(Placement(transformation(extent = {{40, -36}, {20, -16}})));
  Modelica.Blocks.Sources.BooleanConstant nightSignal(k = false) annotation(Placement(transformation(extent = {{42, -58}, {62, -38}})));
  AixLib.Fluid.Sources.FixedBoundary
                     pointFixedPressure(nPorts=1, redeclare package Medium =
        Medium)                                           annotation(Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 90, origin = {112, -39})));
  Modelica.Blocks.Sources.Constant roomsSetTemp[5](k = {293.15, 293.15, 293.15, 291.15, 293.15}) annotation(Placement(transformation(extent = {{18, 28}, {38, 48}})));
  Modelica.Blocks.Sources.Constant sourceSetTemp_HeatPump(k = 273.15 + 55) annotation(Placement(transformation(extent = {{-94, 28}, {-74, 48}})));
  Hydraulics.GroundFloor groundFloor(toWCF(dp(start = 100)), toWCR(dp(start = 100)), thCo2F(dp(start = 100)), thCoR2(dp(start = 100)), valveWC(dp(start = 1000)), valveLiving(dp(start = 1000)), valveHobby(dp(start = 1000)), toHoF(dp(start = 100)), toHoR(dp(start = 100)), thCo1F(dp(start = 100)), thCo1R(dp(start = 100)), toCoR(dp(start = 100)), toKiR(dp(start = 100)), thWCF(dp(start = 100)), thWCR(dp(start = 100)), toLiF(dp(start = 100)), toLiR(dp(start = 100)), valveKitchen(dp(start = 1000)), valveCorridor(dp(start = 1000)), thStR(dp(start = 100))) annotation(Placement(transformation(extent = {{94, 10}, {130, 38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedHeatFlow_conv[5] annotation(Placement(transformation(extent = {{109, 66}, {129, 86}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedHeatFlow_rad[5] annotation(Placement(transformation(extent = {{33, 66}, {53, 86}})));
  Modelica.Blocks.Sources.CombiTimeTable roomTemperaturesConv(                                                              tableOnFile = true, tableName = "TemperaturesConv", columns = {2, 3, 4, 5, 6}, offset = {0},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName=
        "modelica://AixLib/Resources/HVAC_OFD_ExampleData/TemperaturesConv.mat")
                                                                                                        annotation(Placement(transformation(extent = {{71, 66}, {91, 86}})));
  Modelica.Blocks.Sources.CombiTimeTable roomTemperaturesRad(                                                              tableOnFile = true, tableName = "TemperaturesRad", columns = {2, 3, 4, 5, 6}, offset = {0},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName=
        "modelica://AixLib/Resources/HVAC_OFD_ExampleData/TemperaturesRad.mat")
                                                                                                        annotation(Placement(transformation(extent = {{1, 66}, {21, 86}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent = {{48, -18}, {68, 2}})));
  HeatGeneration.HeatPump heatPump(volumeCondenser(T(start = 323.15, fixed = true)), tablePower = [0.0, 273.15, 283.15; 308.15, 1100, 1150; 328.15, 1600, 1750], tableHeatFlowCondenser = [0.0, 273.15, 283.15; 308.15, 4800, 6300; 328.15, 4400, 5750],
    redeclare package Medium = Medium)                                                                                                     annotation(Placement(transformation(extent = {{-38, -30}, {-14, -4}})));
  HeatGeneration.Utilities.FuelCounter fuelCounter annotation(Placement(transformation(extent = {{-23, -46}, {-7, -34}})));
  Pumps.Pump pump1(redeclare package Medium = Medium, m_flow_small=1e-4)
                   annotation(Placement(transformation(extent = {{-56, -1}, {-42, -15}})));
  Pipes.StaticPipe pipe(D = 0.01, l = 2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                   annotation(Placement(transformation(extent = {{-80, -17}, {-62, 1}})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph(h = 4184 * 8,
    nPorts=1,
    redeclare package Medium = Medium)          annotation(Placement(transformation(extent = {{-100, -15}, {-86, -1}})));
  AixLib.Fluid.Sources.FixedBoundary
                      boundary_ph1(nPorts=1, redeclare package Medium = Medium)
                                   annotation(Placement(transformation(extent={{-100,
            -33},{-86,-19}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth = 5) annotation(Placement(transformation(extent = {{-52, 14}, {-32, 34}})));
equation
  connect(roomTemperaturesConv.y, prescribedHeatFlow_conv.T) annotation(Line(points = {{92, 76}, {107, 76}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Flow.port_b, temperatureSensor.port_a) annotation(Line(points = {{40, -8}, {48, -8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(temperatureSensor.port_b, groundFloor.FLOW) annotation(Line(points={{68,-8},
          {126.123,-8},{126.123,9.44}},                                                                                    color = {0, 127, 255}, smooth = Smooth.None));
  connect(Return.port_a, pump.port_b) annotation(Line(points = {{40, -26}, {66, -26}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(roomTemperaturesRad.y, prescribedHeatFlow_rad.T) annotation(Line(points = {{22, 76}, {31, 76}}, color = {0, 0, 127}, smooth = Smooth.Bezier));
  connect(nightSignal.y, pump.IsNight) annotation(Line(points = {{63, -48}, {76, -48}, {76, -36.2}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(roomsSetTemp.y, groundFloor.TSet_GF) annotation(Line(points={{39,38},
          {56,38},{56,46},{97.3923,46},{97.3923,37.44}},                                                                                 color = {0, 0, 127}, smooth = Smooth.None));
  connect(groundFloor.RETURN, pump.port_a) annotation(Line(points={{122.523,
          9.44},{122.523,-26},{86,-26}},                                                                          color = {0, 127, 255}, smooth = Smooth.None));
  connect(roomTemperaturesConv.y, groundFloor.TIs_GF) annotation(Line(points={{92,76},
          {98,76},{98,60},{106.254,60},{106.254,37.44}},                                                                                        color = {0, 0, 127}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[1].port, groundFloor.Rad_Livingroom) annotation(Line(points={{53,76},
          {64,76},{64,30.51},{92.6154,30.51}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[2].port, groundFloor.Rad_Hobby) annotation(Line(points={{53,76},
          {64,76},{64,52},{140,52},{140,37.58},{130.969,37.58}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[3].port, groundFloor.Rad_Corridor) annotation(Line(points={{53,76},
          {64,76},{64,52},{140,52},{140,30.86},{131.385,30.86}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[4].port, groundFloor.Rad_WC) annotation(Line(points={{53,76},
          {64,76},{64,52},{140,52},{140,20.08},{131.108,20.08}},                                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_rad[5].port, groundFloor.Rad_Kitchen) annotation(Line(points={{53,76},
          {64,76},{64,18.12},{92.9615,18.12}},                                                                                                   color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[1].port, groundFloor.Con_Livingroom) annotation(Line(points={{129,76},
          {140,76},{140,52},{64,52},{64,28.41},{92.6846,28.41}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[2].port, groundFloor.Con_Hobby) annotation(Line(points={{129,76},
          {140,76},{140,34.22},{131.108,34.22}},                                                                                                   color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[3].port, groundFloor.Con_Corridor) annotation(Line(points={{129,76},
          {140,76},{140,27.57},{131.177,27.57}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[4].port, groundFloor.Con_WC) annotation(Line(points={{129,76},
          {140,76},{140,17},{131.177,17}},                                                                                                color = {191, 0, 0}, smooth = Smooth.None));
  connect(prescribedHeatFlow_conv[5].port, groundFloor.Con_Kitchen) annotation(Line(points={{129,76},
          {140,76},{140,52},{64,52},{64,15.81},{92.8923,15.81}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(Flow.port_a, heatPump.port_b_sink) annotation(Line(points = {{20, -8}, {0, -8}, {0, -7.9}, {-15.2, -7.9}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Return.port_b, heatPump.port_a_sink) annotation(Line(points = {{20, -26}, {-8, -26}, {-8, -26.1}, {-15.2, -26.1}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(heatPump.Power, fuelCounter.fuel_in) annotation(Line(points = {{-26, -28.7}, {-26, -40}, {-23, -40}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pump1.port_b, heatPump.port_a_source) annotation(Line(points = {{-42, -8}, {-40, -8}, {-40, -7.9}, {-36.8, -7.9}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe.port_b, pump1.port_a) annotation(Line(points = {{-62, -8}, {-56, -8}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(nightSignal.y, pump1.IsNight) annotation(Line(points = {{63, -48}, {76, -48}, {76, -66}, {-49, -66}, {-49, -15.14}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(sourceSetTemp_HeatPump.y, onOffController.reference) annotation(Line(points = {{-73, 38}, {-62, 38}, {-62, 30}, {-54, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(onOffController.y, heatPump.OnOff) annotation(Line(points = {{-31, 24}, {-26, 24}, {-26, -6.6}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(pointFixedPressure.ports[1], pump.port_a) annotation (Line(
      points={{112,-32},{112,-26},{86,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_ph1.ports[1], heatPump.port_b_source) annotation (Line(
      points={{-86,-26},{-36.8,-26.1}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_ph.ports[1], pipe.port_a) annotation (Line(
      points={{-86,-8},{-80,-8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureSensor.T, onOffController.u) annotation (Line(
      points={{58,3},{58,8},{-60,8},{-60,18},{-54,18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{160,100}},      preserveAspectRatio=false),   graphics={  Text(extent = {{-38, -42}, {100, -128}}, lineColor = {0, 0, 255}, textString = "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 In order for the over temperature calculation (if using logaritmic mean value) for the radiator to work we need: flow temperature > return temperature > room temperature.
 Initialize temperature of heat pump condenser water volume (e.g. 55 �C) and set the value as fixed -> flow temperature. Lower initialisation temperatures also work, as long as they are higher than the initialization for the return temperature.
 Set initial temperature for system over room temperature, in order to calculate a correct over temperature (e.g. baseParameters.T0  = 25�C) -> return temperature.
 "), Rectangle(extent = {{-100, 56}, {-8, -46}}, lineColor = {255, 0, 0}, fillColor = {255, 255, 85},
            fillPattern =                                                                                           FillPattern.Solid), Text(extent = {{-70, 61}, {-40, 57}}, lineColor = {255, 0, 0}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                    FillPattern.Solid, textString = "Heating System
 ", fontSize = 11), Rectangle(extent = {{-6, 4}, {132, -64}}, lineColor = {255, 0, 0}, fillColor = {170, 255, 170},
            fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-6, 92}, {150, 6}}, lineColor = {255, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{44, -70}, {74, -74}}, lineColor = {255, 0, 0}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                    FillPattern.Solid, textString = "Hydraulics
 ", fontSize = 11), Text(extent = {{54, 96}, {84, 92}}, lineColor = {255, 0, 0}, fillColor = {0, 0, 255},
            fillPattern =                                                                                               FillPattern.Solid, fontSize = 11, textString = "Distribution and Consumption
 ")}), Icon(coordinateSystem(extent = {{-100, -100}, {160, 100}})), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>04.11.2013, Moritz Lauster</p>
 <p><ul>
 <li>Implemented full example</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This example illustrates the usage of the OFD-hydraulics model in combination with heating systems, e.g. a heat pump.</p>
 <p>As the hydraulics correspond to a specific building, all boundray conditions have to be chosen accordingly. The heat demand and temperatures in the building have been pre-simulated in a building-physics simulation.</p>
 </html>"));
end GroundfloorHeatPump;
