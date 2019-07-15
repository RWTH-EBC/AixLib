within AixLib.DataBase.Materials.FillingMaterials;
record basicFilling
  "basicFilling - Working filling with semi-realistic properties"
  extends AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord(
    density=3000,
    heatCapacity=1000,
    thermalConductivity=2.1);
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>",
      info="<html>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definitiopn for records to be used in in model <a href=\"HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement\">HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement </a></p>
</html>"));
end basicFilling;
