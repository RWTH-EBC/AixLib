within AixLib.Fluid.Movers.Data;
record FlowControlled
  "Generic data record for pumps and fans with prescribed m_flow or dp"
  extends Modelica.Icons.Record;

  parameter
    AixLib.Fluid.Movers.BaseClasses.Characteristics.efficiencyParameters
    hydraulicEfficiency(
      V_flow={0},
      eta={0.7}) "Hydraulic efficiency";
  parameter
    AixLib.Fluid.Movers.BaseClasses.Characteristics.efficiencyParameters
    motorEfficiency(
      V_flow={0},
      eta={0.7}) "Electric motor efficiency";

  // Power requires default values to avoid in Dymola the message
  // Failed to expand the variable Power.V_flow
  parameter BaseClasses.Characteristics.powerParameters power(V_flow={0}, P={0})
    "Volume flow rate vs. electrical power consumption"
    annotation (Dialog(enable=use_powerCharacteristic));

  parameter Boolean motorCooledByFluid=true
    "If true, then motor heat is added to fluid stream";
  parameter Boolean use_powerCharacteristic=false
    "Use powerCharacteristic instead of efficiencyCharacteristic";

  annotation(defaultComponentPrefixes = "parameter",
             defaultComponentName = "per",
  Documentation(
info="<html>
<p>
Record containing parameters for pumps or fans
that have either the mass flow rate or the pressure rise
as an input signal.
</p>
<p>
This record may be used to assign for example fan performance data using
declaration such as
</p>
<pre>
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(
      redeclare package Medium = Medium) \"Fan\";
</pre>
<p>
This data record can be used with
<a href=\"modelica://AixLib.Fluid.Movers.FlowControlled_dp\">
AixLib.Fluid.Movers.FlowControlled_dp</a>
and with
<a href=\"modelica://AixLib.Fluid.Movers.FlowControlled_m_flow\">
AixLib.Fluid.Movers.FlowControlled_m_flow</a>.
</p>
<p>
For
<a href=\"modelica://AixLib.Fluid.Movers.SpeedControlled_y\">
AixLib.Fluid.Movers.SpeedControlled_y</a>,
use the record
<a href=\"modelica://AixLib.Fluid.Movers.Data.SpeedControlled_y\">
AixLib.Fluid.Movers.Data.SpeedControlled_y</a>.
</p>
<p>
For
<a href=\"modelica://AixLib.Fluid.Movers.SpeedControlled_Nrpm\">
AixLib.Fluid.Movers.SpeedControlled_Nrpm</a>,
use the record
<a href=\"modelica://AixLib.Fluid.Movers.Data.Generic_Nrpm\">
AixLib.Fluid.Movers.Data.Generic_Nrpm</a>
</p>
</html>",
revisions="<html>
<ul>
<li>
January 6, 2015, by Michael Wetter:<br/>
Revised record for OpenModelica.
</li>
<li>
November 22, 2014, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FlowControlled;
