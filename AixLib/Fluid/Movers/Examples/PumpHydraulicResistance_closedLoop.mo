within AixLib.Fluid.Movers.Examples;
model PumpHydraulicResistance_closedLoop
  "Example with pump, hydraulic resistance and pipes in a closed loop"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium = AixLib.Media.Water;
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump pump(
    V_flow(fixed=false),
    MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
    V_flow_max=2,
    ControlStrategy=2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(zeta = 2,
    redeclare package Medium = Medium,
    diameter=0.05,
    m_flow_nominal=0.001)                                                annotation(Placement(transformation(extent = {{26, 20}, {46, 40}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-4,20},{16,40}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-12,-20},{-32,0}})));
  Modelica.Blocks.Sources.BooleanPulse NightSignal(period = 86400) annotation(Placement(transformation(extent = {{-60, 60}, {-40, 80}})));
  AixLib.Fluid.Sources.Boundary_pT
                     PointFixedPressure(nPorts=1, redeclare package Medium =
        Medium)                                           annotation(Placement(transformation(extent = {{-100, 20}, {-80, 40}})));
equation
  connect(pump.port_b, pipe.port_a) annotation(Line(points = {{-20, 30}, {-4, 30}}, color = {0, 127, 255}));
  connect(pipe.port_b, hydraulicResistance.port_a) annotation(Line(points = {{16, 30}, {26, 30}}, color = {0, 127, 255}));
  connect(hydraulicResistance.port_b, pipe1.port_a) annotation(Line(points = {{46, 30}, {66, 30}, {66, -10}, {-12, -10}}, color = {0, 127, 255}));
  connect(pipe1.port_b, pump.port_a) annotation(Line(points = {{-32, -10}, {-62, -10}, {-62, 30}, {-40, 30}}, color = {0, 127, 255}));
  connect(NightSignal.y, pump.IsNight) annotation(Line(points = {{-39, 70}, {-30, 70}, {-30, 40.2}}, color = {255, 0, 255}));
  connect(PointFixedPressure.ports[1], pump.port_a) annotation (Line(
      points={{-80,30},{-40,30}},
      color={0,127,255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics={  Text(extent = {{-124, 74}, {-62, 44}}, lineColor = {0, 0, 255}, textString = "Always have
 a point of fixed pressure
 before a pump
 when building a closed loop")}), experiment(StopTime = 86400, Interval = 60),
 Documentation(revisions="<html><ul>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe and change medium
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>01.11.2013&#160;</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple example with a pump, a hydraulic resistance, two pipes in a
  loop.
</p>
<p>
  <br/>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  Always have a point of fixed pressure before the pump in order to be
  able to solve the equation for the closed loop.
</p>
<p>
  With different control strategies for the pump, you have different
  dependecies of the head from the volume flow. For visualisation plot
  the head as a function of the volume flow.
</p>
</html>"));
end PumpHydraulicResistance_closedLoop;
