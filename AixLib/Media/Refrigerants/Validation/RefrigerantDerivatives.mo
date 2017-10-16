within AixLib.Media.Refrigerants.Validation;
model RefrigerantDerivatives
  "Model that checks the implementation of derivatives by comparing the
  results to external media models"
  extends Modelica.Icons.Example;

  // Definition of the refrigerant that shall be tested
  //
  package MediumInt =
     AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
    "Internal medium model";

  package MediumExt =
     HelmholtzMedia.HelmholtzFluids.R134a
     "External medium model";

  // Definition of parameters and constants
  //
  parameter MediumInt.AbsolutePressure p0 = 20e5
    "Fixed pressure for calculations at initialization";
  parameter MediumInt.Density d0 = 75
    "Fixed density for calculations at initialization";

  constant Real convT(unit="K/s3") = 125
    "Conversion factor to satisfy derivative check";
  constant Real convH(unit="J/(kg.s3)") = 300e3
    "Conversion factor to satisfy derivative check";
  constant Real convS(unit="J/(kg.K.s3)") = 750
    "Conversion factor to satisfy derivative check";

  // Definition of variables used for calculations
  //
  MediumInt.AbsolutePressure p = p0 + 10e5*time^3
    "Pressure used for calculations";
  MediumInt.Temperature T = 273.15 + convT*time^3
    "Temperature used for calculations";
  MediumInt.Density d = d0 + 125*time^3
    "Density used for calculations";
  MediumInt.SpecificEnthalpy h = 200e3 + convH*time^3
    "Specific enthalpy used for calculations";
  MediumInt.SpecificEntropy s = 1e3 + convS*time^3
    "Specific entropy used for calculations";

  // Definition of states that include both one-phase and two-phase regions
  //
  record States
    "Record that contains calculated states for further calculations"
    MediumInt.ThermodynamicState dT_Int
      "Thermodynamic state calculated by d and T by the internal medium model";
    MediumInt.ThermodynamicState pT_Int
      "Thermodynamic state calculated by p and T by the internal medium model";
    MediumInt.ThermodynamicState ph_Int
      "Thermodynamic state calculated by p and h by the internal medium model";
    MediumInt.ThermodynamicState ps_Int
      "Thermodynamic state calculated by p and s by the internal medium model";
    MediumExt.ThermodynamicState dT_Ext
      "Thermodynamic state calculated by d and T by the external medium model";
    MediumExt.ThermodynamicState pT_Ext
      "Thermodynamic state calculated by p and T by the external medium model";
    MediumExt.ThermodynamicState ph_Ext
      "Thermodynamic state calculated by p and h by the external medium model";
    MediumExt.ThermodynamicState ps_Ext
      "Thermodynamic state calculated by p and s by the external medium model";

    MediumInt.SpecificEntropy s_dT_Int
      "Specific entropy calculated by d and T by the internal medium model";
    MediumExt.SpecificEntropy s_dT_Ext
      "Specific entropy calculated by d and T by the external medium model";
    MediumInt.SpecificEntropy s_pT_Int
      "Specific entropy calculated by p and T by the internal medium model";
    MediumExt.SpecificEntropy s_pT_Ext
      "Specific entropy calculated by p and T by the external medium model";
    MediumInt.SpecificEntropy s_ph_Int
      "Specific entropy calculated by p and h by the internal medium model";
    MediumExt.SpecificEntropy s_ph_Ext
      "Specific entropy calculated by p and h by the external medium model";
    MediumInt.SpecificEntropy s_ps_Int
      "Specific entropy calculated by p and s by the internal medium model";
    MediumExt.SpecificEntropy s_ps_Ext
      "Specific entropy calculated by p and s by the external medium model";

    MediumExt.SaturationProperties sat_T
      "Saturation properties calculated by temperature";
    MediumExt.SaturationProperties sat_p
      "Saturation properties calculated by pressure";
    MediumExt.FixedPhase phase_dT
      "Actual phase of thermodynamic state calculated by d and T";
    MediumExt.FixedPhase phase_ph
      "Actual phase of thermodynamic state calculated by p and h";
    MediumExt.FixedPhase phase_ps
      "Actual phase of thermodynamic state calculated by p and s";
  end States;
  States states
    "Record that contains thermodynamic states calculated by
    independent state variables";

  // Definition of properties derived by partial derivatives of the EoS
  //
  record DerProp
    "Record that containts properties derived by partial derivatives of the EoS"
    Modelica.SIunits.SpecificHeatCapacity cp_Int
      "Isobaric heat capacity calculated by the internal medium model";
    Modelica.SIunits.SpecificHeatCapacity cp_Ext
      "Isobaric heat capacity calculated by the external medium model";
    Modelica.SIunits.SpecificHeatCapacity cv_Int
      "Isochoric heat capacity calculated by the internal medium model";
    Modelica.SIunits.SpecificHeatCapacity cv_Ext
      "Isochoric heat capacity calculated by the external medium model";
    Modelica.SIunits.VelocityOfSound a_Int
      "Velocity of sound calculated by the internal medium model";
    Modelica.SIunits.VelocityOfSound a_Ext
      "Velocity of sound calculated by the external medium model";
    MediumInt.IsobaricExpansionCoefficient beta_Int
      "Isobaric expansion coefficient calculated by the internal medium model";
    MediumInt.IsobaricExpansionCoefficient beta_Ext
      "Isobaric expansion coefficient calculated by the external medium model";
    MediumInt.IsentropicExponent gamma_Int
      "Isentropic exponent calculated by the internal medium model";
    MediumInt.IsentropicExponent gamma_Ext
      "Isentropic exponent calculated by the external medium model";
    Modelica.SIunits.IsothermalCompressibility kappa_Int
      "Isothermal compressibility calculated by the internal medium model";
    Modelica.SIunits.IsothermalCompressibility kappa_Ext
      "Isothermal compressibility calculated by the external medium model";
    Real delta_T_Int
      "Isothermal throttling coefficient calculated by the internal medium model";
    Real delta_T_Ext
      "Isothermal throttling coefficient by the external medium model";
    Real my_Int
      "Joule Thomson coefficient by the internal medium model";
    Real my_Ext
      "Joule Thomson coefficient calculated by the external medium model";

    Real d_cp =  cp_Int - cp_Ext
      "Difference of the isobaric heat capacity";
    Real d_cv =  cv_Int - cv_Ext
      "Difference of the isochoric heat capacity";
    Real d_a =  a_Int-a_Ext
      "Difference of the velocity of sound";
    Real d_beta =  beta_Int - beta_Ext
      "Difference of the isobaric expansion coefficient";
    Real d_gamma =  gamma_Int-gamma_Ext
      "Difference of the isentropic exponent";
    Real d_kappa =  kappa_Int - kappa_Ext
      "Difference of the isothermal compressibility";
    Real d_delta_T =  delta_T_Int - delta_T_Ext
      "Difference of the isothermal throttling coefficient";
    Real d_my =  my_Int - my_Ext
      "Difference of the Joule Thomson coefficient";
  end DerProp;
  DerProp derProp
    "Record that contains thermodynamic properties derived
    by partial derivatives";

  // Definition of derivatives depending on derivatives of the EoS only
  //
  record ExplDer
    "Record that contains derivatives depending on derivatives of the EoS only"
    parameter Real convH(unit="J/(kg.s3)") = 300e3
    "Conversion factor to satisfy derivative check";
    MediumExt.AbsolutePressure p
      "Pressure used for calculations";

    MediumExt.ThermodynamicState state = MediumExt.setState_phX(
      p=p, h=200e3 + convH*time^3)
      "Thermodynamic state used for caculationg derivatives of the EoS";
    MediumExt.EoS.HelmholtzDerivs f =  MediumExt.EoS.setHelmholtzDerivsThird(
      T=state.T, d=state.d, phase=1)
      "Derivatives of the EoS calculated by the external medium model";

    Real dpdd_T_Int
      "Derivative (dp/dd)_T=const. calculated by the internal medium model";
    Real dpdd_T_Ext
      "Derivative (dp/dd)_T=const. calculated by the external medium model";
    Real dpdT_d_Int
      "Derivative (dp/dT)_d=const. calculated by the internal medium model";
    Real dpdT_d_Ext
      "Derivative (dp/dT)_d=const. calculated by the external medium model";

    Real dhdT_d_Int
      "Derivative (dh/dT)_d=const. calculated by the internal medium model";
    Real dhdT_d_Ext
      "Derivative (dh/dT)_d=const. calculated by the external medium model";
    Real dhdd_T_Int
      "Derivative (dh/dd)_T=const. calculated by the internal medium model";
    Real dhdd_T_Ext
      "Derivative (dh/dd)_T=const. calculated by the external medium model";

    Real dsdd_T_Int
      "Derivative (ds/dd)_T=const. calculated by the internal medium model";
    Real dsdd_T_Ext
      "Derivative (ds/dd)_T=const. calculated by the external medium model";
    Real dsdT_d_Int
      "Derivative (ds/dT)_d=const. calculated by the internal medium model";
    Real dsdT_d_Ext
      "Derivative (ds/dT)_d=const. calculated by the external medium model";

    Real dudT_d_Int
      "Derivative (du/dT)_d=const. calculated by the internal medium model";
    Real dudT_d_Ext
      "Derivative (du/dT)_d=const. calculated by the external medium model";
    Real dudd_T_Int
      "Derivative (du/dd)_T=const. calculated by the internal medium model";
    Real dudd_T_Ext
      "Derivative (du/dd)_T=const. calculated by the external medium model";

    Real d_dpdd_T =  dpdd_T_Int-dpdd_T_Ext
      "Difference of the derivative (dp/dd)_T=const.";
    Real d_dpdT_d =  dpdT_d_Int-dpdT_d_Ext
      "Difference of the derivative (dp/dT)_d=const.";
    Real d_dhdT_d =  dhdT_d_Int-dhdT_d_Ext
      "Difference of the derivative (dh/dT)_d=const.";
    Real d_dhdd_T =  dhdd_T_Int-dhdd_T_Ext
      "Difference of the derivative (dh/dd)_T=const.";
    Real d_dsdd_T =  dsdd_T_Int-dsdd_T_Ext
      "Difference of the derivative (ds/dd)_T=const.";
    Real d_dsdT_d =  dsdT_d_Int-dsdT_d_Ext
      "Difference of the derivative (ds/dT)_d=const.";
    Real d_dudT_d =  dudT_d_Int-dudT_d_Ext
      "Difference of the derivative (du/dT)_d=const.";
    Real d_dudd_T =  dudd_T_Int-dudd_T_Ext
      "Difference of the derivative (du/dd)_T=const.";
  end ExplDer;
  ExplDer explDer(p=p,convH=convH)
    "Record that contains partial derivatives wrt. density and temperature";

  // Definition of further derivatives
  //
  record FurDer "Record that contains further derivatives"
    Real dddp_T_Int
      "Derivative (dd/dp)_T=const. calculated by the internal medium model";
    Real dddp_T_Ext
      "Derivative (dd/dp)_T=const. calculated by the external medium model";
    Real dddT_p_Int
      "Derivative (dd/dT)_p=const. calculated by the internal medium model";
    Real dddT_p_Ext
      "Derivative (dd/dT)_p=const. calculated by the external medium model";
    Real dddp_h_Int
      "Derivative (dd/dp)_h=const. calculated by the internal medium model";
    Real dddp_h_Ext
      "Derivative (dd/dp)_h=const. calculated by the external medium model";
    Real dddh_p_Int
      "Derivative (dd/dh)_p=const. calculated by the internal medium model";
    Real dddh_p_Ext
      "Derivative (dd/dh)_p=const. calculated by the external medium model";
    Real dddp_s_Int
      "Derivative (dd/dp)_s=const. calculated by the internal medium model";
    Real dddp_s_Ext
      "Derivative (dd/dp)_s=const. calculated by the external medium model";
    Real ddds_p_Int
      "Derivative (dd/ds)_p=const. calculated by the internal medium model";
    Real ddds_p_Ext
      "Derivative (dd/ds)_p=const. calculated by the external medium model";

    Real dTdp_h_Int
      "Derivative (dT/dp)_h=const. calculated by the internal medium model";
    Real dTdp_h_Ext
      "Derivative (dT/dp)_h=const. calculated by the external medium model";
    Real dTdh_p_Int
      "Derivative (dT/dh)_p=const. calculated by the internal medium model";
    Real dTdh_p_Ext
      "Derivative (dT/dh)_p=const. calculated by the external medium model";
    Real dTdp_s_Int
      "Derivative (dT/dp)_s=const. calculated by the internal medium model";
    Real dTdp_s_Ext
      "Derivative (dT/dp)_s=const. calculated by the external medium model";
    Real dTds_p_Int
      "Derivative (dT/ds)_p=const. calculated by the internal medium model";
    Real dTds_p_Ext
      "Derivative (dT/ds)_p=const. calculated by the external medium model";

    Real dhdp_T_Int
      "Derivative (dh/dp)_T=const. calculated by the internal medium model";
    Real dhdp_T_Ext
      "Derivative (dh/dp)_T=const. calculated by the external medium model";
    Real dhdT_p_Int
      "Derivative (dh/dT)_p=const. calculated by the internal medium model";
    Real dhdT_p_Ext
      "Derivative (dh/dT)_p=const. calculated by the external medium model";
    Real dhds_p_Int
      "Derivative (dh/ds)_p=const. calculated by the internal medium model";
    Real dhds_p_Ext
      "Derivative (dh/ds)_p=const. calculated by the external medium model";
    Real dhdp_s_Int
      "Derivative (dh/dp)_s=const. calculated by the internal medium model";
    Real dhdp_s_Ext
      "Derivative (dh/dp)_s=const. calculated by the external medium model";

    Real d_dddp_T = dddp_T_Int - dddp_T_Ext
      "Difference of the derivative (dd/dp)_T=const.";
    Real d_dddT_p = dddT_p_Int - dddT_p_Ext
      "Difference of the derivative (dd/dT)_p=const.";
    Real d_dddp_h = dddp_h_Int - dddp_h_Ext
      "Difference of the derivative (dd/dp)_h=const.";
    Real d_dddh_p = dddh_p_Int - dddh_p_Ext
      "Difference of the derivative (dd/dh)_p=const.";
    Real d_dddp_s = dddp_s_Int - dddp_s_Ext
      "Difference of the derivative (dd/dp)_s=const.";
    Real d_ddds_p = ddds_p_Int - ddds_p_Ext
      "Difference of the derivative (dd/ds)_p=const.";
    Real d_dTdp_h = dTdp_h_Int - dTdp_h_Ext
      "Difference of the derivative (dT/dp)_h=const.";
    Real d_dTdh_p = dTdh_p_Int - dTdh_p_Ext
      "Difference of the derivative (dT/dh)_p=const.";
    Real d_dTdp_s = dTdp_s_Int - dTdp_s_Ext
      "Difference of the derivative (dT/dp)_s=const.";
    Real d_dTds_p = dTds_p_Int - dTds_p_Ext
      "Difference of the derivative (dT/ds)_p=const.";
    Real d_dhdp_T = dhdp_T_Int - dhdp_T_Ext
      "Difference of the derivative (dh/dp)_T=const.";
    Real d_dhdT_p = dhdT_p_Int - dhdT_p_Ext
      "Difference of the derivative (dh/dT)_p=const.";
    Real d_dhds_p = dhds_p_Int - dhds_p_Ext
      "Difference of the derivative (dh/ds)_p=const.";
    Real d_dhdp_s = dhdp_s_Int - dhdp_s_Ext
      "Difference of the derivative (dh/dp)_s=const.";
  end FurDer;
  FurDer furDer
    "Record that contains further derivatives not wrt. density and temperature";

  // Definition of derivates at bubble and dew state
  //
  record SatDer "Record that contains derivatives at bubble and dew state"
    parameter Real convT(unit="K/(s3)") = 125
    "Conversion factor to satisfy derivative check";
    MediumExt.Density d = 75
      "Density used for calculations";

    MediumExt.ThermodynamicState state = MediumExt.setState_dTX(
      d=d, T=min(273.15 + convT*time^3,
      MediumExt.fluidConstants[1].criticalTemperature-3))
      "Thermodynamic state calculated by d and T for further calculations";
    MediumExt.ThermodynamicState sat_l=
      MediumExt.setBubbleState(MediumExt.setSat_p(state.p))
      "Bubble state calculated by d and T";
    MediumExt.ThermodynamicState sat_v=
      MediumExt.setDewState(MediumExt.setSat_p(state.p))
      "Dew state calculated by d and T";
    MediumExt.EoS.HelmholtzDerivs fl=
      MediumExt.EoS.setHelmholtzDerivsSecond(T=sat_l.T,
      d=sat_l.d, phase=1)
      "Derivatives of the EoS calculated by the external medium
      model at bubble state";
    MediumExt.EoS.HelmholtzDerivs fv=
      MediumExt.EoS.setHelmholtzDerivsSecond(T=sat_v.T,
      d=sat_v.d, phase=1)
      "Derivatives of the EoS calculated by the external medium
      model at dew state";

    Real dpdT_Int
      "Derivative (dp/dT)_saturation calculated by the internal medium model";
    Real dpdT_Ext
      "Derivative (dp/dT)_saturation calculated by the external medium model";
    Real dTdp_Int
      "Derivative (dT/dp)_saturation calculated by the internal medium model";
    Real dTdp_Ext
      "Derivative (dT/dp)_saturation  calculated by the external medium model";

    Real dddp_l_Int
      "Derivative (dd_l/dp)_saturation calculated by the internal medium model";
    Real dddp_l_Ext
      "Derivative (dd_l/dp)_saturation calculated by the external medium model";
    Real dddp_v_Int
      "Derivative (dd_v/dp)_saturation calculated by the internal medium model";
    Real dddp_v_Ext
      "Derivative (dd_v/dp)_saturation calculated by the external medium model";
    Real dhdp_l_Int
      "Derivative (dh_l/dp)_saturation calculated by the internal medium model";
    Real dhdp_l_Ext
      "Derivative (dh_l/dp)_saturation calculated by the external medium model";
    Real dhdp_v_Int
      "Derivative (dh_v/dp)_saturation calculated by the internal medium model";
    Real dhdp_v_Ext
      "Derivative (dh_v/dp)_saturation calculated by the external medium model";
    Real dsdp_l_Int
      "Derivative (ds_l/dp)_saturation calculated by the internal medium model";
    Real dsdp_l_Ext
      "Derivative (ds_l/dp)_saturation calculated by the external medium model";
    Real dsdp_v_Int
      "Derivative (ds_v/dp)_saturation calculated by the internal medium model";
    Real dsdp_v_Ext
      "Derivative (ds_v/dp)_saturation calculated by the external medium model";

    Real dddT_l_Int
      "Derivative (dd_l/dT)_saturation calculated by the internal medium model";
    Real dddT_l_Ext
      "Derivative (dd_l/dT)_saturation calculated by the external medium model";
    Real dddT_v_Int
      "Derivative (dd_v/dT)_saturation calculated by the internal medium model";
    Real dddT_v_Ext
      "Derivative (dd_v/dT)_saturation calculated by the external medium model";
    Real dhdT_l_Int
      "Derivative (dh_l/dT)_saturation calculated by the internal medium model";
    Real dhdT_l_Ext
      "Derivative (dh_l/dT)_saturation calculated by the external medium model";
    Real dhdT_v_Int
      "Derivative (dh_v/dT)_saturation calculated by the internal medium model";
    Real dhdT_v_Ext
      "Derivative (dh_v/dT)_saturation calculated by the external medium model";
    Real dudT_l_Int
      "Derivative (du_l/dT)_saturation calculated by the internal medium model";
    Real dudT_l_Ext
      "Derivative (du_l/dT)_saturation calculated by the external medium model";
    Real dudT_v_Int
      "Derivative (du_v/dT)_saturation calculated by the internal medium model";
    Real dudT_v_Ext
      "Derivative (du_v/dT)_saturation calculated by the external medium model";

    Real d_dpdT = dpdT_Int - dpdT_Ext
      "Difference of the derivative (dp/dT)_saturation";
    Real d_dTdp = dTdp_Int - dTdp_Ext
      "Difference of the derivative (dT/dp)_saturation";
    Real d_dddp_l = dddp_l_Int - dddp_l_Ext
      "Difference of the derivative (dd_l/dp)_saturation";
    Real d_dddp_v = dddp_v_Int - dddp_v_Ext
      "Difference of the derivative (dd_v/dp)_saturation ";
    Real d_dhdp_l = dhdp_l_Int - dhdp_l_Ext
      "Difference of the derivative (dh_l/dp)_saturation";
    Real d_dhdp_v = dhdp_v_Int - dhdp_v_Ext
      "Difference of the derivative (dh_v/dp)_saturation";
    Real d_dsdp_l = dsdp_l_Int - dsdp_l_Ext
      "Difference of the derivative (ds_l/dp)_saturation";
    Real d_dsdp_v = dsdp_v_Int - dsdp_v_Ext
      "Difference of the derivative (ds_v/dp)_saturation";
    Real d_dddT_l = dddT_l_Int - dddT_l_Ext
      "Difference of the derivative (dd_l/dT)_saturation";
    Real d_dddT_v = dddT_v_Int - dddT_v_Ext
      "Difference of the derivative (dd_v/dT)_saturation";
    Real d_dhdT_l = dhdT_l_Int - dhdT_l_Ext
      "Difference of the derivative (dh_l/dT)_saturation";
    Real d_dhdT_v = dhdT_v_Int - dhdT_v_Ext
      "Difference of the derivative (dh_v/dT)_saturation";
    Real d_dudT_l = dudT_l_Int - dudT_l_Ext
      "Difference of the derivative (du_l/dT)_saturation";
    Real d_dudT_v = dudT_v_Int - dudT_v_Ext
      "Difference of the derivative (du_v/dT)_saturation";
  end SatDer;
  SatDer satDer(d=d,convT=convT)
    "Record that contains derivates at bubble and dew state";

