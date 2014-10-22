within AixLib.HVAC.Ductwork.Examples;
model DuctPressureLoss "Example for Duct"
  import Anlagensimulation_WS1314 = AixLib.HVAC;
extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in=false, p=
        100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,20})));
  inner Anlagensimulation_WS1314.BaseParameters
                            baseParameters
    annotation (Placement(transformation(extent={{60,66},{80,86}})));
 Modelica.Blocks.Sources.Ramp ramp(
   duration=100,
    startTime=50,
    offset=1.005e5,
    height=40000)
   annotation (Placement(transformation(extent={{-52,-58},{-32,-38}})));
 Modelica.Blocks.Sources.Ramp ramp1(
    offset=0,
    startTime=150,
    height=-5000,
    duration=2)
   annotation (Placement(transformation(extent={{-52,-88},{-32,-68}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-4,-72},{16,-52}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in=true, p=99900)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,20})));
  Anlagensimulation_WS1314.Ductwork.Duct duct
    annotation (Placement(transformation(extent={{-12,16},{8,24}})));
equation

  connect(ramp.y, add.u1) annotation (Line(
      points={{-31,-48},{-24,-48},{-24,-56},{-6,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, add.u2) annotation (Line(
      points={{-31,-78},{-23.5,-78},{-23.5,-68},{-6,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundaryMoistAir_phX2.p_in, add.y) annotation (Line(
      points={{-54,28},{-92,28},{-92,-32},{60,-32},{60,-62},{17,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundaryMoistAir_phX2.portMoistAir_a, duct.portMoistAir_a)
    annotation (Line(
      points={{-32,20},{-12,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(duct.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
    annotation (Line(
      points={{8,20},{36,20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics),
   Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example which shows the use of the duct model</p>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end DuctPressureLoss;
