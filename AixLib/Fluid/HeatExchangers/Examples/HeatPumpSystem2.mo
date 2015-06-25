within AixLib.Fluid.HeatExchangers.Examples;
model HeatPumpSystem2 "Test case for boiler model"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.Movers.Pump Pump2(
    Head_max=1,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,10})));
  AixLib.Fluid.Sources.FixedBoundary
                     staticPressure(nPorts=1, redeclare package Medium = Medium)
                                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-10, -10})));
  Fluid.FixedResistances.StaticPipe pipe(D = 0.01, l = 15,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {90, 10})));
  Fluid.FixedResistances.StaticPipe pipe1(D = 0.01, l = 15,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                     annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {30, -50})));
  AixLib.Fluid.Sensors.MassFlowRate
                         massFlowSensor(redeclare package Medium = Medium)
                                        annotation(Placement(transformation(extent = {{20, 60}, {40, 80}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent = {{60, 60}, {80, 80}})));
  AixLib.Fluid.HeatExchangers.HeatPump.SimpleHeatPump heatPump(
    tablePower=[0.0,273.15,283.15; 308.15,1100,1150; 328.15,1600,1750],
    tableHeatFlowCondenser=[0.0,273.15,283.15; 308.15,4800,6300; 328.15,4400,
        5750],
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));

  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth = 5) annotation(Placement(transformation(extent = {{-36, 74}, {-16, 94}})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 40) annotation(Placement(transformation(extent = {{-80, 80}, {-60, 100}})));
  AixLib.Fluid.Movers.Pump Pump1(
    MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
    ControlStrategy=1,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,58})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph(h = 4184 * 8, nPorts=1,
    redeclare package Medium = Medium)          annotation(Placement(transformation(extent = {{-100, 52}, {-80, 72}})));
  Fluid.FixedResistances.StaticPipe pipe2(D = 0.01, l = 2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-64, 58})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph1(nPorts=1, redeclare package Medium = Medium)
                                   annotation(Placement(transformation(extent = {{-100, 24}, {-80, 44}})));
  Modelica.Blocks.Sources.BooleanExpression Source_IsNight annotation(Placement(transformation(extent = {{-102, 4}, {-82, 24}})));
  AixLib.Fluid.HeatExchangers.Utilities.FuelCounter electricityCounter
    annotation (Placement(transformation(extent={{-14,16},{6,36}})));
  AixLib.Fluid.HeatExchangers.Radiators.Radiator
                     radiator(RadiatorType = AixLib.DataBase.Radiators.ThermX2_ProfilV_979W(),
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)                                                                       annotation(Placement(transformation(extent = {{-11, -10}, {11, 10}}, rotation = 180, origin={69,-50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp annotation(Placement(transformation(extent={{42,-78},
            {54,-66}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp annotation(Placement(transformation(extent={{92,-78},
            {80,-66}})));
  Modelica.Blocks.Sources.Constant Source_Temp(k = 273.15 + 20) annotation(Placement(transformation(extent={{4,-94},
            {24,-74}})));
equation
  connect(pipe1.port_b, Pump2.port_a) annotation(Line(points = {{20, -50}, {10, -50}, {10, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation(Line(points = {{40, 70}, {60, 70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(temperatureSensor.port_b, pipe.port_a) annotation(Line(points = {{80, 70}, {90, 70}, {90, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Pump2.port_b, heatPump.port_a_sink) annotation(Line(points = {{10, 20}, {10, 43}, {1, 43}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(heatPump.port_b_sink, massFlowSensor.port_a) annotation(Line(points = {{1, 57}, {6, 57}, {6, 56}, {10, 56}, {10, 70}, {20, 70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(onOffController.y, heatPump.OnOff) annotation(Line(points = {{-15, 84}, {-8, 84}, {-8, 58}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(const.y, onOffController.reference) annotation(Line(points = {{-59, 90}, {-38, 90}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pipe2.port_b, Pump1.port_a) annotation(Line(points = {{-54, 58}, {-48, 58}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Pump1.port_b, heatPump.port_a_source) annotation(Line(points = {{-28, 58}, {-20, 58}, {-20, 57}, {-17, 57}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Source_IsNight.y, Pump2.IsNight) annotation(Line(points = {{-81, 14}, {-40, 14}, {-40, 10}, {-0.2, 10}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(Source_IsNight.y, Pump1.IsNight) annotation(Line(points = {{-81, 14}, {-68, 14}, {-68, 68.2}, {-38, 68.2}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(electricityCounter.fuel_in, heatPump.Power) annotation(Line(points = {{-14, 26}, {-22, 26}, {-22, 36}, {-8, 36}, {-8, 41}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(onOffController.u, temperatureSensor.T) annotation (Line(
      points={{-38,78},{-48,78},{-48,100},{70,100},{70,81}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(staticPressure.ports[1], Pump2.port_a) annotation (Line(
      points={{-10,-20},{-10,-28},{10,-28},{10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_ph.ports[1], pipe2.port_a) annotation (Line(
      points={{-80,62},{-74,58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_ph1.ports[1], heatPump.port_b_source) annotation (Line(
      points={{-80,34},{-26,34},{-26,42},{-17,43}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Source_Temp.y, AirTemp.T) annotation (Line(
      points={{25,-84},{96,-84},{96,-72},{93.2,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Source_Temp.y, RadTemp.T) annotation (Line(
      points={{25,-84},{36,-84},{36,-72},{40.8,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(RadTemp.port, radiator.radPort) annotation (Line(
      points={{54,-72},{64,-72},{64.6,-57.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(AirTemp.port, radiator.convPort) annotation (Line(
      points={{80,-72},{74,-72},{73.62,-57.6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipe1.port_a, radiator.port_b) annotation (Line(
      points={{40,-50},{58,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(radiator.port_a, pipe.port_b) annotation (Line(
      points={{80,-50},{90,-50},{90,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics), experiment(StopTime = 10800, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This example models a simple fluid circuit in order to test the heat pump model for plausibility</p>
 </html>", revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>25.11.2013, Kristian Huchtemann</p>
 <p><ul>
 <li>changed BoilerSystem to HeatPumpSystem</li>
 </ul></p>
 </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end HeatPumpSystem2;
