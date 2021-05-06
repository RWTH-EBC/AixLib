within AixLib.Controls.Interfaces;
expandable connector ThermalMachineControlBus
  "Standard data bus with heat pump or chiller information"
extends Modelica.Icons.SignalBus;

Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm N "rotational speed compressor"
  annotation (HideResult=false);
Boolean onOff "true: on" annotation (HideResult=false);

Boolean mode "true: main operation mode, false: reversible operation mode";

Modelica.SIunits.ThermodynamicTemperature T_flow_ev "temperature of flow into evaporator";

Modelica.SIunits.ThermodynamicTemperature T_flow_co "temperature of flow into condenser";

Modelica.SIunits.ThermodynamicTemperature T_ret_ev "temperature of flow out of evaporator";

Modelica.SIunits.ThermodynamicTemperature T_ret_co "temperature of flow out of condenser";

Modelica.SIunits.ThermodynamicTemperature TSource "temperature of heat source";

Modelica.SIunits.Power Pel "Total electrical active power";

Real QRel "Part load ratio";

Real PLR "Part load ratio compressor";

Boolean Shutdown "true: force shutdown";

Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate through evaporator";

Modelica.SIunits.MassFlowRate m_flow_co "Mass flow rate through condenser";

Real CoP "Coefficient of performance";

Modelica.SIunits.ThermodynamicTemperature T_oda "Outdoor air temperature";
Modelica.SIunits.ThermodynamicTemperature T_amb_eva
  "Ambient temperature on evaporator side";
Modelica.SIunits.ThermodynamicTemperature T_amb_con
  "Ambient temperature on condenser side";
Real iceFac
  "Factor(0..1) to estimate efficiency losses through icing of evaporator"
annotation (
  defaultComponentName = "sigBusHP",
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>Definition of a standard heat pump bus that contains basic data points that appear in every heat pump.</p>
</html>",
        revisions="<html>
<p>March 31, 2017, by Marc Baranski:</p>
<p>First implementation. </p>
</html>"));

 Real PEl;
 Real QCon;
 Real QEvap;
 Real QEvapNom;

Real THotMax;
Real THotNom;
 Real TSourceNom;
 Real QNom;
 Real PLRMin;
 Boolean HighTemp;
 Real DeltaTCon;
 Real DeltaTEvap;

Real COP;














end ThermalMachineControlBus;
