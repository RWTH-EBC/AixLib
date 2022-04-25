within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
expandable connector PumpBus "Standard data bus with pump information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  SI.Conversions.NonSIunits.AngularVelocity_rpm rpmSet "Pump speed setpoint"
    annotation (HideResult=false);
  SI.Conversions.NonSIunits.AngularVelocity_rpm rpmMea "Pump speed actor signal"
    annotation (HideResult=false);
  SI.Power PelMea "Electrical pump power"
                                         annotation (HideResult=false);
  SI.Height dpMea "Pump pressure difference or head in meter water column"
                                    annotation (HideResult=false);
  SI.Efficiency efficiencyMea "Pump efficiency"
                                             annotation (HideResult=false);
  SI.Height dpSet "Pump head in meter water column";
  SI.MassFlowRate mFlowSet
    "Massflow rate of pump, for m_flow controlled pump [kg/s]";
  Boolean onSet(start=true) "Pump on or off";
  annotation (
    Icon(graphics, coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics, coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard pump bus for use with the Zugabe library.
</p>
<ul>
  <li>2020-01-09, by Alexander Kümpel:<br/>
    Variable names changed.
  </li>
  <li>2017-02-06, by Peter Matthes:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PumpBus;
