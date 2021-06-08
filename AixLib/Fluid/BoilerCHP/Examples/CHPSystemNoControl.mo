within AixLib.Fluid.BoilerCHP.Examples;
model CHPSystemNoControl "Example that illustrates use of CHPNoControl model"
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  CHPNoControl
      combinedHeatPower(
    redeclare package Medium = Medium,
    m_flow_nominal=0.02,
    param=DataBase.CHP.CHPDataSimple.CHP_FMB_65_GSK()) "CHP"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1,
    m_flow=0.5)
    "Source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    nPorts=1, redeclare package Medium = Medium)
    "Sink"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=7200,
    width=7200,
    falling=7200,
    period=28800,
    offset=313.15,
    amplitude=50,
    startTime=7200)
    "Source temperature"
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Blocks.Sources.Ramp     TSet(duration=200, startTime=10)
    "Set temperature"
    annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));

equation
  connect(source.ports[1],combinedHeatPower. port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(combinedHeatPower.port_b, sink.ports[1])
    annotation (Line(points={{10,0},{26,0},{40,0}}, color={0,127,255}));
  connect(trapezoid.y, source.T_in)
    annotation (Line(points={{-79,4},{-62,4}}, color={0,0,127}));
  connect(TSet.y, combinedHeatPower.u_rel) annotation (Line(points={{-19,-28},{
          -16,-28},{-16,-6},{-7,-6}},
                                 color={0,0,127}));
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The simulation illustrates the behavior of <a href=
  \"AixLib.Fluid.BoilerCHP.CHPNoControl\">AixLib.Fluid.BoilerCHP.CHPNoControl</a> in
  different conditions. Inlet and outlet temperature as well as the
  electrical and thermal power of the CHP can be observed.
</p>
</html>",
        revisions="<html><ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"),
experiment(Tolerance=1e-6, StopTime=300, Interval=60),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/BoilerCHP/Examples/CHPSystemNoControl.mos"
        "Simulate and Plot"));
end CHPSystemNoControl;
