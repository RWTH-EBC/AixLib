within AixLib.ThermalZones.HighOrder.Components.DryAir;
model Airload "Air volume"

  extends Modelica.Thermal.HeatTransfer.Components.HeatCapacitor(final C=rho*V*c,
    final T(
      stateSelect=StateSelect.always,
      fixed=(initDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T0),
    final der_T(
      fixed=(initDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0));

  parameter Modelica.Fluid.Types.Dynamics initDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Like energyDynamics, but SteadyState leeds to same behavior as DynamicFreeInitial"
    annotation(Evaluate=true, Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T0 "initial temperature"
    annotation (Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.Density rho=1.19 "Density of air";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=1007
    "Specific heat capacity of air";
  parameter Modelica.Units.SI.Volume V "Volume of the room";

equation

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={                                                                                                                                          Rectangle(extent={{-100,100},{100,-100}},   lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-28,34},{32,-32}},      lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={                                                                      Rectangle(extent={{-100,76},{100,-100}},    lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-28,34},{32,-32}},      lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}), Documentation(revisions = "<html><ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>Airload</b> model represents a heat capacity consisting of
  air. It is described by its volume, density and specific heat
  capacity.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a>
</p>
</html>"));
end Airload;
