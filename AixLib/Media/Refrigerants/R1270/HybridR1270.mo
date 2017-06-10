within AixLib.Media.Refrigerants.R1270;
package HybridR1270
  "Refrigerant model for R1270 using the hybrid approach"

    /*Provide basic definitions of the refrigerent. Therefore, fullfill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
  */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
      each chemicalFormula = "C3H8",
      each structureFormula = "C3H8",
      each casRegistryNumber = "74-98-6",
      each iupacName = "Propane",
      each molarMass = 0.04409562,
      each criticalTemperature = 369.89,
      each criticalPressure = 4.2512e6,
      each criticalMolarVolume = 5e3,
      each normalBoilingPoint = 231.036,
      each triplePointTemperature = 85.525,
      each meltingPoint = 85.45,
      each acentricFactor = 0.153,
      each triplePointPressure = 0.00017,
      each dipoleMoment = 0.1,
      each hasCriticalData = true) "Thermodynamic constants for refrigerant";

  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium(
    mediumName="Propane",
    substanceNames={"Propane"},
    singleState=false,
    SpecificEnthalpy(
      start=1.0e5,
      nominal=1.0e5,
      min=177e3,
      max=576e3),
    Density(
      start=500,
      nominal=529,
      min=0.77,
      max=547),
    AbsolutePressure(
      start=1e5,
      nominal=5e5,
      min=0.5e5,
      max=30e5),
    Temperature(
      start=273.15,
      nominal=273.15,
      min=263.15,
      max=343.15),
    smoothModel=true,
    onePhase=false,
    ThermoStates=Choices.IndependentVariables.phX,
    fluidConstants=refrigerantConstants);
    /*The vector substanceNames is mandatory, as the number of
      substances is determined based on its size. Here we assume
      a single-component medium.
      singleState is true if u and d do not depend on pressure, but only
      on a thermal variable (temperature or enthalpy). Otherwise, set it
      to false.
      For a single-substance medium, just set reducedX and fixedX to true,
      and there's no need to bother about medium compositions at all. Otherwise,
      set final reducedX = true if the medium model has nS-1 independent mass
      fraction, or reducedX = false if the medium model has nS independent
      mass fractions (nS = number of substances).
      If a mixture has a fixed composition set fixedX=true, otherwise false.
      The modifiers for reducedX and fixedX should normally be final
      since the other equations are based on these values.
      
      It is also possible to redeclare the min, max, and start attributes of
      Medium types, defined in the base class Interfaces.PartialMedium
      (the example of Temperature is shown here). Min and max attributes
      should be set in accordance to the limits of validity of the medium
      model, while the start attribute should be a reasonable default value
      for the initialization of nonlinear solver iterations.
    */

  //redeclare record extends ThermodynamicState "Thermodynamic state"
  //  Density d "Density";
  //  Temperature T "Temperature";
  //  AbsolutePressure p "Pressure";
  //  SpecificEnthalpy h "Enthalpy";
  //end ThermodynamicState;
  /*The record "ThermodynamicState" contains the input arguments
    of all the function and is defined together with the used
    type definitions in PartialMedium. The record most often contains two of the
    variables "p, T, d, h" (e.g., medium.T)
  */

  redeclare replaceable model extends BaseProperties(
    h(stateSelect=StateSelect.prefer),
    d(stateSelect=StateSelect.default),
    T(stateSelect=StateSelect.default),
    p(stateSelect=StateSelect.prefer)) "Base properties of refrigerant"

    Integer phase(min=0, max=2, start=1)
    "2 for two-phase, 1 for one-phase, 0 if not known";
    SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5))
    "Saturation temperature and pressure";

  equation
    MM = fluidConstants[1].molarMass;
    phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants[1].criticalPressure) then 1 else 2;
    phase = state.phase;

    d = state.d; //density_ph(p=p,h=h,phase=phase);
    T = state.T; //temperature_ph(p=p,h=h,phase=phase);
    d = density_ph(p=p,h=h,phase=phase);
    T = temperature_ph(p=p,h=h,phase=phase);
    p = state.p; //pressure_dT(d, T, phase);
    h = state.h; //specificEnthalpy_dT(d, T, phase);

    sat.Tsat = saturationTemperature(p=p);
    sat.psat = p; //saturationPressure(T=T);

    u = h - p/d;
    R = Modelica.Constants.R/MM;
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
    its definition (see ThermodynamicState below).
    The computation of vector X[nX] from Xi[nXi] is already included in
    the base class Interfaces.PartialMedium.BaseProperties, so it should not
    be repeated here.
    The code fragment above is for a single-substance medium with
    p,T as independent variables.
  */

  /*Provide Helmholtz equatos of state (EoS). These EoS must be fitted to
    different refrigerents. However, the structure will not change and, therefore,
    the coefficients, which are obtained during the fitting procedure, are 
    provided with a record.
    Just change if needed.
  */
  redeclare function extends alpha_0
  "Dimensionless Helmholz energy (Ideal gas contribution alpha_0)"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end alpha_0;

  redeclare function extends alpha_r
  "Dimensionless Helmholz energy (Residual part alpha_r)"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end alpha_r;

  redeclare function extends tau_d_alpha_0_d_tau
  "Short form for tau*(dalpha_0/dtau)@delta=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_d_alpha_0_d_tau;

  redeclare function extends tau2_d2_alpha_0_d_tau2
  "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau2_d2_alpha_0_d_tau2;

  redeclare function extends tau_d_alpha_r_d_tau
  "Short form for tau*(dalpha_r/dtau)@delta=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_d_alpha_r_d_tau;

  redeclare function extends tau_delta_d2_alpha_r_d_tau_d_delta
  "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  redeclare function extends tau2_d2_alpha_r_d_tau2
  "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau2_d2_alpha_r_d_tau2;

  redeclare function extends delta_d_alpha_r_d_delta
  "Short form for delta*(dalpha_r/(ddelta))@tau=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta_d_alpha_r_d_delta;

  redeclare function extends delta3_d3_alpha_r_d_delta3
  "Short form for delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta3_d3_alpha_r_d_delta3;

  redeclare function extends delta2_d2_alpha_r_d_delta2
  "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
  protected
     AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta2_d2_alpha_r_d_delta2;

  /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). The
    code fragments below are examples for fitting aproaches.
  */
  redeclare function extends saturationPressure
  "Saturation pressure of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end saturationPressure;

  redeclare function extends saturationTemperature
  "Saturation temperature of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end saturationTemperature;

  redeclare function extends bubbleDensity
  "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleDensity;

  redeclare function extends dewDensity
  "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewDensity;

  redeclare function extends bubbleEnthalpy
  "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
  "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
  "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleEntropy;

  redeclare function extends dewEntropy
  "Dew curve specific entropy of propane (Ancillary equation)"
  protected
     AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewEntropy;

  /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal concutivity. Add references.
  */
  redeclare function extends dynamicViscosity
  "Calculates dynamic viscosity of refrigerant"

  protected
      Real tv[:] = {0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 2.0, 2.0, 2.0, 3.0, 4.0, 1.0, 2.0};
      Real dv[:] = {1.0, 2.0, 3.0, 13.0, 12.0, 16.0, 0.0, 18.0, 20.0, 13.0, 4.0, 0.0, 1.0};
      Real nv[:] = {-0.7548580e-1, 0.7607150, -0.1665680, 0.1627612e-5, 0.1443764e-4, -0.2759086e-6, -0.1032756, -0.2498159e-7, 0.4069891e-8, -0.1513434e-5, 0.2591327e-2, 0.5650076, 0.1207253};

      Real T_crit = fluidConstants[1].criticalTemperature;
      Real d_crit = fluidConstants[1].criticalMolarVolume;
      Real MM = fluidConstants[1].molarMass;
      Real R = Modelica.Constants.R/MM;

      ThermodynamicState dewState = setDewState(setSat_T(state.T));
      ThermodynamicState bubbleState = setBubbleState(setSat_T(state.T));
      Real dr;
      Real drL;
      Real drG;
      Real etaL;
      Real etaG;
      Real Hc = 17.1045;
      Real Tr = state.T/T_crit;

      SaturationProperties sat = setSat_T(state.T);
      Real quality = if state.phase==2 then (bubbleState.d/state.d - 1)/
        (bubbleState.d/dewState.d - 1) else 1;
      Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;

  algorithm
      if state.phase==1 or phase_dT==1 then
        eta := 0;
        dr := state.d/(d_crit*MM);
        for i in 1:11 loop
            eta := eta + nv[i]*Tr^tv[i]*dr^dv[i];
        end for;
        for i in 12:13 loop
            eta := eta + exp(-dr*dr/2)*nv[i]*Tr^tv[i]*dr^dv[i];
        end for;
        eta := (exp(eta) - 1)*Hc/1e6;
      elseif state.phase==2 or phase_dT==2 then
        etaL := 0;
        etaG := 0;
        drG := dewState.d/(d_crit*MM);
        drL := bubbleState.d/(d_crit*MM);
        for i in 1:11 loop
            etaL := etaL + nv[i]*Tr^tv[i]*drL^dv[i];
            etaG := etaG + nv[i]*Tr^tv[i]*drG^dv[i];
        end for;
        for i in 12:13 loop
            etaL := etaL + exp(-drL*drL/2)*nv[i]*Tr^tv[i]*drL^dv[i];
            etaG := etaG + exp(-drG*drG/2)*nv[i]*Tr^tv[i]*drG^dv[i];
        end for;
        etaL := (exp(etaL) - 1)*Hc/1e6;
        etaG := (exp(etaG) - 1)*Hc/1e6;
        eta := (quality/etaG + (1 - quality)/etaL)^(-1);
      end if;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
  "Calculates thermal conductivity of refrigerant"

  protected
      Real B1[:] = {-3.51153e-2,1.70890e-1,-1.47688e-1,5.19283e-2,-6.18662e-3};
      Real B2[:] = {4.69195e-2,-1.48616e-1,1.32457e-1,-4.85636e-2,6.60414e-3};
      Real C[:] = {3.66486e-4,-2.21696e-3,2.64213e+0};
      Real A[:] = {-1.24778e-3,8.16371e-3,1.99374e-2};

      Real T_crit = fluidConstants[1].criticalTemperature;
      Real d_crit = fluidConstants[1].criticalMolarVolume;
      Real MM = fluidConstants[1].molarMass;

      Real delta = state.d/(d_crit*MM);
      Real deltaL = bubbleDensity(setSat_T(state.T))/(d_crit*MM);
      Real deltaG = dewDensity(setSat_T(state.T))/(d_crit*MM);
      Real tau = T_crit/state.T;

      Real quality = if state.phase==2 then (bubbleDensity(setSat_T(
        state.T))/state.d - 1)/(bubbleDensity(setSat_T(state.T))/
        dewDensity(setSat_T(state.T)) - 1) else 1;
      Real lambda0 = A[1]+A[2]/tau+A[3]/(tau^2);
      Real lambdar = 0;
      Real lambdarL = 0;
      Real lambdarG = 0;
      Real lambdaL = 0;
      Real lambdaG = 0;

      SaturationProperties sat = setSat_T(state.T);
      Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
        then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      for i in 1:5 loop
          lambdar := lambdar + (B1[i] + B2[i]/tau)*delta^i;
      end for;
      lambda := (lambda0 + lambdar + (C[1]/(C[2] + abs(1.0/tau - 1.0))*
        exp(-(C[3]*(delta - 1.0))^2)));
    elseif state.phase==2 or phase_dT==2 then
      for i in 1:5 loop
          lambdarL := lambdarL + (B1[i] + B2[i]/tau)*deltaL^i;
          lambdarG := lambdarG + (B1[i] + B2[i]/tau)*deltaG^i;
      end for;
      lambdaL := (lambda0 + lambdarL + (C[1]/(C[2] + abs(1.0/tau - 1.0))*
        exp(-(C[3]*(deltaL - 1.0))^2)));
      lambdaG := (lambda0 + lambdarG + (C[1]/(C[2] + abs(1.0/tau - 1.0))*
        exp(-(C[3]*(deltaG - 1.0))^2)));
      lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);
    end if;
  end thermalConductivity;

  redeclare function extends surfaceTension
  "Surface tension in two phase region of refrigerant"

  algorithm
    sigma := 1e-3*55.817*(1-sat.Tsat/369.85)^1.266;
  end surfaceTension;

  /*Provide functions to calculate further thermodynamic properties depending on
    thermodynamic properties. These functions are polynomial fits in order to
    reduce computing time. Moreover, these functions may have a heuristic to deal with
    discontinuities. Add furhter fits if necessary.
  */
  redeclare function extends temperature_ph
  "Calculates temperature as function of pressure and specific enthalpy"
  protected
     AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
    SpecificEnthalpy dh = 10;
  end temperature_ph;

  redeclare function extends temperature_ps
  "Calculates temperature as function of pressure and specific entroy"
  protected
     AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
    SpecificEntropy ds = 10;
  end temperature_ps;

  redeclare function extends density_pT
  "Calculates density as function of pressure and temperature"
  protected
     AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =   AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
    AbsolutePressure dp = 10;
  end density_pT;

  redeclare function extends density_ph
  "Computes density as a function of pressure and enthalpy"
  protected
    SpecificEnthalpy dh = 10;
  end density_ph;

  redeclare function extends density_ps
  "Computes density as a function of pressure and entropy"
  protected
    SpecificEntropy ds = 50*p/(30e5-0.5e5);
  end density_ps;

  redeclare function extends specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and entropy"
  protected
    SpecificEntropy ds = 100*p/(30e5-0.5e5);
  end specificEnthalpy_ps;

  redeclare function extends density_derh_p
  "Calculates density derivative (dd/dh)@p=const"
  protected
    AbsolutePressure dp = 0.2;
  end density_derh_p;

end HybridR1270;