equation
  // Calculation of states
  //
  states.dT_Int = MediumInt.setState_dTX(d=d,T=
    min(T,MediumInt.fluidConstants[1].criticalTemperature-3));
  states.pT_Int = MediumInt.setState_pTX(p=p,T=
    min(T,MediumExt.fluidConstants[1].criticalTemperature-3));
  states.ph_Int = MediumInt.setState_phX(p=p,h=h);
  states.ps_Int = MediumInt.setState_psX(p=p,s=s);
  states.dT_Ext = MediumExt.setState_dTX(d=d,T=T);
  states.pT_Ext = MediumExt.setState_pTX(p=p,T=T);
  states.ph_Ext = MediumExt.setState_phX(p=p,h=h);
  states.ps_Ext = MediumExt.setState_psX(p=p,s=s);

  states.s_dT_Int = MediumInt.specificEntropy(states.dT_Int);
  states.s_dT_Ext = MediumExt.specificEntropy(states.dT_Ext);
  states.s_pT_Int = MediumInt.specificEntropy(states.pT_Int);
  states.s_pT_Ext = MediumExt.specificEntropy(states.pT_Ext);
  states.s_ph_Int = MediumInt.specificEntropy(states.ph_Int);
  states.s_ph_Ext = MediumExt.specificEntropy(states.ph_Ext);
  states.s_ps_Int = MediumInt.specificEntropy(states.ps_Int);
  states.s_ps_Ext = MediumExt.specificEntropy(states.ps_Ext);

  states.sat_T = MediumExt.setSat_T(T);
  states.sat_p = MediumExt.setSat_p(p);
  states.phase_dT = if not ((d < MediumExt.bubbleDensity(states.sat_T) and d >
    MediumExt.dewDensity(states.sat_T)) and T < MediumExt.fluidConstants[1].
    criticalTemperature) then 1 else 2;
  states.phase_ph =  if not ((MediumExt.density(states.ph_Ext) <
    MediumExt.bubbleDensity(states.sat_p) and MediumExt.density(states.ph_Ext) >
    MediumExt.dewDensity(states.sat_p)) and MediumExt.temperature(states.ph_Ext)
    < MediumExt.fluidConstants[1].criticalTemperature) then 1 else 2;
  states.phase_ps =  if not ((MediumExt.density(states.ps_Ext) <
    MediumExt.bubbleDensity(states.sat_p) and MediumExt.density(states.ps_Ext) >
    MediumExt.dewDensity(states.sat_p)) and MediumExt.temperature(states.ps_Ext)
    < MediumExt.fluidConstants[1].criticalTemperature) then 1 else 2;

