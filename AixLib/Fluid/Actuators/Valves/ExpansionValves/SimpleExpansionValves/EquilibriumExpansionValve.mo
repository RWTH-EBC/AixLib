within AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves;
model EquilibriumExpansionValve
  "Model with equilibrium and frozen flow model"


  extends BaseClasses.PartialMetaIsenthalpicExpansionValve;
    Medium.SaturationProperties satInl "Saturation properties at valve's inlet conditions";
    Modelica.SIunits.Pressure p_t "Throat Pressure";
    Modelica.SIunits.Temperature T_tv "Throat vapor temperature";
    Modelica.SIunits.SpecificVolume v_tv "Throat vapor specific volume";
    Real kappa "Isentropic exponent";
    Modelica.SIunits.Temperature TInl "Temperature at inlet of valve";
    Modelica.SIunits.SpecificEnthalpy h_t "Specific enthalpie at throat";
    Real x_inl "vapor quality at inlet";
    Modelica.SIunits.MassFlowRate m_FFM "Frozen flow Model mass flow rate";
    Modelica.SIunits.MassFlowRate m_HEN "Equlibirum flow Model mass flow rate";


equation
  C = 1;
  x_inl =  Medium.vapourQuality(staInl) "Vapor quality at inlet";
  TInl = Medium.temperature(staInl);
  satInl = Medium.setSat_T(Medium.temperature(staInl)) "Saturtation properties";
  kappa*Medium.specificHeatCapacityCv(staInl)= Medium.specificHeatCapacityCp(staInl)  "Isentrop exponent";
  p_t = pInl*(2/( kappa + 1))^(kappa/(kappa-1)) "Throat Pressure";
  T_tv =  TInl*(2/( kappa + 1)) "Throat vapor temperature";
  v_tv  = (1/dInl) *(2/( kappa + 1))^(1/(1-kappa)) "Throat vapor specific volume";
  port_a.h_outflow - h_t =   x_inl*Medium.specificHeatCapacityCp(staInl)*(TInl-T_tv)+(1-x_inl)*v_tv*(pInl-p_t) "Specific enthalpie at throat";
  (m_FFM*(x_inl*v_tv+(1-x_inl)*(1/dInl)))^2 = (AThr*opening)^2*2*(port_a.h_outflow-h_t) "Calculate of mass flow rate frozen flow model";
  m_HEN^2= AThr^2*2*dInl*(port_a.p-port_b.p) "Equlibirum flow Model mass flow rate";
  C_meta = metastabilitycoefficient.C_meta "Calculate metastability coefficient";
  m_flow = m_HEN*C_meta*(m_FFM-m_HEN)  "Mass flow Rate";


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EquilibriumExpansionValve;
