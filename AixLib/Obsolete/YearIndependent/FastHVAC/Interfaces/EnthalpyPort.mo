within AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces;
partial connector EnthalpyPort "Enthalpy port for 1-dim. enthalpy transfer"

  Modelica.Units.SI.Temperature T "Port temperature";
  Modelica.Units.SI.MassFlowRate m_flow
    "Mass flow rate(positive if flowing from outside into the component)";
  Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy of fluid";
  Modelica.Units.SI.SpecificHeatCapacity c "Constant specific heat capacity";

  annotation (Documentation(info="<html>This is an interface model for a 1-dimensional enthalpy port to
consider enthalpy transfer
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib
  </li>
</ul>
</html>"));
end EnthalpyPort;
