within AixLib.Media.Refrigerants.R410A_HEoS;
package R410a_IIR_P1_48_T233_473_Horner "Refrigerant model for R410a using a hybrid approach with explicit
  Horner formulas"

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
     each criticalMolarVolume = 1/6324,
     each normalBoilingPoint = 221.71,
     each triplePointTemperature = 200,
     each meltingPoint = 118.15,
     each acentricFactor = 0.296,
     each triplePointPressure = 29160,
     each dipoleMoment = 0,
     each hasCriticalData=true) "Thermodynamic constants for R410a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R410a",
    substanceNames={"R410a"},
    singleState=false,
    SpecificEnthalpy(
      start=2.0e5,
      nominal=2.50e5,
      min=143.4e3,
      max=620.0e3),
    Density(
      start=500,
      nominal=750,
      min=2,
      max=1325),
    AbsolutePressure(
      start=2e5,
      nominal=5e5,
      min=1e5,
      max=48e5),
    Temperature(
      start=273.15,
      nominal=273.15,
      min=233.15,
      max=473.15),
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

  /*Provide records thats contain the coefficients for the smooth transition
    between different regions.
  */
  redeclare record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
      SpecificEnthalpy T_ph = 2.5;
      SpecificEntropy T_ps = 2.5;
      AbsolutePressure d_pT = 2.5;
      SpecificEnthalpy d_ph = 2.5;
      Real d_ps(unit="J/(Pa.K.kg)") =  50/(48e5-1e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 50/(48e5-1e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  algorithm
    f_Idg := log(delta) + (-1) * log(tau^(1)) + (36.8871) * tau^(0) +
      (7.15807) * tau^(1) + (-46.87575) * tau^(-0.1) + (2.0623) *
      log(1-exp(-(2.02326)*tau)) + (5.9751) * log(1-exp(-(5.00154)*tau)) +
      (1.5612) * log(1-exp(-(11.2484)*tau));
  end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    f_Res := (0.987252) * delta^(1) * tau^(0.44) + (-1.03017) * delta^(1)
      * tau^(1.2) + (1.17666) * delta^(1) * tau^(2.97) + (-0.138991)
      * delta^(2) * tau^(2.95) + (0.00302373) * delta^(5) * tau^(0.2) +
      (-2.53639) * delta^(1) * tau^(1.93) * exp(-delta^(1)) + (-1.9668)
      * delta^(2) * tau^(1.78) * exp(-delta^(1)) + (-0.83048) * delta^(3)
      * tau^(3) * exp(-delta^(1)) + (0.172477) * delta^(5) * tau^(0.2)
      * exp(-delta^(1)) + (-0.261116) * delta^(5) * tau^(0.74)
      * exp(-delta^(1)) + (-0.0745473) * delta^(5) * tau^(3)
      * exp(-delta^(1)) + (0.679757) * delta^(1) * tau^(2.1)
      * exp(-delta^(2)) + (-0.652431) * delta^(1) * tau^(4.3)
      * exp(-delta^(2)) + (0.0553849) * delta^(4) * tau^(0.25)
      * exp(-delta^(2)) + (-0.071097) * delta^(4) * tau^(7)
      * exp(-delta^(2)) + (-0.000875332) * delta^(9) * tau^(4.7)
      * exp(-delta^(2)) + (0.020076) * delta^(2) * tau^(13)
      * exp(-delta^(3)) + (-0.0139761) * delta^(2) * tau^(16)
      * exp(-delta^(3)) + (-0.018511) * delta^(4) * tau^(25)
      * exp(-delta^(3)) + (0.0171939) * delta^(5) * tau^(17)
      * exp(-delta^(3)) + (-0.00482049) * delta^(6) * tau^(7.4)
      * exp(-delta^(3));
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
  algorithm
    t_fIdg_t := (-1)*(1) + (36.8871)*(0)*tau^(0) + (7.15807)*(1)*
      tau^(1) + (-46.87575)*(-0.1)*tau^(-0.1) + tau*(2.0623)*(2.02326)/
      (exp((2.02326)*tau)-1) + tau*(5.9751)*(5.00154)/(exp((5.00154)*tau)-1)
      + tau*(1.5612)*(11.2484)/(exp((11.2484)*tau)-1);
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
  algorithm
    tt_fIdg_tt := -(-1)*(1) + (36.8871)*(0)*((0)-1)*tau^(0) +
      (7.15807)*(1)*((1)-1)*tau^(1) + (-46.87575)*(-0.1)*((-0.1)-1)*
      tau^(-0.1) -tau^2*(2.0623)*(2.02326)^2*exp((2.02326)*tau)/
      (exp((2.02326)*tau)-1)^2 -tau^2*(5.9751)*(5.00154)^2*exp((5.00154)*
      tau)/(exp((5.00154)*tau)-1)^2 -tau^2*(1.5612)*(11.2484)^2*
      exp((11.2484)*tau)/(exp((11.2484)*tau)-1)^2;
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
  algorithm
    t_fRes_t := (0.987252)*(0.44)*delta^(1)*tau^(0.44) +
      (-1.03017)*(1.2)*delta^(1)*tau^(1.2) + (1.17666)*(2.97)*delta^(1)*
      tau^(2.97) + (-0.138991)*(2.95)*delta^(2)*tau^(2.95) + (0.00302373)*
      (0.2)*delta^(5)*tau^(0.2) + (-2.53639)*(1.93)*delta^(1)*tau^(1.93)*
      exp(-delta^(1)) + (-1.9668)*(1.78)*delta^(2)*tau^(1.78)*
      exp(-delta^(1)) + (-0.83048)*(3)*delta^(3)*tau^(3)*exp(-delta^(1))
      + (0.172477)*(0.2)*delta^(5)*tau^(0.2)*exp(-delta^(1)) + (-0.261116)*
      (0.74)*delta^(5)*tau^(0.74)*exp(-delta^(1)) + (-0.0745473)*(3)*
      delta^(5)*tau^(3)*exp(-delta^(1)) + (0.679757)*(2.1)*delta^(1)*
      tau^(2.1)*exp(-delta^(2)) + (-0.652431)*(4.3)*delta^(1)*tau^(4.3)*
      exp(-delta^(2)) + (0.0553849)*(0.25)*delta^(4)*tau^(0.25)*
      exp(-delta^(2)) + (-0.071097)*(7)*delta^(4)*tau^(7)*exp(-delta^(2))
      + (-0.000875332)*(4.7)*delta^(9)*tau^(4.7)*exp(-delta^(2)) + (0.020076)*
      (13)*delta^(2)*tau^(13)*exp(-delta^(3)) + (-0.0139761)*(16)*
      delta^(2)*tau^(16)*exp(-delta^(3)) + (-0.018511)*(25)*delta^(4)*
      tau^(25)*exp(-delta^(3)) + (0.0171939)*(17)*delta^(5)*tau^(17)*
      exp(-delta^(3)) + (-0.00482049)*(7.4)*delta^(6)*tau^(7.4)*
      exp(-delta^(3));
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
  algorithm
    tt_fRes_tt := (0.987252)*(0.44)*((0.44)-1)*delta^(1)*
      tau^(0.44) + (-1.03017)*(1.2)*((1.2)-1)*delta^(1)*tau^(1.2) + (1.17666)*
      (2.97)*((2.97)-1)*delta^(1)*tau^(2.97) + (-0.138991)*(2.95)*((2.95)-1)*
      delta^(2)*tau^(2.95) + (0.00302373)*(0.2)*((0.2)-1)*delta^(5)*tau^(0.2)
      + (-2.53639)*(1.93)*((1.93)-1)*delta^(1)*tau^(1.93)*exp(-delta^(1))
      + (-1.9668)*(1.78)*((1.78)-1)*delta^(2)*tau^(1.78)*exp(-delta^(1))
      + (-0.83048)*(3)*((3)-1)*delta^(3)*tau^(3)*exp(-delta^(1))
      + (0.172477)*(0.2)*((0.2)-1)*delta^(5)*tau^(0.2)*exp(-delta^(1))
      + (-0.261116)*(0.74)*((0.74)-1)*delta^(5)*tau^(0.74)*exp(-delta^(1))
      + (-0.0745473)*(3)*((3)-1)*delta^(5)*tau^(3)*exp(-delta^(1))
      + (0.679757)*(2.1)*((2.1)-1)*delta^(1)*tau^(2.1)*exp(-delta^(2))
      + (-0.652431)*(4.3)*((4.3)-1)*delta^(1)*tau^(4.3)*exp(-delta^(2))
      + (0.0553849)*(0.25)*((0.25)-1)*delta^(4)*tau^(0.25)*exp(-delta^(2))
      + (-0.071097)*(7)*((7)-1)*delta^(4)*tau^(7)*exp(-delta^(2))
      + (-0.000875332)*(4.7)*((4.7)-1)*delta^(9)*tau^(4.7)*exp(-delta^(2))
      + (0.020076)*(13)*((13)-1)*delta^(2)*tau^(13)*exp(-delta^(3))
      + (-0.0139761)*(16)*((16)-1)*delta^(2)*tau^(16)*exp(-delta^(3))
      + (-0.018511)*(25)*((25)-1)*delta^(4)*tau^(25)*exp(-delta^(3))
      + (0.0171939)*(17)*((17)-1)*delta^(5)*tau^(17)*exp(-delta^(3))
      + (-0.00482049)*(7.4)*((7.4)-1)*delta^(6)*tau^(7.4)*exp(-delta^(3));
  end tt_fRes_tt;

  redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
  algorithm
    d_fRes_d := (0.987252)*(1)*delta^(1)*tau^(0.44)
      + (-1.03017)*(1)*delta^(1)*tau^(1.2) + (1.17666)*(1)*delta^(1)
      *tau^(2.97) + (-0.138991)*(2)*delta^(2)*tau^(2.95) + (0.00302373)*(5)
      *delta^(5)*tau^(0.2) + (-2.53639)*delta^(1)*tau^(1.93)*((1)-(1)
      *delta^(1))*exp(-delta^(1)) + (-1.9668)*delta^(2)*tau^(1.78)*((2)-(1)
      *delta^(1))*exp(-delta^(1)) + (-0.83048)*delta^(3)*tau^(3)*((3)-(1)
      *delta^(1))*exp(-delta^(1)) + (0.172477)*delta^(5)*tau^(0.2)*((5)-(1)
      *delta^(1))*exp(-delta^(1)) + (-0.261116)*delta^(5)*tau^(0.74)*((5)-(1)
      *delta^(1))*exp(-delta^(1)) + (-0.0745473)*delta^(5)*tau^(3)*((5)-(1)
      *delta^(1))*exp(-delta^(1)) + (0.679757)*delta^(1)*tau^(2.1)*((1)-(2)
      *delta^(2))*exp(-delta^(2)) + (-0.652431)*delta^(1)*tau^(4.3)*((1)-(2)
      *delta^(2))*exp(-delta^(2)) + (0.0553849)*delta^(4)*tau^(0.25)*((4)-(2)
      *delta^(2))*exp(-delta^(2)) + (-0.071097)*delta^(4)*tau^(7)*((4)-(2)
      *delta^(2))*exp(-delta^(2)) + (-0.000875332)*delta^(9)*tau^(4.7)
      *((9)-(2)*delta^(2))*exp(-delta^(2)) + (0.020076)*delta^(2)*tau^(13)
      *((2)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0139761)*delta^(2)*tau^(16)
      *((2)-(3)*delta^(3))*exp(-delta^(3)) + (-0.018511)*delta^(4)*tau^(25)
      *((4)-(3)*delta^(3))*exp(-delta^(3)) + (0.0171939)*delta^(5)*tau^(17)
      *((5)-(3)*delta^(3))*exp(-delta^(3)) + (-0.00482049)*delta^(6)*tau^(7.4)
      *((6)-(3)*delta^(3))*exp(-delta^(3));
  end d_fRes_d;

  redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
  algorithm
    dd_fRes_dd := (0.987252)*(1)*((1)-1)*delta^(1)*tau^(0.44)
      + (-1.03017)*(1)*((1)-1)*delta^(1)*tau^(1.2) + (1.17666)*(1)*((1)-1)
      *delta^(1)*tau^(2.97) + (-0.138991)*(2)*((2)-1)*delta^(2)*tau^(2.95)
      + (0.00302373)*(5)*((5)-1)*delta^(5)*tau^(0.2) + (-2.53639)*delta^(1)
      *tau^(1.93)*(((1)-(1)*delta^(1))*((1)-1-(1)*delta^(1))-(1)^2*delta^(1))
      *exp(-delta^(1)) + (-1.9668)*delta^(2)*tau^(1.78)*(((2)-(1)*delta^(1))
      *((2)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.83048)
      *delta^(3)*tau^(3)*(((3)-(1)*delta^(1))*((3)-1-(1)*delta^(1))-(1)^2
      *delta^(1))*exp(-delta^(1)) + (0.172477)*delta^(5)*tau^(0.2)*(((5)-(1)
      *delta^(1))*((5)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1))
      + (-0.261116)*delta^(5)*tau^(0.74)*(((5)-(1)*delta^(1))*((5)-1-(1)
      *delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.0745473)*delta^(5)
      *tau^(3)*(((5)-(1)*delta^(1))*((5)-1-(1)*delta^(1))-(1)^2*delta^(1))
      *exp(-delta^(1)) + (0.679757)*delta^(1)*tau^(2.1)*(((1)-(2)*delta^(2))
      *((1)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.652431)
      *delta^(1)*tau^(4.3)*(((1)-(2)*delta^(2))*((1)-1-(2)*delta^(2))-(2)^2
      *delta^(2))*exp(-delta^(2)) + (0.0553849)*delta^(4)*tau^(0.25)*(((4)-(2)
      *delta^(2))*((4)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2))
      + (-0.071097)*delta^(4)*tau^(7)*(((4)-(2)*delta^(2))*((4)-1-(2)
      *delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.000875332)*delta^(9)
      *tau^(4.7)*(((9)-(2)*delta^(2))*((9)-1-(2)*delta^(2))-(2)^2*delta^(2))
      *exp(-delta^(2)) + (0.020076)*delta^(2)*tau^(13)*(((2)-(3)*delta^(3))
      *((2)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.0139761)
      *delta^(2)*tau^(16)*(((2)-(3)*delta^(3))*((2)-1-(3)*delta^(3))-(3)^2
      *delta^(3))*exp(-delta^(3)) + (-0.018511)*delta^(4)*tau^(25)*(((4)-(3)
      *delta^(3))*((4)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3))
      + (0.0171939)*delta^(5)*tau^(17)*(((5)-(3)*delta^(3))*((5)-1-(3)
      *delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (-0.00482049)*delta^(6)
      *tau^(7.4)*(((6)-(3)*delta^(3))*((6)-1-(3)*delta^(3))-(3)^2*delta^(3))
      *exp(-delta^(3));
  end dd_fRes_dd;

  redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  algorithm
    td_fRes_td := (0.987252)*(1)*(0.44)*delta^(1)
      *tau^(0.44) + (-1.03017)*(1)*(1.2)*delta^(1)*tau^(1.2) + (1.17666)
      *(1)*(2.97)*delta^(1)*tau^(2.97) + (-0.138991)*(2)*(2.95)*delta^(2)
      *tau^(2.95) + (0.00302373)*(5)*(0.2)*delta^(5)*tau^(0.2) + (-2.53639)
      *(1.93)*delta^(1)*tau^(1.93)*((1)-(1)*delta^(1))*exp(-delta^(1))
      + (-1.9668)*(1.78)*delta^(2)*tau^(1.78)*((2)-(1)*delta^(1))*
      exp(-delta^(1)) + (-0.83048)*(3)*delta^(3)*tau^(3)*((3)-(1)*delta^(1))*
      exp(-delta^(1)) + (0.172477)*(0.2)*delta^(5)*tau^(0.2)*((5)-(1)*
      delta^(1))*exp(-delta^(1)) + (-0.261116)*(0.74)*delta^(5)*tau^(0.74)*
      ((5)-(1)*delta^(1))*exp(-delta^(1)) + (-0.0745473)*(3)*delta^(5)*
      tau^(3)*((5)-(1)*delta^(1))*exp(-delta^(1)) + (0.679757)*(2.1)*delta^(1)*
      tau^(2.1)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.652431)*(4.3)*
      delta^(1)*tau^(4.3)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (0.0553849)*
      (0.25)*delta^(4)*tau^(0.25)*((4)-(2)*delta^(2))*exp(-delta^(2)) +
       (-0.071097)*(7)*delta^(4)*tau^(7)*((4)-(2)*delta^(2))*exp(-delta^(2)) +
        (-0.000875332)*(4.7)*delta^(9)*tau^(4.7)*((9)-(2)*delta^(2))*
        exp(-delta^(2)) + (0.020076)*(13)*delta^(2)*tau^(13)*((2)-(3)*
        delta^(3))*exp(-delta^(3)) + (-0.0139761)*(16)*delta^(2)*tau^(16)*
        ((2)-(3)*delta^(3))*exp(-delta^(3)) + (-0.018511)*(25)*delta^(4)*
        tau^(25)*((4)-(3)*delta^(3))*exp(-delta^(3)) + (0.0171939)*(17)*
        delta^(5)*tau^(17)*((5)-(3)*delta^(3))*exp(-delta^(3)) +
        (-0.00482049)*(7.4)*delta^(6)*tau^(7.4)*((6)-(3)*delta^(3))*
        exp(-delta^(3));
  end td_fRes_td;

  redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fIdg_ttt := 2*(-1)*(1) + (36.8871)*(0)*((0)-1)*((0)-2) *
      tau^(0) + (7.15807)*(1)*((1)-1)*((1)-2) *tau^(1) + (-46.87575)*
      (-0.1)*((-0.1)-1)*((-0.1)-2) *tau^(-0.1) + tau^3*(2.0623)*(2.02326)^3*
      exp((2.02326)*tau)*(exp((2.02326)*tau)+1)/(exp((2.02326)*tau)-1)^3 +
       tau^3*(5.9751)*(5.00154)^3*exp((5.00154)*tau)*(exp((5.00154)*tau)+1)/
       (exp((5.00154)*tau)-1)^3 + tau^3*(1.5612)*(11.2484)^3*exp((11.2484)*
       tau)*(exp((11.2484)*tau)+1)/(exp((11.2484)*tau)-1)^3;
  end ttt_fIdg_ttt;

  redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fRes_ttt := (0.987252)*(0.44)*((0.44)-1)*((0.44)-2)*
      delta^(1)*tau^(0.44) + (-1.03017)*(1.2)*((1.2)-1)*((1.2)-2)*delta^(1)*
      tau^(1.2) + (1.17666)*(2.97)*((2.97)-1)*((2.97)-2)*delta^(1)*
      tau^(2.97) + (-0.138991)*(2.95)*((2.95)-1)*((2.95)-2)*delta^(2)*
      tau^(2.95) + (0.00302373)*(0.2)*((0.2)-1)*((0.2)-2)*delta^(5)*
      tau^(0.2) + (-2.53639)*(1.93)*((1.93)-1)*((1.93)-2)*delta^(1)*
      tau^(1.93)*exp(-delta^(1)) + (-1.9668)*(1.78)*((1.78)-1)*((1.78)-2)*
      delta^(2)*tau^(1.78)*exp(-delta^(1)) + (-0.83048)*(3)*((3)-1)*((3)-2)*
      delta^(3)*tau^(3)*exp(-delta^(1)) + (0.172477)*(0.2)*((0.2)-1)*
      ((0.2)-2)*delta^(5)*tau^(0.2)*exp(-delta^(1)) + (-0.261116)*(0.74)*
      ((0.74)-1)*((0.74)-2)*delta^(5)*tau^(0.74)*exp(-delta^(1)) +
      (-0.0745473)*(3)*((3)-1)*((3)-2)*delta^(5)*tau^(3)*exp(-delta^(1))
      + (0.679757)*(2.1)*((2.1)-1)*((2.1)-2)*delta^(1)*tau^(2.1)*
      exp(-delta^(2)) + (-0.652431)*(4.3)*((4.3)-1)*((4.3)-2)*delta^(1)*
      tau^(4.3)*exp(-delta^(2)) + (0.0553849)*(0.25)*((0.25)-1)*((0.25)-2)*
      delta^(4)*tau^(0.25)*exp(-delta^(2)) + (-0.071097)*(7)*((7)-1)*((7)-2)*
      delta^(4)*tau^(7)*exp(-delta^(2)) + (-0.000875332)*(4.7)*((4.7)-1)*
      ((4.7)-2)*delta^(9)*tau^(4.7)*exp(-delta^(2)) + (0.020076)*(13)*
      ((13)-1)*((13)-2)*delta^(2)*tau^(13)*exp(-delta^(3)) + (-0.0139761)*
      (16)*((16)-1)*((16)-2)*delta^(2)*tau^(16)*exp(-delta^(3)) +
      (-0.018511)*(25)*((25)-1)*((25)-2)*delta^(4)*tau^(25)*exp(-delta^(3))
      + (0.0171939)*(17)*((17)-1)*((17)-2)*delta^(5)*tau^(17)*exp(-delta^(3))
      + (-0.00482049)*(7.4)*((7.4)-1)*((7.4)-2)*delta^(6)*tau^(7.4)*
      exp(-delta^(3));
  end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd
    "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
  algorithm
    ddd_fRes_ddd := (0.987252)*(1)*((1)-1)*((1)-2)*delta^(1)*
      tau^(0.44) + (-1.03017)*(1)*((1)-1)*((1)-2)*delta^(1)*tau^(1.2) +
      (1.17666)*(1)*((1)-1)*((1)-2)*delta^(1)*tau^(2.97) + (-0.138991)*(2)*
      ((2)-1)*((2)-2)*delta^(2)*tau^(2.95) + (0.00302373)*(5)*((5)-1)*((5)-2)*
      delta^(5)*tau^(0.2) - (-2.53639)*delta^(1)*tau^(1.93)*exp(-delta^(1))*
      ((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(1)+3)+(1)+3*(1)-3)+
      3*(1)^2-6*(1)+2)-((1)-2)*((1)-1)*(1)) - (-1.9668)*delta^(2)*tau^(1.78)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(2)+
      3)+(1)+3*(2)-3)+3*(2)^2-6*(2)+2)-((2)-2)*((2)-1)*(2)) - (-0.83048)*
      delta^(3)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1)-3)-3*(3)+3)+(1)+3*(3)-3)+3*(3)^2-6*(3)+2)-((3)-2)*((3)-1)*
      (3)) - (0.172477)*delta^(5)*tau^(0.2)*exp(-delta^(1))*((1)*delta^(1)*
      ((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(5)+3)+(1)+3*(5)-3)+3*(5)^2-6*
      (5)+2)-((5)-2)*((5)-1)*(5)) - (-0.261116)*delta^(5)*tau^(0.74)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*
      (5)+3)+(1)+3*(5)-3)+3*(5)^2-6*(5)+2)-((5)-2)*((5)-1)*(5)) - (-0.0745473)*
      delta^(5)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1)-3)-3*(5)+3)+(1)+3*(5)-3)+3*(5)^2-6*(5)+2)-((5)-2)*((5)-1)*
      (5)) - (0.679757)*delta^(1)*tau^(2.1)*exp(-delta^(2))*((2)*delta^(2)*
      ((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(1)+3)+(2)+3*(1)-3)+3*(1)^2-6*
      (1)+2)-((1)-2)*((1)-1)*(1)) - (-0.652431)*delta^(1)*tau^(4.3)*
      exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(1)+
      3)+(2)+3*(1)-3)+3*(1)^2-6*(1)+2)-((1)-2)*((1)-1)*(1)) - (0.0553849)*
      delta^(4)*tau^(0.25)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*
      ((2)*(delta^(2)-3)-3*(4)+3)+(2)+3*(4)-3)+3*(4)^2-6*(4)+2)-((4)-2)*
      ((4)-1)*(4)) - (-0.071097)*delta^(4)*tau^(7)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(4)+3)+(2)+3*(4)-3)+3*
      (4)^2-6*(4)+2)-((4)-2)*((4)-1)*(4)) - (-0.000875332)*delta^(9)*
      tau^(4.7)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*
      (delta^(2)-3)-3*(9)+3)+(2)+3*(9)-3)+3*(9)^2-6*(9)+2)-((9)-2)*((9)-1)*
      (9)) - (0.020076)*delta^(2)*tau^(13)*exp(-delta^(3))*((3)*delta^(3)*
      ((3)*(delta^(3)*((3)*(delta^(3)-3)-3*(2)+3)+(3)+3*(2)-3)+3*(2)^2-6*
      (2)+2)-((2)-2)*((2)-1)*(2)) - (-0.0139761)*delta^(2)*tau^(16)*
      exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)*((3)*(delta^(3)-3)-3*
      (2)+3)+(3)+3*(2)-3)+3*(2)^2-6*(2)+2)-((2)-2)*((2)-1)*(2)) - (-0.018511)*
      delta^(4)*tau^(25)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)*
      ((3)*(delta^(3)-3)-3*(4)+3)+(3)+3*(4)-3)+3*(4)^2-6*(4)+2)-((4)-2)*
      ((4)-1)*(4)) - (0.0171939)*delta^(5)*tau^(17)*exp(-delta^(3))*((3)*
      delta^(3)*((3)*(delta^(3)*((3)*(delta^(3)-3)-3*(5)+3)+(3)+3*(5)-3)+3*
      (5)^2-6*(5)+2)-((5)-2)*((5)-1)*(5)) - (-0.00482049)*delta^(6)*tau^(7.4)*
      exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)*((3)*(delta^(3)-3)-3*
      (6)+3)+(3)+3*(6)-3)+3*(6)^2-6*(6)+2)-((6)-2)*((6)-1)*(6));
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  algorithm
    tdd_fRes_tdd := (0.987252)*(1)*(0.44)*(1-1)*
      delta^(1)*tau^(0.44) + (-1.03017)*(1)*(1.2)*(1-1)*delta^(1)*tau^(1.2)
      + (1.17666)*(1)*(2.97)*(1-1)*delta^(1)*tau^(2.97) + (-0.138991)*(2)*
      (2.95)*(2-1)*delta^(2)*tau^(2.95) + (0.00302373)*(5)*(0.2)*(5-1)*
      delta^(5)*tau^(0.2) + (-2.53639)*(1.93)*delta^(1)*tau^(1.93)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(1)+1)+(1)*
      ((1)-1)) + (-1.9668)*(1.78)*delta^(2)*tau^(1.78)*exp(-delta^(1))*((1)*
      delta^(1)*((1)*(delta^(1)-1)-2*(2)+1)+(2)*((2)-1)) + (-0.83048)*(3)*
      delta^(3)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*
      (3)+1)+(3)*((3)-1)) + (0.172477)*(0.2)*delta^(5)*tau^(0.2)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(5)+1)+(5)*((5)-1))
      + (-0.261116)*(0.74)*delta^(5)*tau^(0.74)*exp(-delta^(1))*((1)*
      delta^(1)*((1)*(delta^(1)-1)-2*(5)+1)+(5)*((5)-1)) + (-0.0745473)*(3)*
      delta^(5)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*
      (5)+1)+(5)*((5)-1)) + (0.679757)*(2.1)*delta^(1)*tau^(2.1)*
      exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)-1)-2*(1)+1)+(1)*((1)-1))
      + (-0.652431)*(4.3)*delta^(1)*tau^(4.3)*exp(-delta^(2))*((2)*delta^(2)*
      ((2)*(delta^(2)-1)-2*(1)+1)+(1)*((1)-1)) + (0.0553849)*(0.25)*delta^(4)*
      tau^(0.25)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)-1)-2*(4)+1)+
      (4)*((4)-1)) + (-0.071097)*(7)*delta^(4)*tau^(7)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)-1)-2*(4)+1)+(4)*((4)-1)) + (-0.000875332)*
      (4.7)*delta^(9)*tau^(4.7)*exp(-delta^(2))*((2)*delta^(2)*((2)*
      (delta^(2)-1)-2*(9)+1)+(9)*((9)-1)) + (0.020076)*(13)*delta^(2)*
      tau^(13)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)-1)-2*(2)+1)+(2)*
      ((2)-1)) + (-0.0139761)*(16)*delta^(2)*tau^(16)*exp(-delta^(3))*((3)*
      delta^(3)*((3)*(delta^(3)-1)-2*(2)+1)+(2)*((2)-1)) + (-0.018511)*(25)*
      delta^(4)*tau^(25)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)-1)-2*
      (4)+1)+(4)*((4)-1)) + (0.0171939)*(17)*delta^(5)*tau^(17)*
      exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)-1)-2*(5)+1)+(5)*((5)-1)) +
      (-0.00482049)*(7.4)*delta^(6)*tau^(7.4)*exp(-delta^(3))*((3)*
      delta^(3)*((3)*(delta^(3)-1)-2*(6)+1)+(6)*((6)-1));
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  algorithm
    ttd_fRes_ttd := (0.987252)*(1)*(0.44)*(0.44-1)*
      delta^(1)*tau^(0.44) + (-1.03017)*(1)*(1.2)*(1.2-1)*delta^(1)*
      tau^(1.2) + (1.17666)*(1)*(2.97)*(2.97-1)*delta^(1)*tau^(2.97) +
      (-0.138991)*(2)*(2.95)*(2.95-1)*delta^(2)*tau^(2.95) + (0.00302373)*
      (5)*(0.2)*(0.2-1)*delta^(5)*tau^(0.2) + (-2.53639)*(1.93)*((1.93)-1)*
      delta^(1)*tau^(1.93)*exp(-delta^(1))*((1)-(1)*delta^(1)) + (-1.9668)*
      (1.78)*((1.78)-1)*delta^(2)*tau^(1.78)*exp(-delta^(1))*((2)-(1)*
      delta^(1)) + (-0.83048)*(3)*((3)-1)*delta^(3)*tau^(3)*exp(-delta^(1))*
      ((3)-(1)*delta^(1)) + (0.172477)*(0.2)*((0.2)-1)*delta^(5)*tau^(0.2)*
      exp(-delta^(1))*((5)-(1)*delta^(1)) + (-0.261116)*(0.74)*((0.74)-1)*
      delta^(5)*tau^(0.74)*exp(-delta^(1))*((5)-(1)*delta^(1)) +
      (-0.0745473)*(3)*((3)-1)*delta^(5)*tau^(3)*exp(-delta^(1))*((5)-(1)*
      delta^(1)) + (0.679757)*(2.1)*((2.1)-1)*delta^(1)*tau^(2.1)*
      exp(-delta^(2))*((1)-(2)*delta^(2)) + (-0.652431)*(4.3)*((4.3)-1)*
      delta^(1)*tau^(4.3)*exp(-delta^(2))*((1)-(2)*delta^(2)) + (0.0553849)*
      (0.25)*((0.25)-1)*delta^(4)*tau^(0.25)*exp(-delta^(2))*((4)-(2)*
      delta^(2)) + (-0.071097)*(7)*((7)-1)*delta^(4)*tau^(7)*
      exp(-delta^(2))*((4)-(2)*delta^(2)) + (-0.000875332)*(4.7)*((4.7)-1)*
      delta^(9)*tau^(4.7)*exp(-delta^(2))*((9)-(2)*delta^(2)) + (0.020076)*
      (13)*((13)-1)*delta^(2)*tau^(13)*exp(-delta^(3))*((2)-(3)*delta^(3)) +
      (-0.0139761)*(16)*((16)-1)*delta^(2)*tau^(16)*exp(-delta^(3))*
      ((2)-(3)*delta^(3)) + (-0.018511)*(25)*((25)-1)*delta^(4)*tau^(25)*
      exp(-delta^(3))*((4)-(3)*delta^(3)) + (0.0171939)*(17)*((17)-1)*
      delta^(5)*tau^(17)*exp(-delta^(3))*((5)-(3)*delta^(3)) +
      (-0.00482049)*(7.4)*((7.4)-1)*delta^(6)*tau^(7.4)*exp(-delta^(3))*
      ((6)-(3)*delta^(3));
  end ttd_fRes_ttd;
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
      p := 1.0014 * fluidConstants[1].criticalPressure *
        exp((fluidConstants[1].criticalTemperature/T) * ((-5.42493213611446)*
        OM^(0.914568767900918) + (4.55984223535243)*OM^(0.84920213389611) +
        (-5.63920263436646)*OM^(0.914588351221298) + (-17.0179004677748)*
        OM^(5.60238999663603) + (16.6119518017247)*OM^(4.56148875806592) +
        (-9.23457354191128)*OM^(3.77677091719265)));
    end if;
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationPressure;

  redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (p - (1690546.68662399))/(1337345.61888569);
    T := (288.745128) + (32.1667276731741) * (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*((0.000212734358958718)*x +
      (-0.00274826770400574)) + (0.0139370674840602)) +
      (-0.0315500773133433)) + (0.0121512184212727)) +
      (0.0856249369531822)) + (-0.14074454381608)) +
      (-0.0367634254282132)) + (0.254757708465645)) +
      (-0.112689322533039)) + (-0.182876490328916)) +
      (0.134350167076272)) + (0.0860242126577126)) +
      (-0.100893270492692)) + (0.0309833589718576)) +
      (-0.0529002490944326)) + (0.127140300183199)) +
      (-0.277494430607753)) + (0.928326269698458)) +
      (0.315625855266007));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.Tsat - (288.8))/(32.1728405128715);
    dl := x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*((-6.99578865762325)*
      x + (-6.7604174117019)) + (200.407961520649)) + (188.571236226921)) +
      (-2652.94723562807)) + (-2425.45498526778)) + (21528.66639571)) +
      (19078.45309768)) + (-119801.207674824)) + (-102626.361637478)) +
      (484499.198159567)) + (399940.695532179)) + (-1472497.37440782)) +
      (-1167021.96071837)) + (3430188.48017565)) + (2599053.22102125)) +
      (-6191424.52123395)) + (-4462494.4315702)) + (8696236.64921065)) +
      (5926540.10974656)) + (-9493407.55362208)) + (-6073193.59372745)) +
      (8003916.94227124)) + (4763589.89778695)) + (-5150368.09268112)) +
      (-2819821.21050958)) + (2483733.27900105)) + (1232954.81219775)) +
      (-874144.249122246)) + (-385938.163587198)) + (216126.678937935)) +
      (82629.6546432032)) + (-35497.5732400153)) + (-11300.2847533843)) +
      (3553.26510924274)) + (883.68895963431)) + (-189.882928)) +
      (-39.47055814)) + (-18.62912585)) + (-146.230018)) + (1103.300057);
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.Tsat - (288.8))/(32.1728405128715);
    dv := (81.1402553535331) + (81.8525665515266) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*((6.58978478503912e-06)*x + (8.61462899584184e-06)) +
      (-6.20269693625927e-05)) + (-7.37407932198282e-05)) +
      (0.000190760055223262)) + (0.000178769740095248)) +
      (-0.000136388992345257)) + (4.36249648285315e-05)) +
      (-0.000238334815888865)) + (-0.000431298226628196)) +
      (3.80080621897099e-05)) + (-0.000561479744368981)) +
      (0.000423297560316714)) + (0.0011568545426888)) +
      (0.000495543657457393)) + (0.00214762507546025)) +
      (-5.92221614138573e-07)) + (-0.00196695410352135)) +
      (-0.000901075042193254)) + (-0.00283896802944253)) +
      (-0.00166768829541246)) + (-0.00088860171586863)) +
      (-0.00158538480741269)) + (0.00289539863035636)) +
      (0.00214921036271588)) + (0.00434299894514524)) +
      (0.0157317419040667)) + (0.0012382068787828)) +
      (-0.0125489243448401)) + (0.0112261211991694)) +
      (0.0370242887570731)) + (0.0865129026480271)) +
      (0.262992182086301)) + (0.594247698000419)) +
      (-0.38258005733403));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    hl := (-1300) + x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*((135.494256329739)*x + (-1944.58002467352)) +
      (10873.0680837202)) + (-25735.7403798769)) + (-2430.18903333571)) +
      (142145.874373996)) + (-225871.839384057)) + (-169961.413579647)) +
      (771955.520997377)) + (-282765.448706001)) + (-1164737.86099266)) +
      (1049080.17122333)) + (917249.096544049)) + (-1352382.65503727)) +
      (-343473.199502079)) + (952332.78180563)) + (11186.9638591466)) +
      (-394215.457107193)) + (36248.009362927)) + (92213.8523639965)) +
      (-8896.04419964822)) + (-14352.0238351)) + (6700.78180055371)) +
      (-10395.4314481771)) + (50536.1142524471)) + (242430.487439737);
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    hv := (417945.765501892) + (8545.487483279) * (x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*((-0.000218029221261958)*x +
      (0.0022323353175877)) + (-0.00799014541436163)) +
      (0.00833845606213506)) + (0.0144702747235008)) + (-0.0331179314189472)) +
      (0.000390283122980614)) + (0.0115258430193761)) + (0.0308964007853627)) +
      (0.0136472460889214)) + (-0.0360136736458006)) + (-0.0386765421186988)) +
      (-0.0605463077241532)) + (0.0502647244559176)) + (0.095321629007505)) +
      (0.0755533366303853)) + (0.063900536295213)) + (-0.298358086862518)) +
      (-0.10365771583044)) + (0.163409334532178)) + (0.17524027979117)) +
      (-0.215325369147047)) + (0.197032758310628)) + (-0.777842402746969)) +
      (0.173961838358794)) + (0.983520185682028));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    sl := (1089.97331866083) + (185.695651493037) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*((0.00033828165088767)*x +
      (-0.00370309827636681)) + (0.014209075443824)) + (-0.0145766678299393)) +
      (-0.0416403990009039)) + (0.101032460509914)) + (0.0336400125229364)) +
      (-0.233747525374593)) + (0.0199708486352523)) + (0.290832433096577)) +
      (-0.00660210880306234)) + (-0.197892691158687)) + (-0.12141201709424)) +
      (0.00592212772109565)) + (0.255290714023843)) + (0.0779323618368683)) +
      (-0.184232949517685)) + (-0.0976178186610381)) + (0.122020592620146)) +
      (-0.0471292444744683)) + (0.113902422370081)) + (-0.245671669378254)) +
      (0.888482458507174)) + (0.274891927776532));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
    "Dew curve specific entropy of propane (Ancillary equation)"
