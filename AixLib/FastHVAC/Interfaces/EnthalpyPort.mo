within AixLib.FastHVAC.Interfaces;
partial connector EnthalpyPort "Enthalpy port for 1-dim. enthalpy transfer"
    replaceable package Medium = AixLib.Media.FastHvac.BaseClasses.MediumSimple
    "Medium model" annotation (choicesAllMatching=true);

  flow Modelica.SIunits.MassFlowRate m_flow
   "Mass flow rate(positive if flowing from outside into the component)";
  stream Modelica.SIunits.SpecificEnthalpy h_outflow
    "Specific enthalpy of fluid if m_flow <0";
  Real dummy_potential "dummy potential variable"  annotation(HideResult=true);
  annotation (Documentation(info="<html>This is an interface model for a 1-dimensional enthalpy port to
consider enthalpy transfer
</html>", revisions="<html>
<ul>
  <li>
    <i>Ocotober 24, 2019</i>, by David Jansen:<br/>
    Reworked for using massflow as flow variable
  </li>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib
  </li>
</ul>
</html>"));
end EnthalpyPort;
