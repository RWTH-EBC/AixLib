within AixLib.DataBase.CHP.CHPDataSimple;
record CHPBaseDataDefinition "Basic CHP data"
extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;

  parameter SI.Volume vol[:] "Water volume of CHP";
  parameter Real data_CHP[:,5];
          //Matrix contains : [capacity [Percent], electrical power [kW], total heat recovery [kW], fuel input [kW], fuel consumption [m3/h]]
  parameter SI.Temperature maxTFlow "Maximum flow temperature";
  parameter SI.Temperature maxTReturn "Maximum return temperature";
  parameter SI.Length DPipe "Outlet pipe diameter";

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data record for combined heat and power generators (CHP).
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>June 27, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end CHPBaseDataDefinition;
