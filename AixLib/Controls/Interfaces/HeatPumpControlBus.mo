within AixLib.Controls.Interfaces;
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
<p>Definition of a standard heat pump bus that contains basic data points that appear in every heat pump.</p>
</html>", revisions="<html>
<p>March 31, 2017, by Marc Baranski:</p>
<p>First implementation. </p>
</html>"));
end HeatPumpControlBus;
