within AixLib.Utilities.HeatTransfer;
model SolarRadToHeat "Compute the heat flow caused by radiation on a surface"
  parameter Real coeff = 0.6 "Weight coefficient";
  // parameter Modelica.SIunits.Area A=6 "Area of surface";
  parameter Real A(min=0) "Area of surface";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(transformation(extent = {{80, -30}, {100, -10}})));
  AixLib.Utilities.Interfaces.SolarRad_in solarRad_in annotation(Placement(transformation(extent = {{-122, -40}, {-80, 0}})));
equation
  heatPort.Q_flow = -solarRad_in.I * A * coeff;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-48, 2}, {-4, -42}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "I"), Text(extent = {{4, 0}, {56, -44}}, lineColor = {0, 0, 0}, textString = "J"), Polygon(points = {{-12, -24}, {-12, -16}, {10, -16}, {10, -10}, {22, -20}, {10, -30}, {10, -24}, {-12, -24}}, lineColor = {0, 0, 0})}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 0}, {-14, -44}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "I"), Text(extent = {{0, -2}, {52, -46}}, lineColor = {0, 0, 0}, textString = "J"), Polygon(points = {{-22, -24}, {-22, -16}, {0, -16}, {0, -10}, {12, -20}, {0, -30}, {0, -24}, {-22, -24}}, lineColor = {0, 0, 0}), Text(extent = {{-100, 100}, {100, 60}}, lineColor = {0, 0, 255}, textString = "%name")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 The <b>RadCondAdapt</b> model computes a heat flow rate caused by the absorbance of radiation. The amount of radiation being transformed into a heat flow is controlled by a given coefficient.
 </p>
 </html>
 ", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 </ul>
 </html>"));
end SolarRadToHeat;
