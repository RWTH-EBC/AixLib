within AixLib.Utilities.HeatTransfer;
model HeatConv
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon
    "Convection heat transfer coeffient";
  parameter Modelica.Units.SI.Area A(min=0);
equation
  // no storage of heat
  port_a.Q_flow =hCon*A*(port_a.T - port_b.T);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,   extent={{-100,
            -100},{100,100}}),                                                                                                    Rectangle(extent = [-80, 60; 0, -100], style(rgbcolor = {0, 0, 0}, pattern = 0, fillColor = 31, rgbfillColor = {211, 243, 255}, fillPattern = 1)), Rectangle(extent = [-80, 60; 80, -100], style),   Rectangle(extent = [60, 60; 80, -100], style(pattern = 0, fillColor = 7, rgbfillColor = {244, 244, 244}, fillPattern = 1)), Rectangle(extent = [40, 60; 60, -100], style(pattern = 0, fillColor = 30, rgbfillColor = {207, 207, 207}, fillPattern = 1)), Rectangle(extent = [20, 60; 40, -100], style(pattern = 0, fillColor = 8, rgbfillColor = {182, 182, 182}, fillPattern = 1)), Rectangle(extent = [0, 60; 20, -100], style(pattern = 0, fillColor = 9, rgbfillColor = {156, 156, 156}, fillPattern = 1)), graphics, lineColor = {0, 0, 0}, pattern = LinePattern.Solid, fillColor = {211, 243, 255}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, Rectangle(extent = [60, 70; 80, -90], lineColor = {0, 0, 255}, pattern = LinePattern.Solid, fillColor = {244, 244, 244}, fillPattern = FillPattern.Solid), Rectangle(extent = [40, 70; 60, -90], lineColor = {0, 0, 255}, pattern = LinePattern.Solid, fillColor = {207, 207, 207}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 70}, {40, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.Solid, fillColor = {182, 182, 182}, fillPattern = FillPattern.Solid), Rectangle(extent = {{0, 70}, {20, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.Solid, fillColor = {156, 156, 156}, fillPattern = FillPattern.Solid)), Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),                                                                                                    Rectangle(extent = [-80, 60; 0, -100], style(pattern = 0, fillColor = 31, rgbfillColor = {211, 243, 255}, fillPattern = 1)), Rectangle(extent = [60, 60; 80, -100], style(pattern = 0, fillColor = 7, rgbfillColor = {244, 244, 244}, fillPattern = 1)), Rectangle(extent = [40, 60; 60, -100], style(pattern = 0, fillColor = 30, rgbfillColor = {207, 207, 207}, fillPattern = 1)), Rectangle(extent = [20, 60; 40, -100], style(pattern = 0, fillColor = 8, rgbfillColor = {182, 182, 182}, fillPattern = 1)), Rectangle(extent = [0, 60; 20, -100], style(pattern = 0, fillColor = 9, rgbfillColor = {156, 156, 156}, fillPattern = 1)), graphics={  Rectangle(extent={{
              -80,80},{0,-80}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                    Rectangle(extent={{60,80},{80,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{40,80},{60,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{20,80},{40,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{0,80},{20,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{-80,80},{80,-80}},      lineColor = {0, 0, 0})}),
                                                                                                                                                  Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>HeatConv</b> model represents the phenomenon of heat
  convection. No heat is stored.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.HeatTransfer_test</a>
</p>
<ul>
  <li>
    <i>April 1, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Added basic documentation and formatted appropriately
  </li>
  <li>
    <i>October 22, 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed graphics section to be compliant with Modelica
    Specification
  </li>
</ul>
</html>"));
end HeatConv;
