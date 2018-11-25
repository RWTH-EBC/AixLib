within AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor;
partial function PartialBaseFct "Base function for all icing factor functions"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ThermodynamicTemperature T_flow_ev;
  input Modelica.SIunits.ThermodynamicTemperature T_ret_ev;
  input Modelica.SIunits.ThermodynamicTemperature T_oda;
  input Modelica.SIunits.MassFlowRate m_flow_ev;
  output Real iceFac;

  annotation (Documentation(revisions="<html>
 <li><i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)</li>
</html>"));
end PartialBaseFct;
