within AixLib.Fluid.FixedResistances.Examples;
model StaticPipe_Validation
  extends Modelica.Icons.Example;
  replaceable package Medium =
      Modelica.Media.Water.StandardWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  StaticPipe pipe(
    l=10,
    D=0.02412,
    e=0.03135,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph(use_p_in = true, nPorts=1,
    redeclare package Medium = Medium)             annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = false, nPorts=1,
    redeclare package Medium = Medium)               annotation(Placement(transformation(extent = {{60, -10}, {40, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000, offset = 1.2e5, height = 6e6) annotation(Placement(transformation(extent = {{-100, -4}, {-80, 16}})));
equation
  connect(ramp.y, boundary_ph.p_in) annotation(Line(points={{-79,6},{-62,8}},      color = {0, 0, 127}));
  connect(boundary_ph.ports[1], pipe.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255}));
  connect(pipe.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{10,0},{40,0}},
      color={0,127,255}));
  annotation (experiment(StopTime = 1000, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(revisions="<html>
 Will be removed </html>"));
end StaticPipe_Validation;