algorithm
  // Calculation of properties based on derivatives
  //
  derProp.cp_Int := MediumInt.specificHeatCapacityCp(states.ph_Int);
  derProp.cp_Ext := MediumExt.specificHeatCapacityCp(states.ph_Ext);
  derProp.cv_Int := MediumInt.specificHeatCapacityCv(states.ph_Int);
  derProp.cv_Ext := MediumExt.specificHeatCapacityCv(states.ph_Ext);
  derProp.a_Int := MediumInt.velocityOfSound(states.ph_Int);
  derProp.a_Ext := MediumExt.velocityOfSound(states.ph_Ext);
  derProp.beta_Int := MediumInt.isobaricExpansionCoefficient(states.ph_Int);
  derProp.beta_Ext := MediumExt.isobaricExpansionCoefficient(states.ph_Ext);
  derProp.gamma_Int := MediumInt.isentropicExponent(states.ph_Int);
  derProp.gamma_Ext := MediumExt.isentropicExponent(states.ph_Ext);
  derProp.kappa_Int := MediumInt.isothermalCompressibility(states.ph_Int);
  derProp.kappa_Ext := MediumExt.isothermalCompressibility(states.ph_Ext);
  derProp.delta_T_Int :=
    MediumInt.isothermalThrottlingCoefficient(states.ph_Int);
  derProp.delta_T_Ext :=
    MediumExt.isothermalThrottlingCoefficient(states.ph_Ext);
  derProp.my_Int := MediumInt.jouleThomsonCoefficient(states.ph_Int);
  derProp.my_Ext := MediumExt.jouleThomsonCoefficient(states.ph_Ext);

  // Calculate derivatives that depend on derivatives of the EoS only
  //
  explDer.dpdd_T_Int := MediumInt.pressure_derd_T(states.ph_Int);
  explDer.dpdd_T_Ext := MediumExt.pressure_derd_T(states.ph_Ext);
  explDer.dpdT_d_Int := MediumInt.pressure_derT_d(states.ph_Int);
  explDer.dpdT_d_Ext := MediumExt.pressure_derT_d(states.ph_Ext);

  explDer.dhdT_d_Int := MediumInt.specificEnthalpy_derT_d(states.ph_Int);
  explDer.dhdT_d_Ext := MediumExt.specificEnthalpy_derT_d(states.ph_Ext);
  explDer.dhdd_T_Int := MediumInt.specificEnthalpy_derd_T(states.ph_Int);
  explDer.dhdd_T_Ext := MediumExt.specificEnthalpy_derd_T(states.ph_Ext);

  explDer.dsdd_T_Int := MediumInt.specificEntropy_derd_T(states.ph_Int);
  explDer.dsdd_T_Ext := MediumExt.EoS.dsdT(explDer.f); // no two-phase region
  explDer.dsdT_d_Int := MediumInt.specificEntropy_derT_d(states.ph_Int);
  explDer.dsdT_d_Ext := MediumExt.EoS.dsTd(explDer.f); // no two-phase region

  explDer.dudT_d_Int := MediumInt.specificInternalEnergy_derT_d(states.ph_Int);
  explDer.dudT_d_Ext := MediumExt.EoS.duTd(explDer.f); // no two-phase region
  explDer.dudd_T_Int := MediumInt.specificInternalEnergy_derd_T(states.ph_Int);
  explDer.dudd_T_Ext := MediumExt.EoS.dudT(explDer.f); // no two-phase region

  // Calculate further derivatives
  //
  furDer.dddp_T_Int := MediumInt.density_derp_T(states.ph_Int);
  furDer.dddp_T_Ext := MediumExt.density_derp_T(states.ph_Ext);
  furDer.dddT_p_Int := MediumInt.density_derT_p(states.ph_Int);
  furDer.dddT_p_Ext := MediumExt.density_derT_p(states.ph_Ext);
  furDer.dddp_h_Int := MediumInt.density_derp_h(states.ph_Int);
  furDer.dddp_h_Ext := MediumExt.density_derp_h(states.ph_Ext);
  furDer.dddh_p_Int := MediumInt.density_derh_p(states.ph_Int);
  furDer.dddh_p_Ext := MediumExt.density_derh_p(states.ph_Ext);
  furDer.dddp_s_Int := MediumInt.density_derp_s(states.ph_Int);
  furDer.dddp_s_Ext := 1/(MediumExt.pressure_derd_T(states.ph_Ext)-
    MediumExt.pressure_derT_d(states.ph_Ext)*explDer.dsdd_T_Ext/
    explDer.dsdT_d_Ext); // no two-phase region
  furDer.ddds_p_Int := MediumInt.density_ders_p(states.ph_Int);
  furDer.ddds_p_Ext := (MediumExt.density_derh_p(states.ph_Ext)*
    MediumExt.temperature(states.ph_Ext));

  furDer.dTdp_h_Int := MediumInt.temperature_derp_h(states.ph_Int);
  furDer.dTdp_h_Ext := MediumExt.jouleThomsonCoefficient(states.ph_Ext);
  furDer.dTdh_p_Int := MediumInt.temperature_derh_p(states.ph_Int);
  furDer.dTdh_p_Ext := 1/MediumExt.specificHeatCapacityCp(states.ph_Ext);
  furDer.dTdp_s_Int := MediumInt.temperature_derp_s(states.ph_Int);
  furDer.dTdp_s_Ext := -(MediumExt.EoS.dsdT(explDer.f)/
    MediumExt.pressure_derd_T(states.ph_Ext))/(1/furDer.dTds_p_Ext);
  furDer.dTds_p_Int := MediumInt.temperature_ders_p(states.ph_Int);
  furDer.dTds_p_Ext := 1/(MediumExt.EoS.dsTd(explDer.f)-
    MediumExt.EoS.dsdT(explDer.f)*MediumExt.pressure_derT_d(states.ph_Ext)/
    MediumExt.pressure_derd_T(states.ph_Ext));

  furDer.dhdp_T_Int := MediumInt.specificEnthalpy_derp_T(states.ph_Int);
  furDer.dhdp_T_Ext := MediumExt.isothermalThrottlingCoefficient(states.ph_Ext);
  furDer.dhdT_p_Int := MediumInt.specificEnthalpy_derT_p(states.ph_Int);
  furDer.dhdT_p_Ext := MediumExt.specificHeatCapacityCp(states.ph_Ext);
  furDer.dhds_p_Int := MediumInt.specificEnthalpy_ders_p(states.ph_Int);
  furDer.dhds_p_Ext := MediumExt.temperature(states.ph_Ext);
  furDer.dhdp_s_Int := MediumInt.specificEnthalpy_derp_s(states.ph_Int);
  furDer.dhdp_s_Ext := 1/MediumExt.density(states.ph_Ext);

  // Calculate derivatives at bubble and dew line
  //
  satDer.dpdT_Int := MediumInt.saturationPressure_derT(min(
    MediumInt.temperature(states.ph_Int),
    MediumInt.fluidConstants[1].criticalTemperature-3));
  satDer.dpdT_Ext := MediumExt.saturationPressure_derT(min(
    MediumExt.temperature(states.ph_Ext),
    MediumExt.fluidConstants[1].criticalTemperature-3));
  satDer.dTdp_Int := MediumInt.saturationTemperature_derp(
    MediumInt.pressure(states.dT_Int));
  satDer.dTdp_Ext := MediumExt.saturationTemperature_derp(
    MediumExt.pressure(states.dT_Ext));

  satDer.dddp_l_Int := MediumInt.dBubbleDensity_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dddp_l_Ext := MediumExt.dBubbleDensity_dPressure(
    MediumExt.setSat_p(MediumExt.pressure(states.dT_Ext)));
  satDer.dddp_v_Int := MediumInt.dDewDensity_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dddp_v_Ext := MediumExt.dDewDensity_dPressure(
    MediumExt.setSat_p(MediumExt.pressure(states.dT_Ext)));
  satDer.dhdp_l_Int := MediumInt.dBubbleEnthalpy_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dhdp_l_Ext := MediumExt.dBubbleEnthalpy_dPressure(
    MediumExt.setSat_p(MediumExt.pressure(states.dT_Ext)));
  satDer.dhdp_v_Int := MediumInt.dDewEnthalpy_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dhdp_v_Ext := MediumExt.dDewEnthalpy_dPressure(
    MediumExt.setSat_p(MediumExt.pressure(states.dT_Ext)));
  satDer.dsdp_l_Int := MediumInt.dBubbleEntropy_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dsdp_l_Ext := ((satDer.fl.R/MediumExt.density(satDer.sat_l)*
    (-(1 + satDer.fl.delta*satDer.fl.rd) + (0 + satDer.fl.tau*satDer.fl.delta*
    satDer.fl.rtd)))/MediumExt.pressure_derd_T(MediumExt.setBubbleState(
    MediumExt.setSat_p(MediumExt.pressure(satDer.sat_l)))))+((satDer.fl.R/
    satDer.sat_l.T*(-satDer.fl.tau^2*(satDer.fl.itt + satDer.fl.rtt))) -
    (satDer.fl.R/MediumExt.density(satDer.sat_l)*(-(1 + satDer.fl.delta*
    satDer.fl.rd) + (0 + satDer.fl.tau*satDer.fl.delta*satDer.fl.rtd)))*
    MediumExt.pressure_derT_d(MediumExt.setBubbleState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_l))))/MediumExt.pressure_derd_T(
    MediumExt.setBubbleState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_l)))))*
    MediumExt.saturationTemperature_derp(MediumExt.pressure(satDer.sat_l));
  satDer.dsdp_v_Int := MediumInt.dDewEntropy_dPressure(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dsdp_v_Ext := ((satDer.fv.R/MediumExt.density(satDer.sat_v)*(-(1 +
    satDer.fv.delta*satDer.fv.rd) + (0 + satDer.fv.tau*satDer.fv.delta*
    satDer.fv.rtd)))/MediumExt.pressure_derd_T(MediumExt.setDewState(
    MediumExt.setSat_p(MediumExt.pressure(satDer.sat_v)))))+((satDer.fv.R/
    satDer.sat_v.T*(-satDer.fv.tau^2*(satDer.fv.itt + satDer.fv.rtt))) -
    (satDer.fv.R/MediumExt.density(satDer.sat_v)*(-(1 + satDer.fv.delta*
    satDer.fv.rd) + (0 + satDer.fv.tau*satDer.fv.delta*satDer.fv.rtd)))*
    MediumExt.pressure_derT_d(MediumExt.setDewState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_v))))/MediumExt.pressure_derd_T(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v)))))* MediumExt.saturationTemperature_derp(
    MediumExt.pressure(satDer.sat_v));

  satDer.dddT_l_Int := MediumInt.dBubbleDensity_dTemperature(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dddT_l_Ext := MediumExt.density_derT_p(MediumExt.setBubbleState(
    MediumExt.setSat_p(MediumExt.pressure(satDer.sat_l)))) +
    MediumExt.density_derp_T(MediumExt.setBubbleState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_l))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_l));
  satDer.dddT_v_Int := MediumInt.dDewDensity_dTemperature(MediumInt.setSat_p(
    MediumInt.pressure(states.dT_Int)));
  satDer.dddT_v_Ext := MediumExt.density_derT_p(MediumExt.setDewState(
    MediumExt.setSat_p(MediumExt.pressure(satDer.sat_v)))) +
    MediumExt.density_derp_T(MediumExt.setDewState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_v))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_v));
  satDer.dhdT_l_Int := MediumInt.dBubbleEnthalpy_dTemperature(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dhdT_l_Ext := MediumExt.specificHeatCapacityCp(
    MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l)))) + MediumExt.isothermalThrottlingCoefficient(
    MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_l));
  satDer.dhdT_v_Int := MediumInt.dDewEnthalpy_dTemperature(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dhdT_v_Ext := MediumExt.specificHeatCapacityCp(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v)))) + MediumExt.isothermalThrottlingCoefficient(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_v));
  satDer.dudT_l_Int := MediumInt.dBubbleInternalEnergy_dTemperature(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dudT_l_Ext := (MediumExt.specificHeatCapacityCv(
    MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l)))) - (satDer.fl.R*satDer.sat_l.T/MediumExt.density(
     MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l))))*satDer.fl.tau*satDer.fl.delta*satDer.fl.rtd)*
    MediumExt.pressure_derT_d(MediumExt.setBubbleState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_l))))/MediumExt.pressure_derd_T(
    MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l)))))+((satDer.fl.R*satDer.sat_l.T/MediumExt.density(
    MediumExt.setBubbleState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_l))))*satDer.fl.tau*satDer.fl.delta*satDer.fl.rtd)/
    MediumExt.pressure_derd_T(MediumExt.setBubbleState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_l)))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_l));
  satDer.dudT_v_Int := MediumInt.dDewInternalEnergy_dTemperature(
    MediumInt.setSat_p(MediumInt.pressure(states.dT_Int)));
  satDer.dudT_v_Ext := (MediumExt.specificHeatCapacityCv(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v)))) -(satDer.fv.R*satDer.sat_v.T/MediumExt.density(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v))))*satDer.fv.tau*satDer.fv.delta*satDer.fv.rtd)*
    MediumExt.pressure_derT_d(MediumExt.setDewState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_v))))/MediumExt.pressure_derd_T(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v)))))+((satDer.fv.R*satDer.sat_v.T/MediumExt.density(
    MediumExt.setDewState(MediumExt.setSat_p(MediumExt.pressure(
    satDer.sat_v))))*satDer.fv.tau*satDer.fv.delta*satDer.fv.rtd)/
    MediumExt.pressure_derd_T(MediumExt.setDewState(MediumExt.setSat_p(
    MediumExt.pressure(satDer.sat_v)))))* MediumExt.saturationPressure_derT(
    MediumExt.temperature(satDer.sat_v));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  August 13, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This example models checks the implementation of the<b> refrigerant&apos;s
partial derivatives</b>. Therefore, the user has first to introduce some
information about the refrigerant and afterwards the partial derivatives
are calculated. The following <b>refrigerant&apos;s information</b>
is required:
</p>
<ol>
<li>
The <i>refrigerant package</i> that shall be tested.
</li>
<li>
The <i>independent variables</i> i.e. independents variables'
alteration with time.
</li>
</ol>
<p>
The following <b>refrigerant&apos;s partial derivatives </b> are calculated
and checked:
</p>
<ol>
<li>Thermodynamic properties calculated by partial derivatives of the
Helmholtz equation of state (e.g. specific heat capacity at
constant pressure).</li>
<li>Partial derivatives that only depend on partial derivatives of the
Helmholtz equation of state (i.e. derivatives wrt. density
and temperature).</li>
<li>Partial derivatives that do not directly depend on partial
derivatives of the Helmholtz equation of state (i.e. derivatives not wrt.
density and temperature).</li>
<li>Partial derivatives at bubble and dew line.</li>
</ol>
<p>
Furthermore, the derivatives are compared with the associated derivatives
calculated by an external medium model (i.e. HelmholtzMediaLibrary).
</p>
</html>"), experiment);
end RefrigerantDerivatives;
