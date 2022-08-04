within AixLib.Obsolete.Year2019.Utilities.HeatTransfer;
model HeatToStar "Adaptor for approximative longwave radiation exchange"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation(Placement(transformation(extent = {{-102, -10}, {-82, 10}})));
  AixLib.Utilities.Interfaces.RadPort Star annotation (Placement(transformation(extent={{81,-10},{101,10}})));
  parameter Modelica.Units.SI.Area A(min=0) "Area of radiation exchange";
  parameter Modelica.Units.SI.Emissivity eps=0.95 "Emissivity";
equation
  Therm.Q_flow + Star.Q_flow = 0;

  // To prevent negative solutions for T, the max() expression is used.
  // Negative solutions also occur when using max(T,0), therefore, 1 K is used.
  Therm.Q_flow = Modelica.Constants.sigma * eps * A * (
    max(Therm.T,1) * max(Therm.T,1) * max(Therm.T,1) * max(Therm.T,1) -
    max(Star.T,1) * max(Star.T,1) * max(Star.T,1) * max(Star.T,1));
  annotation(obsolete = "Obsolete model - use AixLib.Utilities.HeatTransfer.HeatToStar_Avar", Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>TwoStar_RadEx</b> model cobines the <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>
  and the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">Star</a></b>
  connector. To model longwave radiation exchange of a surfaces, just
  connect the <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>
  to the outmost layer of the surface and connect the <b><a href=
  \"AixLib.Utilities.Interfaces.RadPort\">Star</a></b> connector to the
  <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">Star</a></b>
  connectors of an unlimited number of corresponding surfaces.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Since exact calculation of longwave radiation exchange inside a room
  demands for the computation of view factors, it may be very complex
  to achieve for non-rectangular room layouts. Therefore, an
  approximated calculation of radiation exchange basing on the
  proportions of the affected surfaces is an alternative. The
  underlying concept of this approach is known as the \"two star\" room
  model.
</p>
<ul>
  <li>
    <i>February 16, 2018&#160;</i> by Philipp Mehrfeld:<br/>
    Introduce max(T,100) to prevent negative solutions for the
    temperature
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 01, 2014</i> by Moritz Lauster:<br/>
    Moved and Renamed
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>June 16, 2006&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HeatToStar;
