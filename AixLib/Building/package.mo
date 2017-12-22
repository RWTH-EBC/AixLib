within AixLib;
package Building "Package contains models for components used in setting up the building envelope, along with high and low order building models."
  extends Modelica.Icons.Package;

package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>This package will be integrated into <a href=\"AixLib.ThermalZones\">AixLib.ThermalZones</a>, see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/276\">https://github.com/RWTH-EBC/AixLib/issues/276</a>. </p>
<p>In the current version, this package still contains: </p>
<ul>
<li>Components related to building physics, such as walls, windows, internal heat sources and weather processing.</li>
<li>High Order Models with high resolution building models.</li>
<li>The validation of a Low Order Model with ASHRAE 140 and all models related to this validation.</li>
</ul>
</html>"));
end UsersGuide;

  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>This package contains models for components used in setting up the building envelope, along with high and low order building models.</p>
 </html>"));
end Building;
