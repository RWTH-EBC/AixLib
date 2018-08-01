within AixLib.DataBase.Materials.FillingMaterials;
record Bentonite "Bentonite (VDI 4640)"
  extends AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord(
    density=2600,
    heatCapacity=1500,
    thermalConductivity=0.6);
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>",
      info="<html>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definitiopn for records to be used in in model <a href=\"HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement\">HVAC.Components.GeothermalField_UC.BaseClasses.UPipeElement </a></p>
<p>Source: </p>
<p><ul>
<li>VDI 4640</li>
</ul></p>
</html>"));
end Bentonite;
