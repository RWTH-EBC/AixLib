within AixLib.Media.Refrigerants.R134a;
package R134a_IIR_P1_295_T233_370_Formula
  "Refrigerant model developed by Engelpracht"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
  */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
     each chemicalFormula = "CF3CH2F",
     each structureFormula = "1,1,1,2-tetrafluoroethane",
     each casRegistryNumber = "811-97-2",
     each iupacName = "tetrafluoroethan",
     each molarMass = 0.102032,
     each criticalTemperature = 374.21,
     each criticalPressure = 4.059280000000001e+06,
     each criticalMolarVolume = 4978.830171,
     each triplePointTemperature = 169.85,
     each triplePointPressure = 389.563789,
     each normalBoilingPoint = 247.076,
     each meltingPoint = 172.15,
     each acentricFactor = 0.32684,
     each dipoleMoment = 1.99,
     each hasCriticalData=true) "Thermodynamic constants for R134a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R134a",
    substanceNames={"R134a"},
    singleState=false,
    SpecificEnthalpy(
      start=1.0e5,
      nominal=1.0e5,
      min=151000,
      max=492700),
    Density(
      start=500,
      nominal=529,
      min=3.5,
      max=1425),
    AbsolutePressure(
      start=1e5,
      nominal=5e5,
      min=1e5,
      max=39.5e5),
    Temperature(
      start=273.15,
      nominal=273.15,
      min=233.15,
      max=370.15),
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

    The code fragments above are for a single-substance medium with
    p,T as independent variables.
  */

  /*Provide records thats contain the coefficients for the smooth transition
    between different regions.
  */
  redeclare record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph = 10;
    SpecificEntropy T_ps = 10;
    AbsolutePressure d_pT = 10;
    SpecificEnthalpy d_ph = 10;
    Real d_ps(unit="J/(Pa.K.kg)") =  50/(39.5e5-1e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 100/(39.5e5-1e5);
    AbsolutePressure d_derh_p = 0.2;
  end SmoothTransition;

  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  redeclare function extends alpha_0
  "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  algorithm
    alpha_0 := (-1.629789) * log(tau) + (-1.019535)  + (9.047135) * tau + (-9.723916) * tau^(-0.5) + (-3.92717) * tau^(-0.75) + log(delta);
  annotation(Inline=false,
          LateInline=true);
  end alpha_0;

  redeclare function extends alpha_r
  "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    alpha_r := (0.05586817) * delta^(-0.5) * tau^(2) * exp(-delta^(0)) + (0.498223) * delta^(0) * tau^(1) * exp(-delta^(0)) + (0.02458698) * delta^(0) * tau^(3) * exp(-delta^(0)) + (0.0008570145) * delta^(0) * tau^(6) * exp(-delta^(0)) + (0.0004788584) * delta^(1.5) * tau^(6) * exp(-delta^(0)) + (-1.800808) * delta^(1.5) * tau^(1) * exp(-delta^(0)) + (0.2671641) * delta^(2) * tau^(1) * exp(-delta^(0)) + (-0.04781652) * delta^(2) * tau^(2) * exp(-delta^(0)) + (0.01423987) * delta^(1) * tau^(5) * exp(-delta^(1)) + (0.3324062) * delta^(3) * tau^(2) * exp(-delta^(1)) + (-0.007485907) * delta^(5) * tau^(2) * exp(-delta^(1)) + (0.0001017263) * delta^(1) * tau^(4) * exp(-delta^(2)) + (-0.5184567) * delta^(5) * tau^(1) * exp(-delta^(2)) + (-0.08692288) * delta^(5) * tau^(4) * exp(-delta^(2)) + (0.2057144) * delta^(6) * tau^(1) * exp(-delta^(2)) + (-0.005000457) * delta^(10) * tau^(2) * exp(-delta^(2)) + (0.0004603262) * delta^(10) * tau^(4) * exp(-delta^(2)) + (-0.003497836) * delta^(10) * tau^(1) * exp(-delta^(3)) + (0.006995038) * delta^(18) * tau^(5) * exp(-delta^(3)) + (-0.01452184) * delta^(22) * tau^(3) * exp(-delta^(3)) + (-0.0001285458) * delta^(50) * tau^(10) * exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end alpha_r;

  redeclare function extends tau_d_alpha_0_d_tau
  "Short form for tau*(dalpha_0/dtau)@delta=const"
  algorithm
    tau_d_alpha_0_d_tau := (-1.629789)*(1) + (-1.019535)*(0)*tau^(0) + (9.047135)*(1)*tau^(1) + (-9.723916)*(-0.5)*tau^(-0.5) + (-3.92717)*(-0.75)*tau^(-0.75);
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_0_d_tau;

  redeclare function extends tau2_d2_alpha_0_d_tau2
  "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
  algorithm
    tau2_d2_alpha_0_d_tau2 := -(-1.629789)*(1) + (-1.019535)*(0)*((0)-1)*tau^(0) + (9.047135)*(1)*((1)-1)*tau^(1) + (-9.723916)*(-0.5)*((-0.5)-1)*tau^(-0.5) + (-3.92717)*(-0.75)*((-0.75)-1)*tau^(-0.75);
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2;

  redeclare function extends tau_d_alpha_r_d_tau
  "Short form for tau*(dalpha_r/dtau)@delta=const"
  algorithm
    tau_d_alpha_r_d_tau := (0.05586817)*(2)*delta^(-0.5)*tau^(2)*exp(-delta^(0)) + (0.498223)*(1)*delta^(0)*tau^(1)*exp(-delta^(0)) + (0.02458698)*(3)*delta^(0)*tau^(3)*exp(-delta^(0)) + (0.0008570145)*(6)*delta^(0)*tau^(6)*exp(-delta^(0)) + (0.0004788584)*(6)*delta^(1.5)*tau^(6)*exp(-delta^(0)) + (-1.800808)*(1)*delta^(1.5)*tau^(1)*exp(-delta^(0)) + (0.2671641)*(1)*delta^(2)*tau^(1)*exp(-delta^(0)) + (-0.04781652)*(2)*delta^(2)*tau^(2)*exp(-delta^(0)) + (0.01423987)*(5)*delta^(1)*tau^(5)*exp(-delta^(1)) + (0.3324062)*(2)*delta^(3)*tau^(2)*exp(-delta^(1)) + (-0.007485907)*(2)*delta^(5)*tau^(2)*exp(-delta^(1)) + (0.0001017263)*(4)*delta^(1)*tau^(4)*exp(-delta^(2)) + (-0.5184567)*(1)*delta^(5)*tau^(1)*exp(-delta^(2)) + (-0.08692288)*(4)*delta^(5)*tau^(4)*exp(-delta^(2)) + (0.2057144)*(1)*delta^(6)*tau^(1)*exp(-delta^(2)) + (-0.005000457)*(2)*delta^(10)*tau^(2)*exp(-delta^(2)) + (0.0004603262)*(4)*delta^(10)*tau^(4)*exp(-delta^(2)) + (-0.003497836)*(1)*delta^(10)*tau^(1)*exp(-delta^(3)) + (0.006995038)*(5)*delta^(18)*tau^(5)*exp(-delta^(3)) + (-0.01452184)*(3)*delta^(22)*tau^(3)*exp(-delta^(3)) + (-0.0001285458)*(10)*delta^(50)*tau^(10)*exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_r_d_tau;

  redeclare function extends tau2_d2_alpha_r_d_tau2
  "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
  algorithm
    tau2_d2_alpha_r_d_tau2 := (0.05586817)*(2)*((2)-1)*delta^(-0.5)*tau^(2)*exp(-delta^(0)) + (0.498223)*(1)*((1)-1)*delta^(0)*tau^(1)*exp(-delta^(0)) + (0.02458698)*(3)*((3)-1)*delta^(0)*tau^(3)*exp(-delta^(0)) + (0.0008570145)*(6)*((6)-1)*delta^(0)*tau^(6)*exp(-delta^(0)) + (0.0004788584)*(6)*((6)-1)*delta^(1.5)*tau^(6)*exp(-delta^(0)) + (-1.800808)*(1)*((1)-1)*delta^(1.5)*tau^(1)*exp(-delta^(0)) + (0.2671641)*(1)*((1)-1)*delta^(2)*tau^(1)*exp(-delta^(0)) + (-0.04781652)*(2)*((2)-1)*delta^(2)*tau^(2)*exp(-delta^(0)) + (0.01423987)*(5)*((5)-1)*delta^(1)*tau^(5)*exp(-delta^(1)) + (0.3324062)*(2)*((2)-1)*delta^(3)*tau^(2)*exp(-delta^(1)) + (-0.007485907)*(2)*((2)-1)*delta^(5)*tau^(2)*exp(-delta^(1)) + (0.0001017263)*(4)*((4)-1)*delta^(1)*tau^(4)*exp(-delta^(2)) + (-0.5184567)*(1)*((1)-1)*delta^(5)*tau^(1)*exp(-delta^(2)) + (-0.08692288)*(4)*((4)-1)*delta^(5)*tau^(4)*exp(-delta^(2)) + (0.2057144)*(1)*((1)-1)*delta^(6)*tau^(1)*exp(-delta^(2)) + (-0.005000457)*(2)*((2)-1)*delta^(10)*tau^(2)*exp(-delta^(2)) + (0.0004603262)*(4)*((4)-1)*delta^(10)*tau^(4)*exp(-delta^(2)) + (-0.003497836)*(1)*((1)-1)*delta^(10)*tau^(1)*exp(-delta^(3)) + (0.006995038)*(5)*((5)-1)*delta^(18)*tau^(5)*exp(-delta^(3)) + (-0.01452184)*(3)*((3)-1)*delta^(22)*tau^(3)*exp(-delta^(3)) + (-0.0001285458)*(10)*((10)-1)*delta^(50)*tau^(10)*exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2;

  redeclare function extends delta_d_alpha_r_d_delta
  "Short form for delta*(dalpha_r/(ddelta))@tau=const"
  algorithm
    delta_d_alpha_r_d_delta := (0.05586817)*delta^(-0.5)*tau^(2)*((-0.5)-(0)*delta^(0))*exp(-delta^(0)) + (0.498223)*delta^(0)*tau^(1)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.02458698)*delta^(0)*tau^(3)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.0008570145)*delta^(0)*tau^(6)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.0004788584)*delta^(1.5)*tau^(6)*((1.5)-(0)*delta^(0))*exp(-delta^(0)) + (-1.800808)*delta^(1.5)*tau^(1)*((1.5)-(0)*delta^(0))*exp(-delta^(0)) + (0.2671641)*delta^(2)*tau^(1)*((2)-(0)*delta^(0))*exp(-delta^(0)) + (-0.04781652)*delta^(2)*tau^(2)*((2)-(0)*delta^(0))*exp(-delta^(0)) + (0.01423987)*delta^(1)*tau^(5)*((1)-(1)*delta^(1))*exp(-delta^(1)) + (0.3324062)*delta^(3)*tau^(2)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (-0.007485907)*delta^(5)*tau^(2)*((5)-(1)*delta^(1))*exp(-delta^(1)) + (0.0001017263)*delta^(1)*tau^(4)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.5184567)*delta^(5)*tau^(1)*((5)-(2)*delta^(2))*exp(-delta^(2)) + (-0.08692288)*delta^(5)*tau^(4)*((5)-(2)*delta^(2))*exp(-delta^(2)) + (0.2057144)*delta^(6)*tau^(1)*((6)-(2)*delta^(2))*exp(-delta^(2)) + (-0.005000457)*delta^(10)*tau^(2)*((10)-(2)*delta^(2))*exp(-delta^(2)) + (0.0004603262)*delta^(10)*tau^(4)*((10)-(2)*delta^(2))*exp(-delta^(2)) + (-0.003497836)*delta^(10)*tau^(1)*((10)-(3)*delta^(3))*exp(-delta^(3)) + (0.006995038)*delta^(18)*tau^(5)*((18)-(3)*delta^(3))*exp(-delta^(3)) + (-0.01452184)*delta^(22)*tau^(3)*((22)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0001285458)*delta^(50)*tau^(10)*((50)-(4)*delta^(4))*exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end delta_d_alpha_r_d_delta;

  redeclare function extends delta2_d2_alpha_r_d_delta2
  "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
  algorithm
    delta2_d2_alpha_r_d_delta2 := (0.05586817)*delta^(-0.5)*tau^(2)*(((-0.5)-(0)*delta^(0))*((-0.5)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.498223)*delta^(0)*tau^(1)*(((0)-(0)*delta^(0))*((0)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.02458698)*delta^(0)*tau^(3)*(((0)-(0)*delta^(0))*((0)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.0008570145)*delta^(0)*tau^(6)*(((0)-(0)*delta^(0))*((0)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.0004788584)*delta^(1.5)*tau^(6)*(((1.5)-(0)*delta^(0))*((1.5)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (-1.800808)*delta^(1.5)*tau^(1)*(((1.5)-(0)*delta^(0))*((1.5)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.2671641)*delta^(2)*tau^(1)*(((2)-(0)*delta^(0))*((2)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (-0.04781652)*delta^(2)*tau^(2)*(((2)-(0)*delta^(0))*((2)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.01423987)*delta^(1)*tau^(5)*(((1)-(1)*delta^(1))*((1)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.3324062)*delta^(3)*tau^(2)*(((3)-(1)*delta^(1))*((3)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.007485907)*delta^(5)*tau^(2)*(((5)-(1)*delta^(1))*((5)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.0001017263)*delta^(1)*tau^(4)*(((1)-(2)*delta^(2))*((1)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.5184567)*delta^(5)*tau^(1)*(((5)-(2)*delta^(2))*((5)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.08692288)*delta^(5)*tau^(4)*(((5)-(2)*delta^(2))*((5)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (0.2057144)*delta^(6)*tau^(1)*(((6)-(2)*delta^(2))*((6)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.005000457)*delta^(10)*tau^(2)*(((10)-(2)*delta^(2))*((10)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (0.0004603262)*delta^(10)*tau^(4)*(((10)-(2)*delta^(2))*((10)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.003497836)*delta^(10)*tau^(1)*(((10)-(3)*delta^(3))*((10)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (0.006995038)*delta^(18)*tau^(5)*(((18)-(3)*delta^(3))*((18)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.01452184)*delta^(22)*tau^(3)*(((22)-(3)*delta^(3))*((22)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.0001285458)*delta^(50)*tau^(10)*(((50)-(4)*delta^(4))*((50)-1-(4)*delta^(4))-(4)^2*delta^(4))*exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2;

  redeclare function extends tau_delta_d2_alpha_r_d_tau_d_delta
  "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  algorithm
    tau_delta_d2_alpha_r_d_tau_d_delta := (0.05586817)*(2)*delta^(-0.5)*tau^(2)*((-0.5)-(0)*delta^(0))*exp(-delta^(0)) + (0.498223)*(1)*delta^(0)*tau^(1)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.02458698)*(3)*delta^(0)*tau^(3)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.0008570145)*(6)*delta^(0)*tau^(6)*((0)-(0)*delta^(0))*exp(-delta^(0)) + (0.0004788584)*(6)*delta^(1.5)*tau^(6)*((1.5)-(0)*delta^(0))*exp(-delta^(0)) + (-1.800808)*(1)*delta^(1.5)*tau^(1)*((1.5)-(0)*delta^(0))*exp(-delta^(0)) + (0.2671641)*(1)*delta^(2)*tau^(1)*((2)-(0)*delta^(0))*exp(-delta^(0)) + (-0.04781652)*(2)*delta^(2)*tau^(2)*((2)-(0)*delta^(0))*exp(-delta^(0)) + (0.01423987)*(5)*delta^(1)*tau^(5)*((1)-(1)*delta^(1))*exp(-delta^(1)) + (0.3324062)*(2)*delta^(3)*tau^(2)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (-0.007485907)*(2)*delta^(5)*tau^(2)*((5)-(1)*delta^(1))*exp(-delta^(1)) + (0.0001017263)*(4)*delta^(1)*tau^(4)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.5184567)*(1)*delta^(5)*tau^(1)*((5)-(2)*delta^(2))*exp(-delta^(2)) + (-0.08692288)*(4)*delta^(5)*tau^(4)*((5)-(2)*delta^(2))*exp(-delta^(2)) + (0.2057144)*(1)*delta^(6)*tau^(1)*((6)-(2)*delta^(2))*exp(-delta^(2)) + (-0.005000457)*(2)*delta^(10)*tau^(2)*((10)-(2)*delta^(2))*exp(-delta^(2)) + (0.0004603262)*(4)*delta^(10)*tau^(4)*((10)-(2)*delta^(2))*exp(-delta^(2)) + (-0.003497836)*(1)*delta^(10)*tau^(1)*((10)-(3)*delta^(3))*exp(-delta^(3)) + (0.006995038)*(5)*delta^(18)*tau^(5)*((18)-(3)*delta^(3))*exp(-delta^(3)) + (-0.01452184)*(3)*delta^(22)*tau^(3)*((22)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0001285458)*(10)*delta^(50)*tau^(10)*((50)-(4)*delta^(4))*exp(-delta^(4));
  annotation(Inline=false,
          LateInline=true);
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). 
    Currently, just one fitting approach is implemented.
  */
  redeclare function extends saturationPressure
  "Saturation pressure of refrigerant (Ancillary equation)"
  protected
    Real OM = (1 - T/fluidConstants[1].criticalTemperature);

  algorithm
    if T>fluidConstants[1].criticalTemperature then
      p := fluidConstants[1].criticalPressure;
    elseif T<fluidConstants[1].triplePointTemperature then
      p := fluidConstants[1].triplePointPressure;
    else
      p := fluidConstants[1].criticalPressure * exp((fluidConstants[1].criticalTemperature/T) * ((-5.29535582243675)*OM^(0.927890501793078) + (-5.15024230998653)*OM^(0.927889861253321) + (-3.13553371894143)*OM^(3.24457658937591) + (3.81009392578704)*OM^(0.866053953377016) + (-10.0339381768489)*OM^(7.91909121618172)));
    end if;
    annotation(Inline=false,
          LateInline=true);
  end saturationPressure;

  redeclare function extends saturationTemperature
  "Saturation temperature of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (p - (1173800.40711465))/(1099321.32004152);
    T := (303.15) + (40.457817538765) * ((0.38249253104432) + (0.892255186981679)*x^1 + (-0.320459852390984)*x^2 + (0.231277309474011)*x^3 + (-0.134756698170718)*x^4 + (-0.205778664289702)*x^5 + (0.282001632207744)*x^6 + (0.334501685240843)*x^7 + (-0.774526008534057)*x^8 + (0.476452166349933)*x^9 + (0.0593606578796145)*x^10 + (-0.568839868842873)*x^11 + (0.780471017454786)*x^12 + (-0.354221116728346)*x^13 + (-0.253413897218538)*x^14 + (0.425168770423832)*x^15 + (-0.249050314762991)*x^16 + (0.0770475764642235)*x^17 + (-0.012572124352724)*x^18 + (0.000856145215973102)*x^19);
    annotation(Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
  "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (303.15))/(40.457817538765);
    dl := (1154.76921560841) + (186.377105500294) * ((0.175929581543644) + (-0.852119620735449)*x^1 + (-0.127670555032919)*x^2 + (-0.0374485959337434)*x^3 + (-0.00608897193476253)*x^4 + (-0.015629210325371)*x^5 + (-0.0278957421821363)*x^6 + (0.0228301975089902)*x^7 + (0.0427509092895292)*x^8 + (-0.0229939450681468)*x^9 + (-0.0238499545719808)*x^10 + (-0.000616337915310588)*x^11 + (-0.0105366608468246)*x^12 + (0.00877619977663642)*x^13 + (0.00966016249453505)*x^14 + (0.0015035390606699)*x^15 + (0.0052745028368933)*x^16 + (-0.00324890680807353)*x^17 + (-0.00304627975391413)*x^18 + (-0.00139835845666441)*x^19 + (-0.00271392542422017)*x^20 + (0.00115118761651369)*x^21 + (0.00102217606099457)*x^22 + (0.000692222421841495)*x^23 + (0.00117810694822977)*x^24 + (-0.000711233946249634)*x^25 + (-0.000884554304484925)*x^26 + (0.000201449273758331)*x^27 + (0.000222365658261271)*x^28 + (-1.95142006499461e-05)*x^29 + (-1.99050688360501e-05)*x^30);
    annotation(Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
  "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (303.15))/(40.457817538765);
    dv := (69.6350562981406) + (78.2018951633148) * ((-0.410573575889814) + (0.571375643654458)*x^1 + (0.290203185591792)*x^2 + (0.0944670658995607)*x^3 + (0.0335588375215924)*x^4 + (0.0213729212936608)*x^5 + (0.0125403112808612)*x^6 + (0.00163884176955777)*x^7 + (-0.00442695150412588)*x^8 + (-0.0160629389592364)*x^9 + (-0.0157770655470561)*x^10 + (0.0104752961686273)*x^11 + (0.0192116863158408)*x^12 + (0.00928365063283756)*x^13 + (0.00577975219114743)*x^14 + (-0.00152493313354843)*x^15 + (-0.00633529330607583)*x^16 + (-0.00993446985358331)*x^17 + (-0.0100260256225324)*x^18 + (0.00156280037379907)*x^19 + (0.00404298825822586)*x^20 + (0.00487742079986775)*x^21 + (0.0101819654961302)*x^22 + (-0.000959792897754829)*x^23 + (-0.0107006379492618)*x^24 + (-0.00199991775882815)*x^25 + (0.00441713821541128)*x^26 + (0.00129166033049564)*x^27 + (-0.00086631140654061)*x^28 + (-0.000306003129608424)*x^29 + (6.70712781452191e-05)*x^30 + (2.6424608384756e-05)*x^31);
    annotation(Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
  "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711509))/(1099321.32004199);
    hl := (246214.388066966) + (61231.3334054695) * ((0.301093896760792) + (0.898379169203496)*x^1 + (-0.258319108109933)*x^2 + (0.194785429539137)*x^3 + (-0.0846449464610971)*x^4 + (-0.19514687212152)*x^5 + (0.0948185681821124)*x^6 + (0.511695939749379)*x^7 + (-0.501764195128414)*x^8 + (-0.154498103846821)*x^9 + (0.30180839243061)*x^10 + (-0.104020450003939)*x^11 + (0.179958908866564)*x^12 + (-0.180419896118152)*x^13 + (-0.0759150034894905)*x^14 + (0.222156994328846)*x^15 + (-0.153093505731763)*x^16 + (0.0519961916132593)*x^17 + (-0.00903354208639087)*x^18 + (0.000643955583122244)*x^19);
    annotation(Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
  "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711465))/(1099321.32004152);
    hv := (409576.287023374) + (16957.9188539679) * ((0.716885920461567) + (0.847986730088046)*x^1 + (-0.550946254566628)*x^2 + (0.246372277496221)*x^3 + (-0.245243281452568)*x^4 + (0.206740480104201)*x^5 + (-0.130568776308635)*x^6 + (0.096151215082195)*x^7 + (0.0767890190523656)*x^8 + (-0.308799991735697)*x^9 + (0.165337515949091)*x^10 + (0.191088567972776)*x^11 + (-0.277432585048023)*x^12 + (0.147469798302808)*x^13 + (-0.0665601068588061)*x^14 + (0.0499552429639684)*x^15 + (-0.0311947330620793)*x^16 + (0.0109988406358016)*x^17 + (-0.0019919160005003)*x^18 + (0.000146114755723916)*x^19);
    annotation(Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
  "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711509))/(1099321.32004199);
    sl := (1143.41719860427) + (197.97154554642) * ((0.367254501164274) + (0.864782086800948)*x^1 + (-0.322942845043548)*x^2 + (0.124473252062715)*x^3 + (0.104039083894388)*x^4 + (0.103128885664524)*x^5 + (-0.428783234059689)*x^6 + (0.248723895581585)*x^7 + (-0.274490051594771)*x^8 + (0.270937563407533)*x^9 + (0.581768823312344)*x^10 + (-1.0197350762984)*x^11 + (0.237332482467957)*x^12 + (0.512118973546239)*x^13 + (-0.488659533566704)*x^14 + (0.19220422424959)*x^15 + (-0.0368836456982008)*x^16 + (0.00284189296657569)*x^17);
    annotation(Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
  "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711465))/(1099321.32004152);
    sv := (1712.24326581151) + (28.1128516491483) * ((-0.112521430007482) + (-0.487193861215391)*x^1 + (-0.0348797154510423)*x^2 + (-0.166303870548519)*x^3 + (0.613836064832119)*x^4 + (-0.649160332871882)*x^5 + (-1.39246834979196)*x^6 + (3.1237950342012)*x^7 + (0.288248120938586)*x^8 + (-5.99082191486733)*x^9 + (5.0114795117494)*x^10 + (2.40076318691562)*x^11 + (-6.31082724099684)*x^12 + (3.16107365916373)*x^13 + (1.10085009131208)*x^14 + (-2.14399458831077)*x^15 + (1.19044487009117)*x^16 + (-0.346503794691849)*x^17 + (0.0535860524537702)*x^18 + (-0.0034897846279889)*x^19);
    annotation(Inline=false,
          LateInline=true);
  end dewEntropy;

  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on the Helmholtz
    EoS.
  */
  redeclare replaceable function temperature_ph
  "Calculates temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

  protected
    SmoothTransition st;
    SpecificEnthalpy dh = st.T_ph;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;
    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real y2;
    Real T2;

  algorithm
    h_dew := dewEnthalpy(sat = setSat_p(p=p));
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));

    if h<h_bubble-dh then
      x1 := (p-(3122877.04280156))/(1423576.66186916);
      y1 := (h-(253581.468871595))/(57906.7545347278);
      T := (308.540976124287) + (37.8085909600305) * (0.0764471826097096 + (0.00259905276461432)*x1^1 + (-0.00194869219631078)*x1^2 + (1.0554450934331)*y1^1 + (-0.0745060258188885)*y1^2 + (-0.00800863253266789)*y1^3 + (0.00429240219739706)*y1^4 + (-0.0130285831491516)*y1^5 + (-0.000926538970633092)*y1^6 + (0.00471253496574143)*y1^7 + (-0.00133115564640567)*y1^8 + (-0.000338121899863582)*y1^9 + (0.00181533507384901)*y1^8*x1^1 + (-0.000107633479443707)*y1^7*x1^1 + (-0.00302256680844611)*y1^7*x1^2 + (-0.00683834144020797)*y1^6*x1^1 + (0.00492846839576282)*y1^6*x1^2 + (0.00553076584386651)*y1^5*x1^1 + (0.00364501837231738)*y1^5*x1^2 + (0.00749977512677308)*y1^4*x1^1 + (-0.00934628064362871)*y1^4*x1^2 + (0.000971651135700144)*y1^3*x1^1 + (-0.00124376043139813)*y1^3*x1^2 + (0.00765890216235989)*y1^2*x1^1 + (0.00325322175077137)*y1^2*x1^2 + (0.0154185989281787)*y1^1*x1^1 + (-0.00255481322292717)*y1^1*x1^2);
    elseif h>h_dew+dh then
      x2 := (p-(1145465.34582903))/(844687.782728257);
      y2 := (h-(443729.127320671))/(19962.2651435233);
      T := (337.959825750072) + (23.6670013488795) * (-0.0135541295247023 + (0.586835340383077)*x2^1 + (-0.00431212735183889)*x2^2 + (0.000471659559934485)*x2^3 + (-0.000603613504384605)*x2^4 + (0.779805556521014)*y2^1 + (0.0144076318532589)*y2^2 + (-0.00693980103108749)*y2^3 + (0.00269629594629901)*y2^4 + (-0.000812213481593644)*y2^5 + (8.45385157398224e-05)*y2^6 + (-0.00059924712851379)*y2^5*x2^1 + (0.00244272354781721)*y2^4*x2^1 + (-0.000369960128948983)*y2^4*x2^2 + (-0.00804426907085302)*y2^3*x2^1 + (0.000251534760394184)*y2^3*x2^2 + (0.0012327672443667)*y2^3*x2^3 + (0.0293932957114119)*y2^2*x2^1 + (0.000897813476408314)*y2^2*x2^2 + (-0.00174609458213687)*y2^2*x2^3 + (0.000266582797227659)*y2^2*x2^4 + (-0.138253912846704)*y2^1*x2^1 + (-0.000307976361935865)*y2^1*x2^2 + (-0.000331033022884691)*y2^1*x2^3 + (0.000519680346642066)*y2^1*x2^4);
    else
      if h<h_bubble then
        x1 := (p-(3122877.04280156))/(1423576.66186916);
        y1 := (h-(253581.468871595))/(57906.7545347278);
        T1 := (308.540976124287) + (37.8085909600305) * (0.0764471826097096 + (0.00259905276461432)*x1^1 + (-0.00194869219631078)*x1^2 + (1.0554450934331)*y1^1 + (-0.0745060258188885)*y1^2 + (-0.00800863253266789)*y1^3 + (0.00429240219739706)*y1^4 + (-0.0130285831491516)*y1^5 + (-0.000926538970633092)*y1^6 + (0.00471253496574143)*y1^7 + (-0.00133115564640567)*y1^8 + (-0.000338121899863582)*y1^9 + (0.00181533507384901)*y1^8*x1^1 + (-0.000107633479443707)*y1^7*x1^1 + (-0.00302256680844611)*y1^7*x1^2 + (-0.00683834144020797)*y1^6*x1^1 + (0.00492846839576282)*y1^6*x1^2 + (0.00553076584386651)*y1^5*x1^1 + (0.00364501837231738)*y1^5*x1^2 + (0.00749977512677308)*y1^4*x1^1 + (-0.00934628064362871)*y1^4*x1^2 + (0.000971651135700144)*y1^3*x1^1 + (-0.00124376043139813)*y1^3*x1^2 + (0.00765890216235989)*y1^2*x1^1 + (0.00325322175077137)*y1^2*x1^2 + (0.0154185989281787)*y1^1*x1^1 + (-0.00255481322292717)*y1^1*x1^2);
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) + T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-(1145465.34582903))/(844687.782728257);
        y2 := (h-(443729.127320671))/(19962.2651435233);
        T2 := (337.959825750072) + (23.6670013488795) * (-0.0135541295247023 + (0.586835340383077)*x2^1 + (-0.00431212735183889)*x2^2 + (0.000471659559934485)*x2^3 + (-0.000603613504384605)*x2^4 + (0.779805556521014)*y2^1 + (0.0144076318532589)*y2^2 + (-0.00693980103108749)*y2^3 + (0.00269629594629901)*y2^4 + (-0.000812213481593644)*y2^5 + (8.45385157398224e-05)*y2^6 + (-0.00059924712851379)*y2^5*x2^1 + (0.00244272354781721)*y2^4*x2^1 + (-0.000369960128948983)*y2^4*x2^2 + (-0.00804426907085302)*y2^3*x2^1 + (0.000251534760394184)*y2^3*x2^2 + (0.0012327672443667)*y2^3*x2^3 + (0.0293932957114119)*y2^2*x2^1 + (0.000897813476408314)*y2^2*x2^2 + (-0.00174609458213687)*y2^2*x2^3 + (0.000266582797227659)*y2^2*x2^4 + (-0.138253912846704)*y2^1*x2^1 + (-0.000307976361935865)*y2^1*x2^2 + (-0.000331033022884691)*y2^1*x2^3 + (0.000519680346642066)*y2^1*x2^4);
        T := saturationTemperature(p)*(1 - (h - h_dew)/dh) + T2*(h - h_dew)/dh;
      else
        T := saturationTemperature(p);
      end if;
    end if;
  annotation(derivative(noDerivative=phase)=temperature_ph_der,
      inverse(h=specificEnthalpy_pT(p=p,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end temperature_ph;

  redeclare replaceable function temperature_ps
  "Calculates temperature as function of pressure and specific entroy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

  protected
    SmoothTransition st;
    SpecificEntropy ds = st.T_ps;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;
    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real y2;
    Real T2;

  algorithm
    s_dew := dewEntropy(sat = setSat_p(p=p));
    s_bubble := bubbleEntropy(sat = setSat_p(p=p));

    if s<s_bubble-ds then
      x1 := (log(p)-(14.7156251377652))/(0.675821257151287);
      y1 := (s-(1113.4665819568))/(166.046492925304);
      T := (297.870297831011) + (34.68262138546) * (-0.00309324938815765 + (0.025125098218863)*x1^1 + (0.00978713920392164)*x1^2 + (0.00130657861764361)*x1^3 + (-0.000869815795848839)*x1^4 + (1.01455111001633)*y1^1 + (0.0110974477932547)*y1^2 + (-0.00608709123931724)*y1^3 + (0.0022918308510058)*y1^4 + (-0.0143627531745134)*y1^5 + (-0.00062372722971936)*y1^6 + (0.0114849519213852)*y1^7 + (-0.00577629476001108)*y1^8 + (0.000167115023817252)*y1^9 + (0.0046968193005345)*y1^8*x1^1 + (0.00874458447157717)*y1^7*x1^1 + (-0.0180881948591259)*y1^7*x1^2 + (-0.0245034215096852)*y1^6*x1^1 + (-0.00509757090828782)*y1^6*x1^2 + (0.0289054880183162)*y1^6*x1^3 + (0.00385580622640529)*y1^5*x1^1 + (0.0311742416971329)*y1^5*x1^2 + (-0.00875879005040054)*y1^5*x1^3 + (-0.0138225446485601)*y1^5*x1^4 + (0.0163148296361175)*y1^4*x1^1 + (-0.00103570400408568)*y1^4*x1^2 + (-0.0159777858855411)*y1^4*x1^3 + (-0.00206077677687377)*y1^4*x1^4 + (-0.00447192398026712)*y1^3*x1^1 + (-0.0193487677757482)*y1^3*x1^2 + (0.0140669169280503)*y1^3*x1^3 + (0.00697404875237796)*y1^3*x1^4 + (0.00187622942333955)*y1^2*x1^1 + (0.000929960800127734)*y1^2*x1^2 + (0.00761532175582505)*y1^2*x1^3 + (-0.00217057567383935)*y1^2*x1^4 + (0.0124291282925215)*y1^1*x1^1 + (0.00882888313131136)*y1^1*x1^2 + (-2.98251597423176e-05)*y1^1*x1^3 + (-0.00379491005531747)*y1^1*x1^4);
    elseif s>s_dew+ds then
      x2 := (log(p)-(13.6272293677126))/(0.780027698786717);
      y2 := (s-(1798.14671280277))/(83.2552398320482);
      T := (336.142452238348) + (24.3148978859384) * (-0.185837651853814 + (1.1954928227171)*x2^1 + (0.0864438085718725)*x2^2 + (0.0119235845340482)*x2^3 + (1.11855757186273)*y2^1 + (0.0591435736110949)*y2^2 + (-0.0014756327659456)*y2^3 + (-0.011735327016651)*y2^4 + (-0.000196726536500004)*y2^5 + (0.0105928780290282)*y2^6 + (-0.00856196121962472)*y2^7 + (0.00336078587580529)*y2^8 + (-0.00067065697892189)*y2^9 + (4.62196356179375e-05)*y2^10 + (-1.10811628042016e-06)*y2^9*x2^1 + (-0.00104384291435824)*y2^8*x2^1 + (-0.000322167616428099)*y2^8*x2^2 + (0.00574073897118765)*y2^7*x2^1 + (0.00111386139935012)*y2^7*x2^2 + (-0.00023925132759031)*y2^7*x2^3 + (-0.0102061935670129)*y2^6*x2^1 + (0.000151540720270352)*y2^6*x2^2 + (0.00104914945725364)*y2^6*x2^3 + (0.00364357208963307)*y2^5*x2^1 + (-0.00326066155147761)*y2^5*x2^2 + (-0.00076337148752412)*y2^5*x2^3 + (0.00859014378453588)*y2^4*x2^1 + (0.0016928706761254)*y2^4*x2^2 + (-0.00142387091901161)*y2^4*x2^3 + (-0.00927214133919975)*y2^3*x2^1 + (0.00185862788125459)*y2^3*x2^2 + (0.000209686620645933)*y2^3*x2^3 + (0.00693536992725869)*y2^2*x2^1 + (0.00144203692307136)*y2^2*x2^2 + (0.00480678193195678)*y2^2*x2^3 + (-0.0323132910560146)*y2^1*x2^1 + (-0.0284742815497814)*y2^1*x2^2 + (-0.00960171672309107)*y2^1*x2^3);
    else
      if s<s_bubble then
        x1 := (log(p)-(14.7156251377652))/(0.675821257151287);
        y1 := (s-(1113.4665819568))/(166.046492925304);
        T1 := (297.870297831011) + (34.68262138546) * (-0.00309324938815765 + (0.025125098218863)*x1^1 + (0.00978713920392164)*x1^2 + (0.00130657861764361)*x1^3 + (-0.000869815795848839)*x1^4 + (1.01455111001633)*y1^1 + (0.0110974477932547)*y1^2 + (-0.00608709123931724)*y1^3 + (0.0022918308510058)*y1^4 + (-0.0143627531745134)*y1^5 + (-0.00062372722971936)*y1^6 + (0.0114849519213852)*y1^7 + (-0.00577629476001108)*y1^8 + (0.000167115023817252)*y1^9 + (0.0046968193005345)*y1^8*x1^1 + (0.00874458447157717)*y1^7*x1^1 + (-0.0180881948591259)*y1^7*x1^2 + (-0.0245034215096852)*y1^6*x1^1 + (-0.00509757090828782)*y1^6*x1^2 + (0.0289054880183162)*y1^6*x1^3 + (0.00385580622640529)*y1^5*x1^1 + (0.0311742416971329)*y1^5*x1^2 + (-0.00875879005040054)*y1^5*x1^3 + (-0.0138225446485601)*y1^5*x1^4 + (0.0163148296361175)*y1^4*x1^1 + (-0.00103570400408568)*y1^4*x1^2 + (-0.0159777858855411)*y1^4*x1^3 + (-0.00206077677687377)*y1^4*x1^4 + (-0.00447192398026712)*y1^3*x1^1 + (-0.0193487677757482)*y1^3*x1^2 + (0.0140669169280503)*y1^3*x1^3 + (0.00697404875237796)*y1^3*x1^4 + (0.00187622942333955)*y1^2*x1^1 + (0.000929960800127734)*y1^2*x1^2 + (0.00761532175582505)*y1^2*x1^3 + (-0.00217057567383935)*y1^2*x1^4 + (0.0124291282925215)*y1^1*x1^1 + (0.00882888313131136)*y1^1*x1^2 + (-2.98251597423176e-05)*y1^1*x1^3 + (-0.00379491005531747)*y1^1*x1^4);
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) + T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-(13.6272293677126))/(0.780027698786717);
        y2 := (s-(1798.14671280277))/(83.2552398320482);
        T2 := (336.142452238348) + (24.3148978859384) * (-0.185837651853814 + (1.1954928227171)*x2^1 + (0.0864438085718725)*x2^2 + (0.0119235845340482)*x2^3 + (1.11855757186273)*y2^1 + (0.0591435736110949)*y2^2 + (-0.0014756327659456)*y2^3 + (-0.011735327016651)*y2^4 + (-0.000196726536500004)*y2^5 + (0.0105928780290282)*y2^6 + (-0.00856196121962472)*y2^7 + (0.00336078587580529)*y2^8 + (-0.00067065697892189)*y2^9 + (4.62196356179375e-05)*y2^10 + (-1.10811628042016e-06)*y2^9*x2^1 + (-0.00104384291435824)*y2^8*x2^1 + (-0.000322167616428099)*y2^8*x2^2 + (0.00574073897118765)*y2^7*x2^1 + (0.00111386139935012)*y2^7*x2^2 + (-0.00023925132759031)*y2^7*x2^3 + (-0.0102061935670129)*y2^6*x2^1 + (0.000151540720270352)*y2^6*x2^2 + (0.00104914945725364)*y2^6*x2^3 + (0.00364357208963307)*y2^5*x2^1 + (-0.00326066155147761)*y2^5*x2^2 + (-0.00076337148752412)*y2^5*x2^3 + (0.00859014378453588)*y2^4*x2^1 + (0.0016928706761254)*y2^4*x2^2 + (-0.00142387091901161)*y2^4*x2^3 + (-0.00927214133919975)*y2^3*x2^1 + (0.00185862788125459)*y2^3*x2^2 + (0.000209686620645933)*y2^3*x2^3 + (0.00693536992725869)*y2^2*x2^1 + (0.00144203692307136)*y2^2*x2^2 + (0.00480678193195678)*y2^2*x2^3 + (-0.0323132910560146)*y2^1*x2^1 + (-0.0284742815497814)*y2^1*x2^2 + (-0.00960171672309107)*y2^1*x2^3);
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) + T2*(s - s_dew)/ ds;
      else
        T := saturationTemperature(p);
      end if;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end temperature_ps;

  redeclare replaceable partial function density_pT
  "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

  protected
    SmoothTransition st;
    AbsolutePressure dp = st.d_pT;
    SaturationProperties sat = setSat_T(T=T);
    Real x1;
    Real y1;
    Real d1;
    Real x2;
    Real y2;
    Real d2;

  algorithm
    if p<sat.psat-dp then
      x1 := (p-(2475798.47477282))/(1003504.05318001);
      y1 := (T-(300.540241779284))/(37.6657526002195);
      d := (1184.39249906) + (157.651060388072) * (0.151890458566005 + (0.0372634084244887)*x1^1 + (-0.000878451524432626)*x1^2 + (-0.899614368318172)*y1^1 + (-0.127035977603312)*y1^2 + (-0.0274302803041562)*y1^3 + (0.0102583685959201)*y1^4 + (-0.113626140315071)*y1^5 + (-0.116383967425595)*y1^6 + (0.289902421993179)*y1^7 + (0.237778250738714)*y1^8 + (-0.414920878869079)*y1^9 + (-0.28684718076925)*y1^10 + (0.329245144484589)*y1^11 + (0.20394734239444)*y1^12 + (-0.147657584030167)*y1^13 + (-0.0851473346060712)*y1^14 + (0.0348950504085374)*y1^15 + (0.0192280779971103)*y1^16 + (-0.00339757963864487)*y1^17 + (-0.00182072452876127)*y1^18 + (0.00189521481290361)*y1^17*x1^1 + (0.00509260585366773)*y1^16*x1^1 + (-0.00028442156587044)*y1^16*x1^2 + (-0.0154716389273261)*y1^15*x1^1 + (-0.00162049647024837)*y1^15*x1^2 + (-0.047429989460496)*y1^14*x1^1 + (-0.000272621321414234)*y1^14*x1^2 + (0.0482510149805848)*y1^13*x1^1 + (0.0121995817900101)*y1^13*x1^2 + (0.179636538886051)*y1^12*x1^1 + (0.0135063136889622)*y1^12*x1^2 + (-0.0683847553428589)*y1^11*x1^1 + (-0.0342220018039388)*y1^11*x1^2 + (-0.352779730995159)*y1^10*x1^1 + (-0.0538892893200737)*y1^10*x1^2 + (0.03730735169123)*y1^9*x1^1 + (0.0420950557839142)*y1^9*x1^2 + (0.384821808018022)*y1^8*x1^1 + (0.0895317087139894)*y1^8*x1^2 + (0.00967534381376119)*y1^7*x1^1 + (-0.019483787353428)*y1^7*x1^2 + (-0.226325445604688)*y1^6*x1^1 + (-0.071058924803234)*y1^6*x1^2 + (-0.0133479888519577)*y1^5*x1^1 + (-0.00243347035244024)*y1^5*x1^2 + (0.0724165055705047)*y1^4*x1^1 + (0.0240750246375301)*y1^4*x1^2 + (0.0144173181332641)*y1^3*x1^1 + (0.00174763704564308)*y1^3*x1^2 + (0.00850449257675651)*y1^2*x1^1 + (-0.00451536825718203)*y1^2*x1^2 + (0.026506350818004)*y1^1*x1^1 + (-0.00178260670566042)*y1^1*x1^2);
    elseif p>sat.psat+dp then
      x2 := (p-(1527593.68627396))/(977122.342799691);
      y2 := (T-(343.78903714748))/(24.094033535573);
      d := (77.2937976036829) + (60.4708448240192) * (-0.127736937594876 + (0.991612615419474)*x2^1 + (0.276132633408671)*x2^2 + (0.137649251535845)*x2^3 + (0.0807181321995163)*x2^4 + (0.0353291648391036)*x2^5 + (0.0162438954249514)*x2^6 + (0.0210246453812625)*x2^7 + (0.00461881622737762)*x2^8 + (-0.00173249966279668)*x2^9 + (0.0184585355461897)*x2^10 + (0.0100951923182075)*x2^11 + (-0.010676700434955)*x2^12 + (-0.00594046098458385)*x2^13 + (0.00238466815600013)*x2^14 + (0.00135362947159984)*x2^15 + (-0.190776038192531)*y2^1 + (0.0588686679935053)*y2^2 + (-0.0166745339678476)*y2^3 + (-0.00803133952365695)*x2^14*y2^1 + (-0.0129857286900139)*x2^13*y2^1 + (0.0152811003359077)*x2^13*y2^2 + (0.0336807837091247)*x2^12*y2^1 + (0.0271228380651828)*x2^12*y2^2 + (-0.00955960169175646)*x2^12*y2^3 + (0.0595859655254497)*x2^11*y2^1 + (-0.0664227721601945)*x2^11*y2^2 + (-0.0192214328223119)*x2^11*y2^3 + (-0.0437150956482684)*x2^10*y2^1 + (-0.13155114669656)*x2^10*y2^2 + (0.0422387323022419)*x2^10*y2^3 + (-0.10911091031313)*x2^9*y2^1 + (0.0922134952800557)*x2^9*y2^2 + (0.100083004065978)*x2^9*y2^3 + (-0.0355208192901018)*x2^8*y2^1 + (0.250941212010578)*x2^8*y2^2 + (-0.0582824068602976)*x2^8*y2^3 + (0.00717528806303255)*x2^7*y2^1 + (0.0469948217072075)*x2^7*y2^2 + (-0.206541112100745)*x2^7*y2^3 + (-0.0274927434685209)*x2^6*y2^1 + (-0.0753992372346624)*x2^6*y2^2 + (-0.0312566803162229)*x2^6*y2^3 + (-0.0891031004384912)*x2^5*y2^1 + (0.0293100079179995)*x2^5*y2^2 + (0.121536911410358)*x2^5*y2^3 + (-0.159025194185859)*x2^4*y2^1 + (0.119170354497954)*x2^4*y2^2 + (0.011851645935622)*x2^4*y2^3 + (-0.22394645774232)*x2^3*y2^1 + (0.173966132201382)*x2^3*y2^2 + (-0.0839752138763187)*x2^3*y2^3 + (-0.287172719166482)*x2^2*y2^1 + (0.197105514194536)*x2^2*y2^2 + (-0.0704613195929054)*x2^2*y2^3 + (-0.318632022231698)*x2^1*y2^1 + (0.151313126276188)*x2^1*y2^2 + (-0.0430518594660977)*x2^1*y2^3);
    else
      if p<sat.psat then
        x1 := (p-(2475798.47477282))/(1003504.05318001);
        y1 := (T-(300.540241779284))/(37.6657526002195);
        d1 := (1184.39249906) + (157.651060388072) * (0.151890458566005 + (0.0372634084244887)*x1^1 + (-0.000878451524432626)*x1^2 + (-0.899614368318172)*y1^1 + (-0.127035977603312)*y1^2 + (-0.0274302803041562)*y1^3 + (0.0102583685959201)*y1^4 + (-0.113626140315071)*y1^5 + (-0.116383967425595)*y1^6 + (0.289902421993179)*y1^7 + (0.237778250738714)*y1^8 + (-0.414920878869079)*y1^9 + (-0.28684718076925)*y1^10 + (0.329245144484589)*y1^11 + (0.20394734239444)*y1^12 + (-0.147657584030167)*y1^13 + (-0.0851473346060712)*y1^14 + (0.0348950504085374)*y1^15 + (0.0192280779971103)*y1^16 + (-0.00339757963864487)*y1^17 + (-0.00182072452876127)*y1^18 + (0.00189521481290361)*y1^17*x1^1 + (0.00509260585366773)*y1^16*x1^1 + (-0.00028442156587044)*y1^16*x1^2 + (-0.0154716389273261)*y1^15*x1^1 + (-0.00162049647024837)*y1^15*x1^2 + (-0.047429989460496)*y1^14*x1^1 + (-0.000272621321414234)*y1^14*x1^2 + (0.0482510149805848)*y1^13*x1^1 + (0.0121995817900101)*y1^13*x1^2 + (0.179636538886051)*y1^12*x1^1 + (0.0135063136889622)*y1^12*x1^2 + (-0.0683847553428589)*y1^11*x1^1 + (-0.0342220018039388)*y1^11*x1^2 + (-0.352779730995159)*y1^10*x1^1 + (-0.0538892893200737)*y1^10*x1^2 + (0.03730735169123)*y1^9*x1^1 + (0.0420950557839142)*y1^9*x1^2 + (0.384821808018022)*y1^8*x1^1 + (0.0895317087139894)*y1^8*x1^2 + (0.00967534381376119)*y1^7*x1^1 + (-0.019483787353428)*y1^7*x1^2 + (-0.226325445604688)*y1^6*x1^1 + (-0.071058924803234)*y1^6*x1^2 + (-0.0133479888519577)*y1^5*x1^1 + (-0.00243347035244024)*y1^5*x1^2 + (0.0724165055705047)*y1^4*x1^1 + (0.0240750246375301)*y1^4*x1^2 + (0.0144173181332641)*y1^3*x1^1 + (0.00174763704564308)*y1^3*x1^2 + (0.00850449257675651)*y1^2*x1^1 + (-0.00451536825718203)*y1^2*x1^2 + (0.026506350818004)*y1^1*x1^1 + (-0.00178260670566042)*y1^1*x1^2);
        d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-(1527593.68627396))/(977122.342799691);
        y2 := (T-(343.78903714748))/(24.094033535573);
        d2 := (77.2937976036829) + (60.4708448240192) * (-0.127736937594876 + (0.991612615419474)*x2^1 + (0.276132633408671)*x2^2 + (0.137649251535845)*x2^3 + (0.0807181321995163)*x2^4 + (0.0353291648391036)*x2^5 + (0.0162438954249514)*x2^6 + (0.0210246453812625)*x2^7 + (0.00461881622737762)*x2^8 + (-0.00173249966279668)*x2^9 + (0.0184585355461897)*x2^10 + (0.0100951923182075)*x2^11 + (-0.010676700434955)*x2^12 + (-0.00594046098458385)*x2^13 + (0.00238466815600013)*x2^14 + (0.00135362947159984)*x2^15 + (-0.190776038192531)*y2^1 + (0.0588686679935053)*y2^2 + (-0.0166745339678476)*y2^3 + (-0.00803133952365695)*x2^14*y2^1 + (-0.0129857286900139)*x2^13*y2^1 + (0.0152811003359077)*x2^13*y2^2 + (0.0336807837091247)*x2^12*y2^1 + (0.0271228380651828)*x2^12*y2^2 + (-0.00955960169175646)*x2^12*y2^3 + (0.0595859655254497)*x2^11*y2^1 + (-0.0664227721601945)*x2^11*y2^2 + (-0.0192214328223119)*x2^11*y2^3 + (-0.0437150956482684)*x2^10*y2^1 + (-0.13155114669656)*x2^10*y2^2 + (0.0422387323022419)*x2^10*y2^3 + (-0.10911091031313)*x2^9*y2^1 + (0.0922134952800557)*x2^9*y2^2 + (0.100083004065978)*x2^9*y2^3 + (-0.0355208192901018)*x2^8*y2^1 + (0.250941212010578)*x2^8*y2^2 + (-0.0582824068602976)*x2^8*y2^3 + (0.00717528806303255)*x2^7*y2^1 + (0.0469948217072075)*x2^7*y2^2 + (-0.206541112100745)*x2^7*y2^3 + (-0.0274927434685209)*x2^6*y2^1 + (-0.0753992372346624)*x2^6*y2^2 + (-0.0312566803162229)*x2^6*y2^3 + (-0.0891031004384912)*x2^5*y2^1 + (0.0293100079179995)*x2^5*y2^2 + (0.121536911410358)*x2^5*y2^3 + (-0.159025194185859)*x2^4*y2^1 + (0.119170354497954)*x2^4*y2^2 + (0.011851645935622)*x2^4*y2^3 + (-0.22394645774232)*x2^3*y2^1 + (0.173966132201382)*x2^3*y2^2 + (-0.0839752138763187)*x2^3*y2^3 + (-0.287172719166482)*x2^2*y2^1 + (0.197105514194536)*x2^2*y2^2 + (-0.0704613195929054)*x2^2*y2^3 + (-0.318632022231698)*x2^1*y2^1 + (0.151313126276188)*x2^1*y2^2 + (-0.0430518594660977)*x2^1*y2^3);
        d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
      end if;
    end if;
  annotation(inverse(p=pressure_dT(d=d,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end density_pT;

  /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal conductivity. Also add references.
  */
  redeclare function extends dynamicViscosity
  "Calculates dynamic viscosity of refrigerant"

  /*The functional form of the dynamic viscosity is implented as presented in
  Huber et al. (2003), Model for the Viscosity and Thermal Conductivity of 
  Refrigerants, Including a New Correlation for the Viscosity of R134a.
  Ind. Eng. Chem. Res(42)
*/
  protected
    Real Tred = state.T/299.363 "Reduced temperature for lower density terms";
    Real theta_eta "Reduced effective collision cross section";
    Real eta_zd "Dynamic viscosity for the limit of zero density";
    Real B_eta_zd "Second viscosity virial coefficient for the limit of zero density";
    Real B_eta "Second viscosity virial coefficient";
    Real tau = state.T/374.21 "Reduced temperature for higher density terms";
    Real delta = state.d/511.9 "Reduced density for higher density terms";
    Real delta_hd "Reduced close-pacled density";
    Real eta_hd "Dynamic viscosity for the limit of high density";

  algorithm

    // Calculate the dynamic visocity near the limit of zero density
    theta_eta := exp(0.355404 - 0.00464337*log(Tred) + 0.0257353*log(Tred)^2);
    eta_zd := 0.021357*sqrt(102.031*state.T) / (0.46893^2*theta_eta);

    // Calculate the second viscosity virial coefficient
    B_eta_zd := -19.572881 + 219.73999*(Tred)^(-0.25) - 1015.3226*(Tred)^(-0.50)
      + 2471.0125*(Tred)^(-0.75) - 3375.1717*(Tred)^(-1.00) + 2491.6597*(Tred)^(-1.25)
      - 787.26086*(Tred)^(-1.50) + 14.085455*(Tred)^(-2.50) - 0.34664158*(Tred)^(-5.5);
    B_eta := Modelica.Constants.N_A*0.46893^3*B_eta_zd;

    // Calculate the dynamic viscosity for limits of higher densities
    delta_hd := 3.163695636 / (1 -0.0890173375*tau + 0.100035295*tau^2);
    eta_hd := -0.0206900719*delta + (0.000356029549/tau^6 + 0.00211101816/tau^2
    + 0.0139601415/sqrt(tau) - 0.00456435020*tau^2)*delta^2 - 0.00351593275*delta^3
    + 0.214763320/(delta_hd-delta) - 0.214763320/delta_hd;

    // Calculate the final dynamic visocity
    eta := (eta_zd * (1 + B_eta*state.d) + eta_hd)*1e-6;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
  "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
  Perkins et al. (2000), Experimental Thermal Conductivity Values for the IUPAC
  Round-Robin Sample of 1,1,1,2-Tetrafluoroethane (R134a).
  National Institute of Standards and Technology
  */
  protected
    Real lambda_0 "Thermal conductivity for the limit of zero density";
    Real delta = state.d/(0.102032*5017.053) "Reduced density for the residual part";
    Real lambda_r "Thermal conductivity for residual part";
    ThermodynamicState state_0(
      d=state.d,
      T=561.411,
      p=pressure_dT(d=state.d,T=561.411,phase=state.phase),
      h = specificEnthalpy_dT(d=state.d,T=561.411,phase=state.phase),
      phase = state.phase) "Reference state for crossover function";
    Real chi "Dimensionless susceptibility";
    Real xi "Correlation length";
    Real chi_0 "Dimensionless susceptibility at reference state";
    Real cp = specificHeatCapacityCp(state) "Specific heat capacity at constant pressure";
    Real cv = specificHeatCapacityCv(state) "Specific heat capacity at constant volume";
    Real eta = dynamicViscosity(state) "Dynamic viscosity";
    Real omega "Crossover function";
    Real omega_0 "Crossover function at reference state";
    Real lambda_c "Thermal conductivity for the region of the critical point";
  algorithm

    // Calculate the thermal conducitvity for the limit of zero density
    lambda_0 := -0.0105248 + 0.0164602*state.T;

    // Calculate the thermal conductivity for the residual part
    lambda_r := 0.00377406*delta + 0.0105342*delta^2 - 0.00295279*delta^3
      + 0.00304692*delta^4;

    // Calculate the thermal conductivity for the regition of the critical point
    chi := state.d*4059280/(0.102032*5017.053)^2 / pressure_derd_T(state);
    chi_0 := state.d*4059280/(0.102032*5017.053)^2 / pressure_derd_T(state_0);
    xi := 1.94e-10 * (1/0.0496 * (chi-chi_0))^(0.63/1.239);
    omega := 2/Modelica.Constants.pi * (((cp-cv)/cp)*
      atan(1.89202e9*xi) + cv/cp*1.89202e9*xi);
    omega_0 := 2/Modelica.Constants.pi * (1-exp(-1/(1/(1.89202e9*xi)+
      (1.89202e9*xi/delta)^2/3)));
    lambda_c := state.d*cp* (0.63*Modelica.Constants.k*state.T)/
      (6*Modelica.Constants.pi*eta*xi) * (omega-omega_0);

    // Calculate the final thermal conductivity
    lambda := lambda_0 + lambda_r + lambda_c;

  end thermalConductivity;

  redeclare function extends surfaceTension
  "Surface tension in two phase region of refrigerant"

  /*The functional form of the surface tension is implented as presented in
  Mulero and Cachadiña (2012), Recommended Correlations for the Surface Tension 
  of Common Fluids. Journal of Physical and Chemical Reference Data 41,
*/
  algorithm
    sigma := 0.05801*(1-sat.Tsat/374.21)^1.241;
  end surfaceTension;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 20, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides a refrigerant model for R134a using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula</a> and the refrigerant model is implemented by complete the template <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula</a>.</p>
<p><b>Assumptions and limitations</b> </p>
<p>The implemented coefficients are fitted to external data by Engelpracht and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>1</p></td>
<td><p>39.5</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>233.15</p></td>
<td><p>370.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>Validation</b> </p>
<p> The model is validated by comparing results obtained from the example model <a href=\"modelica://AixLib.Media.Refrigerants.Examples.RefrigerantProperties\">AixLib.Media.Refrigerants.Examples.RefrigerantProperties</a> to external data (i.e. NIST RefProp 9.1).</p>
<p><b>References</b></p>
<p>Tillner-Roth, R.; Baehr, H. D. (1994): An International Standard Formulation for the thermodynamic Properties of 1,1,1,2‐Tetrafluoroethane (HFC‐134a) for Temperatures from 170 K to 455 K and Pressures up to 70 MPa. In: <i>Journal of physical and chemical reference data (23)</i>, S. 657–729. DOI: 10.1063/1.555958.</p>
<p>Huber, Marcia L.; Laesecke, Arno; Perkins, Richard A. (2003): Model for the Viscosity and Thermal Conductivity of Refrigerants, Including a New Correlation for the Viscosity of R134a. In: <i>Ind. Eng. Chem. Res. 42 (13)</i>, S. 3163–3178. DOI: 10.1021/ie0300880.</p>
<p>Perkins, R. A.; Laesecke, A.; Howley, J.; Ramires, M. L. V.; Gurova, A. N.; Cusco, L. (2000): Experimental thermal conductivity values for the IUPAC round-robin sample of 1,1,1,2-tetrafluoroethane (R134a). Gaithersburg, MD: <i>National Institute of Standards and Technology.</i></p>
<p>Mulero, A.; Cachadiña, I.; Parra, M. I. (2012): Recommended Correlations for the Surface Tension of Common Fluids. In: <i>Journal of physical and chemical reference data 41 (4)</i>, S. 43105. DOI: 10.1063/1.4768782.</p>
<p>Engelpracht, Mirko (2017): Development of modular and scalable simulation models for heat pumps and chillers considering various refrigerants. <i>Master Thesis</i></p>
</html>"));
end R134a_IIR_P1_295_T233_370_Formula;
