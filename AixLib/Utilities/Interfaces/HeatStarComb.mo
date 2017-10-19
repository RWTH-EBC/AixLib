within AixLib.Utilities.Interfaces;
connector HeatStarComb "Combines therm connector and star connector."
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm;
  AixLib.Utilities.Interfaces.Star Star;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 102}, {102, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-9, 86}, {17, 86}, {17, 12}, {81, 34}, {89, 6}, {26, -14}, {66, -72}, {41, -88}, {4, -28}, {-31, -88}, {-56, -72}, {-18, -14}, {-81, 6}, {-73, 34}, {-9, 12}, {-9, 86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 This connector makes a single connection for a combination of Radiation and Convection possible.
 </p>
 </html>
 ", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li>by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
end HeatStarComb;
