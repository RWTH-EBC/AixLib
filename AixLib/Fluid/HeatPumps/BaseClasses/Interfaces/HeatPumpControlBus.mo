within AixLib.Fluid.HeatPumps.BaseClasses.Interfaces;
expandable connector HeatPumpControlBus
  "Standard data bus with heat pump information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  SI.Conversions.NonSIunits.AngularVelocity_rpm N "rotational speed compressor"
    annotation (HideResult=false);
  Boolean input_on "true: on" annotation (HideResult=false);

  Boolean input_mode "true: heat pump, false: chiller";

  SI.ThermodynamicTemperature T_flow_ev "temperature of flow into evaporator";

  SI.ThermodynamicTemperature T_flow_co "temperature of flow into condenser";

  SI.ThermodynamicTemperature T_ret_ev "temperature of flow out of evaporator";

  SI.ThermodynamicTemperature T_ret_co "temperature of flow out of condenser";

  SI.Power Pel "Total electrical active power";

  SI.MassFlowRate m_flow_ev "Mass flow rate through evaporator";

  SI.MassFlowRate m_flow_co "Mass flow rate through condenser";

  Real CoP "Coefficient of performance";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Definition of a standard pump bus for use with the Zugabe library.
</p>
</html>", revisions="<html>
<ul>
<li>
2012-02-06, by Peter Matthes:<br/>
First implementation.
</li>
</ul>
</html>"));
end HeatPumpControlBus;
