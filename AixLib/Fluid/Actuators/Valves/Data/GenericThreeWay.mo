within AixLib.Fluid.Actuators.Valves.Data;
record GenericThreeWay "Generic record for 3 way valve parameters"
  extends Modelica.Icons.Record;
  parameter AixLib.Fluid.Actuators.Valves.Data.Generic a_ab
    "Valve characteristics for gate A to AB";
  parameter AixLib.Fluid.Actuators.Valves.Data.Generic b_ab
     "Valve characteristics for gate B to AB";
  annotation (
defaultComponentName="datVal",
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
This is a generic record for three way valve that includes two records for the gate A-AB and B-AB. 
The records define the normalized volume flow rates for different valve opening positions.
See the documentation of
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.Data\">
AixLib.Fluid.Actuators.Valves.Data</a>
for how to use this record.
</p>
</html>",
revisions="<html>
<ul>
<li>
June 09, 2020, by Alexander Kümpel:<br/>
First implementation.
</li>
</ul>
</html>"));
end GenericThreeWay;
