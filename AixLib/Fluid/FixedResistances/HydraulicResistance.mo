within AixLib.Fluid.FixedResistances;
model HydraulicResistance
  "Model for a hydraulic resistance using a pressure loss factor zeta"
  extends AixLib.Fluid.BaseClasses.PartialResistance(
    final m_flow_turbulent = if computeFlowResistance then 0.25 * ReCrit * Modelica.Constants.pi * diameter * mu_default * rho_default else 0);

  parameter Real zeta(min=0, unit="")
    "Pressure loss factor for flow of port_a -> port_b";
  parameter Modelica.SIunits.Diameter diameter
    "Diameter of component";
  parameter Modelica.SIunits.ReynoldsNumber ReCrit = 2300
    "Critical Reynolds number";

  final parameter Real k(unit="") = if computeFlowResistance then
        m_flow_nominal_pos / sqrt(dp_nominal_pos) else 0
    "Flow coefficient, k=m_flow/sqrt(dp), with unit=(kg.m)^(1/2)";
protected
  final parameter Boolean computeFlowResistance=(dp_nominal_pos > Modelica.Constants.eps)
    "Flag to enable/disable computation of flow resistance"
   annotation(Evaluate=true);
  parameter Medium.ThermodynamicState state_default=
    Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Default state";
  parameter Modelica.SIunits.Density rho_default = Medium.density(state_default)
    "Density at nominal condition";
  parameter Modelica.SIunits.DynamicViscosity mu_default = Medium.dynamicViscosity(
      state_default)
    "Dynamic viscosity at nominal condition";
initial equation
 if computeFlowResistance then
   assert(m_flow_turbulent > 0, "m_flow_turbulent must be bigger than zero.");
 end if;

 assert(m_flow_nominal_pos > 0, "m_flow_nominal_pos must be non-zero. Check parameters.");
equation
  // Pressure drop calculation
  if computeFlowResistance then
    if linearized then
      m_flow*m_flow_nominal_pos = k^2*dp;
    else
      if homotopyInitialization then
        if from_dp then
          m_flow=homotopy(
            actual=AixLib.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp(
              dp=dp,
              k=k,
              m_flow_turbulent=m_flow_turbulent),
            simplified=m_flow_nominal_pos*dp/dp_nominal_pos);
        else
          dp=homotopy(
            actual=AixLib.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow(
              m_flow=m_flow,
              k=k,
              m_flow_turbulent=m_flow_turbulent),
            simplified=dp_nominal_pos*m_flow/m_flow_nominal_pos);
         end if;  // from_dp
      else // do not use homotopy
        if from_dp then
          m_flow=AixLib.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp(
            dp=dp,
            k=k,
            m_flow_turbulent=m_flow_turbulent);
        else
          dp=AixLib.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow(
            m_flow=m_flow,
            k=k,
            m_flow_turbulent=m_flow_turbulent);
        end if;  // from_dp
      end if; // homotopyInitialization
    end if; // linearized
  else // do not compute flow resistance
    dp = 0;
  end if;  // computeFlowResistance

  dp = sign(m_flow)*8*zeta/(Modelica.Constants.pi*Modelica.Constants.pi*
    diameter*diameter*diameter*diameter*rho)*m_flow*m_flow
    "Multiplication instead of exponent term for speed improvement";
  annotation (Icon(graphics={Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          radius=45), Text(
          extent={{32,20},{-30,-16}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="Zeta=%zeta")}), Documentation(revisions="<html>
  <ul>
  <li><i>April 25, 2017&nbsp;</i>
     by Philipp Mehrfeld:<br/>
     Delete standard parameterization</li>
  <li><i>April 2016&nbsp;</i>
     by Peter Matthes:<br/>
     Improved formulation of flow equation according to issue #232.</li>
  <li><i>November 2014&nbsp;</i>
     by Marcus Fuchs:<br/>
     Changed model to use Annex 60 base class</li>
  <li><i>November 1, 2013&nbsp;</i>
     by Ana Constantin:<br/>
     Implemented</li>
  </ul>
 </html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Very simple model for a hydraulic resistance with the pressureloss modelled with the pressure loss factor <code>zeta</code>. </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>Values for pressure loss factor zeta can be easily found in tables. </p>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p><a href=\"AixLib.Fluid.FixedResistances.Examples.CompareFixedResistances\">AixLib.Fluid.FixedResistances.Examples.CompareFixedResistances</a> </p>
<p><a href=\"AixLib.Fluid.FixedResistances.Examples.CompareFixedResistances\">AixLib.Fluid.FixedResistances.Examples.PerformanceHydraulicResistance2</a> </p>
</html>"));
end HydraulicResistance;
