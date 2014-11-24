within AixLib.HVAC.Pipes.Examples;
model StaticPipe_Validation
  extends Modelica.Icons.Example;
  replaceable package Medium =
      Modelica.Media.Water.StandardWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  StaticPipe pipe(l = 10, D = 0.02412, e = 0.03135,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                              annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph(use_p_in = true, nPorts=1,
    redeclare package Medium = Medium)             annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = false, nPorts=1,
    redeclare package Medium = Medium)               annotation(Placement(transformation(extent = {{60, -10}, {40, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000, offset = 1.2e5, height = 6e6) annotation(Placement(transformation(extent = {{-100, -4}, {-80, 16}})));
equation
  connect(ramp.y, boundary_ph.p_in) annotation(Line(points={{-79,6},{-62,8}},      color = {0, 0, 127}, smooth = Smooth.None));
  connect(boundary_ph.ports[1], pipe.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{10,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics), experiment(StopTime = 1000, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Simple example of the static pipe connected to two boundaries.</p>
 <p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
 <p>The first boundary has a changing pressure and the second boundary has a fixed pressure. This results in changing of the mass flow and pressure drop in the pipe which can be observed in the results.</p>
 </html>"));
end StaticPipe_Validation;

