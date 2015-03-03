within AixLib.HVAC.Ductwork.BaseClasses;


function m_flow_of_dp
  "Calculate mass flow rate as function of pressure drop due to friction"
  input Modelica.SIunits.Pressure dp
    "Pressure loss due to friction (dp = port_a.p - port_b.p)";
  input Modelica.SIunits.Density rho "Density at port_a";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity at port_a";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Real Delta "Relative roughness";
  output Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
protected
  Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
  Modelica.SIunits.ReynoldsNumber Re "Reynolds number";
algorithm
  // Positive mass flow rate
  lambda2 := abs(dp) * 2 * diameter ^ 3 * rho / (length * mu * mu)
    "Known as lambda2=f(dp)";
  Re := lambda2 / 64 "Hagen-Poiseuille";
  // Modify Re, if turbulent flow
  if Re > 2300 then
    Re := -2 * sqrt(lambda2) * Modelica.Math.log10(2.51 / sqrt(lambda2) + 0.27 * Delta)
      "Colebrook-White";
  end if;
  // Determine mass flow rate
  m_flow := Modelica.Constants.pi * diameter / 4 * mu * (if dp >= 0 then Re else -Re);
  annotation(smoothOrder = 1, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Calculation of pressureloss according to the following equation:</p>
 <pre>dp = lambda * l / d * rho / 2 * u^2</pre>
 <p><br/>For laminar regime (if Re &le; 2300): </p>
 <pre>
 lambda = 64 / Re </pre>
 <p><br/>For turbulent regime (if Re &gt; 2300): </p>
 <pre>
 1/sqrt(lambda) = -2 log(2.51 / (Re *sqrt(lambda)) + epsilon / (3.71 * d)</pre>
 <p> </p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end m_flow_of_dp;
