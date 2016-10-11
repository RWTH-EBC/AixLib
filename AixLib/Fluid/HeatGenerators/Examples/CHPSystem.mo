within AixLib.Fluid.HeatGenerators.Examples;
model CHPSystem
  extends Modelica.Icons.Example;
  CHP cHP(
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    m_flow_nominal=0.02,
    TSet_in=true,
    MinCapacity=20,
    DelayTime=300,
    param=DataBase.CHP.CHP_FMB_65_GSK())
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    use_T_in=true,
    nPorts=1,
    m_flow=0.5)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=7200,
    width=7200,
    falling=7200,
    period=28800,
    offset=313.15,
    amplitude=50,
    startTime=7200)
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Blocks.Sources.BooleanConstant On
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.Constant TSet(k=80 + 273.15)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(source.ports[1], cHP.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(cHP.port_b, sink.ports[1])
    annotation (Line(points={{10,0},{26,0},{40,0}}, color={0,127,255}));
  connect(trapezoid.y, source.T_in)
    annotation (Line(points={{-79,4},{-62,4}}, color={0,0,127}));
  connect(On.y, cHP.ON)
    annotation (Line(points={{-19,-30},{3,-30},{3,-9}}, color={255,0,255}));
  connect(TSet.y, cHP.TSet) annotation (Line(points={{-19,30},{-14,30},{-14,-6},
          {-7,-6}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The simulation illustrates the behavior of <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">CHP</a> in diferent conditions. 
Inlet and outlet temperature as well as the electrical and thermal power of the CHP can be observed.
Change the inlet water temperature profile to see the reaction timing. </p>
</html>",
        revisions="<html>
<p><ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with AixLib</li>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated documentation.</li>
<li>by Pooyan Jahangiri:<br>First implementation.</li>
</ul></p>
</html>"),
experiment(StopTime=35000, Interval=60));
end CHPSystem;
