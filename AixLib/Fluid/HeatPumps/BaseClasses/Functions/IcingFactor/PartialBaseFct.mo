within AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor;
partial function PartialBaseFct "Base function for all icing factor functions"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ThermodynamicTemperature T_flow_ev;
  input Modelica.SIunits.ThermodynamicTemperature T_ret_ev;
  input Modelica.SIunits.ThermodynamicTemperature T_oda;
  input Modelica.SIunits.MassFlowRate m_flow_ev;
  output Real iceFac;

end PartialBaseFct;
