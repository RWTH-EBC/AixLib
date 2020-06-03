within AixLib.Controls.Interfaces;
expandable connector ThermalMachineControlBus
  "Standard data bus with heat pump or chiller information"
extends Modelica.Icons.SignalBus;

Real n "relative rotational speed of compressor between 0 and 1"
  annotation (HideResult=false);

Boolean onOff "true: on" annotation (HideResult=false);

Boolean mode "true: main operation mode, false: reversible operation mode";

Modelica.SIunits.ThermodynamicTemperature T_flow_ev "temperature of flow into evaporator";

Modelica.SIunits.ThermodynamicTemperature T_flow_co "temperature of flow into condenser";

Modelica.SIunits.ThermodynamicTemperature T_ret_ev "temperature of flow out of evaporator";

Modelica.SIunits.ThermodynamicTemperature T_ret_co "temperature of flow out of condenser";

Modelica.SIunits.Power Pel "Total electrical active power";

Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate through evaporator";

Modelica.SIunits.MassFlowRate m_flow_co "Mass flow rate through condenser";

Real CoP "Coefficient of performance";

Modelica.SIunits.ThermodynamicTemperature T_oda "Outdoor air temperature";
Modelica.SIunits.ThermodynamicTemperature T_amb_eva
  "Ambient temperature on evaporator side";
Modelica.SIunits.ThermodynamicTemperature T_amb_con
  "Ambient temperature on condenser side";
Real iceFac
  "Efficiency factor (0..1) to estimate influence of icing. 0 means no heat is transferred through heat exchanger (fully frozen). 1 means no icing/frosting."
annotation (
  defaultComponentName = "sigBusHP",
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html><p>
  Definition of a standard heat pump bus that contains basic data
  points that appear in every heat pump.
</p>
</html>",
        revisions="<html><p>
  March 31, 2017, by Marc Baranski:
</p>
<p>
  First implementation.
</p>
</html>"));

end ThermalMachineControlBus;
