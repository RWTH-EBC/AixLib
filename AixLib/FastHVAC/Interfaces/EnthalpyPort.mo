within AixLib.FastHVAC.Interfaces;
partial connector EnthalpyPort "Enthalpy port for 1-dim. enthalpy transfer"
  flow Modelica.SIunits.MassFlowRate m_flow
   "Mass flow rate(positive if flowing from outside into the component)";
  Modelica.SIunits.Pressure p "dummy pressure";
  stream Modelica.SIunits.Temperature T_outflow "Port temperature";
  stream Modelica.SIunits.SpecificEnthalpy h_outflow "Specific enthalpy of fluid";
  stream Modelica.SIunits.SpecificHeatCapacity c_outflow "Constant specific heat capacity";
  annotation (Documentation(info="<html>This is an interface model for a 1-dimensional enthalpy port to
consider enthalpy transfer
</html>", revisions="<html>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib
  </li>
</ul>
</html>"));
end EnthalpyPort;
