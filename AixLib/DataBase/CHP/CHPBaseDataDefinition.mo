within AixLib.DataBase.CHP;
record CHPBaseDataDefinition "Basic CHP Data"
extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;
  import SIconv = Modelica.SIunits.Conversions.NonSIunits;

  parameter SI.Volume Vol[:] "Water volume of CHP";
  parameter Real data_CHP[:,5];
          //Matrix contains : [Capacity [%], Electrical Power [kW], Total Heat Recovery [kW], Fuel Input [kW], Fuel Consumption [m3/h]]

  parameter SI.Temperature MaxTFlow "Maximum Flow Temperature";
  parameter SI.Temperature MaxTReturn "Maximum Return Temperature";

  parameter Real Pipe_D "Outlet pipe diameter";

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Base data record for combined heat and power generators (CHP). </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end CHPBaseDataDefinition;
