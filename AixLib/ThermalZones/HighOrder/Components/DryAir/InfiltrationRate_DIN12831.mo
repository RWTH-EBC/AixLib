within AixLib.ThermalZones.HighOrder.Components.DryAir;
model InfiltrationRate_DIN12831
  "Heat flow caused by infiltration after european standard DIN EN 12831"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.SIunits.Volume room_V = 50 "Volume of the room";
  parameter Real n50(unit = "h-1") = 4
    "Air exchange rate at 50 Pa pressure difference";
  parameter Real e = 0.03 "Coefficient of windshield";
  parameter Real eps = 1.0 "Coefficient of height";
  parameter Modelica.SIunits.SpecificHeatCapacity c = 1000
    "Specific heat capacity of air";
  parameter Modelica.SIunits.Density rho = 1.25 "Air density";
protected
  parameter Real InfiltrationRate = 2 * n50 * e * eps;
equation
  port_a.Q_flow = InfiltrationRate * room_V * c * rho * (port_a.T - port_b.T) / 3600;
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-30, -12}, {30, -78}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air"), Text(extent = {{-76, 26}, {78, -8}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "DIN 12381")}), Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The<b> InfiltrationRate</b> model describes heat and mass transport by infiltration. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>Air exchange coefficients at 50 Pa pressure difference between ambience and room air: </p>
<table summary=\"coefficients\" cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Dwelling type</h4></td>
<td><p align=\"center\"><h4>highly air tight</h4></td>
<td><p align=\"center\"><h4>medium air tight</h4></td>
<td><p align=\"center\"><h4>low air tight</h4></td>
</tr>
<tr>
<td><p>one-family dwelling</p></td>
<td><p>&lt; 4</p></td>
<td><p>4 - 10</p></td>
<td><p>&gt; 10</p></td>
</tr>
<tr>
<td><p>multi-family dwelling/other</p></td>
<td><p>&lt; 2</p></td>
<td><p>2 - 5</p></td>
<td><p>&gt; 5</p></td>
</tr>
</table>
<p><br/><br/>Reference values for air shielding value e: </p>
<table summary=\"Reference\" cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td></td>
<td><p align=\"center\"><h4>heated room without </h4><p align=\"center\">facade with openings</p><p align=\"center\">exposed to wind</p></td>
<td><p align=\"center\"><h4>heated room with</h4><p align=\"center\">one facade with openings</p><p align=\"center\">exposed to wind</p></td>
<td><p align=\"center\"><h4>heated room with more than</h4><p align=\"center\">one facade with openings</p><p align=\"center\">exposed to wind</p></td>
</tr>
<tr>
<td><p>no shielding</p></td>
<td><p>0</p></td>
<td><p>0.03</p></td>
<td><p>0.05</p></td>
</tr>
<tr>
<td><p>moderate shielding</p></td>
<td><p>0</p></td>
<td><p>0.02</p></td>
<td><p>0.03</p></td>
</tr>
<tr>
<td><p>well shielded</p></td>
<td><p>0</p></td>
<td><p>0.01</p></td>
<td><p>0.02</p></td>
</tr>
</table>
<p><br/><br/>Reference values for height correction value &epsilon;: </p>
<table summary=\"Reference\" cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><h4>Height of room</h4></td>
<td><p align=\"center\"><br/><b>&epsilon;</b></p></td>
</tr>
<tr>
<td><p>0 - 10 m</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>10 - 30 m</p></td>
<td><p>1.2</p></td>
</tr>
<tr>
<td><p>&gt; 30 m</p></td>
<td><p>1.5</p></td>
</tr>
</table>
<p><br/><br/><b><font style=\"color: #008000; \">References</font></b> </p>
<p>DIN EN 12831 </p>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
</html>",  revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>August 2, 2011&nbsp;</i>
          by Ana Constantin:<br/>
          Implemented after a model from Time Haase.</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-30, 16}, {30, -50}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}));
end InfiltrationRate_DIN12831;
