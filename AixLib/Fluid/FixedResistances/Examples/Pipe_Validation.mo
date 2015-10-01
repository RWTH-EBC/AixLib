within AixLib.Fluid.FixedResistances.Examples;
model Pipe_Validation
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  Pipe pipe(
    l=10,
    D=0.02412,
    e=0.03135,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph(use_p_in = false,
    redeclare package Medium = Medium,
    nPorts=1,
    p=110000)                                                annotation(Placement(transformation(extent={{-80,-10},
            {-60,10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = false,
    redeclare package Medium = Medium,
    nPorts=1)                                        annotation(Placement(transformation(extent={{80,-10},
            {60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-38, 20}, {-18, 40}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1000, duration = 1000, startTime = 200) annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
  Fluid.Sensors.TemperatureTwoPort Tin(redeclare package Medium = Medium,
      m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Fluid.Sensors.TemperatureTwoPort Tout(redeclare package Medium = Medium,
      m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
equation
  connect(prescribedHeatFlow.port, pipe.heatport) annotation(Line(points = {{-18, 30}, {0, 30}, {0, 5}}, color = {191, 0, 0}));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-59, 30}, {-38, 30}}, color = {0, 0, 127}));
  connect(boundary_ph.ports[1], Tin.port_a) annotation (Line(
      points={{-60,0},{-44,0}},
      color={0,127,255}));
  connect(Tin.port_b, pipe.port_a) annotation (Line(
      points={{-24,0},{-10,0}},
      color={0,127,255}));
  connect(pipe.port_b, Tout.port_a) annotation (Line(
      points={{10,0},{26,0}},
      color={0,127,255}));
  connect(Tout.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{46,0},{60,0}},
      color={0,127,255}));
  annotation( experiment(StopTime = 1500, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Simple example of the pipe connected to two boundaries and a heat source.</p>
 <p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
 <p>The boundaries have different pressures resulting in a mass flow in the pipe. The pipe is connected to a heat source with variable heat flow. The change in internal energy and the temperature of the pipe can be observed.</p>
 </html>"));
end Pipe_Validation;
