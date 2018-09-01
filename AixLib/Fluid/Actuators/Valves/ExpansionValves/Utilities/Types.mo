within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities;
package Types "Types, constants to define menu choices"
  extends Modelica.Icons.TypesPackage;

  // Types describing calculation procedures of mass flow and pressure drop
  //
  type CalcProc = enumeration(
      linear
      "Usage of linear behaviour: m_flow = A * f(dp)",
      nominal
      "Usage of nominal conditions: m_flow = (m_flow/dp)_nominal * f(dp)",
      flowCoefficient
      "Usage of flow coefficient: m_flow = C * f(dp)")
    "Enumeration to define calculation procedure of mass flow and pressure drop"
    annotation (Evaluate=true);
  // Types describing calculation procedures of flow coefficients
  //
  type PolynomialModels = enumeration(
      Liang2008 "Liang2008",
      Liu2006 "Liu2006",
      ShanweiEtAl2005
        "ShanweiEtAl2005 - Function of area, pressures, subcooling and densities",
      Li2013 "Li2013 - Function of opening degree and subcooling")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type PowerModels = enumeration(
      Liu2006 "Liu2006 ",
      Liang2008 "Liang2008",
      ShanweiEtAl2005
        "ShanweiEtAl2005 - Function of area, pressures, subcooling and densities",
      ZhifangAndOu2008
        "ZhifangAndOu2008 - Function of geometry data and various media properties",
      Li2013 "Li2013 - Function of opening degree and subcooling",
      Zhang2006 "Zhang - Function modified parameter",
      Choi14 "Choi - Function")
    "Enumeration to define power models for calculating flow coefficient"
    annotation (Evaluate=true);
  type FlowProc = enumeration(
      Incompressible "m_flow = m_flow_inc",
      Compressible "m_flow = m_flow_incompressible + m_flow_compressible");
  type Choice = enumeration(
      ExpansionValve
                 " m_flow = C*A*sqrt(d_inlet*(pinl-pOut))",
      Bernoullip_th
                 "m_flow = C*A*sqrt(d_inlet*(pInl-p_th))",
      ExpansionValveChoke
                 "m_flow = C*A*Y*sqrt(dInl*pInl*X)",
      ExpansionValveChokedpEff
                 "m_flow = C*A*Y*sqrt(dInl*dpEff");
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>This package contains types and constants to define menue choices.</p>
</html>"));
end Types;
