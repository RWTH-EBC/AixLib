within AixLib.Fluid.BoilerCHP.Examples;
model BoilerNoControlSystem
  "Example that illustrates use of boiler model without control"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    m_flow=0.05,
    T=293.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    length=1,
    diameter=0.025,
    redeclare package Medium = Medium)
    "Pressure drop"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient,
    p_ambient(displayUnit="Pa"))
    "Pressure drop"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=3600,
    offset=0,
    startTime=1200)
    "Ambient air temperature"
    annotation (Placement(transformation(extent={{-60,62},{-40,82}})));

  BoilerNoControl boilerNoControl(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_18kW(),
    G=100)
    annotation (Placement(transformation(extent={{-24,-14},{2,14}})));
equation
  connect(pipe.port_b, sink.ports[1])
    annotation (Line(points={{50,0},{50,0},{60,0}}, color={0,127,255}));
  connect(source.ports[1], boilerNoControl.port_a)
    annotation (Line(points={{-40,0},{-34,0},{-34,1.77636e-15},{-24,1.77636e-15}},
                                               color={0,127,255}));
  connect(boilerNoControl.port_b, pipe.port_a)
    annotation (Line(points={{2,1.77636e-15},{18,1.77636e-15},{18,0},{30,0}},
                                            color={0,127,255}));
  connect(boilerNoControl.u_rel, ramp.y) annotation (Line(points={{-20.1,9.8},{
          -19.8,9.8},{-19.8,72},{-39,72}},
                                  color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The simulation illustrates the behavior of <a href=\"AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a> during a day.
Flow temperature of the boiler can be compared to the heating curve produced by
the internal controler of the boiler.
Change the inlet water temperature, heat curve or day and night mode to see the
reaction. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
 AixLib</li>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated
documentation.</li>
<li>by Pooyan Jahangiri:<br/>First implementation.</li>
</ul>
</html>"),
    experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
end BoilerNoControlSystem;