protected
    Real x;

  algorithm
    x := (sat.psat - (1690546.68662399))/(1337345.61888569);
    sv := ((1768.34582896195) + (79.2403170328169) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*((-0.000546560772734549)*x +
      (0.00581168717069958)) + (-0.0215691827119022)) + (0.0223518186558442)) +
      (0.0473507418719607)) + (-0.0983005227940781)) + (-0.0497700161113581)) +
      (0.0790325658994048)) + (0.256674014689244)) + (0.0817324388473164)) +
      (-0.899619588503897)) + (-0.161232661224616)) + (1.51293677931511)) +
      (0.15442682704994)) + (-1.47492388142783)) + (-0.122700813082128)) +
      (0.808894385214169)) + (0.136507017005217)) + (-0.308151297008007)) +
      (0.0270489376466083)) + (-0.0847856959955504)) + (0.132564781752192)) +
      (-0.773757700736367)) + (-0.150479610948503)))*1.002;
    annotation(smoothOrder = 2,
          Inline=false,
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
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
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
     x1 := (p-(3386089.75740898))/(1327435.5559674);
     y1 := (h-(221403.010195671))/(83334.0890066773);
     T := (0) + (1) * ((287.021664392518) + y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*
      (y1*((0.0864117831531705)*y1 + (0.171784244137346) +
      (-0.0754087777872457)*x1) + (-0.297748052935782) + x1*(
      (0.0174851132885221)*x1 + (-0.113732590174603))) + (-0.872911774900146) +
      x1*(x1*((0.0279225582194194)*x1 + (-0.0060899049206074)) +
      (0.348152824991852))) + (-0.370648789311289) + x1*(x1*(x1*(
      (-0.0201076646974901)*x1 + (0.0913740201046021)) +
      (-0.180427599342632)) + (0.793238216844397))) + (0.176294552751571) +
      x1*(x1*(x1*((-0.0586819391563395)*x1 + (0.0811142564076022)) +
      (-0.269409245572516)) + (0.328350703575568))) + (-0.431165279279122) +
      x1*(x1*(x1*((-0.0302212183613812)*x1 + (-0.00805504114050181)) +
      (-0.0997281511935187)) + (-0.070776597639706))) + (-2.04065167066883) +
      x1*(x1*(x1*((0.0433631502561081)*x1 + (-0.0236752632712486)) +
      (-0.015533863828046)) + (0.304572997097524))) + (-5.88862734169674) +
      x1*(x1*(x1*((0.0337585408958696)*x1 + (0.0123678914525845)) +
      (-0.0638071155038644)) + (0.669171917292208))) + (53.34763090261) + x1*
      (x1*(x1*((-0.00956248998345363)*x1 + (0.011937105968086)) +
      (-0.0457611197544299)) + (0.786295970183816))) + x1*(x1*(x1*(
      (-0.00847904392329953)*x1 + (0.0014409474800833)) +
      (-0.0139499454480583)) + (0.0784539758046494)));
    elseif h>h_dew+dh then
     x2 := (p-(1892065.91097279))/(1644413.85209216);
     y2 := (h-(499554.093389481))/(58727.7569010133);
     T := (0) + (1) * ((365.146842872405) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
      (y2*((0.00237194280566996)*y2 + (-0.00242661170883643) +
      (0.000840569788988142)*x2) + (0.00984123984001866) + x2*(
      (-0.0116499567302523)*x2 + (-0.00432837936077168))) +
      (-0.0471817882838252) + x2*(x2*((-0.0463425507102811)*x2 +
      (0.0531393188529756)) + (0.085377268026775))) + (0.0187475886663365) +
      x2*(x2*(x2*((-0.0489685316884883)*x2 + (0.13780304779475)) +
      (0.0230222331968282)) + (-0.171330421821666))) + (-0.0549304792713878) +
      x2*(x2*(x2*(x2*((-0.0189371252586533)*x2 + (0.121635292261662)) +
      (-0.0171832389900513)) + (-0.191987470592909)) +
      (-0.0929200275911617))) + (0.537922635233623) + x2*(x2*(x2*(x2*(
      (0.0383733903927351)*x2 + (-0.0405204964449092)) + (-0.13859503421283)) +
      (-0.0996812537150541)) + (0.351109821077926))) + (-1.49238889408244) +
      x2*(x2*(x2*(x2*((-0.0194802531401436)*x2 + (-0.00902698301946151)) +
      (-0.122945011915202)) + (0.634484271554577)) + (-0.703423308021757))) +
      (1.32987408992145) + x2*(x2*(x2*(x2*((0.0101680900894223)*x2 +
      (-0.0967477066845138)) + (0.337776046181807)) + (-0.94530847153653)) +
      (2.911142242608))) + (54.9826366363199) + x2*(x2*(x2*(x2*(
      (-0.0150312740494949)*x2 + (0.0923297717937169)) +
      (-0.214366060484023)) + (1.25182009270752)) + (-8.61552286082537))) +
      x2*(x2*(x2*(x2*((0.00395092103052318)*x2 + (-0.0207390776905432)) +
      (0.0770766169578993)) + (-1.18709182937648)) + (17.2483894918718)));
    else
     if h<h_bubble then
      x1 := (p-(3386089.75740898))/(1327435.5559674);
      y1 := (h-(221403.010195671))/(83334.0890066773);
      T1 := (0) + (1) * ((287.021664392518) + y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*
       (y1*((0.0864117831531705)*y1 + (0.171784244137346) +
       (-0.0754087777872457)*x1) + (-0.297748052935782) + x1*(
       (0.0174851132885221)*x1 + (-0.113732590174603))) + (-0.872911774900146) +
       x1*(x1*((0.0279225582194194)*x1 + (-0.0060899049206074)) +
       (0.348152824991852))) + (-0.370648789311289) + x1*(x1*(x1*(
       (-0.0201076646974901)*x1 + (0.0913740201046021)) +
       (-0.180427599342632)) + (0.793238216844397))) + (0.176294552751571) +
       x1*(x1*(x1*((-0.0586819391563395)*x1 + (0.0811142564076022)) +
       (-0.269409245572516)) + (0.328350703575568))) + (-0.431165279279122) +
       x1*(x1*(x1*((-0.0302212183613812)*x1 + (-0.00805504114050181)) +
       (-0.0997281511935187)) + (-0.070776597639706))) + (-2.04065167066883) +
       x1*(x1*(x1*((0.0433631502561081)*x1 + (-0.0236752632712486)) +
       (-0.015533863828046)) + (0.304572997097524))) + (-5.88862734169674) +
       x1*(x1*(x1*((0.0337585408958696)*x1 + (0.0123678914525845)) +
       (-0.0638071155038644)) + (0.669171917292208))) + (53.34763090261) + x1*
       (x1*(x1*((-0.00956248998345363)*x1 + (0.011937105968086)) +
       (-0.0457611197544299)) + (0.786295970183816))) + x1*(x1*(x1*(
       (-0.00847904392329953)*x1 + (0.0014409474800833)) +
       (-0.0139499454480583)) + (0.0784539758046494)));
     T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
       T1*(h_bubble - h)/dh;
     elseif h>h_dew then
      x2 := (p-(1892065.91097279))/(1644413.85209216);
      y2 := (h-(499554.093389481))/(58727.7569010133);
      T2 := (0) + (1) * ((365.146842872405) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
       (y2*((0.00237194280566996)*y2 + (-0.00242661170883643) +
       (0.000840569788988142)*x2) + (0.00984123984001866) + x2*(
       (-0.0116499567302523)*x2 + (-0.00432837936077168))) +
       (-0.0471817882838252) + x2*(x2*((-0.0463425507102811)*x2 +
       (0.0531393188529756)) + (0.085377268026775))) + (0.0187475886663365) +
       x2*(x2*(x2*((-0.0489685316884883)*x2 + (0.13780304779475)) +
       (0.0230222331968282)) + (-0.171330421821666))) + (-0.0549304792713878) +
       x2*(x2*(x2*(x2*((-0.0189371252586533)*x2 + (0.121635292261662)) +
       (-0.0171832389900513)) + (-0.191987470592909)) +
       (-0.0929200275911617))) + (0.537922635233623) + x2*(x2*(x2*(x2*(
       (0.0383733903927351)*x2 + (-0.0405204964449092)) + (-0.13859503421283)) +
       (-0.0996812537150541)) + (0.351109821077926))) + (-1.49238889408244) +
       x2*(x2*(x2*(x2*((-0.0194802531401436)*x2 + (-0.00902698301946151)) +
       (-0.122945011915202)) + (0.634484271554577)) + (-0.703423308021757))) +
       (1.32987408992145) + x2*(x2*(x2*(x2*((0.0101680900894223)*x2 +
       (-0.0967477066845138)) + (0.337776046181807)) + (-0.94530847153653)) +
       (2.911142242608))) + (54.9826366363199) + x2*(x2*(x2*(x2*(
       (-0.0150312740494949)*x2 + (0.0923297717937169)) +
       (-0.214366060484023)) + (1.25182009270752)) + (-8.61552286082537))) +
       x2*(x2*(x2*(x2*((0.00395092103052318)*x2 + (-0.0207390776905432)) +
       (0.0770766169578993)) + (-1.18709182937648)) + (17.2483894918718)));
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
     x1 := (log(p)-(14.8682464548966))/(0.572967793317542);
     y1 := (s-(1062.25690261649))/(214.725037980704);
     T := (0) + (1) * ((285.694699667815) + y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*
      (y1*((0.0176359573966827)*y1 + (0.0316726651980843) +
      (-0.0164121223780564)*x1) + (-0.115330088394623) + x1*
      ((0.00964207302480855)*x1 + (-0.021049391159093))) +
      (-0.287988292846959) + x1*(x1*((0.000448400580450467)*x1 +
      (0.00446666151932734)) + (0.160836146227042))) + (-0.0674005888547959) +
      x1*(x1*(x1*((-0.00184914832370402)*x1 + (0.0237831303795189)) +
      (-0.136779662319749)) + (0.407078466782749))) + (0.103684161622761) +
      x1*(x1*(x1*((-0.0155224543284392)*x1 + (0.113054265723455)) +
      (-0.331019995172275)) + (0.232664909912497))) + (-0.37547776638412) +
      x1*(x1*(x1*((-0.0489805912413537)*x1 + (0.202926583202097)) +
      (-0.226383454966623)) + (-0.0570300608606503))) + (-1.35891209361109) +
      x1*(x1*(x1*((-0.0744032871840306)*x1 + (0.156042986921594)) +
      (0.0619867405719159)) + (0.118289457566212))) + (-0.538203800364751) +
      x1*(x1*(x1*((-0.0560518828539283)*x1 + (0.0432588380531332)) +
      (0.159824750585592)) + (0.444334054359482))) + (39.25784184622) +
      x1*(x1*(x1*((-0.0169796856907351)*x1 + (0.0174579733698449)) +
      (0.181304075574015)) + (0.712211978720827))) + x1*(x1*(x1*(
      (0.00203028958902996)*x1 + (0.043941556562575)) + (0.275193128445195)) +
      (1.02968381585158)));
    elseif s>s_dew+ds then
     x2 := (log(p)-(13.9633083007351))/(1.0544928909531);
     y2 := (s-(2038.24821446123))/(182.368581972174);
     T := (0) + (1) * ((362.780429406726) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
      ((0.00143691811058645)*y2 + (-0.0067888044083486) +
      (0.00913195481359379)*x2) + (0.00966378023797837) + x2*(
      (0.0171350539134858)*x2 + (-0.0430345823130263))) +
      (-0.0027549017535748) + x2*(x2*((0.013260520352129)*x2 +
      (-0.0860624242518243)) + (0.0412715307520025))) + (-0.0126978939045207) +
      x2*(x2*(x2*((0.00263775754316385)*x2 + (-0.0833330343192107)) +
      (0.0829846036839661)) + (0.050353274463767))) + (-0.0369077715111301) +
      x2*(x2*(x2*(x2*((0.000580068228029518)*x2 + (-0.0339664301243253)) +
      (0.0999632250360851)) + (0.0967647474299231)) + (-0.0960583200277675))) +
      (0.261713154987473) + x2*(x2*(x2*(x2*((-0.0126569601251682)*x2 +
      (0.0556366141911953)) + (0.08683709431814)) + (-0.159492293757689)) +
      (-0.112248284624909))) + (-0.959764190149959) + x2*(x2*(x2*(x2*(
      (0.0311254594242568)*x2 + (0.0249648964493416)) + (-0.19857043646911)) +
      (-0.214744852220885)) + (0.0830757358076766))) + (5.48129300138706) + x2*
      (x2*(x2*(x2*((-0.0160699196008859)*x2 + (-0.0905900761832388)) +
      (-0.0794219527244774)) + (0.355311305918674)) + (0.507873375509499))) +
      (66.4905228835631) + x2*(x2*(x2*(x2*((-0.0109582919094829)*x2 +
      (-0.0347404280037205)) + (-0.0804760434416528)) + (-0.905686167783714)) +
      (1.3654391575539))) + x2*(x2*(x2*(x2*((-0.00286577362938595)*x2 +
      (0.0522653189730272)) + (0.443209929215919)) + (3.39955470785848)) +
      (53.6928909515271)));
    else
     if s<s_bubble then
      x1 := (log(p)-(14.8682464548966))/(0.572967793317542);
      y1 := (s-(1062.25690261649))/(214.725037980704);
      T1 := (0) + (1) * ((285.694699667815) + y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*
       (y1*((0.0176359573966827)*y1 + (0.0316726651980843) +
       (-0.0164121223780564)*x1) + (-0.115330088394623) + x1*
       ((0.00964207302480855)*x1 + (-0.021049391159093))) +
       (-0.287988292846959) + x1*(x1*((0.000448400580450467)*x1 +
       (0.00446666151932734)) + (0.160836146227042))) + (-0.0674005888547959) +
       x1*(x1*(x1*((-0.00184914832370402)*x1 + (0.0237831303795189)) +
       (-0.136779662319749)) + (0.407078466782749))) + (0.103684161622761) +
       x1*(x1*(x1*((-0.0155224543284392)*x1 + (0.113054265723455)) +
       (-0.331019995172275)) + (0.232664909912497))) + (-0.37547776638412) +
       x1*(x1*(x1*((-0.0489805912413537)*x1 + (0.202926583202097)) +
       (-0.226383454966623)) + (-0.0570300608606503))) + (-1.35891209361109) +
       x1*(x1*(x1*((-0.0744032871840306)*x1 + (0.156042986921594)) +
       (0.0619867405719159)) + (0.118289457566212))) + (-0.538203800364751) +
       x1*(x1*(x1*((-0.0560518828539283)*x1 + (0.0432588380531332)) +
       (0.159824750585592)) + (0.444334054359482))) + (39.25784184622) +
       x1*(x1*(x1*((-0.0169796856907351)*x1 + (0.0174579733698449)) +
       (0.181304075574015)) + (0.712211978720827))) + x1*(x1*(x1*(
       (0.00203028958902996)*x1 + (0.043941556562575)) + (0.275193128445195)) +
       (1.02968381585158)));
      T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
        T1*(s_bubble - s)/ds;
     elseif s>s_dew then
      x2 := (log(p)-(13.9633083007351))/(1.0544928909531);
      y2 := (s-(2038.24821446123))/(182.368581972174);
      T2 := (0) + (1)*((362.780429406726) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
       ((0.00143691811058645)*y2 + (-0.0067888044083486) +
       (0.00913195481359379)*x2) + (0.00966378023797837) + x2*(
       (0.0171350539134858)*x2 + (-0.0430345823130263))) +
       (-0.0027549017535748) + x2*(x2*((0.013260520352129)*x2 +
       (-0.0860624242518243)) + (0.0412715307520025))) + (-0.0126978939045207) +
       x2*(x2*(x2*((0.00263775754316385)*x2 + (-0.0833330343192107)) +
       (0.0829846036839661)) + (0.050353274463767))) + (-0.0369077715111301) +
       x2*(x2*(x2*(x2*((0.000580068228029518)*x2 + (-0.0339664301243253)) +
       (0.0999632250360851)) + (0.0967647474299231)) + (-0.0960583200277675))) +
       (0.261713154987473) + x2*(x2*(x2*(x2*((-0.0126569601251682)*x2 +
       (0.0556366141911953)) + (0.08683709431814)) + (-0.159492293757689)) +
       (-0.112248284624909))) + (-0.959764190149959) + x2*(x2*(x2*(x2*(
       (0.0311254594242568)*x2 + (0.0249648964493416)) + (-0.19857043646911)) +
       (-0.214744852220885)) + (0.0830757358076766))) + (5.48129300138706) + x2*
       (x2*(x2*(x2*((-0.0160699196008859)*x2 + (-0.0905900761832388)) +
       (-0.0794219527244774)) + (0.355311305918674)) + (0.507873375509499))) +
       (66.4905228835631) + x2*(x2*(x2*(x2*((-0.0109582919094829)*x2 +
       (-0.0347404280037205)) + (-0.0804760434416528)) + (-0.905686167783714)) +
       (1.3654391575539))) + x2*(x2*(x2*(x2*((-0.00286577362938595)*x2 +
       (0.0522653189730272)) + (0.443209929215919)) + (3.39955470785848)) +
       (53.6928909515271)));
      T := saturationTemperature(p)*(1 - (s - s_dew)/ds) + T2*(s - s_dew)/ ds;
     else
      T := saturationTemperature(p);
     end if;
    end if;
    annotation(derivative(noDerivative=phase)=temperature_ps_der,
          Inline=false,
          LateInline=true);
  end temperature_ps;

  redeclare replaceable function density_pT
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
     x1 := (p-(2557114.88519498))/(1413182.14146982);
     y1 := (T-(368.962789646881))/(49.6511585937515);
     d := (0) + (1) * ((72.4673451196848) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*
      (x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.0241532472331232)*x1 +
      (0.0344891241850553) + (0.0180148100259595)*y1) + (-0.23272984842566) +
      y1*((-0.0231125330926145)*y1 + (0.0671983465772878))) +
      (-0.329764047290808) + y1*(y1*((-0.040051833346326)*y1 +
      (0.0313955248670506)) + (-0.0894987039385263))) + (0.853546056385162) +
      y1*(y1*(y1*((0.0595656346612924)*y1 + (-0.275970127268419)) +
      (0.481814040999413)) + (-0.532041879544919))) + (1.20018741172135) +
      y1*(y1*(y1*(y1*((-0.0701269844815475)*y1 + (0.398690880981839)) +
      (-0.417480184022921)) + (0.15313898975363)) + (0.0982162914145338))) +
      (-1.44678640775593) + y1*(y1*(y1*(y1*(y1*((0.0317598014122311)*y1 +
      (-0.358268894813906)) + (0.646867664174733)) + (0.927414069768541)) +
      (-2.61992220201529)) + (1.80583502511502))) + (-1.99711947941136) +
      y1*(y1*(y1*(y1*(y1*((0.118852155856873)*y1 + (-0.367575376717921)) +
      (-0.831729960654545)) + (2.70476046968443)) + (-2.10284280349872)) +
      (0.255369672573349))) + (1.06577883644539) + y1*(y1*(y1*(y1*(y1*(
      (0.0136992544264435)*y1 + (0.867895545592989)) + (-2.67778456580955)) +
      (-0.830116315750902)) + (6.17083877403159)) + (-3.42174233434026))) +
      (1.28068452524156) + y1*(y1*(y1*(y1*(y1*((-0.324542370497003)*y1 +
      (1.37039039275325)) + (1.0530366207728)) + (-7.93528126528024)) +
      (7.6160126741786)) + (-0.96520996414829))) + (-0.360885881436796) + y1*
      (y1*(y1*(y1*(y1*((0.117380045025554)*y1 + (-2.55855423377597)) +
      (8.75770767644535)) + (-6.62046825385111)) + (-4.18020614281834)) +
      (3.87963397609216))) + (0.0932321559076097) + y1*(y1*(y1*(y1*(y1*(
      (1.47071603482735)*y1 + (-7.85980012364802)) + (11.3113517826107)) +
      (0.432267641929898)) + (-8.5130194254542)) + (1.78744711380603))) +
      (0.567726549561638) + y1*(y1*(y1*(y1*(y1*((1.93615111192894)*y1 +
      (-8.49155787450058)) + (10.2988208629762)) + (-1.997473493718)) +
      (-0.0949843941880612)) + (-1.91705372885997))) + (1.04050224938105) +
      y1*(y1*(y1*(y1*(y1*((1.41546506608579)*y1 + (-6.89614017369394)) +
      (12.2400759177558)) + (-10.5322720390077)) + (5.70360979762331)) +
      (-2.50033746594717))) + (6.23191503754805) + y1*(y1*(y1*(y1*(y1*(
      (1.30538371420034)*y1 + (-6.96053351490482)) + (13.6930855976963)) +
      (-12.3736046239659)) + (7.03151752112028)) + (-6.78589792338576))) +
      (48.747095068058) + y1*(y1*(y1*(y1*(y1*((1.17509668533631)*y1 +
      (-5.73211692947672)) + (9.72582231178454)) + (-7.9576902925063)) +
      (8.58256357158168)) + (-18.3917285008394))) + y1*(y1*(y1*(y1*(y1*(
      (0.476112131319811)*y1 + (-2.13520897173966)) + (3.19530678611049)) +
      (-2.78595570494937)) + (5.82503909222006)) + (-17.9789227494755)));
    elseif p>sat.psat+dp then
     x2 := (p-(3230978.96987517))/(1215430.51013093);
     y2 := (T-(286.37703960126))/(30.2813023973015);
     d := (0) + (1) * ((1128.29342170365) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
      (y2*((-1.72623019772007)*y2 + (-3.14754559007914) + (1.34539694151813)*
      x2) + (7.18763169338531) + x2*((-0.477663643528785)*x2 +
      (3.89985990853728))) + (11.9194637097639) + x2*(x2*(
      (0.0535260150930145)*x2 + (-1.58757914444201)) + (-1.01963032819307))) +
      (-13.42480950003) + x2*(x2*(x2*((-0.0128186939933804)*x2 +
      (0.238676850832625)) + (-0.688688832277525)) + (-9.82580093531666))) +
      (-18.6737509725287) + x2*(x2*(x2*((-0.00246289257004601)*x2 +
      (0.340643562102322)) + (1.9888439943296)) + (-1.63106702729664))) +
      (7.41012261893865) + x2*(x2*(x2*((0.0558666269760638)*x2 +
      (0.0543199338072468)) + (1.02660482095755)) + (10.360113896152))) +
      (2.65009519098121) + x2*(x2*(x2*((0.00360942200618328)*x2 +
      (-0.221168110890005)) + (-1.40297227072936)) + (5.26843887978288))) +
      (-23.0011865132665) + x2*(x2*(x2*((-0.0835073418715788)*x2 +
      (-0.0481483280978479)) + (-0.930022610155721)) + (0.881530520864514))) +
      (-133.244855967764) + x2*(x2*(x2*((-0.0311912243742686)*x2 +
      (0.10599088619427)) + (-0.284394146008372)) + (4.79216519948661))) +
      x2*(x2*(x2*((0.00468405676173685)*x2 + (0.0359536256629997)) +
      (-0.257941704085539)) + (7.87960605987028)));
    else
     if p<sat.psat then
      x1 := (p-(2557114.88519498))/(1413182.14146982);
      y1 := (T-(368.962789646881))/(49.6511585937515);
      d1 := (0) + (1) * ((72.4673451196848) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*
       (x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.0241532472331232)*x1 +
       (0.0344891241850553) + (0.0180148100259595)*y1) + (-0.23272984842566) +
       y1*((-0.0231125330926145)*y1 + (0.0671983465772878))) +
       (-0.329764047290808) + y1*(y1*((-0.040051833346326)*y1 +
       (0.0313955248670506)) + (-0.0894987039385263))) + (0.853546056385162) +
       y1*(y1*(y1*((0.0595656346612924)*y1 + (-0.275970127268419)) +
       (0.481814040999413)) + (-0.532041879544919))) + (1.20018741172135) +
       y1*(y1*(y1*(y1*((-0.0701269844815475)*y1 + (0.398690880981839)) +
       (-0.417480184022921)) + (0.15313898975363)) + (0.0982162914145338))) +
       (-1.44678640775593) + y1*(y1*(y1*(y1*(y1*((0.0317598014122311)*y1 +
       (-0.358268894813906)) + (0.646867664174733)) + (0.927414069768541)) +
       (-2.61992220201529)) + (1.80583502511502))) + (-1.99711947941136) +
       y1*(y1*(y1*(y1*(y1*((0.118852155856873)*y1 + (-0.367575376717921)) +
       (-0.831729960654545)) + (2.70476046968443)) + (-2.10284280349872)) +
       (0.255369672573349))) + (1.06577883644539) + y1*(y1*(y1*(y1*(y1*(
       (0.0136992544264435)*y1 + (0.867895545592989)) + (-2.67778456580955)) +
       (-0.830116315750902)) + (6.17083877403159)) + (-3.42174233434026))) +
       (1.28068452524156) + y1*(y1*(y1*(y1*(y1*((-0.324542370497003)*y1 +
       (1.37039039275325)) + (1.0530366207728)) + (-7.93528126528024)) +
       (7.6160126741786)) + (-0.96520996414829))) + (-0.360885881436796) + y1*
       (y1*(y1*(y1*(y1*((0.117380045025554)*y1 + (-2.55855423377597)) +
       (8.75770767644535)) + (-6.62046825385111)) + (-4.18020614281834)) +
       (3.87963397609216))) + (0.0932321559076097) + y1*(y1*(y1*(y1*(y1*(
       (1.47071603482735)*y1 + (-7.85980012364802)) + (11.3113517826107)) +
       (0.432267641929898)) + (-8.5130194254542)) + (1.78744711380603))) +
       (0.567726549561638) + y1*(y1*(y1*(y1*(y1*((1.93615111192894)*y1 +
       (-8.49155787450058)) + (10.2988208629762)) + (-1.997473493718)) +
       (-0.0949843941880612)) + (-1.91705372885997))) + (1.04050224938105) +
       y1*(y1*(y1*(y1*(y1*((1.41546506608579)*y1 + (-6.89614017369394)) +
       (12.2400759177558)) + (-10.5322720390077)) + (5.70360979762331)) +
       (-2.50033746594717))) + (6.23191503754805) + y1*(y1*(y1*(y1*(y1*(
       (1.30538371420034)*y1 + (-6.96053351490482)) + (13.6930855976963)) +
       (-12.3736046239659)) + (7.03151752112028)) + (-6.78589792338576))) +
       (48.747095068058) + y1*(y1*(y1*(y1*(y1*((1.17509668533631)*y1 +
       (-5.73211692947672)) + (9.72582231178454)) + (-7.9576902925063)) +
       (8.58256357158168)) + (-18.3917285008394))) + y1*(y1*(y1*(y1*(y1*(
       (0.476112131319811)*y1 + (-2.13520897173966)) + (3.19530678611049)) +
       (-2.78595570494937)) + (5.82503909222006)) + (-17.9789227494755)));
      d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
     elseif p>=sat.psat then
      x2 := (p-(3230978.96987517))/(1215430.51013093);
      y2 := (T-(286.37703960126))/(30.2813023973015);
      d2 := (0) + (1) * ((1128.29342170365) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*
       (y2*((-1.72623019772007)*y2 + (-3.14754559007914) + (1.34539694151813)*
       x2) + (7.18763169338531) + x2*((-0.477663643528785)*x2 +
       (3.89985990853728))) + (11.9194637097639) + x2*(x2*(
       (0.0535260150930145)*x2 + (-1.58757914444201)) + (-1.01963032819307))) +
       (-13.42480950003) + x2*(x2*(x2*((-0.0128186939933804)*x2 +
       (0.238676850832625)) + (-0.688688832277525)) + (-9.82580093531666))) +
       (-18.6737509725287) + x2*(x2*(x2*((-0.00246289257004601)*x2 +
       (0.340643562102322)) + (1.9888439943296)) + (-1.63106702729664))) +
       (7.41012261893865) + x2*(x2*(x2*((0.0558666269760638)*x2 +
       (0.0543199338072468)) + (1.02660482095755)) + (10.360113896152))) +
       (2.65009519098121) + x2*(x2*(x2*((0.00360942200618328)*x2 +
       (-0.221168110890005)) + (-1.40297227072936)) + (5.26843887978288))) +
       (-23.0011865132665) + x2*(x2*(x2*((-0.0835073418715788)*x2 +
       (-0.0481483280978479)) + (-0.930022610155721)) + (0.881530520864514))) +
       (-133.244855967764) + x2*(x2*(x2*((-0.0311912243742686)*x2 +
       (0.10599088619427)) + (-0.284394146008372)) + (4.79216519948661))) +
       x2*(x2*(x2*((0.00468405676173685)*x2 + (0.0359536256629997)) +
       (-0.257941704085539)) + (7.87960605987028)));
      d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
     end if;
    end if;
   annotation(derivative(noDerivative=phase)=density_pT_der,
          inverse(p=pressure_dT(d=d,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end density_pT;
  /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal conductivity. Also add references.
  */
  redeclare function extends dynamicViscosity
    "Calculates dynamic viscosity of refrigerant"

  /*The functional form of the dynamic viscosity is implented as presented in
    Geller et al. (2000), Viscosity of Mixed Refrigerants, R404A, R407C, R410A,
    and R507C. Eighth International Refrigeration Conference.
    Afterwards, the coefficients are adapted to the results obtained by the
    ExternalMedia libaray (i.e. CoolProp)
  */

protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real etaHd "Dynamic viscosity for the limit of high density";
    Real etaHdL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaHdG "Dynamic viscosity for the limit of high density at dew line";
    Real etaL "Dynamic viscosity at dew line";
    Real etaG "Dynamic viscosity at bubble line";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;

    if (state.phase == 1 or phase_dT == 1) then
      // Calculate the dynamic visocity near the limit of zero density
      etaZd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

      // Calculate the dynamic viscosity for limits of higher densities
      etaHd := 9.047e-3 + 5.784e-5*state.d^2 + 1.309e-7*state.d^3 -
        2.422e-10*state.d^4 + 9.424e-14*state.d^5 + 3.933e-17*state.d^6;

      // Calculate the final dynamic visocity
      eta := (1.003684953*etaZd + 1.055260736*etaHd)*1e-6;
    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      etaZd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

      // Calculate the dynamic viscosity for limits of higher densities
      etaHdL := 9.047e-3 + 5.784e-5*bubbleState.d^2 + 1.309e-7*bubbleState.d^3 -
        2.422e-10*bubbleState.d^4 + 9.424e-14*bubbleState.d^5 +
        3.933e-17*bubbleState.d^6;
      etaHdG := 9.047e-3 + 5.784e-5*dewState.d^2 + 1.309e-7*dewState.d^3 -
        2.422e-10*dewState.d^4 + 9.424e-14*dewState.d^5 +
        3.933e-17*dewState.d^6;

      // Calculate the dynamic visocity at bubble and dew line
      etaL := (1.003684953*etaZd + 1.055260736*etaHdL)*1e-6;
      etaG := (1.003684953*etaZd + 1.055260736*etaHdG)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
    end if;

  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
    Geller et al. (2001), Thermal Conductivity of the Refrigerant Mixtures
    R404A, R407C, R410A, and R507A. International Journal of Thermophysics,
    Vol. 22, No. 4. Afterwards, the coefficients are adapted to the results
    obtained by the ExternalMedia libaray (i.e. CoolProp)
  */
protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real lambdaIdg "Thermal conductivity for the limit of zero density";
    Real lambdaRes "Thermal conductivity for residual part";
    Real lambdaResL "Thermal conductivity for residual part at bubble line";
    Real lambdaResG "Thermal conductivity for residual part at dew line";
    Real lambdaL "Thermal conductivity at dew line";
    Real lambdaG "Thermal conductivity at bubble line";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;

    if (state.phase == 1 or phase_dT == 1) then
      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -8.872 + 7.41e-2*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaRes := 3.576e-2*state.d - 9.045e-6*state.d^2 + 4.343e-8*state.d^3
        - 3.705e-12*state.d^4;

      // Calculate the final thermal conductivity
      lambda := (lambdaIdg + 0.9994549202*lambdaRes)*1e-3;
    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -8.872 + 7.41e-2*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaResL := 3.576e-2*bubbleState.d - 9.045e-6*bubbleState.d^2 +
        4.343e-8*bubbleState.d^3 - 3.705e-12*bubbleState.d^4;
      lambdaResG := 3.576e-2*dewState.d - 9.045e-6*dewState.d^2 +
        4.343e-8*dewState.d^3 - 3.705e-12*dewState.d^4;

      // Calculate the thermal conductivity at bubble and dew line
      lambdaL := (lambdaIdg + 0.9994549202*lambdaResL)*1e-3;
      lambdaG := (lambdaIdg + 0.9994549202*lambdaResG)*1e-3;

      // Calculate the final thermal conductivity
      lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);
    end if;

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
    sigma := (67.468*(1-tau)^1.26 * (1 - 0.051*(1-tau)^0.5 -
      0.193*(1-tau)))*1e-3;
  end surfaceTension;

  annotation (Documentation(revisions="<html><ul>
  <li>September 06, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides a refrigerant model for R410a using a hybrid
  approach developed by Sangi et al.. The hybrid approach is
  implemented in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a>
  and the refrigerant model is implemented by complete the template
  <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  . The fitting coefficients required in the template are saved in the
  package <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.R410a\">AixLib.DataBase.Media.Refrigerants.R410a</a>
  .
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The implemented coefficients are fitted to external data by
  Engelpracht and are valid within the following range:<br/>
</p>
<table summary=\"Range of validiry\" cellspacing=\"0\" cellpadding=\"2\"
border=\"1\" width=\"30%\" style=\"border-collapse:collapse;\">
  <tr>
    <td>
      <p>
        Parameter
      </p>
    </td>
    <td>
      <p>
        Minimum Value
      </p>
    </td>
    <td>
      <p>
        Maximum Value
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Pressure (p) in bar
      </p>
    </td>
    <td>
      <p>
        1
      </p>
    </td>
    <td>
      <p>
        48
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Temperature (T) in K
      </p>
    </td>
    <td>
      <p>
        233.15
      </p>
    </td>
    <td>
      <p>
        473.15
      </p>
    </td>
  </tr>
</table>
<p>
  The reference point is defined as 200 kJ/kg and 1 kJ/kg/K,
  respectively, for enthalpy and entropy for the saturated liquid at
  273.15 K.
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  R410a is calculated as pseudo-pure fluid and, hence, only roughly
  valid within the two-phase region.
</p>
<h4>
  Validation
</h4>
<p>
  The model is validated by comparing results obtained from the example
  model <a href=
  \"modelica://AixLib.Media.Refrigerants.Examples.RefrigerantProperties\">
  AixLib.Media.Refrigerants.Examples.RefrigerantProperties</a> to
  external data (e.g. obtained from measurements or external media
  libraries).
</p>
<h4>
  References
</h4>
<p>
  Lemmon, E. W. (2003): Pseudo-Pure Fluid Equations of State for the
  Refrigerant Blends R-410A, R-404A, R-507A, and R-407C. In:
  <i>International Journal of Thermophysics 24 (4)</i>, S. 991–1006.
  DOI: 10.1023/A:1025048800563.
</p>
<p>
  Geller, V. Z.; Bivens, D.; Yokozeki, A. (2000): Viscosity of Mixed
  Refrigerants, R404A, R407C, R410A, and R507C. In: <i>International
  refrigeration and air conditioning conference</i>. USA, S. 399–406.
  Online available at http://docs.lib.purdue.edu/iracc/508.
</p>
<p>
  Nabizadeh, H.; Mayinger, F. (1999): Viscosity of Gaseous R404A,
  R407C, R410A, and R507. In: <i>International Journal of Thermophysics
  20 (3)</i>, S. 777–790. DOI: 10.1007/978-1-4615-4777-8_1.
</p>
<p>
  Geller, V. Z.; Nemzer, B. V.; Cheremnykh, U. V. (2001): Thermal
  Conductivity of the Refrigerant Mixtures R404A, R407C, R410A, and
  R507A. In: <i>International Journal of Thermophysics 22 (4)</i>,
  1035–1043. DOI: 10.1023/A:1010691504352.
</p>
<p>
  Fröba, A. P.; Leipertz, A. (2003): Thermophysical Properties of the
  Refrigerant Mixtures R410A and R407C from Dynamic Light Scattering
  (DLS). In: <i>International Journal ofThermophysics 24 (5)</i>, S.
  1185–1206. DOI: 10.1023/A:1026152331710.
</p>
<p>
  Engelpracht, Mirko (2017): Development of modular and scalable
  simulation models for heat pumps and chillers considering various
  refrigerants. <i>Master Thesis</i>
</p>
</html>"));
end R410a_IIR_P1_48_T233_473_Horner;
