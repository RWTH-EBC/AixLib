within AixLib.Utilities.HeatTransfer;
class CylindricLoad "Model for a cylindric heat capacity"
  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Density rho=1600 "Density of material";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=1000
    "Specific heat capacity of material";
  parameter Modelica.Units.SI.Length d_out(min=0) "outer diameter of pipe";
  parameter Modelica.Units.SI.Length d_in(min=0) "inner diameter of pipe";
  parameter Modelica.Units.SI.Length length(min=0) " Length of pipe";
  parameter Modelica.Units.SI.Temperature T0=289.15 "initial temperature";
  parameter Integer nParallel = 1 "Number of identical parallel pipes";
  final parameter Modelica.Units.SI.Mass m=nParallel*rho*length*Modelica.Constants.pi
      *(d_out*d_out - d_in*d_in)/4 "Mass of material";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port
    annotation (Placement(transformation(extent={{-12,-18},{8,2}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    final C=m*c,
    final T(
      stateSelect=StateSelect.always,
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T0),
    final der_T(
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-36,14},{34,84}})));

equation
  connect(heatCapacitor.port, port) annotation (Line(points={{-1,14},{10,14},{10,-8},{-2,-8}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-80,68},{80,-92}},
          lineColor={0,0,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.CrossDiag), Ellipse(
          extent={{-42,28},{38,-52}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.3,
      y=0.18,
      width=0.6,
      height=0.6),
    Documentation(revisions="<html><ul>
  <li>January 24, 2020 by Philipp Mehrfeld:<br/>
    <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/793\">#793</a>
    Switch to MSL capacity model and to Dynamics enumerator to control
    init and energy conversion during simulation.
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Transferred to AixLib
  </li>
  <li>
    <i>November 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>
",  info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <code>CylindricLoad</code> model represents a cylindric heat
  capacity, which is described by its area, density, thickness and
  material specific heat capacity.
</p>
</html>"));
end CylindricLoad;
