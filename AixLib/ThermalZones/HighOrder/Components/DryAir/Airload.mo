within AixLib.ThermalZones.HighOrder.Components.DryAir;
model Airload "Air volume"
  parameter Modelica.SIunits.Density rho = 1.19 "Density of air";
  parameter Modelica.SIunits.SpecificHeatCapacity c = 1007
    "Specific heat capacity of air";
  parameter Modelica.SIunits.Volume V = 48.0 "Volume of the room";
  Modelica.SIunits.Temperature T(start=293.15, nominal=293.15,
        min=278.15, max=323.15, displayUnit="degC") "Temperature of airload";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port annotation(Placement(transformation(extent = {{-104, -24}, {-76, 4}}), iconTransformation(extent = {{-100, -30}, {-80, -10}})));
protected
  parameter Modelica.SIunits.Mass m = rho * V;
equation
  T = port.T;
  m * c * der(T) = port.Q_flow;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-28, 14}, {32, -52}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-30, 16}, {30, -50}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}), Documentation(revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>Airload</b> model represents a heat capacity consisting of air. It is described by its volume, density and specific heat capacity. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
 </html>"));
end Airload;
