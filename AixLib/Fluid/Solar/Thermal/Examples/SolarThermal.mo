within AixLib.Fluid.Solar.Thermal.Examples;
model SolarThermal
  "Example to demonstrate the function of the solar thermal collector model"
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.Solar.Thermal.Examples.BaseClasses.PartialExample(sin(
        nPorts=1), sou(nPorts=1),
        m_flow_nominal=1.5*solThe.A/60*995/1000,
        dp_nominal=solThe.pressureDropCoeff*(m_flow_nominal/995)^2);

  AixLib.Fluid.Solar.Thermal.SolarThermal solThe(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    A=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    volPip=0.05,
    p_start=sou.p,
    redeclare AixLib.DataBase.SolarThermal.FlatCollector parCol)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(hotSumDay.y[1], solThe.TAir)
    annotation (Line(points={{-19,50},{-6,50},{-6,10}}, color={0,0,127}));
  connect(solThe.Irr, hotSumDay.y[2])
    annotation (Line(points={{0,10},{0,50},{-19,50}}, color={0,0,127}));
  connect(solThe.port_b, sin.ports[1])
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(sou.ports[1], solThe.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  annotation (
    experiment(StopTime=86400, Interval=3600),
    Documentation(info="<html>
<p>
  This test demonstrates the solar thermal collector model. Different
  types of collectors can be tested at fixed boundary conditions.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    Renamed and use partial example. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
<ul>
  <li>
    <i>January 7, 2018</i> by Peter Matthes:<br/>
    Removes m_flow_nominal parameter.<br/>
    Add Modelica.Fluid.System to example.<br/>
    Set proper volume flow rate (3 l/min).<br/>
    Calculate source pressure depending on volume flow rate and pipe
    pressure loss.<br/>
    Set start values in most components.<br/>
    Add plot script and simulation command.
  </li>
  <li>
    <i>October 25, 2017</i> by Philipp Mehrfeld:<br/>
    Use <a href=\"modelica://AixLib.Media.Water\">AixLib.Media.Water</a>
  </li>
  <li>
    <i>December 15, 2016</i> by Moritz Lauster:<br/>
    Moved
  </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
  <li>
    <i>April 2016&#160;</i> by Peter Remmen:<br/>
    Replace TempAndRad model
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>November 2013&#160;</i> by Marcus Fuchs:<br/>
    Implemented
  </li>
</ul></ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Fluid/Solar/Thermal/Examples/SolarThermal.mos" "Simulate and plot"));
end SolarThermal;
