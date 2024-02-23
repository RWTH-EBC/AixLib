within AixLib.DataBase.Weather.SurfaceOrientation;
record SurfaceOrientationBaseDataDefinition
  extends Modelica.Icons.Record;
  parameter Integer nSurfaces;
  parameter String[nSurfaces] name;
  parameter Modelica.Units.NonSI.Angle_deg[nSurfaces] Azimut;
  parameter Modelica.Units.NonSI.Angle_deg[nSurfaces] Tilt;
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for the surface orientation
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a>
</p>
<ul>
  <li>
    <i>May 07, 2013&#160;</i> by Ole Odendahl:<br/>
    Added basic documentation
  </li>
</ul>
</html>
 "));
end SurfaceOrientationBaseDataDefinition;
