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
</html>",
        revisions="<html>
<p><ul>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end CHPBaseDataDefinition;
