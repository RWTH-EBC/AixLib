within AixLib.Fluid.Solar.Thermal.Examples;
model SolarThermalCollector
  "Example to demonstrate the function of the solar thermal collector model"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  AixLib.Fluid.Sources.FixedBoundary
                      boundary_ph(h = 125823,
    nPorts=1,
    redeclare package Medium = Medium,
    p=101400)                                                               annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  AixLib.Fluid.Sources.FixedBoundary
                      boundary_ph1(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{100, -10}, {80, 10}})));
  AixLib.Fluid.Sensors.MassFlowRate
                         massFlowSensor(redeclare package Medium = Medium)
                                        annotation(Placement(transformation(extent = {{-54, -10}, {-34, 10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            T1(redeclare package Medium = Medium,
      m_flow_nominal=0.01)     annotation(Placement(transformation(extent = {{-28, -10}, {-8, 10}})));
  AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(
    A=2,
    Collector=AixLib.DataBase.SolarThermal.VacuumCollector(),
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            T2(redeclare package Medium = Medium,
      m_flow_nominal=0.01)     annotation(Placement(transformation(extent = {{28, -10}, {48, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,21,0; 3600,20.6,0; 7200,20.5,0; 10800,20.4,0; 14400,20,6; 18000,
        20.5,106; 21600,22.4,251; 25200,24.1,402; 28800,26.3,540; 32400,28.4,
        657; 36000,30,739; 39600,31.5,777; 43200,31.5,778; 46800,32.5,737;
        50400,32.5,657; 54000,32.5,544; 57600,32.5,407; 61200,32.5,257; 64800,
        31.6,60; 68400,30.8,5; 72000,22.9,0; 75600,21.2,0; 79200,20.6,0; 82800,
        20.3,0],
    offset={273.15,0.01})
    annotation (Placement(transformation(extent={{-26,62},{-6,82}})));
equation
  connect(massFlowSensor.port_b, T1.port_a) annotation(Line(points = {{-34, 0}, {-28, 0}}, color = {0, 127, 255}));
  connect(T1.port_b, solarThermal.port_a) annotation(Line(points = {{-8, 0}, {0, 0}}, color = {0, 127, 255}));
  connect(solarThermal.port_b, T2.port_a) annotation(Line(points = {{20, 0}, {28, 0}}, color = {0, 127, 255}));
  connect(T2.port_b, pipe.port_a) annotation(Line(points = {{48, 0}, {54, 0}}, color = {0, 127, 255}));
  connect(boundary_ph.ports[1], massFlowSensor.port_a) annotation (Line(
      points={{-60,0},{-54,0}},
      color={0,127,255}));
  connect(pipe.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{74,0},{80,0}},
      color={0,127,255}));
  connect(hotSummerDay.y[1], solarThermal.T_air) annotation (Line(points={{-5,
          72},{-5,72},{4,72},{4,10.8}}, color={0,0,127}));
  connect(hotSummerDay.y[2], solarThermal.Irradiation)
    annotation (Line(points={{-5,72},{11,72},{11,10.8}}, color={0,0,127}));
  annotation (experiment(StopTime = 82600, Interval = 3600), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>This test demonstrates the solar thermal collector model. Different types of collectors can be tested at fixed boundary conditions. To test the collectors at different fluid temperatures, adjust h at left boundary accordung to this table:</p>
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
 </html>", revisions="<html>
 <ul>
 <li><i>December 15, 2016</i> by Moritz Lauster:<br/>Moved</li>
 <li><i>October 11, 2016</i> by Marcus Fuchs:<br/>Replace pipe</li>
 <li><i>April 2016&nbsp;</i>
    by Peter Remmen:<br/>
    Replace TempAndRad model</li>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>November 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Implemented</li>
 </ul>
 </html>"));
end SolarThermalCollector;
