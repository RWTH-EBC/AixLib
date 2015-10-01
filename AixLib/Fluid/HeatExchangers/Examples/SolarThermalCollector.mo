within AixLib.Fluid.HeatExchangers.Examples;
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
  AixLib.Fluid.HeatExchangers.SolarThermal solarThermal(
    A=2,
    Collector=AixLib.DataBase.SolarThermal.VacuumCollector(),
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  AixLib.Fluid.Sources.TempAndRad tempAndRad(temperatureOT=
        AixLib.DataBase.Weather.SummerDay()) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,86})));
  Fluid.FixedResistances.StaticPipe pipe(l = 100,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)           annotation(Placement(transformation(extent = {{54, -10}, {74, 10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            T2(redeclare package Medium = Medium,
      m_flow_nominal=0.01)     annotation(Placement(transformation(extent = {{28, -10}, {48, 10}})));
equation
  connect(massFlowSensor.port_b, T1.port_a) annotation(Line(points = {{-34, 0}, {-28, 0}}, color = {0, 127, 255}));
  connect(T1.port_b, solarThermal.port_a) annotation(Line(points = {{-8, 0}, {0, 0}}, color = {0, 127, 255}));
  connect(solarThermal.port_b, T2.port_a) annotation(Line(points = {{20, 0}, {28, 0}}, color = {0, 127, 255}));
  connect(T2.port_b, pipe.port_a) annotation(Line(points = {{48, 0}, {54, 0}}, color = {0, 127, 255}));
  connect(tempAndRad.Rad, solarThermal.Irradiation) annotation(Line(points = {{12, 75.4}, {12, 10.8}, {11, 10.8}}, color = {0, 0, 127}));
  connect(tempAndRad.T_out, solarThermal.T_air) annotation(Line(points={{4,75.4},
          {4,10.8}},                                                                                        color = {0, 0, 127}));
  connect(boundary_ph.ports[1], massFlowSensor.port_a) annotation (Line(
      points={{-60,0},{-54,0}},
      color={0,127,255}));
  connect(pipe.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{74,0},{80,0}},
      color={0,127,255}));
  annotation( experiment(StopTime = 82600, Interval = 3600), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
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
 </html>", revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>26.11.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end SolarThermalCollector;
