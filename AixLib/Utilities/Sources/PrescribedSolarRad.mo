within AixLib.Utilities.Sources;
model PrescribedSolarRad "variable radiation condition"
  parameter Integer n = 1 "number of output vector length";
  AixLib.Utilities.Interfaces.SolarRad_out solarRad_out[n] annotation(Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u[n] "radiation on surface (W/m2)" annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate I[n] = fill(0, n)
    "fixed radiation if u is not connected"                                                                     annotation(Diagram(graphics));
equation
  if cardinality(u) < 1 then
    u[:] = fill(0, n);
    solarRad_out[:].I = I[:];
  else
    solarRad_out[:].I = u[:] "Radiant energy fluence rate";
  end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points=  {{0, 80}, {0, -80}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Line(points=  {{80, 0}, {-80, 0}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Line(points=  {{-68, 42}, {68, -42}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Line(points=  {{-38, 70}, {38, -70}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Line(points=  {{-68, -42}, {68, 42}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Line(points=  {{-40, -70}, {40, 70}}, color=  {255, 170, 85}, pattern=  LinePattern.Dot, thickness=  0.5), Ellipse(extent=  {{-60, 60}, {60, -60}}, lineColor=  {0, 0, 0}, pattern=  LinePattern.None, fillPattern=  FillPattern.Sphere, fillColor=  {255, 255, 0})}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li><i>October 23, 2006&nbsp;</i> by Peter Matthes:<br/>Implemented.</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The VarRad Model is a source model to represent a varying radiation source.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Assumption</span></h4>
 <p>If nothing is specified through the input port solar radiation of 0 W/m2 is assumed by default. </p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end PrescribedSolarRad;
