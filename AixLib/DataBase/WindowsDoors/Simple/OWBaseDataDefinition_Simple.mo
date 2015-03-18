within AixLib.DataBase.WindowsDoors.Simple;


record OWBaseDataDefinition_Simple
  "Outer window base definition for simple model"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw = 2.875
    "Thermal transmission coefficient of whole window: glass + frame";
  parameter Real g = 0.8 "coefficient of solar energy transmission";
  parameter Modelica.SIunits.Emissivity Emissivity = 0.84 "Material emissivity";
  parameter Real frameFraction = 0.2
    "frame fraction from total fenestration area";
  annotation(Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Base data defintion for simple windows. </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <p><h4><font color=\"#008000\">References</font></h4></p>
 <p>Base data definition for record to be used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 </ul></p>
 </html>"));
end OWBaseDataDefinition_Simple;
