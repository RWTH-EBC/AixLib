within AixLib.Utilities.HeatTransfer;


model HeatConv
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha = 2;
  parameter Modelica.SIunits.Area A = 16;
equation
  // no storage of heat
  port_a.Q_flow = alpha * A * (port_a.T - port_b.T);
  annotation(Coordsys(extent = [-100, -100; 100, 100], grid = [2, 2], component = [20, 20]), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), Rectangle(extent = [-80, 60; 0, -100], style(color = 0, rgbcolor = {0, 0, 0}, pattern = 0, fillColor = 31, rgbfillColor = {211, 243, 255}, fillPattern = 1)) = {{-80, 70}, {80, -90}}, Rectangle(extent = [-80, 60; 80, -100], style(color = 0)), Rectangle(extent = [60, 60; 80, -100], style(pattern = 0, fillColor = 7, rgbfillColor = {244, 244, 244}, fillPattern = 1)), Rectangle(extent = [40, 60; 60, -100], style(pattern = 0, fillColor = 30, rgbfillColor = {207, 207, 207}, fillPattern = 1)), Rectangle(extent = [20, 60; 40, -100], style(pattern = 0, fillColor = 8, rgbfillColor = {182, 182, 182}, fillPattern = 1)), Rectangle(extent = [0, 60; 20, -100], style(pattern = 0, fillColor = 9, rgbfillColor = {156, 156, 156}, fillPattern = 1)), graphics, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {211, 243, 255}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, Rectangle(extent = [60, 70; 80, -90], lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244}, fillPattern = FillPattern.Solid), Rectangle(extent = [40, 70; 60, -90], lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 70}, {40, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182}, fillPattern = FillPattern.Solid), Rectangle(extent = {{0, 70}, {20, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156}, fillPattern = FillPattern.Solid)), Icon(Rectangle(extent = [-80, 60; 0, -100], style(pattern = 0, fillColor = 31, rgbfillColor = {211, 243, 255}, fillPattern = 1)), Rectangle(extent = [60, 60; 80, -100], style(pattern = 0, fillColor = 7, rgbfillColor = {244, 244, 244}, fillPattern = 1)), Rectangle(extent = [40, 60; 60, -100], style(pattern = 0, fillColor = 30, rgbfillColor = {207, 207, 207}, fillPattern = 1)), Rectangle(extent = [20, 60; 40, -100], style(pattern = 0, fillColor = 8, rgbfillColor = {182, 182, 182}, fillPattern = 1)), Rectangle(extent = [0, 60; 20, -100], style(pattern = 0, fillColor = 9, rgbfillColor = {156, 156, 156}, fillPattern = 1)), graphics={  Rectangle(extent = {{-76, 80}, {4, -80}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {211, 243, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-76, 80}, {84, -80}}, lineColor = {0, 0, 0}), Rectangle(extent = {{64, 80}, {84, -80}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{44, 80}, {64, -80}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{24, 80}, {44, -80}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{4, 80}, {24, -80}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                    FillPattern.Solid)}), Window(x = 0.25, y = 0.38, width = 0.6, height = 0.6), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>The <b>HeatConv</b> model represents the phenomenon of heat convection. No heat is stored.</p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <p><h4><font color=\"#008000\">Example Results</font></h4></p>
 <p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.HeatTransfer_test </a></p>
 </html>", revisions = "<html>
 <ul>
 <li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Added basic documentation and formatted appropriately</li>
 <li><i>October 22, 2014&nbsp;</i> by Marcus Fuchs:<br>Changed graphics section to be compliant with Modelica Specification</li>
 </ul>
 </html>"));
end HeatConv;
