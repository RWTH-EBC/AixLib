within AixLib.Utilities.Interfaces;
connector RadPort "Connector for twostar (approximated) radiation exchange"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={                                 Polygon(points = {{-13, 86}, {13, 86}, {13, 12}, {77, 34}, {85, 6}, {22, -14}, {62, -72}, {37, -88}, {0, -28}, {-35, -88}, {-60, -72}, {-22, -14}, {-85, 6}, {-77, 34}, {-13, 12}, {-13, 86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
                                                                                                                                                   Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>Star</b> connector extends from the <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>
  connector. But the carried data has to be interpreted in a different
  way: the temperature T is a virtual temperature describing the
  potential of longwave radiation exchange inside the room. The heat
  flow Q_flow is the resulting energy flow due to longwave radiation.
</p>
<ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>July 12, 2009&#160;</i> by Peter Matthes:<br/>
    Switched to Modelica.SIunits.Temperature.
  </li>
  <li>
    <i>June 16, 2006&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end RadPort;
