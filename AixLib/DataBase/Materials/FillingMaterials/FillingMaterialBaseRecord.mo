within AixLib.DataBase.Materials.FillingMaterials;
record FillingMaterialBaseRecord
  "BaseRecord for borehole filling materials. Giving the opportunity to distinguish filling materials from other materials through various parameters."
  extends AixLib.DataBase.Materials.MaterialBaseRecord;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>",
      info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Base data defintion for material data, includes: density, thermal conductivity and heat capacity for filling materials for e.g. bore hole heat exchangers</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definitiopn for records to be used in in model <a href=\"HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement\">HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement </a></p>
</html>"));
end FillingMaterialBaseRecord;
