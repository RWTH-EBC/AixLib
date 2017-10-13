within AixLib.Media.Refrigerants.Interfaces;
partial package PartialHybridTwoPhaseMediumFormula
  "Base class for two phase medium using a hybrid approach without records"
  extends Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  extends AixLib.Media.Refrigerants.Interfaces.Choices;
  extends AixLib.Media.Refrigerants.Interfaces.Types;

  redeclare replaceable model extends BaseProperties(
    p(stateSelect = if preferredMediumStates and
                       (componentInputChoice == InputChoice.pT or
                        componentInputChoice == InputChoice.ph or
                        componentInputChoice == InputChoice.ps) then
                        StateSelect.prefer else StateSelect.default),
    T(stateSelect = if preferredMediumStates and
                       (componentInputChoice == InputChoice.pT or
                        componentInputChoice == InputChoice.dT) then
                        StateSelect.prefer else StateSelect.default),
    d(stateSelect = if preferredMediumStates and
                       (componentInputChoice == InputChoice.dT) then
                        StateSelect.prefer else StateSelect.default),
    h(stateSelect = if preferredMediumStates and
                        (componentInputChoice == InputChoice.ph) then
                        StateSelect.prefer else StateSelect.default))
    "Base properties of refrigerant"

    // Definition of parameters
    //
    parameter InputChoice componentInputChoice = InputChoice.ph
      "Input varibles for property calculations; p and h are default choices";

    // Defition of further variables to be computed
    //
    SpecificEntropy s
      "Specific entropy of the refrigerant";
    FixedPhase phase(min=0, max=2, start=1)
      "2 for two-phase, 1 for one-phase, 0 if not known";
    SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5))
      "Saturation temperature and pressure";

  equation
    // Calculation of basic constants
    //
    R = Modelica.Constants.R/MM;
    MM = fluidConstants[1].molarMass;

    // Calculations of thermodynamic states
    //
    if (componentInputChoice == InputChoice.pT) then
      d = density_pT(p=p,T=T);
      h = specificEnthalpy_pT(p=p,T=T);
    elseif (componentInputChoice == InputChoice.dT) then
      p = pressure_dT(d=d,T=T);
      h = specificEnthalpy_dT(d=d,T=T);
    elseif (componentInputChoice == InputChoice.ph) then
      T = temperature_ph(p=p,h=h);
      d = density_ph(p=p,h=h);
    elseif (componentInputChoice == InputChoice.ps) then
      T = temperature_ps(p=p,s=s);
      d = density_ps(p=p,s=s);
      h = specificEnthalpy_ps(p=p,s=s);
    else
      assert(false, "Invalid choice of input variables for calculations");
    end if;

    s = specificEntropy(state);
    u = h - p/d;

    // Calculation of saturation state
    //
    phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants[1].criticalPressure) then 1 else 2;
    sat = setSat_p(p=p);

    // Connecting thermodynamic state record with calculated states
    //
    p = state.p;
    T = state.T;
    d = state.d;
    h = state.h;
    phase = state.phase;

  end BaseProperties;
  /*Provide an implementation of model BaseProperties,
    that is defined in PartialMedium. Select two independent
    variables from p, T, d, u, h. The other independent
    variables are the mass fractions "Xi", if there is more
    than one substance. Provide 3 equations to obtain the remaining
    variables as functions of the independent variables.
    It is also necessary to provide two additional equations to set
    the gas constant R and the molar mass MM of the medium.
    Finally, the thermodynamic state vector, defined in the base class
    Interfaces.PartialMedium.BaseProperties, should be set, according to
    its definition (see ThermodynamicState above).
    The computation of vector X[nX] from Xi[nXi] is already included in
    the base class Interfaces.PartialMedium.BaseProperties, so it should not
    be repeated here.
  */

  redeclare record extends ThermodynamicState "Thermodynamic state"
    Density d "Density";
    Temperature T "Temperature";
    AbsolutePressure p "Pressure";
    SpecificEnthalpy h "Enthalpy";
  end ThermodynamicState;
  /*The record "ThermodynamicState" contains the input arguments
    of all the function and is defined together with the used
    type definitions in PartialMedium. The record most often contains two of the
    variables "p, T, d, h" (e.g., medium.T)
    */

  /*Provide records thats contain the coefficients for the smooth transition
    between different regions.
  */
  replaceable record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph = 2.5;
    SpecificEntropy T_ps = 2.5;
    AbsolutePressure d_pT = 2.5;
    SpecificEnthalpy d_ph = 2.5;
    Real d_ps(unit="J/(Pa.K.kg)") =  25/(30e5-0.5e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 50/(30e5-0.5e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerants and the explicit formulas have to be
    provided within the template.
  */
  replaceable partial function alpha_0
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real alpha_0 = 0 "Dimensionless ideal gas Helmholz energy";
    annotation(derivative=alpha_0_der,
          Inline=false,
          LateInline=true);
  end alpha_0;

  replaceable partial function alpha_r
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real alpha_r = 0 "Dimensionless residual Helmholz energy";
    annotation(derivative=alpha_r_der,
          Inline=false,
          LateInline=true);
  end alpha_r;

  replaceable partial function tau_d_alpha_0_d_tau
    "Short form for tau*(dalpha_0/dtau)_delta=const"
    input Real tau "Temperature";
    output Real tau_d_alpha_0_d_tau = 0 "Tau*(dalpha_0/dtau)_delta=const";
    annotation(derivative=tau_d_alpha_0_d_tau_der,
          Inline=false,
          LateInline=true);
  end tau_d_alpha_0_d_tau;

  replaceable partial function tau2_d2_alpha_0_d_tau2
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
    input Real tau "Temperature";
    output Real tau2_d2_alpha_0_d_tau2 = 0
      "Tau*tau*(ddalpha_0/(dtau*dtau))_delta=const";
    annotation(derivative=tau2_d2_alpha_0_d_tau2_der,
          Inline=false,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2;

  replaceable partial function tau_d_alpha_r_d_tau
    "Short form for tau*(dalpha_r/dtau)_delta=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau_d_alpha_r_d_tau = 0 "Tau*(dalpha_r/dtau)_delta=const";
    annotation(derivative=tau_d_alpha_r_d_tau_der,
          Inline=false,
          LateInline=true);
  end tau_d_alpha_r_d_tau;

  replaceable partial function tau2_d2_alpha_r_d_tau2
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau2_d2_alpha_r_d_tau2 = 0
      "Tau*tau*(ddalpha_r/(dtau*dtau))_delta=const";
    annotation(derivative=tau2_d2_alpha_r_d_tau2_der,
          Inline=false,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2;

  replaceable partial function delta_d_alpha_r_d_delta
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real delta_d_alpha_r_d_delta = 0
      "Delta*(dalpha_r/(ddelta))_tau=const";
    annotation(derivative=delta_d_alpha_r_d_delta_der,
          Inline=false,
          LateInline=true);
  end delta_d_alpha_r_d_delta;

  replaceable partial function delta2_d2_alpha_r_d_delta2
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real delta2_d2_alpha_r_d_delta2 = 0
      "Delta*delta(ddalpha_r/(ddelta*delta))_tau=const";
    annotation(derivative=delta2_d2_alpha_r_d_delta2_der,
          Inline=false,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2;

  replaceable partial function tau_delta_d2_alpha_r_d_tau_d_delta
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau_delta_d2_alpha_r_d_tau_d_delta = 0
      "Tau*delta*(ddalpha_r/(dtau*ddelta))";
    annotation(derivative=tau_delta_d2_alpha_r_d_tau_d_delta_der,
          Inline=false,
          LateInline=true);
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  replaceable partial function tau3_d3_alpha_0_d_tau3
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
    input Real tau "Temperature";
    output Real tau3_d3_alpha_0_d_tau3 = 0
      "Tau*tau*tau(ddalpha_0/(dtau*dtau*dtau))_delta=const";
    annotation(Inline=false,
          LateInline=true);
  end tau3_d3_alpha_0_d_tau3;

  replaceable partial function tau3_d3_alpha_r_d_tau3
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau3_d3_alpha_r_d_tau3 = 0
      "Tau*tau*tau*(ddalpha_r/(dtau*dtau*dtau))_delta=const";
    annotation(Inline=false,
          LateInline=true);
  end tau3_d3_alpha_r_d_tau3;

  replaceable partial function delta3_d3_alpha_r_d_delta3
    "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real delta3_d3_alpha_r_d_delta3 = 0
      "Delta*delta*delta*(dddalpha_r/(ddelta*ddelta*ddelta))_tau=const";
    annotation(Inline=false,
          LateInline=true);
  end delta3_d3_alpha_r_d_delta3;

  replaceable partial function tau_delta2_d3_alpha_r_d_tau_d_delta2
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau_delta2_d3_alpha_r_d_tau_d_delta2 = 0
      "Tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))";
    annotation(Inline=false,
          LateInline=true);
  end tau_delta2_d3_alpha_r_d_tau_d_delta2;

  replaceable partial function tau2_delta_d3_alpha_r_d_tau2_d_delta
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
    input Real delta "Density";
    input Real tau "Temperature";
    output Real tau2_delta_d3_alpha_r_d_tau2_d_delta = 0
      "Tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))";
    annotation(Inline=false,
          LateInline=true);
  end tau2_delta_d3_alpha_r_d_tau2_d_delta;
  /*Provide functions that set the actual state depending on the given input
    parameters. Additionally, state functions for the two-phase region
    are needed.
    Just change these functions if needed.
  */
  redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates:
    if x > 0 then state_a else state_b"
    import Modelica.Media.Common.smoothStep;

  algorithm
    state := ThermodynamicState(
        p = smoothStep(x, state_a.p, state_b.p, x_small),
        T = temperature_ph(p = smoothStep(x, state_a.p, state_b.p, x_small),
                           h = smoothStep(x, state_a.h, state_b.h, x_small)),
        d = density_ph(p = smoothStep(x, state_a.p, state_b.p, x_small),
                       h = smoothStep(x, state_a.h, state_b.h, x_small)),
        h = smoothStep(x, state_a.h, state_b.h, x_small),
        phase = 0);
    annotation (Inline=true);
  end setSmoothState;

  redeclare function extends setDewState
    "Return thermodynamic state of refrigerant  on the dew line"
  algorithm
    state := ThermodynamicState(
       phase = phase,
       T = sat.Tsat,
       d = dewDensity(sat),
       p = saturationPressure(sat.Tsat),
       h = dewEnthalpy(sat));
    annotation(Inline=false,
          LateInline=true);
  end setDewState;

  redeclare function extends setBubbleState
    "Return thermodynamic state of refrigerant on the bubble line"
  algorithm
    state := ThermodynamicState(
       phase = phase,
       T = sat.Tsat,
       d = bubbleDensity(sat),
       p = saturationPressure(sat.Tsat),
       h = bubbleEnthalpy(sat));
    annotation(Inline=false,
          LateInline=true);
  end setBubbleState;

  redeclare function extends setState_dTX
    "Return thermodynamic state of refrigerant as function of d and T"
  algorithm
    state := ThermodynamicState(
      d = d,
      T = T,
      p = pressure_dT(d=d,T=T,phase=phase),
      h = specificEnthalpy_dT(d=d,T=T,phase=phase),
      phase = phase);
    annotation(derivative(noDerivative=phase)=setState_dTX_der,
          Inline=false,
          LateInline=true);
  end setState_dTX;

  redeclare function extends setState_pTX
    "Return thermodynamic state of refrigerant as function of p and T"
  algorithm
    state := ThermodynamicState(
      d = density_pT(p=p,T=T,phase=phase),
      p = p,
      T = T,
      h = specificEnthalpy_pT(p=p,T=T,phase=phase),
      phase = phase);
    annotation(derivative(noDerivative=phase)=setState_pTX_der,
          Inline=false,
          LateInline=true);
  end setState_pTX;

  redeclare function extends setState_phX
    "Return thermodynamic state of refrigerant as function of p and h"
  algorithm
    state:= ThermodynamicState(
      d = density_ph(p=p,h=h,phase=phase),
      p = p,
      T = temperature_ph(p=p,h=h,phase=phase),
      h = h,
      phase = phase);
    annotation(derivative(noDerivative=phase)=setState_phX_der,
          Inline=false,
          LateInline=true);
  end setState_phX;

  redeclare function extends setState_psX
    "Return thermodynamic state of refrigerant as function of p and s"
  algorithm
    state := ThermodynamicState(
      d = density_ps(p=p,s=s,phase=phase),
      p = p,
      T = temperature_ps(p=p,s=s,phase=phase),
      h = specificEnthalpy_ps(p=p,s=s,phase=phase),
      phase = phase);
    annotation(derivative(noDerivative=phase)=setState_psX_der,
          Inline=false,
          LateInline=true);
  end setState_psX;
  /*Provide functions to calculate thermodynamic properties using the EoS.
    Just change these functions if needed.
  */
  redeclare function extends pressure "Pressure of refrigerant"
  algorithm
    p := state.p;
    annotation(derivative=pressure_der,
          Inline=true,
          LateInline=true);
  end pressure;

  redeclare function extends temperature "Temperature of refrigerant"
  algorithm
    T := state.T;
    annotation(derivative=temperature_der,
          Inline=true,
          LateInline=true);
  end temperature;

  redeclare function extends density "Density of refrigerant"
  algorithm
    d := state.d;
    annotation(derivative=density_der,
          Inline=true,
          LateInline=true);
  end density;

  redeclare function extends specificEnthalpy
    "Specific enthalpy of refrigerant"
  algorithm
    h := state.h;
    annotation(derivative=specificEnthalpy_der,
          Inline=true,
          LateInline=true);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Specific internal energy of refrigerant"
  algorithm
    u := specificEnthalpy(state)  - pressure(state)/state.d;
    annotation(Inline=true,
          LateInline=true);
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy
    "Specific Gibbs energy of refrigerant"
  algorithm
    g := specificEnthalpy(state) - state.T*specificEntropy(state);
    annotation(Inline=true,
          LateInline=true);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Specific Helmholtz energy of refrigerant"
  algorithm
    f := specificEnthalpy(state) - pressure(state)/state.d -
      state.T*specificEntropy(state);
    annotation(Inline=true,
          LateInline=true);
  end specificHelmholtzEnergy;

  redeclare function extends specificEntropy "Specific entropy of refrigerant"
  protected
    SpecificEntropy sl;
    SpecificEntropy sv;
    SaturationProperties sat = setSat_T(state.T);

    Real d_crit = MM/fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/state.T;
    Real delta;
    Real deltaL;
    Real deltaG;
    Real quality;
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      delta := state.d/d_crit;
      s := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) -
        alpha_0(delta, tau) - alpha_r(delta, tau));
    elseif state.phase==2 or phase_dT==2 then
      deltaL := bubbleDensity(sat)/d_crit;
      deltaG := dewDensity(sat)/d_crit;
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/
        dewDensity(sat) - 1);
      sl := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaL, tau) -
        alpha_0(deltaL, tau) - alpha_r(deltaL, tau));
      sv := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaG, tau) -
        alpha_0(deltaG, tau) - alpha_r(deltaG, tau));
       s := sl + quality*(sv-sl);
    end if;
    annotation(Inline=false,
          LateInline=true);
  end specificEntropy;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity at constant pressure of refrigerant"
  algorithm
    cp := specificEnthalpy_derT_p(state);
    annotation(Inline=false,
          LateInline=true);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Specific heat capacity at constant volume of refrigerant"
  protected
     SaturationProperties sat = setSat_p(state.p);
     Real phase_dT;
     Real quality;
     Real dulT;
     Real duvT;
     Real dvlT;
     Real dvvT;
     Real dqualitydTv;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      cv := specificInternalEnergy_derT_d(state);
    elseif state.phase==2 or phase_dT==2 then
       quality := if state.phase==2 or phase_dT==2 then (bubbleDensity(sat)/
         state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
       dulT := dBubbleInternalEnergy_dTemperature(sat);
       duvT := dDewInternalEnergy_dTemperature(sat);
       dvlT := -1/(bubbleDensity(sat)^2)*dBubbleDensity_dTemperature(sat);
       dvvT := -1/(dewDensity(sat)^2)*dDewDensity_dTemperature(sat);
       dqualitydTv := (quality*dvvT + (1-quality)*dvlT)/
         (1/bubbleDensity(sat)-1/dewDensity(sat));

       cv := dulT + dqualitydTv*((dewEnthalpy(sat)-sat.psat/dewDensity(sat))-
        (bubbleEnthalpy(sat)-sat.psat/bubbleDensity(sat))) +
        quality*(duvT-dulT);
    end if;
    annotation(Inline=false,
          LateInline=true);
  end specificHeatCapacityCv;

  redeclare function extends velocityOfSound "Velocity of sound of refrigerant"

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;
    Real quality;
    Real dslp;
    Real dsvp;
    Real dvlp;
    Real dvvp;
    Real dqualitydph;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      a := sqrt(pressure_derd_T(state)-pressure_derT_d(state)*
        specificEntropy_derd_T(state)/specificEntropy_derT_d(state));
    elseif state.phase==2 or phase_dT==2 then
      quality := if state.phase==2 or phase_dT==2 then (bubbleDensity(sat)/
        state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
      dslp := dBubbleEntropy_dPressure(sat);
      dsvp := dDewEntropy_dPressure(sat);
      dvlp := -1/(bubbleDensity(sat)^2)*dBubbleDensity_dPressure(sat);
      dvvp := -1/(dewDensity(sat)^2)*dDewDensity_dPressure(sat);
      dqualitydph := (quality*dsvp + (1-quality)*dslp)/
        (bubbleEntropy(sat)-dewEntropy(sat));

      a := sqrt(-1/(state.d^2*(dvlp + dqualitydph*(1/dewDensity(sat)-
        1/bubbleDensity(sat)) + quality*(dvvp-dvlp))));
    end if;
    annotation(Inline=false,
          LateInline=true);
  end velocityOfSound;

  redeclare function extends isobaricExpansionCoefficient
    "Isobaric expansion coefficient beta of refrigerant"
  protected
    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      beta := 1/state.d * pressure_derT_d(state)/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      beta := Modelica.Constants.small;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end isobaricExpansionCoefficient;

  redeclare function extends isentropicExponent
    "Isentropic exponent defines as -v/p*(dp/dv)@s=const"
  algorithm
    gamma := state.d/state.p*velocityOfSound(state)^2;
    annotation(Inline=false,
          LateInline=true);
  end isentropicExponent;

  redeclare function extends isentropicEnthalpy
    "Isentropic enthalpy calculated by downstream pressure and reference state"
  algorithm
    h_is := specificEnthalpy(setState_ps(p=p_downstream,
      s=specificEntropy(refState)));
    annotation(Inline=false,
          LateInline=true);
  end isentropicEnthalpy;

  redeclare function extends isothermalCompressibility
    "Isothermal compressibility factor of refrigerant"
  protected
    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      kappa := 1/state.d/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      kappa := Modelica.Constants.inf;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end isothermalCompressibility;

  replaceable function isothermalThrottlingCoefficient
    "Isothermal throttling coefficient of refrigerant"
    input ThermodynamicState state "Thermodynamic state";
    output Real delta_T(unit="J/(Pa.kg)") "Isothermal throttling coefficient";

  algorithm
    delta_T := specificEnthalpy_derp_T(state);
    annotation(Inline=false,
          LateInline=true);
  end isothermalThrottlingCoefficient;

  replaceable function jouleThomsonCoefficient
    "Joule-Thomson coefficient of refrigerant"
    input ThermodynamicState state "Thermodynamic state";
    output Real my(unit="K/Pa") "Isothermal throttling coefficient";

  algorithm
    my := temperature_derp_h(state);
    annotation(Inline=false,
          LateInline=true);
  end jouleThomsonCoefficient;
  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on the
    Helmholtz EoS. Just change these functions if needed.
  */
  redeclare replaceable function pressure_dT
    "Computes pressure as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output AbsolutePressure p "Pressure";

  protected
    SaturationProperties sat = setSat_T(T);
    Real phase_dT;

  algorithm
    if phase == 0 then
      phase_dT := if not ((d < bubbleDensity(sat) and d >
        dewDensity(sat)) and T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := phase;
    end if;
    if phase_dT == 1 or phase == 1 then
      p := d*Modelica.Constants.R/fluidConstants[1].molarMass*T*
        (1+delta_d_alpha_r_d_delta(delta = d/
        (fluidConstants[1].molarMass/fluidConstants[1].criticalMolarVolume),
        tau = fluidConstants[1].criticalTemperature/T));
    elseif phase_dT == 2 or phase == 2 then
      p := saturationPressure(T);
    end if;
  annotation(derivative(noDerivative=phase)=pressure_dT_der,
          inverse(d=density_pT(p=p,T=T,phase=phase)),
          Inline=true,
          LateInline=true);
  end pressure_dT;

  redeclare replaceable function density_ph
    "Computes density as a function of pressure and enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

  protected
    SmoothTransition st;

    SpecificEnthalpy dh = st.d_ph;
    SaturationProperties sat;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;

  algorithm
    sat := setSat_p(p=p);
    h_dew := dewEnthalpy(sat);
    h_bubble := bubbleEnthalpy(sat);

    if h<h_bubble-dh or h>h_dew+dh then
      d := density_pT(p=p,T=temperature_ph(p=p,h=h));
    else
      if h<h_bubble then
        d := bubbleDensity(sat)*(1 - (h_bubble - h)/dh) + density_pT(
          p=p,T=temperature_ph(p=p,h=h))*(h_bubble - h)/dh;
      elseif h>h_dew then
        d := dewDensity(sat)*(1 - (h - h_dew)/dh) + density_pT(
          p=p,T=temperature_ph(p=p,h=h))*(h - h_dew)/dh;
      else
        d := 1/((1-(h-h_bubble)/(h_dew-h_bubble))/bubbleDensity(sat) +
          ((h-h_bubble)/(h_dew-h_bubble))/dewDensity(sat));
      end if;
    end if;
    annotation(derivative(noDerivative=phase)=density_ph_der,
          Inline=true,
          LateInline=true);
  end density_ph;

  redeclare replaceable function density_ps
    "Computes density as a function of pressure and entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Temperature";

  protected
    SmoothTransition st;

    SpecificEntropy ds = p*st.d_ps;
    SaturationProperties sat;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;

  algorithm
    sat := setSat_p(p=p);
    s_dew := dewEntropy(sat);
    s_bubble := bubbleEntropy(sat);

    if s<s_bubble-ds or s>s_dew+(75*p/(48e5-1e5)) then
      d:=density_pT(p=p,T=temperature_ps(p=p,s=s,phase=phase));
    else
      if s<s_bubble then
        d:=bubbleDensity(sat)*(1 - (s_bubble - s)/ds) + density_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s_bubble - s)/ds;
      elseif s>s_dew then
        d:=dewDensity(sat)*(1 - (s - s_dew)/ds) + density_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s - s_dew)/ds;
      else
        d:=1/((1-(s-s_bubble)/(s_dew-s_bubble))/bubbleDensity(sat) +
          ((s-s_bubble)/(s_dew-s_bubble))/dewDensity(sat));
      end if;
    end if;
    annotation(derivative(noDerivative=phase)=density_ps_der,
          Inline=false,
          LateInline=true);
  end density_ps;

  redeclare function specificEnthalpy_pT
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  algorithm
    h := specificEnthalpy_dT(density_pT(p,T,phase),T,phase);
    annotation(derivative(noDerivative=phase)=specificEnthalpy_pT_der,
          inverse(T=temperature_ph(p=p,h=h,phase=phase)),
          Inline=true,
          LateInline=true);
  end specificEnthalpy_pT;

  redeclare function specificEnthalpy_dT
    "Computes specific enthalpy as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  protected
    Real hl=0;
    Real hv=0;

    Real d_crit = MM/fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/T;
    Real delta;
    Real dewDelta;
    Real bubbleDelta;
    Real quality;

    SaturationProperties sat = setSat_T(T);
    Real phase_dT;

  algorithm
    if phase == 0 then
      phase_dT := if not ((d < bubbleDensity(sat) and d >
        dewDensity(sat)) and T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := phase;
    end if;
    if phase_dT == 1 or phase == 1 then
      delta := d/d_crit;
      h := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) +
        delta_d_alpha_r_d_delta(delta, tau) + 1);
    elseif phase_dT == 2 or phase == 2 then
      dewDelta := dewDensity(sat)/d_crit;
      bubbleDelta := bubbleDensity(sat)/d_crit;
      quality := if phase==2 or phase_dT==2 then (bubbleDensity(sat)/d - 1)/
        (bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
      hl := R*T*(tau_d_alpha_0_d_tau(tau) +
        tau_d_alpha_r_d_tau(bubbleDelta, tau) + delta_d_alpha_r_d_delta(
        bubbleDelta, tau) + 1);
      hv := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(dewDelta, tau)
        + delta_d_alpha_r_d_delta(dewDelta, tau) + 1);
      h := hl + quality*(hv-hl);
    end if;
    annotation(derivative(noDerivative=phase)=specificEnthalpy_dT_der,
          Inline=true,
          LateInline=true);
  end specificEnthalpy_dT;

  redeclare replaceable function specificEnthalpy_ps
    "Computes specific enthalpy as a function of pressure and entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  protected
    SmoothTransition st;

    SpecificEntropy ds = p*st.h_ps;
    SaturationProperties sat;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;

  algorithm
    sat := setSat_p(p=p);
    s_dew := dewEntropy(sat);
    s_bubble := bubbleEntropy(sat);

    if s<s_bubble-ds or s>s_dew+ds then
      h := specificEnthalpy_pT(p=p,T=temperature_ps(
        p=p,s=s,phase=phase),phase=phase);
    else
      h_dew := dewEnthalpy(sat);
      h_bubble := bubbleEnthalpy(sat);
      if s<s_bubble then
        h := h_bubble*(1 - (s_bubble - s)/ds) + specificEnthalpy_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s_bubble - s)/ds;
      elseif s>s_dew then
        h := h_dew*(1 - (s - s_dew)/ds) + specificEnthalpy_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s - s_dew)/ds;
      else
        h := h_bubble+(s-s_bubble)/(s_dew-s_bubble)*(h_dew-h_bubble);
      end if;
    end if;
    annotation(derivative(noDerivative=phase)=specificEnthalpy_ps_der,
          Inline=false,
          LateInline=true);
  end specificEnthalpy_ps;
  /*Provide partial derivatives in terms of density and temperature.
    These derivatives can be formulated in terms of partial derivatives of the
    Helmholtz EoS and are used to define further derivatives.
  */
  replaceable function pressure_derd_T
    "Calculates pressure derivative (dp/dd)_T=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dpdT "Pressure derivative (dp/dd)_T=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      dpdT := Modelica.Constants.R/fluidConstants[1].molarMass*
        state.T*(1 + 2*delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
        delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dpdT := Modelica.Constants.small;
    end if;
    annotation(Inline=true,
          LateInline=true);
  end pressure_derd_T;

  replaceable function pressure_derT_d
    "Calculates pressure derivative (dp/dT)_d=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dpTd "Pressure derivative (dp/dT)_d=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      dpTd:=Modelica.Constants.R/fluidConstants[1].molarMass*state.d*
        (1 + delta_d_alpha_r_d_delta(delta=delta,tau=tau) -
        tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dpTd := saturationPressure_derT(sat.Tsat);
    end if;
    annotation(Inline=true,
          LateInline=true);
  end pressure_derT_d;

  replaceable function specificEnthalpy_derT_d
    "Calculates enthalpy derivative (dh/dT)_d=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dhTd "Enthalpy derivative (dh/dT)_d=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

    Real quality;
    Real dhlT;
    Real dhvT;
    Real dvlT;
    Real dvvT;
    Real dqualitydph;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      dhTd := Modelica.Constants.R/fluidConstants[1].molarMass*
        (1 - tau2_d2_alpha_0_d_tau2(tau=tau) - tau2_d2_alpha_r_d_tau2(
        delta=delta, tau=tau) + delta_d_alpha_r_d_delta(
        delta=delta,tau=tau) - tau_delta_d2_alpha_r_d_tau_d_delta(
        delta=delta, tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      quality := if state.phase==2 or phase_dT==2 then (bubbleDensity(sat)/
        state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
      dhlT := dBubbleEnthalpy_dTemperature(sat);
      dhvT := dDewEnthalpy_dTemperature(sat);
      dvlT := -1/(bubbleDensity(sat)^2)*dBubbleDensity_dTemperature(sat);
      dvvT := -1/(dewDensity(sat)^2)*dDewDensity_dTemperature(sat);
      dqualitydph := (quality*dvvT + (1-quality)*dvlT)/
        (1/bubbleDensity(sat)-1/dewDensity(sat));

      dhTd := dhlT + dqualitydph*(dewEnthalpy(sat)-bubbleEnthalpy(sat)) +
        quality*(dhvT-dhlT);
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_derT_d;

  replaceable function specificEnthalpy_derd_T
    "Calculates enthalpy derivative (dh/dd)_T=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dhdT "Enthalpy derivative (dh/dd)_T=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      dhdT := Modelica.Constants.R/fluidConstants[1].molarMass*
        state.T/state.d*(0 + tau_delta_d2_alpha_r_d_tau_d_delta(
        delta=delta,tau=tau) + delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
        delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dhdT := -1/state.d^2*(bubbleEnthalpy(sat)-dewEnthalpy(sat))/
        (1/bubbleDensity(sat)-1/dewDensity(sat));
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_derd_T;

  replaceable function specificEntropy_derd_T
    "Calculates derivative (ds/dd)_T=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dsdT "Derivative (ds/dd)_T=const.";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real R = Modelica.Constants.R/fluidConstants[1].molarMass;
    Real delta;
    Real tau;

    ThermodynamicState state_l;
    ThermodynamicState state_v;
    Real delta_l;
    Real tau_l;
    Real delta_v;
    Real tau_v;
    Real dslTd;
    Real dsvTd;
    Real dslpT;
    Real dsvpT;
    Real dslTp;
    Real dsvTp;
    Real dsldT;
    Real dsvdT;
    Real dpT;
    Real dsvT;
    Real dslT;
    Real quality;
    Real dvT_liq;
    Real dvT_vap;
    Real dqualityTv;


  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase == 1 or phase_dT == 1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      dsdT := -R/state.d*
        (1+delta_d_alpha_r_d_delta(tau=tau, delta=delta)-
        tau_delta_d2_alpha_r_d_tau_d_delta(tau=tau, delta=delta));
    else
       state_l := setBubbleState(sat);
       state_v := setDewState(sat);
       delta_l := state_l.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
       tau_l := fluidConstants[1].criticalTemperature/state_l.T;
       delta_v := state_v.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
       tau_v := fluidConstants[1].criticalTemperature/state_v.T;

       dslTd := specificEntropy_derd_T(state_l);
       dsvTd := specificEntropy_derd_T(state_v);
       dsldT := R/state_l.d*(-(1 + delta_d_alpha_r_d_delta(tau=tau_l,
        delta=delta_l)) + (0 + tau_delta_d2_alpha_r_d_tau_d_delta(tau=tau_l,
        delta=delta_l)));
       dsvdT := R/state_v.d*(-(1 + delta_d_alpha_r_d_delta(tau=tau_v,
        delta=delta_v)) + (0 + tau_delta_d2_alpha_r_d_tau_d_delta(tau=tau_v,
        delta=delta_v)));
       dslTp := dslTd - dsldT*pressure_derT_d(state_l)/
        pressure_derd_T(state_l);
       dsvTp := dsvTd - dsvdT*pressure_derT_d(state_v)/
        pressure_derd_T(state_v);
       dslpT := dslpT/pressure_derd_T(state_l);
       dsvpT := dsvpT/pressure_derd_T(state_v);
       dpT := saturationPressure_derT(sat.Tsat);
       dsvT := dsvTp + dsvpT*dpT;
       dslT := dslTp + dslpT*dpT;

       quality := (bubbleDensity(sat)/state.d-1)/(bubbleDensity(sat)/
        dewDensity(sat)-1);
       dvT_liq :=-1/state_l.d^2*(density_derT_p(state_l) +
        density_derp_T(state_l)*dpT);
       dvT_vap :=-1/state_v.d^2*(density_derT_p(state_v) +
        density_derp_T(state_v)*dpT);
       dqualityTv :=(-dvT_liq*(1/state_v.d - 1/state_l.d) -
        (1/state.d - 1/state_l.d)*(dvT_vap - dvT_liq))/
        (1/state_v.d - 1/state_l.d)^2;

       dsdT := dslT + quality*(dsvT - dslT) + dqualityTv*
        (dewEntropy(sat)-bubbleEntropy(sat));

    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificEntropy_derd_T;

  replaceable function specificEntropy_derT_d
    "Calculates derivative (ds/dT)_d=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dsTd "Derivative (ds/dT)_d=const.";

  protected
      Real delta = state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      Real tau = fluidConstants[1].criticalTemperature/state.T;

  algorithm
    dsTd := 1/state.T*specificHeatCapacityCv(state);
    annotation(Inline=true,
          LateInline=true);
  end specificEntropy_derT_d;

  replaceable function specificInternalEnergy_derT_d
    "Calculated derivative (du/dT)_d=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real duTd "Derivative (du/dT)_d=const.";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

    Real quality;
    Real dulT;
    Real duvT;
    Real dvlT;
    Real dvvT;
    Real dqualitydTv;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase == 1 or phase_dT == 1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;

      duTd := -Modelica.Constants.R/fluidConstants[1].molarMass*
        (tau2_d2_alpha_0_d_tau2(tau=tau) + tau2_d2_alpha_r_d_tau2(delta=delta,
        tau=tau));
    else
       quality := if state.phase==2 or phase_dT==2 then (bubbleDensity(sat)/
         state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
       dulT := dBubbleInternalEnergy_dTemperature(sat);
       duvT := dDewInternalEnergy_dTemperature(sat);
       dvlT := -1/(bubbleDensity(sat)^2)*dBubbleDensity_dTemperature(sat);
       dvvT := -1/(dewDensity(sat)^2)*dDewDensity_dTemperature(sat);
       dqualitydTv := (quality*dvvT + (1-quality)*dvlT)/
         (1/bubbleDensity(sat)-1/dewDensity(sat));

       duTd := dulT + dqualitydTv*((dewEnthalpy(sat)-sat.psat/dewDensity(sat))-
        (bubbleEnthalpy(sat)-sat.psat/bubbleDensity(sat))) +
        quality*(duvT-dulT);
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificInternalEnergy_derT_d;

  replaceable function specificInternalEnergy_derd_T
    "Calculated derivative (du/dd)_T=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dudT "Derivative (du/dd)_T=const.";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

    Real delta;
    Real tau;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase == 1 or phase_dT == 1 then
      delta :=state.d/(fluidConstants[1].molarMass/
        fluidConstants[1].criticalMolarVolume);
      tau :=fluidConstants[1].criticalTemperature/state.T;
      dudT := Modelica.Constants.R/fluidConstants[1].molarMass*state.T/state.d
        *tau_delta_d2_alpha_r_d_tau_d_delta(tau=tau, delta=delta);
    else
      dudT := -1/state.d^2*((bubbleEnthalpy(sat)-sat.psat/bubbleDensity(sat))-
        (dewEnthalpy(sat)-sat.psat/dewDensity(sat)))/
        (1/bubbleDensity(sat)-1/dewDensity(sat));
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificInternalEnergy_derd_T;
  /*Provide fruther partial derivatives that can be formulated
    using the partial derivatives defined above.
  */
  redeclare function extends density_derp_T
    "Calculates the derivative (dd/dp)_T=const."

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      ddpT :=1/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      ddpT := Modelica.Constants.inf;
    end if;
    annotation(Inline=true,
          LateInline=true);
  end density_derp_T;

  redeclare function extends density_derT_p
    "Calculates the derivative (dd/dT)_p=const."

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      ddTp :=-pressure_derT_d(state)/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      ddTp := Modelica.Constants.inf;
    end if;
    annotation(Inline=true,
          LateInline=true);
  end density_derT_p;

  replaceable function temperature_derp_h
    "Calculates temperature derivative (dT/dp)_h=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dTph "Temperature derivative (dT/dp)_h=const.";

  protected
    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      dTph := 1 / (pressure_derT_d(state) - pressure_derd_T(state) *
        specificEnthalpy_derT_d(state)/specificEnthalpy_derd_T(state));
    elseif state.phase==2 or phase_dT==2 then
      dTph := saturationTemperature_derp(sat.psat);
    end if;
    annotation(Inline=true,
          LateInline=true);
  end temperature_derp_h;

  replaceable function temperature_derp_s
    "Calculates temperature derivative (dT/dp)_s=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dTps "Temperature derivative (dT/dp)_s=const.";

  protected
    Real dspT;
    Real dsTp;

  algorithm
    dspT := specificEntropy_derd_T(state=state)/pressure_derd_T(state=state);
    dsTp := 1/temperature_ders_p(state=state);

    dTps := -dspT/dsTp;
    annotation(Inline=true,
          LateInline=true);
  end temperature_derp_s;

  replaceable function temperature_ders_p
    "Calculates temperature derivative (dT/ds)@p=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dTsp "Temperature derivative (dT/ds)@p=const.";

  algorithm
    dTsp := 1/(specificEntropy_derT_d(state)-specificEntropy_derd_T(state)*
      pressure_derT_d(state)/pressure_derd_T(state));
    annotation(Inline=true,
          LateInline=true);
  end temperature_ders_p;

  replaceable function temperature_derh_p
    "Calculates temperature derivative (dT/dh)_p=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dThp "Temperature derivative (dT/dh)_p=const.";

  algorithm
    dThp := 1/specificEnthalpy_derT_p(state);
    annotation(Inline=true,
          LateInline=true);
  end temperature_derh_p;

  redeclare replaceable function extends density_derp_h
    "Calculates density derivative (dd/dp)_h=const."

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;
    Real quality;
    Real dhlp;
    Real dhvp;
    Real dvlp;
    Real dvvp;
    Real dqualitydph;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      ddph := 1 / (pressure_derd_T(state) - pressure_derT_d(state)*
      specificEnthalpy_derd_T(state)/specificEnthalpy_derT_d(state));
    elseif state.phase==2 or phase_dT==2 then
      quality := (bubbleDensity(sat)/state.d - 1)/
         (bubbleDensity(sat)/dewDensity(sat) - 1);
      dhlp := dBubbleEnthalpy_dPressure(sat);
      dhvp := dDewEnthalpy_dPressure(sat);
      dvlp := -1/(bubbleDensity(sat)^2)*dBubbleDensity_dPressure(sat);
      dvvp := -1/(dewDensity(sat)^2)*dDewDensity_dPressure(sat);
      dqualitydph := (quality*dhvp + (1-quality)*dhlp)/
        (bubbleEnthalpy(sat)-dewEnthalpy(sat));

      ddph := -state.d^2*(dvlp + dqualitydph*(1/dewDensity(sat)-
        1/bubbleDensity(sat)) + quality*(dvvp-dvlp));
    end if;
    annotation(Inline=true,
          LateInline=true);
  end density_derp_h;

  redeclare replaceable function extends density_derh_p
    "Calculates density derivative (dd/dh)_p=const."

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      ddhp := 1 / (specificEnthalpy_derd_T(state) -
        specificEnthalpy_derT_d(state)*pressure_derd_T(state)/
        pressure_derT_d(state));
    elseif state.phase==2 or phase_dT==2 then
      ddhp:=-(state.d^2)*(1/bubbleDensity(sat)-1/dewDensity(sat))/
        (bubbleEnthalpy(sat)-dewEnthalpy(sat));
    end if;
    annotation(Inline=true,
          LateInline=true);
  end density_derh_p;

  replaceable function density_derp_s
    "Calculates density derivative (dd/dp)_s=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real ddps "Derivative (dd/dp)_s=const.";

  algorithm
      ddps := 1/(pressure_derd_T(state=state)-pressure_derT_d(state=state)*
        specificEntropy_derd_T(state=state)/
        specificEntropy_derT_d(state=state));
    annotation(Inline=true,
          LateInline=true);
  end density_derp_s;

  replaceable function density_ders_p
    "Calculates density derivative (dd/ds)_p=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real ddsp "Derivative (dd/ds)_p=const.";

  algorithm
      ddsp := density_derh_p(state=state)*state.T;
    annotation(Inline=true,
          LateInline=true);
  end density_ders_p;

  replaceable function specificEnthalpy_derp_T
    "Calculates derivative (dh/dp)_T=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dhpT "Specific enthalpy derivative (dh/dp)_T=const.";

  protected
    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      dhpT := specificEnthalpy_derd_T(state)/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      dhpT := Modelica.Constants.inf;
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_derp_T;

  replaceable function specificEnthalpy_derT_p
    "Calculates derivative (dh/dT)_p=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dhTp "Specific enthalpy derivative (dh/dT)_p=const.";

  protected
    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT;

  algorithm
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if state.phase==1 or phase_dT==1 then
      dhTp := specificEnthalpy_derT_d(state)-specificEnthalpy_derd_T(state)*
        pressure_derT_d(state)/pressure_derd_T(state);
    elseif state.phase==2 or phase_dT==2 then
      dhTp := Modelica.Constants.inf;
    end if;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_derT_p;

  replaceable function specificEnthalpy_ders_p
    "Calculates derivative (dh/ds)_p=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dhsp "Specific enthalpy derivative (dh/dT)_p=const.";

  algorithm
    dhsp := state.T;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_ders_p;

  replaceable function specificEnthalpy_derp_s
    "Calculates derivative (dh/dp)_s=const."
    input ThermodynamicState state "Thermodynamic state";
    output Real dhps "Specific enthalpy derivative (dh/dp)_s=const.";

  algorithm
    dhps := 1/state.d;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_derp_s;
  /*Provide partial derivatives along the saturation line, e.g. bubble line
    or dew line.
  */
  replaceable function saturationPressure_derT
    "Calculates derivative (dp/dT)_saturation"
    input Temperature T "Temperature";
    output Real dpT "Saturation temperature derivative dp/dT)_saturation";

  protected
    SaturationProperties sat = setSat_T(T=T);

  algorithm
    dpT := (dewEntropy(sat)-bubbleEntropy(sat))/
      (1/dewDensity(sat)-1/bubbleDensity(sat));
    annotation(Inline=true);
  end saturationPressure_derT;

  redeclare function extends saturationTemperature_derp
    "Calculates derivative (dT/dp)_saturation"
  protected
    SaturationProperties sat = setSat_p(p=p);

  algorithm
    dTp := (1/dewDensity(sat)-1/bubbleDensity(sat))/
      (dewEntropy(sat)-bubbleEntropy(sat));
    annotation(Inline=true);
  end saturationTemperature_derp;

  redeclare function extends dBubbleDensity_dPressure
    "Calculates bubble point density derivative"

  protected
    ThermodynamicState state = setBubbleState(sat);

    Real ddpT = density_derp_T(state);
    Real ddTp = density_derT_p(state);
    Real dTp = saturationTemperature_derp(sat.psat);

  algorithm
    ddldp := ddpT + ddTp*dTp;
    annotation(Inline=true);
  end dBubbleDensity_dPressure;

  redeclare function extends dDewDensity_dPressure
    "Calculates dew point density derivative"

  protected
    ThermodynamicState state = setDewState(sat);

    Real ddpT = density_derp_T(state);
    Real ddTp = density_derT_p(state);
    Real dTp = saturationTemperature_derp(sat.psat);

  algorithm
    ddvdp := ddpT + ddTp*dTp;
    annotation(Inline=true);
  end dDewDensity_dPressure;

  redeclare function extends dBubbleEnthalpy_dPressure
    "Calculates bubble point enthalpy derivative"

  protected
    ThermodynamicState state = setBubbleState(sat);
    Real dhpT = specificEnthalpy_derp_T(state);
    Real dhTp = specificEnthalpy_derT_p(state);
    Real dTp = saturationTemperature_derp(sat.psat);

  algorithm
    dhldp := dhpT + dhTp*dTp;
    annotation(Inline=true);
  end dBubbleEnthalpy_dPressure;

  redeclare function extends dDewEnthalpy_dPressure
    "Calculates dew point enthalpy derivative"

  protected
    ThermodynamicState state = setDewState(sat);
    Real dhpT = specificEnthalpy_derp_T(state);
    Real dhTp = specificEnthalpy_derT_p(state);
    Real dTp = saturationTemperature_derp(sat.psat);

  algorithm
    dhvdp := dhpT + dhTp*dTp;
    annotation(Inline=true);
  end dDewEnthalpy_dPressure;

  replaceable function dBubbleEntropy_dPressure
    "Calculates bubble point entropy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real dsldp
      "Bubble point entropy derivative at constant Temperature";

  protected
    ThermodynamicState state = setBubbleState(sat);
    Real dsdT;
    Real dpdT;
    Real dsTd;
    Real dpTd;
    Real dsTp;
    Real dspT;
    Real dTp;

  algorithm
    dsdT := specificEntropy_derd_T(state);
    dsTd := specificEntropy_derT_d(state);
    dsTp := dsTd - dsdT*pressure_derT_d(state)/pressure_derd_T(state);
    dspT := dsdT/pressure_derd_T(state);
    dTp := saturationTemperature_derp(sat.psat);

    dsldp := dspT + dsTp * dTp
    annotation(Inline=true);
  end dBubbleEntropy_dPressure;

  replaceable function dDewEntropy_dPressure
    "Calculates dew point entropy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real dsvdp "Dew point entropy derivative at constant Temperature";

  protected
    ThermodynamicState state = setDewState(sat);
    Real dsdT;
    Real dpdT;
    Real dsTd;
    Real dpTd;
    Real dsTp;
    Real dspT;
    Real dTp;

  algorithm
    dsdT := specificEntropy_derd_T(state);
    dsTd := specificEntropy_derT_d(state);
    dsTp := dsTd - dsdT*pressure_derT_d(state)/pressure_derd_T(state);
    dspT := dsdT/pressure_derd_T(state);
    dTp := saturationTemperature_derp(sat.psat);

    dsvdp := dspT + dsTp * dTp
    annotation(Inline=true);
  end dDewEntropy_dPressure;

  replaceable function dBubbleDensity_dTemperature
    "Calculates bubble point density derivative"
    input SaturationProperties sat "Saturation properties";
    output Real ddlT "Bubble point density derivative wrt. temperature";

  protected
    ThermodynamicState state = setBubbleState(sat);
    Real ddTp;
    Real ddpT;
    Real dpT;

  algorithm
    ddTp := density_derT_p(state);
    ddpT := density_derp_T(state);
    dpT := saturationPressure_derT(sat.Tsat);

    ddlT := ddTp + ddpT*dpT;
    annotation(Inline=true,
          LateInline=true);
  end dBubbleDensity_dTemperature;

  replaceable function dDewDensity_dTemperature
    "Calculates dew point debsity derivative"
    input SaturationProperties sat "Saturation properties";
    output Real ddvT "Dew point density derivative wrt. temperature";

  protected
    ThermodynamicState state = setDewState(sat);
    Real ddTp;
    Real ddpT;
    Real dpT;

  algorithm
    ddTp := density_derT_p(state);
    ddpT := density_derp_T(state);
    dpT := saturationPressure_derT(sat.Tsat);

    ddvT := ddTp + ddpT*dpT;
    annotation(Inline=true,
          LateInline=true);
  end dDewDensity_dTemperature;

  replaceable function dBubbleEnthalpy_dTemperature
    "Calculates bubble point enthalpy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real dhlT "Bubble point enthalpy derivative wrt. temperature";

  protected
    ThermodynamicState state = setBubbleState(sat);
    Real dpT;

  algorithm
    dpT := saturationPressure_derT(sat.Tsat);
    dhlT := specificEnthalpy_derT_p(state) +
      specificEnthalpy_derp_T(state)*dpT;
    annotation(Inline=false,
          LateInline=true);
  end dBubbleEnthalpy_dTemperature;

  replaceable function dDewEnthalpy_dTemperature
    "Calculates dew point enthalpy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real dhvT "Dew point enthalpy derivative wrt. temperature";

  protected
    ThermodynamicState state = setDewState(sat);
    Real dpT;

  algorithm
    dpT := saturationPressure_derT(sat.Tsat);
    dhvT := specificEnthalpy_derT_p(state) +
      specificEnthalpy_derp_T(state)*dpT;
    annotation(Inline=false,
          LateInline=true);
  end dDewEnthalpy_dTemperature;

  replaceable function dBubbleInternalEnergy_dTemperature
    "Calculates bubble point internal energy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real dulT
      "Bubble point internal energy derivative wrt. temperature";

  protected
    ThermodynamicState state = setBubbleState(sat);
    Real duTd;
    Real dudT;
    Real duTp;
    Real dupT;
    Real dpT;

  algorithm
    duTd := specificInternalEnergy_derT_d(state);
    dudT := specificInternalEnergy_derd_T(state);
    duTp := duTd - dudT*pressure_derT_d(state)/pressure_derd_T(state);
    dupT := dudT/pressure_derd_T(state);
    dpT := saturationPressure_derT(sat.Tsat);

    dulT := duTp +dupT*dpT;
    annotation(Inline=false,
          LateInline=true);
  end dBubbleInternalEnergy_dTemperature;

  replaceable function dDewInternalEnergy_dTemperature
    "Calculates dew point internal energy derivative"
    input SaturationProperties sat "Saturation properties";
    output Real duvT "Dew point internal energy derivative wrt. temperature";

  protected
    ThermodynamicState state = setDewState(sat);
    Real duTd;
    Real dudT;
    Real duTp;
    Real dupT;
    Real dpT;

  algorithm
    duTd := specificInternalEnergy_derT_d(state);
    dudT := specificInternalEnergy_derd_T(state);
    duTp := duTd - dudT*pressure_derT_d(state)/pressure_derd_T(state);
    dupT := dudT/pressure_derd_T(state);
    dpT := saturationPressure_derT(sat.Tsat);

    duvT := duTp +dupT*dpT;
    annotation(Inline=false,
          LateInline=true);
  end dDewInternalEnergy_dTemperature;
  /*Provide total darivatives with respect to simulation time. These
    derivatives can be formulated using the derivatives defined above.
  */
  replaceable function alpha_0_der "Calculates time derivative of alpha_0"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_alpha_0 "Time derivative of alpha_0";

  algorithm
    der_alpha_0 := der_delta/delta + der_tau*tau_d_alpha_0_d_tau(tau=tau)/tau;
    annotation(Inline=true,
          LateInline=true);
  end alpha_0_der;

  replaceable function alpha_r_der "Calculates time derivative of alpha_r"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_alpha_r "Time derivative of alpha_r";

  algorithm
    der_alpha_r := der_delta*delta_d_alpha_r_d_delta(delta=delta,
      tau=tau)/delta + der_tau*tau_d_alpha_r_d_tau(delta=delta,tau=tau)/tau;
    annotation(Inline=true,
          LateInline=true);
  end alpha_r_der;

  replaceable function tau_d_alpha_0_d_tau_der
    "Calculates time derivative of tau_d_alpha_0_d_tau"
    input Real tau "Reduced temperature";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_tau_d_alpha_0_d_tau
      "Time derivative of tau_d_alpha_0_d_tau";

  algorithm
    der_tau_d_alpha_0_d_tau := der_tau*(tau_d_alpha_0_d_tau(tau=tau)+
      tau2_d2_alpha_0_d_tau2(tau=tau))/tau;
    annotation(Inline=true,
          LateInline=true);
  end tau_d_alpha_0_d_tau_der;

  replaceable function tau2_d2_alpha_0_d_tau2_der
    "Calculates time derivative of tau2_d2_alpha_0_d_tau2"
    input Real tau "Reduced temperature";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_tau2_d2_alpha_0_d_tau2
      "Time derivative of tau2_d2_alpha_0_d_tau2";

  algorithm
    der_tau2_d2_alpha_0_d_tau2 := der_tau*(2*tau2_d2_alpha_0_d_tau2(tau=tau)+
      tau3_d3_alpha_0_d_tau3(tau=tau))/tau;
    annotation(Inline=true,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2_der;

  replaceable function tau_d_alpha_r_d_tau_der
    "Calculates time derivative of tau_d_alpha_r_d_tau"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_tau_d_alpha_r_d_tau
      "Time derivative of tau_d_alpha_r_d_tau";

  algorithm
    der_tau_d_alpha_r_d_tau := der_tau*(tau_d_alpha_r_d_tau(delta=delta,
      tau=tau) + tau2_d2_alpha_r_d_tau2(delta=delta,tau=tau))/tau + der_delta*
      tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau)/delta;
    annotation(Inline=true,
          LateInline=true);
  end tau_d_alpha_r_d_tau_der;

  replaceable function tau2_d2_alpha_r_d_tau2_der
    "Calculates time derivative of tau2_d2_alpha_r_d_tau2"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_tau2_d2_alpha_r_d_tau2
      "Time derivative of tau2_d2_alpha_r_d_tau2";

  algorithm
    der_tau2_d2_alpha_r_d_tau2 := der_tau*(2*tau2_d2_alpha_r_d_tau2(
      delta=delta,tau=tau)+tau3_d3_alpha_r_d_tau3(delta=delta,tau=tau))/tau +
      der_delta*tau2_delta_d3_alpha_r_d_tau2_d_delta(delta=delta,tau=tau)/
      delta;
    annotation(Inline=true,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2_der;

  replaceable function delta_d_alpha_r_d_delta_der
    "Calculates time derivative of delta_d_alpha_r_d_delta"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_delta_d_alpha_r_d_delta
      "Time derivative of delta_d_alpha_r_d_delta";

  algorithm
    der_delta_d_alpha_r_d_delta := der_tau*tau_delta_d2_alpha_r_d_tau_d_delta(
      delta=delta,tau=tau)/tau + der_delta*(delta_d_alpha_r_d_delta(delta=
      delta,tau=tau)+delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau))/delta;
    annotation(Inline=true,
          LateInline=true);
  end delta_d_alpha_r_d_delta_der;

  replaceable function delta2_d2_alpha_r_d_delta2_der
    "Calculates time derivative of delta2_d2_alpha_r_d_delta2"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_delta2_d2_alpha_r_d_delta2
      "Time derivative of delta2_d2_alpha_r_d_delta2";

  algorithm
    der_delta2_d2_alpha_r_d_delta2 := der_tau*
      tau_delta2_d3_alpha_r_d_tau_d_delta2(delta=delta,tau=tau)/tau +
      der_delta*(2*delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau)+
      delta3_d3_alpha_r_d_delta3(delta=delta,tau=tau))/delta;
    annotation(Inline=true,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2_der;

  replaceable function tau_delta_d2_alpha_r_d_tau_d_delta_der
    "Calculates time derivative of tau_delta_d2_alpha_r_d_tau_d_delta"
    input Real delta "Reduced density";
    input Real tau "Reduced temperature";
    input Real der_delta "Time derivative of reduced density";
    input Real der_tau "Time derivative of reduced temperature";
    output Real der_tau_delta_d2_alpha_r_d_tau_d_delta
      "Time derivative of tau_delta_d2_alpha_r_d_tau_d_delta";

  algorithm
    der_tau_delta_d2_alpha_r_d_tau_d_delta := der_tau*(
    tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau)+
    tau2_delta_d3_alpha_r_d_tau2_d_delta(delta=delta,tau=tau))/tau
    + der_delta*(tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau) +
    tau_delta2_d3_alpha_r_d_tau_d_delta2(delta=delta,tau=tau))/delta;
    annotation(Inline=true,
          LateInline=true);
  end tau_delta_d2_alpha_r_d_tau_d_delta_der;

  replaceable function setState_dTX_der
    "Calculates time derivative of the thermodynamic state record
    calculated by d and T"
    input Density d "Density";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_d "Time derivative of density";
    input Real der_T "Time derivative of temperature";
    input Real der_X[:] "Time derivative of mass fractions";
    output ThermodynamicState der_state
      "Time derivative of thermodynamic state";

  algorithm
    der_state := ThermodynamicState(
      d = der_d,
      p = pressure_dT_der(d=d,T=T,der_d=der_d,der_T=der_T,phase=phase),
      T = der_T,
      h = specificEnthalpy_dT_der(d=d,T=T,der_d=der_d,der_T=der_T,phase=phase),
      phase = 0);
    annotation(Inline=true,
          LateInline=true);
  end setState_dTX_der;

  replaceable function setState_pTX_der
    "Calculates time derivative of the thermodynamic state record
    calculated by p and T"
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_T "Time derivative of temperature";
    input Real der_X[:] "Time derivative of mass fractions";
    output ThermodynamicState der_state
      "Time derivative of thermodynamic state";

  algorithm
    der_state := ThermodynamicState(
      d = density_pT_der(p=p,T=T,der_p=der_p,der_T=der_T,phase=phase),
      p = der_p,
      T = der_T,
      h = specificEnthalpy_pT_der(p=p,T=T,der_p=der_p,der_T=der_T,phase=phase),
      phase = 0);
    annotation(Inline=true,
          LateInline=true);
  end setState_pTX_der;

  replaceable function setState_phX_der
    "Calculates time derivative of the thermodynamic state record
    calculated by p and h"
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_h "Time derivative of specific enthalpy";
    input Real der_X[:] "Time derivative of mass fractions";
    output ThermodynamicState der_state
      "Time derivative of thermodynamic state";

  algorithm
    der_state := ThermodynamicState(
      d = density_ph_der(p=p,h=h,der_p=der_p,der_h=der_h,phase=phase),
      p = der_p,
      T = temperature_ph_der(p=p,h=h,der_p=der_p,der_h=der_h,phase=phase),
      h = der_h,
      phase = 0);
    annotation(Inline=true,
          LateInline=true);
  end setState_phX_der;

  replaceable function setState_psX_der
    "Calculates time derivative of the thermodynamic state record
    calculated by p and s"
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_s "Time derivative of specific entropy";
    input Real der_X[:] "Time derivative of mass fractions";
    output ThermodynamicState der_state
      "Time derivative of thermodynamic state";

  algorithm
    der_state := ThermodynamicState(
      d = density_ps_der(p=p,s=s,der_p=der_p,der_s=der_s,phase=phase),
      p = der_p,
      T = temperature_ps_der(p=p,s=s,der_p=der_p,der_s=der_s,phase=phase),
      h = specificEnthalpy_ps_der(p=p,s=s,der_p=der_p,der_s=der_s,phase=phase),
      phase = 0);
    annotation(Inline=true,
          LateInline=true);
  end setState_psX_der;

  replaceable function pressure_der
    "Calculates time derivative of pressure calculated by thermodynamic
    state record"
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state
      "Time derivative of thermodynamic state";
    output Real der_p "Time derivative of pressure";
  algorithm
    der_p := der_state.p;
    annotation(Inline=true,
          LateInline=true);
  end pressure_der;

  replaceable function temperature_der
    "Calculates time derivative of temperature calculated by thermodynamic
    state record"
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state
      "Time derivative of thermodynamic state";
    output Real der_T "Time derivative of temperature";
  algorithm
    der_T := der_state.T;
    annotation(Inline=true,
          LateInline=true);
  end temperature_der;

  replaceable function density_der
    "Calculates time derivative of density calculated by thermodynamic
    state record"
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state
      "Time derivative of thermodynamic state";
    output Real der_d "Time derivative of density";
  algorithm
    der_d := der_state.d;
    annotation(Inline=true,
          LateInline=true);
  end density_der;

  replaceable function specificEnthalpy_der
    "Calculates time derivative of specific enthalpy calculated by
    thermodynamic state record"
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state
      "Time derivative of thermodynamic state";
    output Real der_h "Time derivative of specific enthalpy";
  algorithm
    der_h := der_state.h;
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_der;

  replaceable function pressure_dT_der
    "Calculates time derivative of pressure_dT"
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_d "Time derivative of density";
    input Real der_T "Time derivative of temperature";
    output Real der_p "Time derivative of pressure";

  protected
    ThermodynamicState state = setState_dTX(d=d,T=T,phase=phase);

  algorithm
    der_p := der_d*pressure_derd_T(state=state) +
      der_T*pressure_derT_d(state=state);
    annotation(Inline=true,
          LateInline=true);
  end pressure_dT_der;

  replaceable function temperature_ph_der
    "Calculates time derivative of temperature_ph"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_h "Time derivative of specific enthalpy";
    output Real der_T "Time derivative of density";

  protected
    ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

  algorithm
    der_T := der_p*temperature_derp_h(state=state) +
      der_h*temperature_derh_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end temperature_ph_der;

  replaceable function temperature_ps_der
    "Calculates time derivative of temperature_ps"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_s "Time derivative of specific entropy";
    output Real der_T "Time derivative of density";

  protected
    ThermodynamicState state = setState_psX(p=p,s=s,phase=phase);

  algorithm
    der_T := der_p*temperature_derp_s(state=state) +
      der_s*temperature_ders_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end temperature_ps_der;

  replaceable function density_ph_der
    "Calculates time derivative of density_ph"
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific Enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_h "Time derivative of specific enthalpy";
    output Real der_d "Time derivative of density";

  protected
    ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

  algorithm
    der_d := der_p*density_derp_h(state=state) +
      der_h*density_derh_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end density_ph_der;

  replaceable function density_pT_der
    "Calculates time derivative of density_pT"
    input AbsolutePressure p "Pressure";
    input Temperature T "Specific Enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_T "Time derivative of temperature";
    output Real der_d "Time derivative of density";

  protected
    ThermodynamicState state = setState_pT(p=p,T=T,phase=phase);

  algorithm
    der_d := der_p*density_derp_T(state=state) +
      der_T*density_derT_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end density_pT_der;

  replaceable function density_ps_der
    "Calculates time derivative of density_ps"
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific Entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_s "Time derivative of specific entropy";
    output Real der_d "Time derivative of density";

  protected
    ThermodynamicState state = setState_ps(p=p,s=s,phase=phase);

  algorithm
    der_d := der_p*density_derp_s(state=state) +
      der_s*density_ders_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end density_ps_der;

  replaceable function specificEnthalpy_pT_der
    "Calculates time derivative of specificEnthalpy_pT"
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_T "Time derivative of temperature";
    output Real der_h "Time derivative of specific enthalpy";

  protected
    ThermodynamicState state = setState_pT(p=p,T=T,phase=phase);

  algorithm
    der_h := der_p*specificEnthalpy_derp_T(state=state) +
      der_T*specificEnthalpy_derT_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_pT_der;

  replaceable function specificEnthalpy_dT_der
    "Calculates time derivative of specificEnthalpy_dT"
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_d "Time derivative of density";
    input Real der_T "Time derivative of temperature";
    output Real der_h "Time derivative of specific enthalpy";

  protected
    ThermodynamicState state = setState_dT(d=d,T=T,phase=phase);

  algorithm
    der_h := der_d*specificEnthalpy_derd_T(state=state) +
      der_T*specificEnthalpy_derT_d(state=state);
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_dT_der;

  replaceable function specificEnthalpy_ps_der
    "Calculates time derivative of specificEnthalpy_ps"
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_s "Time derivative of specific entropy";
    output Real der_h "Time derivative of specific enthalpy";

  protected
    ThermodynamicState state = setState_psX(p=p,s=s,phase=phase);

  algorithm
    der_h := der_p*specificEnthalpy_derp_s(state=state) +
      der_s*specificEnthalpy_ders_p(state=state);
    annotation(Inline=true,
          LateInline=true);
  end specificEnthalpy_ps_der;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package provides the implementation of a refrigerant modelling approach
using a hybrid approach. The hybrid approach is developed by Sangi et al.
and consists of both the Helmholtz equation of state and fitted formula for
thermodynamic state properties at bubble or dew line (e.g. p<sub>sat</sub>
or h<sub>l,sat</sub>) and thermodynamic state properties depending on two
independent state properties (e.g. T_ph or T_ps). In the following, the basic
formulas of the hybrid approach are given.
</p>
<p>
<b>The Helmholtz equation of state</b>
</p>
<p>
The Helmholtz equation of state (EoS) allows the accurate description of
fluids&apos; thermodynamic behaviour and uses the Helmholtz energy as
fundamental thermodynamic relation with temperature and density as independent
variables. Furthermore, the EoS allows determining all thermodynamic state
properties from its partial derivatives and its<b> general formula</b> is
given below:
</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\"
alt=\"Calculation procedure of dimensionless Helmholtz energy\"/></p>
<p>
As it can be seen, the general formula of the EoS can be divided in two part:
The <b>ideal gas part (left summand) </b>and the <b>residual part (right
summand)</b>. Both parts&apos; formulas are given below:</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\"
alt=\"Calculation procedure of dimensionless ideal gas Helmholtz energy\"/></p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\"
alt=\"Calculation procedure of dimensionless residual Helmholtz energy\"/></p>
<p>
Both, the ideal gas part and the residual part can be divided in three
subparts (i.e. the summations) that contain different coefficients (e.g. nL,
l<sub>i</sub>, p<sub>i</sub> or e<sub>i</sub>). These coefficients are
fitting coefficients and must be obtained during a fitting procedure. While
the fitting procedure, the general formula of the EoS is fitted to external
data (e.g. obtained from measurements or external media libraries) and the
fitting coefficients are determined. Finally, the formulas obtained during
the fitting procedure are implemented in an explicit form.
</p>
<p>
For further information of <b>the EoS and its partial derivatives</b>, please
read the paper &quot;
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia -
A fluid properties library</a>&quot; by Thorade and Saadat as well as the
paper &quot;
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic
simulation</a>&quot; by Thorade and Saadat.
</p>
<p>
<b>Fitted formulas</b>
</p>
<p>
Fitted formulas allow to reduce the overall computing time of the refrigerant
model. Therefore, both thermodynamic state properties at bubble and dew line
and thermodynamic state properties depending on two independent state
properties are expresses as fitted formulas. The fitted formulas&apos;
approaches implemented in this package are developed by Sangi et al. within
their &quot;Fast_Propane&quot; model and given below:<br />
</p>
<table summary=\"Formulas for calculating saturation properties\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"
style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p>
  <i>Saturation pressure</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationPressure.png\"
  alt=\"Formula to calculate saturation pressure\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Saturation temperature</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationTemperature.png\"
  alt=\"Formula to calculate saturation temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble density</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleDensity.png\"
  alt=\"Formula to calculate bubble density\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew density</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewDensity.png\"
  alt=\"Formula to calculate dew density\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble Enthalpy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEnthalpy.png\"
  alt=\"Formula to calculate bubble enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew Enthalpy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEnthalpy.png\"
  alt=\"Formula to calculate dew enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble Entropy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEntropy.png\"
  alt=\"Formula to calculate bubble entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew Entropy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEntropy.png\"
  alt=\"Formula to calculate dew entropy\"/>
</p></td>
</tr>
</table>
<table summary=\"Formulas for calculating thermodynamic properties at
superheated and supercooled regime\" cellspacing=\"0\" cellpadding=\"3\"
border=\"1\" width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Temperature_ph</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\"
  alt=\"First input required to calculate temperature by pressure and specific
  enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\"
  alt=\"Second input required to calculate temperature by pressure and
  specific enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Temperature_ps</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\"
  alt=\"First input required to calculate temperature by pressure and
  specific entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\"
  alt=\"Second input required to calculate temperature by pressure and
  specific entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Density_pT</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\"
  alt=\"First input required to calculate density by pressure and temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\"
  alt=\"Second input required to calculate density by pressure and
  temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Functional approach
</i></p></td>
<td valign=\"middle\" colspan=\"2\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"
  alt=\"Calculation procedure for supercooled and superheated region\"/>
</p></td>
</tr>
</table>
<p>
As it can be seen, the fitted formulas consist basically of the coefficients
e<sub>i</sub>, c<sub>i</sub> as well as of the parameters Mean<sub>i</sub>
and Std<sub>i</sub>. These coefficients are the fitting coefficients and must
be obtained during a fitting procedure. While the fitting procedure, the
formulas presented above are fitted to external data (e.g. obtained from
measurements or external media libraries) and the fitting coefficients are
determined. Finally, the formulas obtained during the fitting procedure are
implemented in an explicit form.
</p>
<p>
For further information of <b>the hybrid approach</b>, please read the paper
&quot;<a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the
Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>&quot;
by Sangi et al..
</p>
<p>
<b>Smooth transition</b>
</p>
<p>
To ensure a smooth transition between different regions (e.g. from supercooled
region to two-phase region) and, therefore, to avoid discontinuities as far as
possible, Sangi et al. implemented functions for a smooth transition between
the regions. An example (i.e. specificEnthalpy_ps) of these functions is
given below:<br />
</p>
<table summary=\"Calculation procedures to avoid numerical instability at
phase change\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"
style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p>
  <i>From supercooled region to bubble line and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\"
  alt=\"Calculation procedure for change from supercooled to two-phase\"/>
</p></td>
<tr>
<td valign=\"middle\"><p>
  <i>From dew line to superheated region and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\"
  alt=\"Calculation procedure for change from superheated to two-phase\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>From bubble or dew line to two-phase region and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\"
  alt=\"Calculation procedure for change from saturation to two-phase\"/>
</p></td>
</tr>
</table>
<h4>Assumptions and limitations</h4>
<p>
Three limitations are known for this package:
</p>
<ol>
<li>The modelling approach implemented in this package is a hybrid approach
and, therefore, is based on the Helmholtz equation of state as well as on
fitted formula. Hence, the refrigerant model is just valid within the valid
range of the fitted formula.</li>
<li>It may be possible to have discontinuities when moving from one region
to another (e.g. from supercooled region to two-phase region). However,
functions are implemented to reach a smooth transition between the regions
and to avoid these discontinuities as far as possible.
(Sangi et al., 2014)</li>
</ol>
<h4>Typical use and important parameters</h4>
<p>
The refrigerant models provided in this package are typically used for heat
pumps and refrigerating machines. However, it is just a partial package and,
hence, it must be completed before usage. In order to allow an easy
completion of the package, a template is provided in
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">
AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula</a>.
</p>
<h4>References</h4>
<p>
Thorade, Matthis; Saadat, Ali (2012):
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia -
A fluid properties library</a>. In: <i>Proceedings of the 9th International
Modelica Conference</i>; September 3-5; 2012; Munich; Germany.
Link&ouml;ping University Electronic Press, S. 63&ndash;70.
</p>
<p>
Thorade, Matthis; Saadat, Ali (2013):
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic
simulation</a>. In:<i> Environmental earth sciences 70 (8)</i>,
S. 3497&ndash;3503.
</p>
<p>
Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">
A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic
Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund,
Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press
(Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275
</p>
<p>
Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat Pumps -
Modeling, Simulation and Exergy Analysis. <i>Master thesis</i>
</p>
</html>"));
end PartialHybridTwoPhaseMediumFormula;
