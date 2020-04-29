within AixLib.Utilities.Interfaces.Adaptors;
model ConvRadToCombPort
  AixLib.Utilities.Interfaces.ConvRadComb portConvRadComb
    annotation (Placement(transformation(extent={{-120,-10},{-76,36}})));
  AixLib.Utilities.Interfaces.RadPort portRad
    annotation (Placement(transformation(extent={{84,38},{124,78}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConv
    annotation (Placement(transformation(extent={{84,-68},{118,-34}})));
equation
  connect(portConvRadComb.rad, portRad);
  connect(portConvRadComb.conv, portConv);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -80}, {100, 80}}), graphics={  Polygon(points = {{-76, 0}, {86, -72}, {86, 70}, {-76, 0}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This adaptor makes it possible to connect HeatStarComb with either
  Star or Heat connector or both.
</p>
<ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 01, 2014</i> by Moritz Lauster:<br/>
    Renamed
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ConvRadToCombPort;
