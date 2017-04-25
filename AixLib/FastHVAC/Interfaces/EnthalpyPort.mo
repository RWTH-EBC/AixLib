within AixLib.FastHVAC.Interfaces;
partial connector EnthalpyPort

  Modelica.SIunits.Temperature T "Port temperature";
  flow Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate(positive if flowing from outside into the component)";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy of fluid";
  Modelica.SIunits.SpecificHeatCapacity c "Constant specific heat capacity";

  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>"));
end EnthalpyPort;
