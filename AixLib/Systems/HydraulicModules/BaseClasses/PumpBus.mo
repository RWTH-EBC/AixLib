within AixLib.Systems.HydraulicModules.BaseClasses;
expandable connector PumpBus "Standard data bus with pump information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Real rpm_Input "pump speed setpoint"
    annotation (HideResult=false);
  Real rpm_Act "pump speed actor signal"
    annotation (HideResult=false);
  SI.Power power "electrical pump power" annotation (HideResult=false);
  SI.Height head "static pump head" annotation (HideResult=false);
  SI.Efficiency efficiency "pump efficiency" annotation (HideResult=false);
  SI.Height dp_Input "pump head in meter water column";
  SI.MassFlowRate MFI_Input "Massflow rate of pump, for m_flow controlled pump [kg/s]";
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
<li>2017-02-06, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end PumpBus;
