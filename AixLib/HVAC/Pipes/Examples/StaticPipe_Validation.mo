within AixLib.HVAC.Pipes.Examples;
model StaticPipe_Validation
  extends Modelica.Icons.Example;
  StaticPipe
       pipe(
    l=10,
    D=0.02412,
    e=0.03135)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner BaseParameters     baseParameters
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Sources.Boundary_ph boundary_ph(use_p_in=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Sources.Boundary_ph boundary_ph1(use_p_in=false)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1000,
    offset=1.2e5,
    height=6e6)
    annotation (Placement(transformation(extent={{-100,-4},{-80,16}})));
equation
  connect(boundary_ph.port_a, pipe.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_ph1.port_a, pipe.port_b) annotation (Line(
      points={{40,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp.y, boundary_ph.p_in) annotation (Line(
      points={{-79,6},{-62,6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
      info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simple example of the static pipe connected to two boundaries.</p>
<p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
<p>The first boundary has a changing pressure and the second boundary has a fixed pressure. This results in changing of the mass flow and pressure drop in the pipe which can be observed in the results.</p>
</html>"));
end StaticPipe_Validation;
