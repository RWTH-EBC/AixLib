within AixLib.Utilities.Interfaces;
connector SolarRad_out "Scalar total radiation connector (output)"
  output Modelica.SIunits.RadiantEnergyFluenceRate I;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent=  {{18, 58}, {-98, -58}}, lineColor=  {255, 128, 0}), Line(points=  {{-40, 62}, {-40, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{24, 0}, {78, 0}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{6, 44}, {46, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{20, 22}, {72, 40}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-14, 58}, {-2, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-14, -58}, {-2, -80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{8, -44}, {46, -80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{20, -22}, {74, -40}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-40, -80}, {-40, -62}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Rectangle(extent=  {{-100, 100}, {-60, -100}}, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Polygon(points=  {{-60, 6}, {-60, 28}, {-60, 28}, {-8, 0}, {-60, -26}, {-60, -26}, {-60, -6}, {-60, 6}}, lineColor=  {0, 0, 0}, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent=  {{18, 58}, {-98, -58}}, lineColor=  {255, 128, 0}), Line(points=  {{-40, 62}, {-40, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{24, 0}, {78, 0}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{6, 44}, {46, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{20, 22}, {72, 40}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-14, 58}, {-2, 80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-14, -58}, {-2, -80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{8, -44}, {46, -80}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{20, -22}, {74, -40}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Line(points=  {{-40, -80}, {-40, -62}}, color=  {255, 128, 0}, smooth=  Smooth.Bezier), Rectangle(extent=  {{-100, 100}, {-60, -100}}, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Polygon(points=  {{-60, 6}, {-60, 28}, {-60, 28}, {-8, 0}, {-60, -26}, {-60, -26}, {-60, -6}, {-60, 6}}, lineColor=  {0, 0, 0}, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The <b>SolarRad_out</b> connector is used for total radiation output. Is explicitly defined as an output.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/> </p>
 </html>", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
 </ul>
 </html>"));
end SolarRad_out;

