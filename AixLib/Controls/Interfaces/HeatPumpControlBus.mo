within AixLib.Controls.Interfaces;
expandable connector HeatPumpControlBus
  "Standard data bus with heat pump information"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm N "rotational speed compressor"
    annotation (HideResult=false);
  Boolean onOff "true: on" annotation (HideResult=false);

  Boolean mode "true: heat pump, false: chiller";

  Modelica.SIunits.ThermodynamicTemperature T_flow_ev "temperature of flow into evaporator";

  Modelica.SIunits.ThermodynamicTemperature T_flow_co "temperature of flow into condenser";

  Modelica.SIunits.ThermodynamicTemperature T_ret_ev "temperature of flow out of evaporator";

  Modelica.SIunits.ThermodynamicTemperature T_ret_co "temperature of flow out of condenser";

  Modelica.SIunits.Power Pel "Total electrical active power";

  Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate through evaporator";

  Modelica.SIunits.MassFlowRate m_flow_co "Mass flow rate through condenser";

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
