within AixLib.Fluid.HeatGenerators.Examples;
model HeatGeneratorNoControllSystem
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    use_T_in=true,
    nPorts=1,
    m_flow=0.03)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity, nPorts=1)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  HeatGeneratorNoControl heatGeneratorNoControll(redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity, m_flow_nominal=
        0.03) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=7200,
    width=7200,
    falling=7200,
    period=28800,
    offset=313.15,
    amplitude=50,
    startTime=7200)
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Blocks.Sources.Constant const(k=5000)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
equation
  connect(source.ports[1], heatGeneratorNoControll.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(heatGeneratorNoControll.port_b, sink.ports[1])
    annotation (Line(points={{10,0},{25,0},{40,0}}, color={0,127,255}));
  connect(trapezoid.y, source.T_in)
    annotation (Line(points={{-79,4},{-79,4},{-62,4}}, color={0,0,127}));
  connect(const.y, heatGeneratorNoControll.Q_flow) annotation (Line(points={{-39,
          40},{-24,40},{-24,6},{-8,6}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The simulation illustrates the functionality of a simple heat generator in
<a href=\"HVAC.Components.HeatGenerators.HeatGeneratorNoControll\">HeatGeneratorNoControll</a> 
in order to test the functionality of the <a href=\"HVAC.Components.HeatGenerators.BaseClasses.PartialHeatGenerator\">PartialHeatGenerator</a>. </p>
</html>",
        revisions="<html>
<p><ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>First implementation</li>
</ul></p>
</html>"),
experiment(StopTime=3600, Interval=1));
end HeatGeneratorNoControllSystem;
