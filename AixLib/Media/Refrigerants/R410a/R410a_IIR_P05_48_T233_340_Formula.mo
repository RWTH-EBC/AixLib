within AixLib.Media.Refrigerants.R410a;
package R410a_IIR_P05_48_T233_340_Formula
  "Refrigerant model developed by Engelpracht"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
  */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
     each chemicalFormula = "50% CH2F2 + 50% Pentafluorethan",
     each structureFormula = "50% Difluormethan + 50% CHF2CF3",
     each casRegistryNumber = "75-10-5 + 354-33-6",
     each iupacName = "R-410A,",
     each molarMass = 0.072585414240660,
     each criticalTemperature = 3.444943810810253e+02,
     each criticalPressure = 4.901264589893823e+06,
     each criticalMolarVolume = 6324,
     each normalBoilingPoint = 221.71,
     each triplePointTemperature = 200,
     each meltingPoint = 118.15,
     each acentricFactor = 0.296,
     each triplePointPressure = 29160,
     each dipoleMoment = -1,
     each hasCriticalData=true) "Thermodynamic constants for R410a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R410a",
    substanceNames={"R410a"},
    singleState=false,
    SpecificEnthalpy(
      start=1.0e5,
      nominal=1.0e5,
      min=143.4e3,
      max=526.1e3),
    Density(
      start=500,
      nominal=529,
      min=5.1,
      max=1325),
    AbsolutePressure(
      start=1e5,
      nominal=5e5,
      min=0.5e5,
      max=48e5),
    Temperature(
      start=273.15,
      nominal=273.15,
      min=233.15,
      max=340),
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
    Real d_ps(unit="J/(Pa.K.kg)") =  50/(48e5-0.5e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 100/(48e5-0.5e5);
    AbsolutePressure d_derh_p = 0.2;
  end SmoothTransition;

  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  redeclare function extends alpha_0
  "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  algorithm
    alpha_0 := (-1) * log(tau) + (36.8871) + (7.15807) * tau + (-46.87575) * tau^(-0.1) + (2.0623) * log(1-exp((-2.02326)*tau)) + (5.9751) * log(1-exp((-5.00154)*tau)) + (1.5612) * log(1-exp((-11.2484)*tau)) + log(delta);
  annotation(Inline=false,
          LateInline=true);
  end alpha_0;

  redeclare function extends alpha_r
  "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    alpha_r := (0.987252) * delta^(0.44) * tau^(1) * exp(-delta^(0)) + (-1.03017) * delta^(1.2) * tau^(1) * exp(-delta^(0)) + (1.17666) * delta^(2.97) * tau^(1) * exp(-delta^(0)) + (-0.138991) * delta^(2.95) * tau^(2) * exp(-delta^(0)) + (0.00302373) * delta^(0.2) * tau^(5) * exp(-delta^(0)) + (-2.53639) * delta^(1.93) * tau^(1) * exp(-delta^(1)) + (-1.9668) * delta^(1.78) * tau^(2) * exp(-delta^(1)) + (-0.83048) * delta^(3) * tau^(3) * exp(-delta^(1)) + (0.172477) * delta^(0.2) * tau^(5) * exp(-delta^(1)) + (-0.261116) * delta^(0.74) * tau^(5) * exp(-delta^(1)) + (-0.0745473) * delta^(3) * tau^(5) * exp(-delta^(1)) + (0.679757) * delta^(2.1) * tau^(1) * exp(-delta^(2)) + (-0.652431) * delta^(4.3) * tau^(1) * exp(-delta^(2)) + (0.0553849) * delta^(0.25) * tau^(4) * exp(-delta^(2)) + (-0.071097) * delta^(7) * tau^(4) * exp(-delta^(2)) + (-0.000875332) * delta^(4.7) * tau^(9) * exp(-delta^(2)) + (0.020076) * delta^(13) * tau^(2) * exp(-delta^(3)) + (-0.0139761) * delta^(16) * tau^(2) * exp(-delta^(3)) + (-0.018511) * delta^(25) * tau^(4) * exp(-delta^(3)) + (0.0171939) * delta^(17) * tau^(5) * exp(-delta^(3)) + (-0.00482049) * delta^(7.4) * tau^(6) * exp(-delta^(3));
  annotation(Inline=false,
          LateInline=true);
  end alpha_r;

  redeclare function extends tau_d_alpha_0_d_tau
  "Short form for tau*(dalpha_0/dtau)@delta=const"
  algorithm
    tau_d_alpha_0_d_tau := (-1)*(1) + (36.8871)*(0)*tau^(0) + (7.15807)*(1)*tau^(1) + (-46.87575)*(-0.1)*tau^(-0.1) + (2.0623)*(2.02326)/(exp((2.02326)*tau)-1) + (5.9751)*(5.00154)/(exp((5.00154)*tau)-1) + (1.5612)*(11.2484)/(exp((11.2484)*tau)-1);
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_0_d_tau;

  redeclare function extends tau2_d2_alpha_0_d_tau2
  "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
  algorithm
    tau2_d2_alpha_0_d_tau2 := -(-1)*(1) + (36.8871)*(0)*((0)-1)*tau^(0) + (7.15807)*(1)*((1)-1)*tau^(1) + (-46.87575)*(-0.1)*((-0.1)-1)*tau^(-0.1) -(2.0623)*(2.02326)^2*exp((2.02326)*tau)/(exp((2.02326)*tau)-1)^2 -(5.9751)*(5.00154)^2*exp((5.00154)*tau)/(exp((5.00154)*tau)-1)^2 -(1.5612)*(11.2484)^2*exp((11.2484)*tau)/(exp((11.2484)*tau)-1)^2;
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2;

  redeclare function extends tau_d_alpha_r_d_tau
  "Short form for tau*(dalpha_r/dtau)@delta=const"
  algorithm
    tau_d_alpha_r_d_tau := (0.987252)*(1)*delta^(0.44)*tau^(1)*exp(-delta^(0)) + (-1.03017)*(1)*delta^(1.2)*tau^(1)*exp(-delta^(0)) + (1.17666)*(1)*delta^(2.97)*tau^(1)*exp(-delta^(0)) + (-0.138991)*(2)*delta^(2.95)*tau^(2)*exp(-delta^(0)) + (0.00302373)*(5)*delta^(0.2)*tau^(5)*exp(-delta^(0)) + (-2.53639)*(1)*delta^(1.93)*tau^(1)*exp(-delta^(1)) + (-1.9668)*(2)*delta^(1.78)*tau^(2)*exp(-delta^(1)) + (-0.83048)*(3)*delta^(3)*tau^(3)*exp(-delta^(1)) + (0.172477)*(5)*delta^(0.2)*tau^(5)*exp(-delta^(1)) + (-0.261116)*(5)*delta^(0.74)*tau^(5)*exp(-delta^(1)) + (-0.0745473)*(5)*delta^(3)*tau^(5)*exp(-delta^(1)) + (0.679757)*(1)*delta^(2.1)*tau^(1)*exp(-delta^(2)) + (-0.652431)*(1)*delta^(4.3)*tau^(1)*exp(-delta^(2)) + (0.0553849)*(4)*delta^(0.25)*tau^(4)*exp(-delta^(2)) + (-0.071097)*(4)*delta^(7)*tau^(4)*exp(-delta^(2)) + (-0.000875332)*(9)*delta^(4.7)*tau^(9)*exp(-delta^(2)) + (0.020076)*(2)*delta^(13)*tau^(2)*exp(-delta^(3)) + (-0.0139761)*(2)*delta^(16)*tau^(2)*exp(-delta^(3)) + (-0.018511)*(4)*delta^(25)*tau^(4)*exp(-delta^(3)) + (0.0171939)*(5)*delta^(17)*tau^(5)*exp(-delta^(3)) + (-0.00482049)*(6)*delta^(7.4)*tau^(6)*exp(-delta^(3));
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_r_d_tau;

  redeclare function extends tau2_d2_alpha_r_d_tau2
  "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
  algorithm
    tau2_d2_alpha_r_d_tau2 := (0.987252)*(1)*((1)-1)*delta^(0.44)*tau^(1)*exp(-delta^(0)) + (-1.03017)*(1)*((1)-1)*delta^(1.2)*tau^(1)*exp(-delta^(0)) + (1.17666)*(1)*((1)-1)*delta^(2.97)*tau^(1)*exp(-delta^(0)) + (-0.138991)*(2)*((2)-1)*delta^(2.95)*tau^(2)*exp(-delta^(0)) + (0.00302373)*(5)*((5)-1)*delta^(0.2)*tau^(5)*exp(-delta^(0)) + (-2.53639)*(1)*((1)-1)*delta^(1.93)*tau^(1)*exp(-delta^(1)) + (-1.9668)*(2)*((2)-1)*delta^(1.78)*tau^(2)*exp(-delta^(1)) + (-0.83048)*(3)*((3)-1)*delta^(3)*tau^(3)*exp(-delta^(1)) + (0.172477)*(5)*((5)-1)*delta^(0.2)*tau^(5)*exp(-delta^(1)) + (-0.261116)*(5)*((5)-1)*delta^(0.74)*tau^(5)*exp(-delta^(1)) + (-0.0745473)*(5)*((5)-1)*delta^(3)*tau^(5)*exp(-delta^(1)) + (0.679757)*(1)*((1)-1)*delta^(2.1)*tau^(1)*exp(-delta^(2)) + (-0.652431)*(1)*((1)-1)*delta^(4.3)*tau^(1)*exp(-delta^(2)) + (0.0553849)*(4)*((4)-1)*delta^(0.25)*tau^(4)*exp(-delta^(2)) + (-0.071097)*(4)*((4)-1)*delta^(7)*tau^(4)*exp(-delta^(2)) + (-0.000875332)*(9)*((9)-1)*delta^(4.7)*tau^(9)*exp(-delta^(2)) + (0.020076)*(2)*((2)-1)*delta^(13)*tau^(2)*exp(-delta^(3)) + (-0.0139761)*(2)*((2)-1)*delta^(16)*tau^(2)*exp(-delta^(3)) + (-0.018511)*(4)*((4)-1)*delta^(25)*tau^(4)*exp(-delta^(3)) + (0.0171939)*(5)*((5)-1)*delta^(17)*tau^(5)*exp(-delta^(3)) + (-0.00482049)*(6)*((6)-1)*delta^(7.4)*tau^(6)*exp(-delta^(3));
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2;

  redeclare function extends delta_d_alpha_r_d_delta
  "Short form for delta*(dalpha_r/(ddelta))@tau=const"
  algorithm
    delta_d_alpha_r_d_delta := (0.987252)*delta^(0.44)*tau^(1)*((0.44)-(0)*delta^(0))*exp(-delta^(0)) + (-1.03017)*delta^(1.2)*tau^(1)*((1.2)-(0)*delta^(0))*exp(-delta^(0)) + (1.17666)*delta^(2.97)*tau^(1)*((2.97)-(0)*delta^(0))*exp(-delta^(0)) + (-0.138991)*delta^(2.95)*tau^(2)*((2.95)-(0)*delta^(0))*exp(-delta^(0)) + (0.00302373)*delta^(0.2)*tau^(5)*((0.2)-(0)*delta^(0))*exp(-delta^(0)) + (-2.53639)*delta^(1.93)*tau^(1)*((1.93)-(1)*delta^(1))*exp(-delta^(1)) + (-1.9668)*delta^(1.78)*tau^(2)*((1.78)-(1)*delta^(1))*exp(-delta^(1)) + (-0.83048)*delta^(3)*tau^(3)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (0.172477)*delta^(0.2)*tau^(5)*((0.2)-(1)*delta^(1))*exp(-delta^(1)) + (-0.261116)*delta^(0.74)*tau^(5)*((0.74)-(1)*delta^(1))*exp(-delta^(1)) + (-0.0745473)*delta^(3)*tau^(5)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (0.679757)*delta^(2.1)*tau^(1)*((2.1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.652431)*delta^(4.3)*tau^(1)*((4.3)-(2)*delta^(2))*exp(-delta^(2)) + (0.0553849)*delta^(0.25)*tau^(4)*((0.25)-(2)*delta^(2))*exp(-delta^(2)) + (-0.071097)*delta^(7)*tau^(4)*((7)-(2)*delta^(2))*exp(-delta^(2)) + (-0.000875332)*delta^(4.7)*tau^(9)*((4.7)-(2)*delta^(2))*exp(-delta^(2)) + (0.020076)*delta^(13)*tau^(2)*((13)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0139761)*delta^(16)*tau^(2)*((16)-(3)*delta^(3))*exp(-delta^(3)) + (-0.018511)*delta^(25)*tau^(4)*((25)-(3)*delta^(3))*exp(-delta^(3)) + (0.0171939)*delta^(17)*tau^(5)*((17)-(3)*delta^(3))*exp(-delta^(3)) + (-0.00482049)*delta^(7.4)*tau^(6)*((7.4)-(3)*delta^(3))*exp(-delta^(3));
  annotation(Inline=false,
          LateInline=true);
  end delta_d_alpha_r_d_delta;

  redeclare function extends delta2_d2_alpha_r_d_delta2
  "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
  algorithm
    delta2_d2_alpha_r_d_delta2 := (0.987252)*delta^(0.44)*tau^(1)*(((0.44)-(0)*delta^(0))*((0.44)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (-1.03017)*delta^(1.2)*tau^(1)*(((1.2)-(0)*delta^(0))*((1.2)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (1.17666)*delta^(2.97)*tau^(1)*(((2.97)-(0)*delta^(0))*((2.97)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (-0.138991)*delta^(2.95)*tau^(2)*(((2.95)-(0)*delta^(0))*((2.95)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (0.00302373)*delta^(0.2)*tau^(5)*(((0.2)-(0)*delta^(0))*((0.2)-1-(0)*delta^(0))-(0)^2*delta^(0))*exp(-delta^(0)) + (-2.53639)*delta^(1.93)*tau^(1)*(((1.93)-(1)*delta^(1))*((1.93)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-1.9668)*delta^(1.78)*tau^(2)*(((1.78)-(1)*delta^(1))*((1.78)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.83048)*delta^(3)*tau^(3)*(((3)-(1)*delta^(1))*((3)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.172477)*delta^(0.2)*tau^(5)*(((0.2)-(1)*delta^(1))*((0.2)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.261116)*delta^(0.74)*tau^(5)*(((0.74)-(1)*delta^(1))*((0.74)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.0745473)*delta^(3)*tau^(5)*(((3)-(1)*delta^(1))*((3)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.679757)*delta^(2.1)*tau^(1)*(((2.1)-(2)*delta^(2))*((2.1)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.652431)*delta^(4.3)*tau^(1)*(((4.3)-(2)*delta^(2))*((4.3)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (0.0553849)*delta^(0.25)*tau^(4)*(((0.25)-(2)*delta^(2))*((0.25)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.071097)*delta^(7)*tau^(4)*(((7)-(2)*delta^(2))*((7)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.000875332)*delta^(4.7)*tau^(9)*(((4.7)-(2)*delta^(2))*((4.7)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (0.020076)*delta^(13)*tau^(2)*(((13)-(3)*delta^(3))*((13)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.0139761)*delta^(16)*tau^(2)*(((16)-(3)*delta^(3))*((16)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.018511)*delta^(25)*tau^(4)*(((25)-(3)*delta^(3))*((25)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (0.0171939)*delta^(17)*tau^(5)*(((17)-(3)*delta^(3))*((17)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.00482049)*delta^(7.4)*tau^(6)*(((7.4)-(3)*delta^(3))*((7.4)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3));
  annotation(Inline=false,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2;

  redeclare function extends tau_delta_d2_alpha_r_d_tau_d_delta
  "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  algorithm
    tau_delta_d2_alpha_r_d_tau_d_delta := (0.987252)*(1)*delta^(0.44)*tau^(1)*((0.44)-(0)*delta^(0))*exp(-delta^(0)) + (-1.03017)*(1)*delta^(1.2)*tau^(1)*((1.2)-(0)*delta^(0))*exp(-delta^(0)) + (1.17666)*(1)*delta^(2.97)*tau^(1)*((2.97)-(0)*delta^(0))*exp(-delta^(0)) + (-0.138991)*(2)*delta^(2.95)*tau^(2)*((2.95)-(0)*delta^(0))*exp(-delta^(0)) + (0.00302373)*(5)*delta^(0.2)*tau^(5)*((0.2)-(0)*delta^(0))*exp(-delta^(0)) + (-2.53639)*(1)*delta^(1.93)*tau^(1)*((1.93)-(1)*delta^(1))*exp(-delta^(1)) + (-1.9668)*(2)*delta^(1.78)*tau^(2)*((1.78)-(1)*delta^(1))*exp(-delta^(1)) + (-0.83048)*(3)*delta^(3)*tau^(3)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (0.172477)*(5)*delta^(0.2)*tau^(5)*((0.2)-(1)*delta^(1))*exp(-delta^(1)) + (-0.261116)*(5)*delta^(0.74)*tau^(5)*((0.74)-(1)*delta^(1))*exp(-delta^(1)) + (-0.0745473)*(5)*delta^(3)*tau^(5)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (0.679757)*(1)*delta^(2.1)*tau^(1)*((2.1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.652431)*(1)*delta^(4.3)*tau^(1)*((4.3)-(2)*delta^(2))*exp(-delta^(2)) + (0.0553849)*(4)*delta^(0.25)*tau^(4)*((0.25)-(2)*delta^(2))*exp(-delta^(2)) + (-0.071097)*(4)*delta^(7)*tau^(4)*((7)-(2)*delta^(2))*exp(-delta^(2)) + (-0.000875332)*(9)*delta^(4.7)*tau^(9)*((4.7)-(2)*delta^(2))*exp(-delta^(2)) + (0.020076)*(2)*delta^(13)*tau^(2)*((13)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0139761)*(2)*delta^(16)*tau^(2)*((16)-(3)*delta^(3))*exp(-delta^(3)) + (-0.018511)*(4)*delta^(25)*tau^(4)*((25)-(3)*delta^(3))*exp(-delta^(3)) + (0.0171939)*(5)*delta^(17)*tau^(5)*((17)-(3)*delta^(3))*exp(-delta^(3)) + (-0.00482049)*(6)*delta^(7.4)*tau^(6)*((7.4)-(3)*delta^(3))*exp(-delta^(3));
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
      p := fluidConstants[1].criticalPressure * exp((fluidConstants[1].criticalTemperature/T) * ((-5.42493213611445)*OM^(0.914568767900918) + (4.55984223535243)*OM^(0.84920213389611) + (-5.63920263436646)*OM^(0.914588351221298) + (-17.0179004677748)*OM^(5.60238999663603) + (16.6119518017247)*OM^(4.56148875806592) + (-9.23457354191128)*OM^(3.77677091719265)));
    end if;
    annotation(Inline=false,
          LateInline=true);
  end saturationPressure;

  redeclare function extends saturationTemperature
  "Saturation temperature of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (p - (1690546.68662399))/(1337345.61888569);
    T := (288.8) + (32.1728405128715) * ((0.315625855266007) + (0.928326269698458)*x^1 + (-0.277494430607752)*x^2 + (0.127140300183199)*x^3 + (-0.0529002490944326)*x^4 + (0.0309833589718576)*x^5 + (-0.100893270492692)*x^6 + (0.0860242126577126)*x^7 + (0.134350167076272)*x^8 + (-0.182876490328916)*x^9 + (-0.112689322533039)*x^10 + (0.254757708465645)*x^11 + (-0.0367634254282132)*x^12 + (-0.14074454381608)*x^13 + (0.0856249369531822)*x^14 + (0.0121512184212727)*x^15 + (-0.0315500773133433)*x^16 + (0.0139370674840602)*x^17 + (-0.00274826770400574)*x^18 + (0.000212734358958718)*x^19);
    annotation(Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
  "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (288.8))/(32.1728405128715);
    dl := (1070.36639000342) + (176.461891556476) * ((0.186630093154286) + (-0.830658005524877)*x^1 + (-0.122145006192698)*x^2 + (-0.0342907457908567)*x^3 + (-0.0662654086479959)*x^4 + (-0.0550862199890643)*x^5 + (0.146102411920836)*x^6 + (0.127659685757962)*x^7 + (-0.072663984277077)*x^8 + (-0.0624251345902524)*x^9 + (-0.220033640493862)*x^10 + (-0.126169099890902)*x^11 + (0.21155243287858)*x^12 + (0.0718657904122464)*x^13 + (0.0901572786179191)*x^14 + (0.0785551804508647)*x^15 + (-0.0743660434596505)*x^16 + (0.0193911381842398)*x^17 + (-0.0942651048840495)*x^18 + (-0.0679342010271487)*x^19 + (-0.0128449984203913)*x^20 + (-0.0917421290392061)*x^21 + (0.144634562910487)*x^22 + (0.128200045509028)*x^23 + (-0.0736032471821009)*x^24 + (0.00629647024697751)*x^25 + (-0.0259497210302272)*x^26 + (-0.082657162249119)*x^27 + (0.0376306904579577)*x^28 + (0.0568626882005316)*x^29 + (-0.014865285998038)*x^30 + (-0.0182096723714437)*x^31 + (0.00268386296928044)*x^32 + (0.00293566954837911)*x^33 + (-0.000190066864688335)*x^34 + (-0.000192762866406722)*x^35);
    annotation(Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
  "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (288.8))/(32.1728405128715);
    dv := (81.1402553535331) + (81.8525665515266) * ((-0.38258005733403) + (0.594247698000419)*x^1 + (0.262992182086301)*x^2 + (0.0865129026480271)*x^3 + (0.0370242887570731)*x^4 + (0.0112261211991694)*x^5 + (-0.0125489243448401)*x^6 + (0.0012382068787828)*x^7 + (0.0157317419040667)*x^8 + (0.00434299894514524)*x^9 + (0.00214921036271588)*x^10 + (0.00289539863035636)*x^11 + (-0.00158538480741269)*x^12 + (-0.00088860171586863)*x^13 + (-0.00166768829541246)*x^14 + (-0.00283896802944253)*x^15 + (-0.000901075042193254)*x^16 + (-0.00196695410352135)*x^17 + (-5.92221614138573e-07)*x^18 + (0.00214762507546025)*x^19 + (0.000495543657457393)*x^20 + (0.0011568545426888)*x^21 + (0.000423297560316714)*x^22 + (-0.000561479744368981)*x^23 + (3.80080621897099e-05)*x^24 + (-0.000431298226628196)*x^25 + (-0.000238334815888865)*x^26 + (4.36249648285314e-05)*x^27 + (-0.000136388992345257)*x^28 + (0.000178769740095248)*x^29 + (0.000190760055223262)*x^30 + (-7.37407932198282e-05)*x^31 + (-6.20269693625927e-05)*x^32 + (8.61462899584184e-06)*x^33 + (6.58978478503912e-06)*x^34);
    annotation(Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
  "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    hl := (230591.064744288) + (55427.1819514098) * ((0.213699512339652) + (0.912820978401616)*x^1 + (-0.198136228106192)*x^2 + (0.0872378134712026)*x^3 + (-0.0526459403049543)*x^4 + (0.131709506237597)*x^5 + (-9.99880752350359e-05)*x^6 + (-0.275377677418503)*x^7 + (-0.0769483120290127)*x^8 + (0.417208839285077)*x^9 + (0.0966313372190178)*x^10 + (-0.216555268787737)*x^11 + (-0.156430951730721)*x^12 + (-0.128383868132659)*x^13 + (0.287671541912508)*x^14 + (0.21534362178513)*x^15 + (-0.337133368803756)*x^16 + (-0.0402840297763956)*x^17 + (0.183700039484998)*x^18 + (-0.0540907239400526)*x^19 + (-0.0295623061533724)*x^20 + (0.0228694199630369)*x^21 + (-0.00557706139864375)*x^22 + (0.000490246648345094)*x^23);
    annotation(Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
  "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    hv := (419045.765501892) + (8545.487483279) * ((0.983520185682028) + (0.173961838358794)*x^1 + (-0.777842402746969)*x^2 + (0.197032758310628)*x^3 + (-0.215325369147047)*x^4 + (0.17524027979117)*x^5 + (0.163409334532178)*x^6 + (-0.10365771583044)*x^7 + (-0.298358086862518)*x^8 + (0.063900536295213)*x^9 + (0.0755533366303853)*x^10 + (0.095321629007505)*x^11 + (0.0502647244559176)*x^12 + (-0.0605463077241532)*x^13 + (-0.0386765421186988)*x^14 + (-0.0360136736458006)*x^15 + (0.0136472460889214)*x^16 + (0.0308964007853627)*x^17 + (0.0115258430193761)*x^18 + (0.000390283122980614)*x^19 + (-0.0331179314189472)*x^20 + (0.0144702747235008)*x^21 + (0.00833845606213506)*x^22 + (-0.00799014541436163)*x^23 + (0.0022323353175877)*x^24 + (-0.000218029221261958)*x^25);
    annotation(Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
  "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    sl := (1160.97331866083) + (185.695651493037) * ((0.274891927776532) + (0.888482458507174)*x^1 + (-0.245671669378254)*x^2 + (0.113902422370081)*x^3 + (-0.0471292444744683)*x^4 + (0.122020592620146)*x^5 + (-0.0976178186610381)*x^6 + (-0.184232949517685)*x^7 + (0.0779323618368683)*x^8 + (0.255290714023843)*x^9 + (0.00592212772109565)*x^10 + (-0.12141201709424)*x^11 + (-0.197892691158687)*x^12 + (-0.00660210880306234)*x^13 + (0.290832433096577)*x^14 + (0.0199708486352523)*x^15 + (-0.233747525374593)*x^16 + (0.0336400125229364)*x^17 + (0.101032460509914)*x^18 + (-0.0416403990009039)*x^19 + (-0.0145766678299393)*x^20 + (0.014209075443824)*x^21 + (-0.00370309827636681)*x^22 + (0.00033828165088767)*x^23);
    annotation(Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
  "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    sv := (1842.94582896195) + (79.2403170328169) * ((-0.150479610948503) + (-0.773757700736367)*x^1 + (0.132564781752192)*x^2 + (-0.0847856959955504)*x^3 + (0.0270489376466083)*x^4 + (-0.308151297008007)*x^5 + (0.136507017005217)*x^6 + (0.808894385214169)*x^7 + (-0.122700813082128)*x^8 + (-1.47492388142783)*x^9 + (0.15442682704994)*x^10 + (1.51293677931511)*x^11 + (-0.161232661224616)*x^12 + (-0.899619588503897)*x^13 + (0.0817324388473164)*x^14 + (0.256674014689244)*x^15 + (0.0790325658994048)*x^16 + (-0.0497700161113581)*x^17 + (-0.0983005227940781)*x^18 + (0.0473507418719607)*x^19 + (0.0223518186558442)*x^20 + (-0.0215691827119022)*x^21 + (0.00581168717069958)*x^22 + (-0.000546560772734549)*x^23);
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
      x1 := (p-(3429583.54285714))/(1286472.42160272);
      y1 := (h-(240858.857142857))/(45214.4438115959);
      T := (296.175729266373) + (25.5807925609779) * (0.0882406936409274 + (0.00696485651693426)*x1^1 + (0.00300623650132852)*x1^2 + (0.0121071983965909)*x1^3 + (-0.00377701491799285)*x1^4 + (-0.0125935847836393)*x1^5 + (0.00142847294487632)*x1^6 + (0.0043582864493429)*x1^7 + (-0.000366259137909091)*x1^8 + (1.07466398400381)*y1^1 + (-0.0762571248081056)*y1^2 + (-0.038621856041722)*y1^3 + (-0.00322877855231498)*y1^4 + (0.0245144453504912)*y1^5 + (-0.0113626584579079)*y1^6 + (-0.00464794880473245)*y1^7 + (0.00617009685472005)*x1^7*y1^1 + (-0.00983708695966969)*x1^6*y1^1 + (-0.0125142505773708)*x1^6*y1^2 + (-0.00769131582735929)*x1^5*y1^1 + (0.0243287041997853)*x1^5*y1^2 + (0.0149688870223868)*x1^5*y1^3 + (0.0178296104692682)*x1^4*y1^1 + (0.0167325212207346)*x1^4*y1^2 + (-0.036913755170423)*x1^4*y1^3 + (-0.0308013877113943)*x1^4*y1^4 + (0.00386038272509948)*x1^3*y1^1 + (-0.0311780714146921)*x1^3*y1^2 + (-0.0152673609829782)*x1^3*y1^3 + (0.0419237142472038)*x1^3*y1^4 + (0.0425626170817709)*x1^3*y1^5 + (-0.0158623877054093)*x1^2*y1^1 + (-0.0260627089547655)*x1^2*y1^2 + (0.0542606746866448)*x1^2*y1^3 + (0.0313424275939254)*x1^2*y1^4 + (-0.060114674759189)*x1^2*y1^5 + (-0.022790470007917)*x1^2*y1^6 + (0.0228346395239131)*x1^1*y1^1 + (0.0298632395107974)*x1^1*y1^2 + (0.00964584567275863)*x1^1*y1^3 + (-0.0399884742697063)*x1^1*y1^4 + (-0.00879892859077808)*x1^1*y1^5 + (0.0330120741067571)*x1^1*y1^6 + (0.00481917893530255)*x1^1*y1^7);
    elseif h>h_dew+dh then
      x2 := (p-(1752187.03362729))/(1048811.75457186);
      y2 := (h-(447077.611687179))/(19823.3189042285);
      T := (316.451559741446) + (17.5552981500054) * (-0.0781198901298308 + (1.05048923283935)*x2^1 + (-0.0869738037857911)*x2^2 + (0.00987325320426037)*x2^3 + (-0.00346587474244462)*x2^4 + (0.00112687640770982)*x2^5 + (0.923172844539287)*y2^1 + (0.0611207938426525)*y2^2 + (-0.0138288041644166)*y2^3 + (0.00304566911224632)*y2^4 + (-0.000741693864083864)*y2^5 + (0.00432076125627709)*x2^4*y2^1 + (-0.00977579981688383)*x2^3*y2^1 + (0.00595597446934317)*x2^3*y2^2 + (0.0370991326871477)*x2^2*y2^1 + (-0.0103387654657405)*x2^2*y2^2 + (0.00332375081831041)*x2^2*y2^3 + (-0.207873407095)*x2^1*y2^1 + (0.0206966920052286)*x2^1*y2^2 + (0.00231309579514234)*x2^1*y2^3 + (-0.00117358921746448)*x2^1*y2^4);
    else
      if h<h_bubble then
        x1 := (p-(3429583.54285714))/(1286472.42160272);
        y1 := (h-(240858.857142857))/(45214.4438115959);
        T1 := (296.175729266373) + (25.5807925609779) * (0.0882406936409274 + (0.00696485651693426)*x1^1 + (0.00300623650132852)*x1^2 + (0.0121071983965909)*x1^3 + (-0.00377701491799285)*x1^4 + (-0.0125935847836393)*x1^5 + (0.00142847294487632)*x1^6 + (0.0043582864493429)*x1^7 + (-0.000366259137909091)*x1^8 + (1.07466398400381)*y1^1 + (-0.0762571248081056)*y1^2 + (-0.038621856041722)*y1^3 + (-0.00322877855231498)*y1^4 + (0.0245144453504912)*y1^5 + (-0.0113626584579079)*y1^6 + (-0.00464794880473245)*y1^7 + (0.00617009685472005)*x1^7*y1^1 + (-0.00983708695966969)*x1^6*y1^1 + (-0.0125142505773708)*x1^6*y1^2 + (-0.00769131582735929)*x1^5*y1^1 + (0.0243287041997853)*x1^5*y1^2 + (0.0149688870223868)*x1^5*y1^3 + (0.0178296104692682)*x1^4*y1^1 + (0.0167325212207346)*x1^4*y1^2 + (-0.036913755170423)*x1^4*y1^3 + (-0.0308013877113943)*x1^4*y1^4 + (0.00386038272509948)*x1^3*y1^1 + (-0.0311780714146921)*x1^3*y1^2 + (-0.0152673609829782)*x1^3*y1^3 + (0.0419237142472038)*x1^3*y1^4 + (0.0425626170817709)*x1^3*y1^5 + (-0.0158623877054093)*x1^2*y1^1 + (-0.0260627089547655)*x1^2*y1^2 + (0.0542606746866448)*x1^2*y1^3 + (0.0313424275939254)*x1^2*y1^4 + (-0.060114674759189)*x1^2*y1^5 + (-0.022790470007917)*x1^2*y1^6 + (0.0228346395239131)*x1^1*y1^1 + (0.0298632395107974)*x1^1*y1^2 + (0.00964584567275863)*x1^1*y1^3 + (-0.0399884742697063)*x1^1*y1^4 + (-0.00879892859077808)*x1^1*y1^5 + (0.0330120741067571)*x1^1*y1^6 + (0.00481917893530255)*x1^1*y1^7);
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) + T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-(1752187.03362729))/(1048811.75457186);
        y2 := (h-(447077.611687179))/(19823.3189042285);
        T2 := (316.451559741446) + (17.5552981500054) * (-0.0781198901298308 + (1.05048923283935)*x2^1 + (-0.0869738037857911)*x2^2 + (0.00987325320426037)*x2^3 + (-0.00346587474244462)*x2^4 + (0.00112687640770982)*x2^5 + (0.923172844539287)*y2^1 + (0.0611207938426525)*y2^2 + (-0.0138288041644166)*y2^3 + (0.00304566911224632)*y2^4 + (-0.000741693864083864)*y2^5 + (0.00432076125627709)*x2^4*y2^1 + (-0.00977579981688383)*x2^3*y2^1 + (0.00595597446934317)*x2^3*y2^2 + (0.0370991326871477)*x2^2*y2^1 + (-0.0103387654657405)*x2^2*y2^2 + (0.00332375081831041)*x2^2*y2^3 + (-0.207873407095)*x2^1*y2^1 + (0.0206966920052286)*x2^1*y2^2 + (0.00231309579514234)*x2^1*y2^3 + (-0.00117358921746448)*x2^1*y2^4);
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
      x1 := (log(p)-(14.9079729539359))/(0.488210605887972);
      y1 := (s-(1162.66484440706))/(134.714216393694);
      T := (290.581847476831) + (23.6549027805724) * (0.0217715958687993 + (0.0432284197491271)*x1^1 + (0.0173111673216577)*x1^2 + (-0.000187373044501361)*x1^3 + (-0.00471457698989544)*x1^4 + (0.000119780066593084)*x1^5 + (1.03232289329609)*y1^1 + (-0.00744121893988517)*y1^2 + (-0.00376821016749394)*y1^3 + (-0.0143388144740809)*y1^4 + (-0.00512420302364675)*y1^5 + (-0.00713706564959165)*x1^4*y1^1 + (0.0166879932067205)*x1^3*y1^1 + (0.0251555081804786)*x1^3*y1^2 + (0.0153707002660639)*x1^2*y1^1 + (-0.0235200392052208)*x1^2*y1^2 + (-0.0334596570921662)*x1^2*y1^3 + (0.00500915732845114)*x1^1*y1^1 + (-0.0101279993211098)*x1^1*y1^2 + (0.0227969104601056)*x1^1*y1^3 + (0.0222415645609194)*x1^1*y1^4);
    elseif s>s_dew+ds then
      x2 := (log(p)-(14.1270245848471))/(0.761443559701843);
      y2 := (s-(1916.095763562))/(120.338905932442);
      T := (315.238330535563) + (18.2458032625777) * (-0.374132398535111 + (2.14804943175534)*x2^1 + (0.153836265569991)*x2^2 + (0.00949849241432722)*x2^3 + (-0.00144958757401209)*x2^4 + (-0.00628505996332526)*x2^5 + (1.80799783428062)*y2^1 + (0.294734938297291)*y2^2 + (-0.0552457831836035)*y2^3 + (-0.0337162309697761)*y2^4 + (0.0271698499948252)*y2^5 + (-0.0197676915158783)*x2^4*y2^1 + (-0.0107327921826553)*x2^3*y2^1 + (-0.00837040100542317)*x2^3*y2^2 + (-0.0447838439862623)*x2^2*y2^1 + (-0.0391462489927273)*x2^2*y2^2 + (0.0424263498174064)*x2^2*y2^3 + (0.0305382945475173)*x2^1*y2^1 + (-0.0207310261585755)*x2^1*y2^2 + (-0.0691143608534964)*x2^1*y2^3 + (0.0638661201628536)*x2^1*y2^4);
    else
      if s<s_bubble then
        x1 := (log(p)-(14.9079729539359))/(0.488210605887972);
        y1 := (s-(1162.66484440706))/(134.714216393694);
        T1 := (290.581847476831) + (23.6549027805724) * (0.0217715958687993 + (0.0432284197491271)*x1^1 + (0.0173111673216577)*x1^2 + (-0.000187373044501361)*x1^3 + (-0.00471457698989544)*x1^4 + (0.000119780066593084)*x1^5 + (1.03232289329609)*y1^1 + (-0.00744121893988517)*y1^2 + (-0.00376821016749394)*y1^3 + (-0.0143388144740809)*y1^4 + (-0.00512420302364675)*y1^5 + (-0.00713706564959165)*x1^4*y1^1 + (0.0166879932067205)*x1^3*y1^1 + (0.0251555081804786)*x1^3*y1^2 + (0.0153707002660639)*x1^2*y1^1 + (-0.0235200392052208)*x1^2*y1^2 + (-0.0334596570921662)*x1^2*y1^3 + (0.00500915732845114)*x1^1*y1^1 + (-0.0101279993211098)*x1^1*y1^2 + (0.0227969104601056)*x1^1*y1^3 + (0.0222415645609194)*x1^1*y1^4);
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) + T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-(14.1270245848471))/(0.761443559701843);
        y2 := (s-(1916.095763562))/(120.338905932442);
        T2 := (315.238330535563) + (18.2458032625777) * (-0.374132398535111 + (2.14804943175534)*x2^1 + (0.153836265569991)*x2^2 + (0.00949849241432722)*x2^3 + (-0.00144958757401209)*x2^4 + (-0.00628505996332526)*x2^5 + (1.80799783428062)*y2^1 + (0.294734938297291)*y2^2 + (-0.0552457831836035)*y2^3 + (-0.0337162309697761)*y2^4 + (0.0271698499948252)*y2^5 + (-0.0197676915158783)*x2^4*y2^1 + (-0.0107327921826553)*x2^3*y2^1 + (-0.00837040100542317)*x2^3*y2^2 + (-0.0447838439862623)*x2^2*y2^1 + (-0.0391462489927273)*x2^2*y2^2 + (0.0424263498174064)*x2^2*y2^3 + (0.0305382945475173)*x2^1*y2^1 + (-0.0207310261585755)*x2^1*y2^2 + (-0.0691143608534964)*x2^1*y2^3 + (0.0638661201628536)*x2^1*y2^4);
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
      x1 := (p-(3096241.39859053))/(1163676.35269992);
      y1 := (T-(284.816908754933))/(29.5145619600909);
      d := (1112.5314961173) + (140.648206671696) * (0.144878740588692 + (0.0484866758187659)*x1^1 + (-0.00262606213239533)*x1^2 + (2.07474676067522e-05)*x1^3 + (0.00067809027014496)*x1^4 + (0.00020156389460073)*x1^5 + (-0.92478911277725)*y1^1 + (-0.0796345614469108)*y1^2 + (0.00334040229484787)*y1^3 + (-0.0563108498721741)*y1^4 + (-0.0322750174116899)*y1^5 + (0.000240882093543706)*x1^4*y1^1 + (0.000374122033432045)*x1^3*y1^1 + (-0.000102532525331961)*x1^3*y1^2 + (-0.00416370775805484)*x1^2*y1^1 + (-0.00614323041119305)*x1^2*y1^2 + (-0.00269226611312936)*x1^2*y1^3 + (0.0225051278186628)*x1^1*y1^1 + (0.0267586102506068)*x1^1*y1^2 + (0.035946750437324)*x1^1*y1^3 + (0.0136166188430791)*x1^1*y1^4);
    elseif p>sat.psat+dp then
      x2 := (p-(1823956.52690785))/(1172821.6452841);
      y2 := (T-(315.553817919741))/(22.5860356446669);
      d := (72.5105250726117) + (57.1460506935912) * (-0.129273971146651 + (0.99651155178974)*x2^1 + (0.281101016700183)*x2^2 + (0.147130012590215)*x2^3 + (0.145707997385443)*x2^4 + (0.109583964956523)*x2^5 + (-0.0119175534851939)*x2^6 + (0.00313920661270989)*x2^7 + (0.0812383370243361)*x2^8 + (0.00434067539185597)*x2^9 + (-0.0237094310504265)*x2^10 + (0.0451518884700338)*x2^11 + (0.0268681344220828)*x2^12 + (-0.0124888861227721)*x2^13 + (-0.00184475033112541)*x2^14 + (0.00586146709079156)*x2^15 + (0.00164388419340731)*x2^16 + (-0.196079689157084)*y2^1 + (0.0648833614589206)*y2^2 + (-0.0397197713647737)*y2^3 + (0.0166391686626386)*y2^4 + (-0.0134026424239549)*x2^15*y2^1 + (-0.0367837226726759)*x2^14*y2^1 + (0.036328314707343)*x2^14*y2^2 + (0.00252638717587399)*x2^13*y2^1 + (0.105893153904389)*x2^13*y2^2 + (-0.0416490057169901)*x2^13*y2^3 + (0.0340925269755911)*x2^12*y2^1 + (0.0270848089789435)*x2^12*y2^2 + (-0.145215868578969)*x2^12*y2^3 + (0.0180268863069663)*x2^12*y2^4 + (-0.108616432418681)*x2^11*y2^1 + (-0.0692276317678458)*x2^11*y2^2 + (-0.0939942247858957)*x2^11*y2^3 + (0.0752603524917725)*x2^11*y2^4 + (-0.176162140644362)*x2^10*y2^1 + (0.175658810699223)*x2^10*y2^2 + (0.121533926675755)*x2^10*y2^3 + (0.0733933268702483)*x2^10*y2^4 + (-0.0371682139799875)*x2^9*y2^1 + (0.307130323147767)*x2^9*y2^2 + (0.0116549872851927)*x2^9*y2^3 + (-0.0806686251004963)*x2^9*y2^4 + (-0.0584815804427485)*x2^8*y2^1 + (0.118612308165429)*x2^8*y2^2 + (-0.294980256501545)*x2^8*y2^3 + (-0.136502474780129)*x2^8*y2^4 + (-0.142289945887777)*x2^7*y2^1 + (0.180949460153352)*x2^7*y2^2 + (-0.275393235215955)*x2^7*y2^3 + (0.0962373987860812)*x2^7*y2^4 + (-0.110181749112742)*x2^6*y2^1 + (0.279154522720042)*x2^6*y2^2 + (-0.176358508833068)*x2^6*y2^3 + (0.257104709761408)*x2^6*y2^4 + (-0.245837508959696)*x2^5*y2^1 + (0.29713358038534)*x2^5*y2^2 + (-0.235845221602773)*x2^5*y2^3 + (0.119038723944664)*x2^5*y2^4 + (-0.434672109900229)*x2^4*y2^1 + (0.550497834124465)*x2^4*y2^2 + (-0.347963136225282)*x2^4*y2^3 + (0.007211734482379)*x2^4*y2^4 + (-0.415109181780274)*x2^3*y2^1 + (0.653916502153626)*x2^3*y2^2 + (-0.443046799428416)*x2^3*y2^3 + (0.0855351466462972)*x2^3*y2^4 + (-0.342539339794234)*x2^2*y2^1 + (0.435109234991179)*x2^2*y2^2 + (-0.373392664448401)*x2^2*y2^3 + (0.135659917562775)*x2^2*y2^4 + (-0.329258772098639)*x2^1*y2^1 + (0.207847083329085)*x2^1*y2^2 + (-0.17734106145167)*x2^1*y2^3 + (0.0758303061734078)*x2^1*y2^4);
    else
      if p<sat.psat then
        x1 := (p-(3096241.39859053))/(1163676.35269992);
        y1 := (T-(284.816908754933))/(29.5145619600909);
        d1 := (1112.5314961173) + (140.648206671696) * (0.144878740588692 + (0.0484866758187659)*x1^1 + (-0.00262606213239533)*x1^2 + (2.07474676067522e-05)*x1^3 + (0.00067809027014496)*x1^4 + (0.00020156389460073)*x1^5 + (-0.92478911277725)*y1^1 + (-0.0796345614469108)*y1^2 + (0.00334040229484787)*y1^3 + (-0.0563108498721741)*y1^4 + (-0.0322750174116899)*y1^5 + (0.000240882093543706)*x1^4*y1^1 + (0.000374122033432045)*x1^3*y1^1 + (-0.000102532525331961)*x1^3*y1^2 + (-0.00416370775805484)*x1^2*y1^1 + (-0.00614323041119305)*x1^2*y1^2 + (-0.00269226611312936)*x1^2*y1^3 + (0.0225051278186628)*x1^1*y1^1 + (0.0267586102506068)*x1^1*y1^2 + (0.035946750437324)*x1^1*y1^3 + (0.0136166188430791)*x1^1*y1^4);
        d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-(1823956.52690785))/(1172821.6452841);
        y2 := (T-(315.553817919741))/(22.5860356446669);
        d2 := (72.5105250726117) + (57.1460506935912) * (-0.129273971146651 + (0.99651155178974)*x2^1 + (0.281101016700183)*x2^2 + (0.147130012590215)*x2^3 + (0.145707997385443)*x2^4 + (0.109583964956523)*x2^5 + (-0.0119175534851939)*x2^6 + (0.00313920661270989)*x2^7 + (0.0812383370243361)*x2^8 + (0.00434067539185597)*x2^9 + (-0.0237094310504265)*x2^10 + (0.0451518884700338)*x2^11 + (0.0268681344220828)*x2^12 + (-0.0124888861227721)*x2^13 + (-0.00184475033112541)*x2^14 + (0.00586146709079156)*x2^15 + (0.00164388419340731)*x2^16 + (-0.196079689157084)*y2^1 + (0.0648833614589206)*y2^2 + (-0.0397197713647737)*y2^3 + (0.0166391686626386)*y2^4 + (-0.0134026424239549)*x2^15*y2^1 + (-0.0367837226726759)*x2^14*y2^1 + (0.036328314707343)*x2^14*y2^2 + (0.00252638717587399)*x2^13*y2^1 + (0.105893153904389)*x2^13*y2^2 + (-0.0416490057169901)*x2^13*y2^3 + (0.0340925269755911)*x2^12*y2^1 + (0.0270848089789435)*x2^12*y2^2 + (-0.145215868578969)*x2^12*y2^3 + (0.0180268863069663)*x2^12*y2^4 + (-0.108616432418681)*x2^11*y2^1 + (-0.0692276317678458)*x2^11*y2^2 + (-0.0939942247858957)*x2^11*y2^3 + (0.0752603524917725)*x2^11*y2^4 + (-0.176162140644362)*x2^10*y2^1 + (0.175658810699223)*x2^10*y2^2 + (0.121533926675755)*x2^10*y2^3 + (0.0733933268702483)*x2^10*y2^4 + (-0.0371682139799875)*x2^9*y2^1 + (0.307130323147767)*x2^9*y2^2 + (0.0116549872851927)*x2^9*y2^3 + (-0.0806686251004963)*x2^9*y2^4 + (-0.0584815804427485)*x2^8*y2^1 + (0.118612308165429)*x2^8*y2^2 + (-0.294980256501545)*x2^8*y2^3 + (-0.136502474780129)*x2^8*y2^4 + (-0.142289945887777)*x2^7*y2^1 + (0.180949460153352)*x2^7*y2^2 + (-0.275393235215955)*x2^7*y2^3 + (0.0962373987860812)*x2^7*y2^4 + (-0.110181749112742)*x2^6*y2^1 + (0.279154522720042)*x2^6*y2^2 + (-0.176358508833068)*x2^6*y2^3 + (0.257104709761408)*x2^6*y2^4 + (-0.245837508959696)*x2^5*y2^1 + (0.29713358038534)*x2^5*y2^2 + (-0.235845221602773)*x2^5*y2^3 + (0.119038723944664)*x2^5*y2^4 + (-0.434672109900229)*x2^4*y2^1 + (0.550497834124465)*x2^4*y2^2 + (-0.347963136225282)*x2^4*y2^3 + (0.007211734482379)*x2^4*y2^4 + (-0.415109181780274)*x2^3*y2^1 + (0.653916502153626)*x2^3*y2^2 + (-0.443046799428416)*x2^3*y2^3 + (0.0855351466462972)*x2^3*y2^4 + (-0.342539339794234)*x2^2*y2^1 + (0.435109234991179)*x2^2*y2^2 + (-0.373392664448401)*x2^2*y2^3 + (0.135659917562775)*x2^2*y2^4 + (-0.329258772098639)*x2^1*y2^1 + (0.207847083329085)*x2^1*y2^2 + (-0.17734106145167)*x2^1*y2^3 + (0.0758303061734078)*x2^1*y2^4);
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
    Nabizadeh and Mayinger (1999), Viscosity of Gaseous R404A, R407C, R410A, 
    and R507. International Journal of Thermophysics, Vol. 20. No. 3.
  */
  /*The functional form of the dynamic viscosity is implented as presented in
    Geller et al. (2000), Viscosity of Mixed Refrigerants, R404A, R407C, R410A, 
    and R507C. Eighth International Refrigeration Conference.
  */

    //Real tau = state.T/317.47 "Reduced temperature for the limits of zero density";
    //Real sigma_eta "Collision integral";
  protected
    Real eta_zd "Dynamic viscosity for the limit of zero density";
    Real eta_hd "Dynamic viscosity for the limit of high density";

  algorithm

    // Calculate the dynamic visocity near the limit of zero density
    //sigma_eta := exp(0.45667 - 0.53955*log(tau) + 0.187265*log(tau)^2
    //  - 0.03629*log(tau)^3 + 0.00241*log(tau)^4);
    //eta_zd := 2.6696e-2 * sqrt(1*state.T)/(0.4324^2*sigma_eta);
    eta_zd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

    // Calculate the dynamic viscosity for limits of higher densities
    eta_hd := 9.047e-3 + 5.784e-5*state.d^2 + 1.309e-7*state.d^3 -
      2.422e-10*state.d^4 + 9.424e-14*state.d^5 + 3.933e-17*state.d^6;

    // Calculate the final dynamic visocity
    eta := (eta_zd + eta_hd)*1e-6;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
  "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
    Geller et al. (2001), Thermal Conductivity of the Refrigerant Mixtures R404A,
    R407C, R410A, and R507A. International Journal of Thermophysics, Vol. 22, No. 4.
  */
  protected
    Real lambda_0 "Thermal conductivity for the limit of zero density";
    Real lambda_r "Thermal conductivity for residual part";

  algorithm

    // Calculate the thermal conducitvity for the limit of zero density
    lambda_0 := -8.872 + 7.41e-2*state.T;

    // Calculate the thermal conductivity for the residual part
    lambda_r := 3.576e-2*state.d - 9.045e-6*state.d^2 + 4.343e-8*state.d^3
      - 3.705e-12*state.d^4;

    // Calculate the final thermal conductivity
    lambda := (lambda_0 + lambda_r)*1e-3;

  end thermalConductivity;

  redeclare function extends surfaceTension
  "Surface tension in two phase region of refrigerant"

  /*The functional form of the surface tension is implented as presented in
    Fröba and Leipertz (2003), Thermophysical Properties of the Refrigerant 
    Mixtures R410A and R407C from Dynamic Light Scattering (DLS).
    International Journal ofThermophysics, Vol. 24, No. 5.
  */
  protected
    Real tau = sat.Tsat/343.16 "Dimensionless temperature";

  algorithm
    sigma := (67.468*(1-tau)^1.26 * (1 - 0.051*(1-tau)^0.5 - 0.193*(1-tau)))*1e-3;
  end surfaceTension;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 20, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides a refrigerant model for R410a using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a> and the refrigerant model is implemented by complete the template <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>. The fitting coefficients required in the template are saved in the package <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.R410a\">AixLib.DataBase.Media.Refrigerants.R410a</a>.</p>
<p><b>Assumptions and limitations</b> </p>
<p>The implemented coefficients are fitted to external data by Engelpracht and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>0.5</p></td>
<td><p>48</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>233.15</p></td>
<td><p>340.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>Validation</b> </p>
<p> The model is validated by comparing results obtained from the example model <a href=\"modelica://AixLib.Media.Refrigerants.Examples.RefrigerantProperties\">AixLib.Media.Refrigerants.Examples.RefrigerantProperties</a> to external data (i.e. NIST RefProp 9.1).</p>
<p><b>References</b> </p>
<p>Lemmon, E. W. (2003): Pseudo-Pure Fluid Equations of State for the Refrigerant Blends R-410A, R-404A, R-507A, and R-407C. In: <i>International Journal ofThermophysics 24 (4)</i>, S. 991–1006. DOI: 10.1023/A:1025048800563.</p>
<p>Geller, V. Z.; Bivens, D.; Yokozeki, A. (2000): Viscosity of Mixed Refrigerants, R404A, R407C, R410A, and R507C. In: <i>International refrigeration and air conditioning conference</i>. USA, S. 399–406. Online available at http://docs.lib.purdue.edu/iracc/508.</p>
<p>Nabizadeh, H.; Mayinger, F. (1999): Viscosity of Gaseous R404A, R407C, R410A, and R507. In: <i>International Journal of Thermophysics 20 (3)</i>, S. 777–790. DOI: 10.1007/978-1-4615-4777-8_1.</p>
<p>Geller, V. Z.; Nemzer, B. V.; Cheremnykh, U. V. (2001): Thermal Conductivity of the Refrigerant Mixtures R404A, R407C, R410A, and R507A. In: <i>International Journal of Thermophysics 22 (4)</i>, 1035–1043. DOI: 10.1023/A:1010691504352.</p>
<p>Fröba, A. P.; Leipertz, A. (2003): Thermophysical Properties of the Refrigerant Mixtures R410A and R407C from Dynamic Light Scattering (DLS). In: <i>International Journal ofThermophysics 24 (5)</i>, S. 1185–1206. DOI: 10.1023/A:1026152331710.</p>
<p>Engelpracht, Mirko (2017): Development of modular and scalable simulation models for heat pumps and chillers considering various refrigerants. <i>Master Thesis</i></p>
</html>"));
end R410a_IIR_P05_48_T233_340_Formula;
