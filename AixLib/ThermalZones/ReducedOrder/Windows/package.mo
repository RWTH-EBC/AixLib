within AixLib.ThermalZones.ReducedOrder;
package Windows "This Package calculates solar gain through windows"
  extends Modelica.Icons.VariantsPackage;






  annotation (Documentation(revisions="<html><ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides two models which calculate the solar heat
  transmitted through windows into the room. <a href=
  \"Windows.Window\">Window</a> considers correction values for
  non-parallel and non-vertical radiation. <a href=
  \"Windows.ShadedWindow\">ShadedWindow</a> additionally includes
  shadowing due to the window itself and surrounding buildings. The
  <a href=\"Windows.BaseClasses\">BaseClasses</a>-package contains an
  <a href=\"Windows.Illumination\">Illumination</a> model which
  calculates the activation and deactivation of the illumination
  &lt;\\p&gt;
</p>
</html>"));
end Windows;
