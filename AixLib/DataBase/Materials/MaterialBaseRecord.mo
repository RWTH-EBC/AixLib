within AixLib.DataBase.Materials;
record MaterialBaseRecord "Definition of parameter values for a material"
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  parameter SI.Density density "Density";
  parameter SI.SpecificHeatCapacity heatCapacity "Specific heat capacity";
  parameter SI.ThermalConductivity thermalConductivity "Thermal conductivity";
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>",
        info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Base data defintion for material data, includes: density, thermal conductivity and heat capacity.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record to be used for material properties.</p>
</html>"));
end MaterialBaseRecord;
