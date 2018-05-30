within AixLib.Fluid.HydraulicModules.BaseClasses;
expandable connector PumpBus "Standard data bus with pump information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  SI.Conversions.NonSIunits.AngularVelocity_rpm rpm_Input "pump speed setpoint"
    annotation (HideResult=false);
  SI.Conversions.NonSIunits.AngularVelocity_rpm rpm_Act "pump speed actor signal"
    annotation (HideResult=false);
  SI.Power power "electrical pump power" annotation (HideResult=false);
  SI.Height head "static pump head" annotation (HideResult=false);
  SI.Efficiency efficiency "pump efficiency" annotation (HideResult=false);
  SI.Height dp_Input "pump head in meter water column";
  SI.MassFlowRate MFI_Input "Massflow rate of pump, if MFI_set active [kg/s]";
  Boolean onOff_Input(start=true) "pump on or off";
  annotation (
    Icon(graphics, coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics, coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Definition of a standard pump bus for use with the Zugabe library.
</p>
</html>", revisions="<html>
<ul>
<li>2018-02-01 by Peter Matthes:<br>Adds variable rpm_Act that represents the current pump speed actor signal.</li>
<li>2017-10-12, by Peter Matthes:<br>Adds variables power, head and efficiency to pump bus. Sets NightMode(start=false). This will be the default value of that component when no connection is made from outside.</li>
<li>2017-02-06, by Peter Matthes:<br>First implementation. </li>
</ul>
</html>"));
end PumpBus;
