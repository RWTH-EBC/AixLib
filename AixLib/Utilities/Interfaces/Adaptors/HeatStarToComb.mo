within AixLib.Utilities.Interfaces.Adaptors;
model HeatStarToComb
  AixLib.Utilities.Interfaces.HeatStarComb thermStarComb annotation(Placement(transformation(extent = {{-120, -10}, {-76, 36}}), iconTransformation(extent = {{-116, -24}, {-72, 22}})));
  AixLib.Utilities.Interfaces.Star star annotation(Placement(transformation(extent = {{84, 38}, {124, 78}}), iconTransformation(extent = {{84, 38}, {124, 78}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a therm annotation(Placement(transformation(extent = {{84, -68}, {118, -34}}), iconTransformation(extent = {{84, -68}, {118, -34}})));
equation
  connect(thermStarComb.Star, star);
  connect(thermStarComb.Therm, therm);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -80}, {100, 80}}), graphics={  Polygon(points = {{-76, 0}, {86, -72}, {86, 70}, {-76, 0}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This adaptor makes it possible to connect HeatStarComb with either Star or Heat connector or both. </p>
 </html>", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li>by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
end HeatStarToComb;
