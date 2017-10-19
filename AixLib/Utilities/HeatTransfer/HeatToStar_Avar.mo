within AixLib.Utilities.HeatTransfer;
model HeatToStar_Avar
  "Adaptor for approximative longwave radiation exchange with variable surface Area"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation(Placement(transformation(extent = {{-102, -10}, {-82, 10}})));
  Modelica.Blocks.Interfaces.RealInput A "Area of radiation exchange" annotation(Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";
  AixLib.Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{81, -10}, {101, 10}})));
equation
  Therm.Q_flow + Star.Q_flow = 0;
  Therm.Q_flow = Modelica.Constants.sigma * eps * A * (Therm.T * Therm.T * Therm.T * Therm.T - Star.T * Star.T * Star.T * Star.T);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"Interfaces.Star\">Star</a></b> connector. To model longwave radiation exchange of surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector to the outmost layer of the surface and connect the <b><a href=\"Interfaces.Star\">Star</a></b> connector to the <b><a href=\"Interfaces.Star\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &quot;two star&quot; room model. </p>
 </html>", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li><i>June 21, 2007&nbsp;</i> by Peter Mattes:<br/>Extended model based on TwoStar_RadEx.</li>
 </ul>
 </html>"));
end HeatToStar_Avar;
