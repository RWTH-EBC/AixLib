within AixLib.Fluid.Examples;
model PumpRadiatorValve
  "Example of a simple heating system with radiator and simple valve"
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water;

  AixLib.Fluid.Movers.Pump
             pump(MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1(), V_flow_max = 2, ControlStrategy = 2, V_flow(fixed = false), Head_max = 2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                                                                                                     annotation(Placement(transformation(extent = {{-54, 10}, {-34, 30}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{4,10},{24,30}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  Modelica.Blocks.Sources.BooleanConstant NightSignal(k = false) annotation(Placement(transformation(extent = {{-76, 50}, {-56, 70}})));
  AixLib.Fluid.Sources.Boundary_pT
                     PointFixedPressure(nPorts=1, redeclare package Medium =
        Medium)                                           annotation(Placement(transformation(extent = {{-98, 10}, {-78, 30}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(
    Kvs=0.4,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  AixLib.Fluid.HeatExchangers.Radiators.Radiator radiator(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    selectable=true,
    radiatorType=
        AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Kitchen())
    annotation (Placement(transformation(extent={{112,10},{134,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp annotation(Placement(transformation(extent = {{100, 58}, {112, 70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp annotation(Placement(transformation(extent = {{148, 58}, {136, 70}})));
  Modelica.Blocks.Sources.Constant Source_Temp(k = 273.15 + 20) annotation(Placement(transformation(extent = {{60, 80}, {80, 100}})));
  Modelica.Blocks.Sources.Sine Source_opening(freqHz = 1 / 86400, offset = 0.5, startTime = -21600, amplitude = 0.49) annotation(Placement(transformation(extent = {{10, 60}, {30, 80}})));
  Modelica.Blocks.Sources.Constant Source_TempSet_Boiler(k = 273.15 + 75) annotation(Placement(transformation(extent = {{0, 60}, {-20, 80}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
equation
  connect(pipe1.port_b, pump.port_a) annotation(Line(points = {{-30, -20}, {-60, -20}, {-60, 20}, {-54, 20}}, color = {0, 127, 255}));
  connect(NightSignal.y, pump.IsNight) annotation(Line(points = {{-55, 60}, {-44, 60}, {-44, 30.2}}, color = {255, 0, 255}));
  connect(pipe.port_b, simpleValve.port_a) annotation(Line(points = {{24, 20}, {30, 20}}, color = {0, 127, 255}));
  connect(simpleValve.port_b, radiator.port_a) annotation(Line(points={{50,20},{
          112,20}},                                                                               color = {0, 127, 255}));
  connect(radiator.port_b, pipe1.port_a) annotation(Line(points={{134,20},{160,20},
          {160,-20},{-10,-20}},                                                                                      color = {0, 127, 255}));
  connect(Source_Temp.y, AirTemp.T) annotation(Line(points = {{81, 90}, {98.8, 90}, {98.8, 64}}, color = {0, 0, 127}));
  connect(Source_Temp.y, RadTemp.T) annotation(Line(points = {{81, 90}, {150, 90}, {150, 64}, {149.2, 64}}, color = {0, 0, 127}));
  connect(Source_opening.y, simpleValve.opening) annotation(Line(points = {{31, 70}, {40, 70}, {40, 28}}, color = {0, 0, 127}));
  connect(PointFixedPressure.ports[1], pump.port_a) annotation (Line(
      points={{-78,20},{-54,20}},
      color={0,127,255}));
  connect(pipe.port_a, hea.port_b)
    annotation (Line(points={{4,20},{-2,20},{-6,20}}, color={0,127,255}));
  connect(pump.port_b, hea.port_a)
    annotation (Line(points={{-34,20},{-30,20},{-26,20}}, color={0,127,255}));
  connect(hea.TSet, Source_TempSet_Boiler.y) annotation (Line(points={{-28,28},
          {-32,28},{-32,70},{-21,70}}, color={0,0,127}));
  connect(AirTemp.port, radiator.ConvectiveHeat) annotation (Line(points={{112,64},
          {118,64},{118,22},{120.8,22}}, color={191,0,0}));
  connect(radiator.RadiativeHeat, RadTemp.port) annotation (Line(points={{127.4,
          22},{132,22},{132,64},{136,64}}, color={95,95,95}));
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{160,100}},
  preserveAspectRatio=false)),
  Icon(coordinateSystem(extent = {{-100, -100}, {160, 100}})),
  experiment(StopTime = 86400, Interval = 60),
  Documentation(info = "<html><p>
  This model contains a simple model of a heating system, with a pump,
  ideal heat source, pipes, simple valve and radiator. It serves as a
  demonstration case of how components of the <code>AixLib</code>
  library can be used.
</p>
<ul>
  <li>
    <i>April 25, 2017</i> by Peter Remmen:<br/>
    Move Example from <code>Fluid.HeatExchangers.Examples</code> to
    <code>Fluid.Examples</code>
  </li>
</ul>
<ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib and replaced boiler with idealHeater
  </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
</ul>
</html>"));
end PumpRadiatorValve;
