within AixLib.Media.Refrigerants.R290;
package R290_IIR_P05_30_T263_343_Horner
  "Refrigerant model for R290 using a hybrid approach with explicit Horner
  formulas developed by Sangi et al."

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
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
     each criticalMolarVolume = 1/(5e3),
     each normalBoilingPoint = 231.036,
     each triplePointTemperature = 85.525,
     each meltingPoint = 85.45,
     each acentricFactor = 0.153,
     each triplePointPressure = 0.00017,
     each dipoleMoment = 0.1,
     each hasCriticalData=true) "Thermodynamic constants for Propane";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="Propane",
    substanceNames={"Propane"},
    singleState=false,
    SpecificEnthalpy(
      start=2.057e5,
      nominal=2.057e5,
      min=177e3,
      max=576e3),
    Density(
      start=300,
      nominal=529,
      min=0.77,
      max=547),
    AbsolutePressure(
      start=4.7446e5,
      nominal=5e5,
      min=0.5e5,
      max=30e5),
    Temperature(
      start=273.15,
      nominal=333.15,
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
      Real d_ps(unit="J/(Pa.K.kg)") =  25/(30e5-0.5e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 50/(30e5-0.5e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  algorithm
    f_Idg := log(delta) + (3) * log(tau^(1)) + (-4.970583) * tau^(0) +
      (4.29352) * tau^(1) + (3.043) * log(1-exp(-(1.062478)*tau)) + (5.874) *
      log(1-exp(-(3.344237)*tau)) + (9.337) * log(1-exp(-(5.363757)*tau)) +
      (7.922) * log(1-exp(-(11.762957)*tau));
  end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    f_Res := (0.042910051) * delta^(4) * tau^(1) + (1.7313671) * delta^(1) *
      tau^(0.33) + (-2.4516524) * delta^(1) * tau^(0.8) + (0.34157466) *
      delta^(2) * tau^(0.43) + (-0.46047898) * delta^(2) * tau^(0.9) +
      (-0.66847295) * delta^(1) * tau^(2.46) * exp(-delta^(1)) + (0.20889705)
      * delta^(3) * tau^(2.09) * exp(-delta^(1)) + (0.19421381) * delta^(6) *
      tau^(0.88) * exp(-delta^(1)) + (-0.22917851) * delta^(6) * tau^(1.09) *
      exp(-delta^(1)) + (-0.60405866) * delta^(2) * tau^(3.25) *
      exp(-delta^(2)) + (0.066680654) * delta^(3) * tau^(4.62) *
      exp(-delta^(2)) + (0.017534618) * delta^(1) * tau^(0.76) *
      exp(-(0.963) * (delta - (1.283))^2 - (2.33) * (tau - (0.684))^2) +
      (0.33874242) * delta^(1) * tau^(2.5) * exp(-(1.977) * (delta -
      (0.6936))^2 - (3.47) * (tau - (0.829))^2) + (0.22228777) * delta^(1) *
      tau^(2.75) * exp(-(1.917) * (delta - (0.788))^2 - (3.15) * (tau -
      (1.419))^2) + (-0.23219062) * delta^(2) * tau^(3.05) * exp(-(2.307) *
      (delta - (0.473))^2 - (3.19) * (tau - (0.817))^2) + (-0.09220694) *
      delta^(2) * tau^(2.55) * exp(-(2.546) * (delta - (0.8577))^2 - (0.92) *
      (tau - (1.5))^2) + (-0.47575718) * delta^(4) * tau^(8.4) * exp(-(3.28) *
      (delta - (0.271))^2 - (18.8) * (tau - (1.426))^2) + (-0.017486824) *
      delta^(1) * tau^(6.75) * exp(-(14.6) * (delta - (0.948))^2 - (547.8) *
      (tau - (1.093))^2);
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
  algorithm
    t_fIdg_t := (3)*(1) + (-4.970583)*(0)*tau^(0) + (4.29352)*(1)*
      tau^(1) + tau*(3.043)*(1.062478)/(exp((1.062478)*tau)-1) + tau*(5.874)*
      (3.344237)/(exp((3.344237)*tau)-1) + tau*(9.337)*(5.363757)/
      (exp((5.363757)*tau)-1) + tau*(7.922)*(11.762957)/(exp((11.762957)*
      tau)-1);
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
  algorithm
    tt_fIdg_tt := -(3)*(1) + (-4.970583)*(0)*((0)-1)*tau^(0) +
      (4.29352)*(1)*((1)-1)*tau^(1) -tau^2*(3.043)*(1.062478)^2*exp(
      (1.062478)*tau)/(exp((1.062478)*tau)-1)^2 -tau^2*(5.874)*(3.344237)^2*
      exp((3.344237)*tau)/(exp((3.344237)*tau)-1)^2 -tau^2*(9.337)*
      (5.363757)^2*exp((5.363757)*tau)/(exp((5.363757)*tau)-1)^2 -tau^2*
      (7.922)*(11.762957)^2*exp((11.762957)*tau)/(exp((11.762957)*tau)-1)^2;
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
  algorithm
    t_fRes_t := (0.042910051)*(1)*delta^(4)*tau^(1) + (1.7313671)*
      (0.33)*delta^(1)*tau^(0.33) + (-2.4516524)*(0.8)*delta^(1)*tau^(0.8) +
      (0.34157466)*(0.43)*delta^(2)*tau^(0.43) + (-0.46047898)*(0.9)*
      delta^(2)*tau^(0.9) + (-0.66847295)*(2.46)*delta^(1)*tau^(2.46)*
      exp(-delta^(1)) + (0.20889705)*(2.09)*delta^(3)*tau^(2.09)*
      exp(-delta^(1)) + (0.19421381)*(0.88)*delta^(6)*tau^(0.88)*
      exp(-delta^(1)) + (-0.22917851)*(1.09)*delta^(6)*tau^(1.09)*
      exp(-delta^(1)) + (-0.60405866)*(3.25)*delta^(2)*tau^(3.25)*
      exp(-delta^(2)) + (0.066680654)*(4.62)*delta^(3)*tau^(4.62)*
      exp(-delta^(2)) + (0.017534618)*delta^(1)*tau^(0.76)*exp(-(0.963)*
      (delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*((0.76) - 2*(2.33)*tau*
      (tau-(0.684))) + (0.33874242)*delta^(1)*tau^(2.5)*exp(-(1.977)*
      (delta-(0.6936))^2 - (3.47)*(tau-(0.829))^2)*((2.5) - 2*(3.47)*tau*
      (tau-(0.829))) + (0.22228777)*delta^(1)*tau^(2.75)*exp(-(1.917)*
      (delta-(0.788))^2 - (3.15)*(tau-(1.419))^2)*((2.75) - 2*(3.15)*tau*
      (tau-(1.419))) + (-0.23219062)*delta^(2)*tau^(3.05)*exp(-(2.307)*
      (delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*((3.05) - 2*(3.19)*tau*
      (tau-(0.817))) + (-0.09220694)*delta^(2)*tau^(2.55)*exp(-(2.546)*
      (delta-(0.8577))^2 - (0.92)*(tau-(1.5))^2)*((2.55) - 2*(0.92)*tau*
      (tau-(1.5))) + (-0.47575718)*delta^(4)*tau^(8.4)*exp(-(3.28)*
      (delta-(0.271))^2 - (18.8)*(tau-(1.426))^2)*((8.4) - 2*(18.8)*tau*
      (tau-(1.426))) + (-0.017486824)*delta^(1)*tau^(6.75)*exp(-(14.6)*
      (delta-(0.948))^2 - (547.8)*(tau-(1.093))^2)*((6.75) - 2*(547.8)*
      tau*(tau-(1.093)));
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
  algorithm
    tt_fRes_tt := (0.042910051)*(1)*((1)-1)*delta^(4)*tau^(1) +
      (1.7313671)*(0.33)*((0.33)-1)*delta^(1)*tau^(0.33) + (-2.4516524)*
      (0.8)*((0.8)-1)*delta^(1)*tau^(0.8) + (0.34157466)*(0.43)*((0.43)-1)*
      delta^(2)*tau^(0.43) + (-0.46047898)*(0.9)*((0.9)-1)*delta^(2)*
      tau^(0.9) + (-0.66847295)*(2.46)*((2.46)-1)*delta^(1)*tau^(2.46)*
      exp(-delta^(1)) + (0.20889705)*(2.09)*((2.09)-1)*delta^(3)*tau^(2.09)*
      exp(-delta^(1)) + (0.19421381)*(0.88)*((0.88)-1)*delta^(6)*tau^(0.88)*
      exp(-delta^(1)) + (-0.22917851)*(1.09)*((1.09)-1)*delta^(6)*tau^(1.09)*
      exp(-delta^(1)) + (-0.60405866)*(3.25)*((3.25)-1)*delta^(2)*tau^(3.25)*
      exp(-delta^(2)) + (0.066680654)*(4.62)*((4.62)-1)*delta^(3)*tau^(4.62)*
      exp(-delta^(2)) + (0.017534618)*delta^(1)*tau^(0.76)*exp(-(0.963)*
      (delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*(((0.76) - 2*(2.33)*tau*
      (tau-(0.684)))^2 -(0.76) - 2*(2.33)*tau^2) + (0.33874242)*delta^(1)*
      tau^(2.5)*exp(-(1.977)*(delta-(0.6936))^2 - (3.47)*(tau-(0.829))^2)*
      (((2.5) - 2*(3.47)*tau*(tau-(0.829)))^2 -(2.5) - 2*(3.47)*tau^2) +
      (0.22228777)*delta^(1)*tau^(2.75)*exp(-(1.917)*(delta-(0.788))^2 -
      (3.15)*(tau-(1.419))^2)*(((2.75) - 2*(3.15)*tau*(tau-(1.419)))^2 -
      (2.75) - 2*(3.15)*tau^2) + (-0.23219062)*delta^(2)*tau^(3.05)*
      exp(-(2.307)*(delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*(((3.05) - 2*
      (3.19)*tau*(tau-(0.817)))^2 -(3.05) - 2*(3.19)*tau^2) + (-0.09220694)*
      delta^(2)*tau^(2.55)*exp(-(2.546)*(delta-(0.8577))^2 - (0.92)*
      (tau-(1.5))^2)*(((2.55) - 2*(0.92)*tau*(tau-(1.5)))^2 -(2.55) - 2*
      (0.92)*tau^2) + (-0.47575718)*delta^(4)*tau^(8.4)*exp(-(3.28)*
      (delta-(0.271))^2 - (18.8)*(tau-(1.426))^2)*(((8.4) - 2*(18.8)*
      tau*(tau-(1.426)))^2 -(8.4) - 2*(18.8)*tau^2) + (-0.017486824)*
      delta^(1)*tau^(6.75)*exp(-(14.6)*(delta-(0.948))^2 - (547.8)*
      (tau-(1.093))^2)*(((6.75) - 2*(547.8)*tau*(tau-(1.093)))^2 -(6.75) - 2*
      (547.8)*tau^2);
  end tt_fRes_tt;

  redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
  algorithm
    d_fRes_d := (0.042910051)*(4)*delta^(4)*tau^(1) +
      (1.7313671)*(1)*delta^(1)*tau^(0.33) + (-2.4516524)*(1)*delta^(1)*
      tau^(0.8) + (0.34157466)*(2)*delta^(2)*tau^(0.43) + (-0.46047898)*
      (2)*delta^(2)*tau^(0.9) + (-0.66847295)*delta^(1)*tau^(2.46)*
      ((1)-(1)*delta^(1))*exp(-delta^(1)) + (0.20889705)*delta^(3)*
      tau^(2.09)*((3)-(1)*delta^(1))*exp(-delta^(1)) + (0.19421381)*
      delta^(6)*tau^(0.88)*((6)-(1)*delta^(1))*exp(-delta^(1)) +
      (-0.22917851)*delta^(6)*tau^(1.09)*((6)-(1)*delta^(1))*exp(-delta^(1))
      + (-0.60405866)*delta^(2)*tau^(3.25)*((2)-(2)*delta^(2))*
      exp(-delta^(2)) + (0.066680654)*delta^(3)*tau^(4.62)*((3)-(2)*
      delta^(2))*exp(-delta^(2)) + (0.017534618)*delta^(1)*tau^(0.76)*
      exp(-(0.963)*(delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*((1) - 2*
      (0.963)*delta*(delta-(1.283))) + (0.33874242)*delta^(1)*tau^(2.5)*
      exp(-(1.977)*(delta-(0.6936))^2 - (3.47)*(tau-(0.829))^2)*((1) - 2*
      (1.977)*delta*(delta-(0.6936))) + (0.22228777)*delta^(1)*tau^(2.75)*
      exp(-(1.917)*(delta-(0.788))^2 - (3.15)*(tau-(1.419))^2)*((1) - 2*
      (1.917)*delta*(delta-(0.788))) + (-0.23219062)*delta^(2)*tau^(3.05)*
      exp(-(2.307)*(delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*((2) - 2*
      (2.307)*delta*(delta-(0.473))) + (-0.09220694)*delta^(2)*tau^(2.55)*
      exp(-(2.546)*(delta-(0.8577))^2 - (0.92)*(tau-(1.5))^2)*((2) - 2*
      (2.546)*delta*(delta-(0.8577))) + (-0.47575718)*delta^(4)*tau^(8.4)*
      exp(-(3.28)*(delta-(0.271))^2 - (18.8)*(tau-(1.426))^2)*((4) - 2*
      (3.28)*delta*(delta-(0.271))) + (-0.017486824)*delta^(1)*tau^(6.75)*
      exp(-(14.6)*(delta-(0.948))^2 - (547.8)*(tau-(1.093))^2)*((1) - 2*
      (14.6)*delta*(delta-(0.948)));
  end d_fRes_d;

  redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
  algorithm
    dd_fRes_dd := (0.042910051)*(4)*((4)-1)*delta^(4)*
      tau^(1) + (1.7313671)*(1)*((1)-1)*delta^(1)*tau^(0.33) + (-2.4516524)*
      (1)*((1)-1)*delta^(1)*tau^(0.8) + (0.34157466)*(2)*((2)-1)*delta^(2)*
      tau^(0.43) + (-0.46047898)*(2)*((2)-1)*delta^(2)*tau^(0.9) +
      (-0.66847295)*delta^(1)*tau^(2.46)*(((1)-(1)*delta^(1))*((1)-1-(1)*
      delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.20889705)*delta^(3)*
      tau^(2.09)*(((3)-(1)*delta^(1))*((3)-1-(1)*delta^(1))-(1)^2*delta^(1))*
      exp(-delta^(1)) + (0.19421381)*delta^(6)*tau^(0.88)*(((6)-(1)*
      delta^(1))*((6)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) +
      (-0.22917851)*delta^(6)*tau^(1.09)*(((6)-(1)*delta^(1))*((6)-1-(1)*
      delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (-0.60405866)*delta^(2)*
      tau^(3.25)*(((2)-(2)*delta^(2))*((2)-1-(2)*delta^(2))-(2)^2*delta^(2))*
      exp(-delta^(2)) + (0.066680654)*delta^(3)*tau^(4.62)*(((3)-(2)*
      delta^(2))*((3)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) +
      (0.017534618)*delta^(1)*tau^(0.76)*exp(-(0.963)*(delta-(1.283))^2 -
      (2.33)*(tau-(0.684))^2)*(((1) - 2*(0.963)*delta*(delta-(1.283)))^2 -
      (1) - 2*(0.963)*delta^2) + (0.33874242)*delta^(1)*tau^(2.5)*
      exp(-(1.977)*(delta-(0.6936))^2 - (3.47)*(tau-(0.829))^2)*(((1) - 2*
      (1.977)*delta*(delta-(0.6936)))^2 - (1) - 2*(1.977)*delta^2) +
      (0.22228777)*delta^(1)*tau^(2.75)*exp(-(1.917)*(delta-(0.788))^2 -
      (3.15)*(tau-(1.419))^2)*(((1) - 2*(1.917)*delta*(delta-(0.788)))^2 -
      (1) - 2*(1.917)*delta^2) + (-0.23219062)*delta^(2)*tau^(3.05)*
      exp(-(2.307)*(delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*(((2) - 2*
      (2.307)*delta*(delta-(0.473)))^2 - (2) - 2*(2.307)*delta^2) +
      (-0.09220694)*delta^(2)*tau^(2.55)*exp(-(2.546)*(delta-(0.8577))^2 -
      (0.92)*(tau-(1.5))^2)*(((2) - 2*(2.546)*delta*(delta-(0.8577)))^2 -
      (2) - 2*(2.546)*delta^2) + (-0.47575718)*delta^(4)*tau^(8.4)*
      exp(-(3.28)*(delta-(0.271))^2 - (18.8)*(tau-(1.426))^2)*(((4) - 2*
      (3.28)*delta*(delta-(0.271)))^2 - (4) - 2*(3.28)*delta^2) +
      (-0.017486824)*delta^(1)*tau^(6.75)*exp(-(14.6)*(delta-(0.948))^2 -
      (547.8)*(tau-(1.093))^2)*(((1) - 2*(14.6)*delta*(delta-(0.948)))^2 -
      (1) - 2*(14.6)*delta^2);
  end dd_fRes_dd;

  redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  algorithm
    td_fRes_td := (0.042910051)*(4)*(1)*delta^(4)*
      tau^(1) + (1.7313671)*(1)*(0.33)*delta^(1)*tau^(0.33) + (-2.4516524)*
      (1)*(0.8)*delta^(1)*tau^(0.8) + (0.34157466)*(2)*(0.43)*delta^(2)*
      tau^(0.43) + (-0.46047898)*(2)*(0.9)*delta^(2)*tau^(0.9) +
      (-0.66847295)*(2.46)*delta^(1)*tau^(2.46)*((1)-(1)*delta^(1))*
      exp(-delta^(1)) + (0.20889705)*(2.09)*delta^(3)*tau^(2.09)*((3)-(1)*
      delta^(1))*exp(-delta^(1)) + (0.19421381)*(0.88)*delta^(6)*tau^(0.88)*
      ((6)-(1)*delta^(1))*exp(-delta^(1)) + (-0.22917851)*(1.09)*delta^(6)*
      tau^(1.09)*((6)-(1)*delta^(1))*exp(-delta^(1)) + (-0.60405866)*(3.25)*
      delta^(2)*tau^(3.25)*((2)-(2)*delta^(2))*exp(-delta^(2)) +
      (0.066680654)*(4.62)*delta^(3)*tau^(4.62)*((3)-(2)*delta^(2))*
      exp(-delta^(2)) + (0.017534618)*delta^(1)*tau^(0.76)*exp(-(0.963)*
      (delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*((0.76) - 2*(2.33)*tau*
      (tau-(0.684)))*((1) - 2*(0.963)*delta*(delta-(1.283))) + (0.33874242)*
      delta^(1)*tau^(2.5)*exp(-(1.977)*(delta-(0.6936))^2 - (3.47)*
      (tau-(0.829))^2)*((2.5) - 2*(3.47)*tau*(tau-(0.829)))*((1) - 2*(1.977)*
      delta*(delta-(0.6936))) + (0.22228777)*delta^(1)*tau^(2.75)*
      exp(-(1.917)*(delta-(0.788))^2 - (3.15)*(tau-(1.419))^2)*((2.75) - 2*
      (3.15)*tau*(tau-(1.419)))*((1) - 2*(1.917)*delta*(delta-(0.788))) +
      (-0.23219062)*delta^(2)*tau^(3.05)*exp(-(2.307)*(delta-(0.473))^2 -
      (3.19)*(tau-(0.817))^2)*((3.05) - 2*(3.19)*tau*(tau-(0.817)))*((2) -
      2*(2.307)*delta*(delta-(0.473))) + (-0.09220694)*delta^(2)*tau^(2.55)*
      exp(-(2.546)*(delta-(0.8577))^2 - (0.92)*(tau-(1.5))^2)*((2.55) - 2*
      (0.92)*tau*(tau-(1.5)))*((2) - 2*(2.546)*delta*(delta-(0.8577))) +
      (-0.47575718)*delta^(4)*tau^(8.4)*exp(-(3.28)*(delta-(0.271))^2 -
      (18.8)*(tau-(1.426))^2)*((8.4) - 2*(18.8)*tau*(tau-(1.426)))*((4) - 2*
      (3.28)*delta*(delta-(0.271))) + (-0.017486824)*delta^(1)*tau^(6.75)*
      exp(-(14.6)*(delta-(0.948))^2 - (547.8)*(tau-(1.093))^2)*((6.75) - 2*
      (547.8)*tau*(tau-(1.093)))*((1) - 2*(14.6)*delta*(delta-(0.948)));
  end td_fRes_td;

  redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fIdg_ttt := 2*(3)*(1) + (-4.970583)*(0)*((0)-1)*((0)-2) *
      tau^(0) + (4.29352)*(1)*((1)-1)*((1)-2) *tau^(1) + tau^3*(3.043)*
      (1.062478)^3*exp((1.062478)*tau)*(exp((1.062478)*tau)+1)/
      (exp((1.062478)*tau)-1)^3 + tau^3*(5.874)*(3.344237)^3*exp((3.344237)*
      tau)*(exp((3.344237)*tau)+1)/(exp((3.344237)*tau)-1)^3 + tau^3*(9.337)*
      (5.363757)^3*exp((5.363757)*tau)*(exp((5.363757)*tau)+1)/
      (exp((5.363757)*tau)-1)^3 + tau^3*(7.922)*(11.762957)^3*exp((11.762957)*
      tau)*(exp((11.762957)*tau)+1)/(exp((11.762957)*tau)-1)^3;
  end ttt_fIdg_ttt;

  redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fRes_ttt := (0.042910051)*(1)*((1)-1)*((1)-2)*delta^(4)*
      tau^(1) + (1.7313671)*(0.33)*((0.33)-1)*((0.33)-2)*delta^(1)*
      tau^(0.33) + (-2.4516524)*(0.8)*((0.8)-1)*((0.8)-2)*delta^(1)*
      tau^(0.8) + (0.34157466)*(0.43)*((0.43)-1)*((0.43)-2)*delta^(2)*
      tau^(0.43) + (-0.46047898)*(0.9)*((0.9)-1)*((0.9)-2)*delta^(2)*
      tau^(0.9) + (-0.66847295)*(2.46)*((2.46)-1)*((2.46)-2)*delta^(1)*
      tau^(2.46)*exp(-delta^(1)) + (0.20889705)*(2.09)*((2.09)-1)*((2.09)-2)*
      delta^(3)*tau^(2.09)*exp(-delta^(1)) + (0.19421381)*(0.88)*((0.88)-1)*
      ((0.88)-2)*delta^(6)*tau^(0.88)*exp(-delta^(1)) + (-0.22917851)*
      (1.09)*((1.09)-1)*((1.09)-2)*delta^(6)*tau^(1.09)*exp(-delta^(1)) +
      (-0.60405866)*(3.25)*((3.25)-1)*((3.25)-2)*delta^(2)*tau^(3.25)*
      exp(-delta^(2)) + (0.066680654)*(4.62)*((4.62)-1)*((4.62)-2)*
      delta^(3)*tau^(4.62)*exp(-delta^(2)) - (0.017534618)*delta^(1)*
      tau^(0.76)*exp(-(0.963)*(delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*
      (8*(2.33)^3*tau^6-24*(2.33)^3*(0.684)*tau^5+12*(2.33)^2*(2*(2.33)*
      (0.684)^2-(0.76)-1)*tau^4-4*(2.33)^2*(0.684)*(2*(2.33)*(0.684)^2-6*
      (0.76)-3)*tau^3-6*(0.76)*(2.33)*(2*(2.33)*(0.684)^2-(0.76))*tau^2-6*
      ((0.76)-1)*(0.76)*(2.33)*(0.684)*tau-(0.76)^3+3*(0.76)^2-2*(0.76)) -
      (0.33874242)*delta^(1)*tau^(2.5)*exp(-(1.977)*(delta-(0.6936))^2 -
      (3.47)*(tau-(0.829))^2)*(8*(3.47)^3*tau^6-24*(3.47)^3*(0.829)*tau^5+
      12*(3.47)^2*(2*(3.47)*(0.829)^2-(2.5)-1)*tau^4-4*(3.47)^2*(0.829)*(2*
      (3.47)*(0.829)^2-6*(2.5)-3)*tau^3-6*(2.5)*(3.47)*(2*(3.47)*(0.829)^2-
      (2.5))*tau^2-6*((2.5)-1)*(2.5)*(3.47)*(0.829)*tau-(2.5)^3+3*(2.5)^2-2*
      (2.5)) - (0.22228777)*delta^(1)*tau^(2.75)*exp(-(1.917)*(delta-
      (0.788))^2 - (3.15)*(tau-(1.419))^2)*(8*(3.15)^3*tau^6-24*(3.15)^3*
      (1.419)*tau^5+12*(3.15)^2*(2*(3.15)*(1.419)^2-(2.75)-1)*tau^4-4*
      (3.15)^2*(1.419)*(2*(3.15)*(1.419)^2-6*(2.75)-3)*tau^3-6*(2.75)*
      (3.15)*(2*(3.15)*(1.419)^2-(2.75))*tau^2-6*((2.75)-1)*(2.75)*(3.15)*
      (1.419)*tau-(2.75)^3+3*(2.75)^2-2*(2.75)) - (-0.23219062)*delta^(2)*
      tau^(3.05)*exp(-(2.307)*(delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*
      (8*(3.19)^3*tau^6-24*(3.19)^3*(0.817)*tau^5+12*(3.19)^2*(2*(3.19)*
      (0.817)^2-(3.05)-1)*tau^4-4*(3.19)^2*(0.817)*(2*(3.19)*(0.817)^2-6*
      (3.05)-3)*tau^3-6*(3.05)*(3.19)*(2*(3.19)*(0.817)^2-(3.05))*tau^2-6*
      ((3.05)-1)*(3.05)*(3.19)*(0.817)*tau-(3.05)^3+3*(3.05)^2-2*(3.05)) -
      (-0.09220694)*delta^(2)*tau^(2.55)*exp(-(2.546)*(delta-(0.8577))^2 -
      (0.92)*(tau-(1.5))^2)*(8*(0.92)^3*tau^6-24*(0.92)^3*(1.5)*tau^5+12*
      (0.92)^2*(2*(0.92)*(1.5)^2-(2.55)-1)*tau^4-4*(0.92)^2*(1.5)*(2*(0.92)*
      (1.5)^2-6*(2.55)-3)*tau^3-6*(2.55)*(0.92)*(2*(0.92)*(1.5)^2-(2.55))*
      tau^2-6*((2.55)-1)*(2.55)*(0.92)*(1.5)*tau-(2.55)^3+3*(2.55)^2-2*
      (2.55)) - (-0.47575718)*delta^(4)*tau^(8.4)*exp(-(3.28)*(delta-
      (0.271))^2 - (18.8)*(tau-(1.426))^2)*(8*(18.8)^3*tau^6-24*(18.8)^3*
      (1.426)*tau^5+12*(18.8)^2*(2*(18.8)*(1.426)^2-(8.4)-1)*tau^4-4*
      (18.8)^2*(1.426)*(2*(18.8)*(1.426)^2-6*(8.4)-3)*tau^3-6*(8.4)*(18.8)*
      (2*(18.8)*(1.426)^2-(8.4))*tau^2-6*((8.4)-1)*(8.4)*(18.8)*(1.426)*
      tau-(8.4)^3+3*(8.4)^2-2*(8.4)) - (-0.017486824)*delta^(1)*tau^(6.75)*
      exp(-(14.6)*(delta-(0.948))^2 - (547.8)*(tau-(1.093))^2)*(8*(547.8)^3*
      tau^6-24*(547.8)^3*(1.093)*tau^5+12*(547.8)^2*(2*(547.8)*(1.093)^2-
      (6.75)-1)*tau^4-4*(547.8)^2*(1.093)*(2*(547.8)*(1.093)^2-6*(6.75)-3)*
      tau^3-6*(6.75)*(547.8)*(2*(547.8)*(1.093)^2-(6.75))*tau^2-6*((6.75)-1)*
      (6.75)*(547.8)*(1.093)*tau-(6.75)^3+3*(6.75)^2-2*(6.75));
  end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd
    "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
  algorithm
    ddd_fRes_ddd := (0.042910051)*(4)*((4)-1)*((4)-2)*
      delta^(4)*tau^(1) + (1.7313671)*(1)*((1)-1)*((1)-2)*delta^(1)*
      tau^(0.33) + (-2.4516524)*(1)*((1)-1)*((1)-2)*delta^(1)*tau^(0.8) +
      (0.34157466)*(2)*((2)-1)*((2)-2)*delta^(2)*tau^(0.43) + (-0.46047898)*
      (2)*((2)-1)*((2)-2)*delta^(2)*tau^(0.9) - (-0.66847295)*delta^(1)*
      tau^(2.46)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1)-3)-3*(1)+3)+(1)+3*(1)-3)+3*(1)^2-6*(1)+2)-((1)-2)*((1)-1)*
      (1)) - (0.20889705)*delta^(3)*tau^(2.09)*exp(-delta^(1))*((1)*
      delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(3)+3)+(1)+3*(3)-3)+3*
      (3)^2-6*(3)+2)-((3)-2)*((3)-1)*(3)) - (0.19421381)*delta^(6)*
      tau^(0.88)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1)-3)-3*(6)+3)+(1)+3*(6)-3)+3*(6)^2-6*(6)+2)-((6)-2)*((6)-1)*
      (6)) - (-0.22917851)*delta^(6)*tau^(1.09)*exp(-delta^(1))*((1)*
      delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(6)+3)+(1)+3*(6)-3)+3*
      (6)^2-6*(6)+2)-((6)-2)*((6)-1)*(6)) - (-0.60405866)*delta^(2)*
      tau^(3.25)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*
      (delta^(2)-3)-3*(2)+3)+(2)+3*(2)-3)+3*(2)^2-6*(2)+2)-((2)-2)*((2)-1)*
      (2)) - (0.066680654)*delta^(3)*tau^(4.62)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(3)+3)+(2)+3*(3)-3)+3*
      (3)^2-6*(3)+2)-((3)-2)*((3)-1)*(3)) - (0.017534618)*delta^(1)*
      tau^(0.76)*exp(-(0.963)*(delta-(1.283))^2 - (2.33)*(tau-(0.684))^2)*
      (8*(0.963)^3*delta^6-24*(0.963)^3*(1.283)*delta^5+12*(0.963)^2*(2*
      (0.963)*(1.283)^2-(1)-1)*delta^4-4*(0.963)^2*(1.283)*(2*(0.963)*
      (1.283)^2-6*(1)-3)*delta^3-6*(1)*(0.963)*(2*(0.963)*(1.283)^2-(1))*
      delta^2-6*((1)-1)*(1)*(0.963)*(1.283)*delta-(1)^3+3*(1)^2-2*(1)) -
      (0.33874242)*delta^(1)*tau^(2.5)*exp(-(1.977)*(delta-(0.6936))^2 -
      (3.47)*(tau-(0.829))^2)*(8*(1.977)^3*delta^6-24*(1.977)^3*(0.6936)*
      delta^5+12*(1.977)^2*(2*(1.977)*(0.6936)^2-(1)-1)*delta^4-4*(1.977)^2*
      (0.6936)*(2*(1.977)*(0.6936)^2-6*(1)-3)*delta^3-6*(1)*(1.977)*(2*
      (1.977)*(0.6936)^2-(1))*delta^2-6*((1)-1)*(1)*(1.977)*(0.6936)*delta-
      (1)^3+3*(1)^2-2*(1)) - (0.22228777)*delta^(1)*tau^(2.75)*exp(-(1.917)*
      (delta-(0.788))^2 - (3.15)*(tau-(1.419))^2)*(8*(1.917)^3*delta^6-24*
      (1.917)^3*(0.788)*delta^5+12*(1.917)^2*(2*(1.917)*(0.788)^2-(1)-1)*
      delta^4-4*(1.917)^2*(0.788)*(2*(1.917)*(0.788)^2-6*(1)-3)*delta^3-6*
      (1)*(1.917)*(2*(1.917)*(0.788)^2-(1))*delta^2-6*((1)-1)*(1)*(1.917)*
      (0.788)*delta-(1)^3+3*(1)^2-2*(1)) - (-0.23219062)*delta^(2)*tau^(3.05)*
      exp(-(2.307)*(delta-(0.473))^2 - (3.19)*(tau-(0.817))^2)*(8*(2.307)^3*
      delta^6-24*(2.307)^3*(0.473)*delta^5+12*(2.307)^2*(2*(2.307)*(0.473)^2-
      (2)-1)*delta^4-4*(2.307)^2*(0.473)*(2*(2.307)*(0.473)^2-6*(2)-3)*
      delta^3-6*(2)*(2.307)*(2*(2.307)*(0.473)^2-(2))*delta^2-6*((2)-1)*
      (2)*(2.307)*(0.473)*delta-(2)^3+3*(2)^2-2*(2)) - (-0.09220694)*
      delta^(2)*tau^(2.55)*exp(-(2.546)*(delta-(0.8577))^2 - (0.92)*
      (tau-(1.5))^2)*(8*(2.546)^3*delta^6-24*(2.546)^3*(0.8577)*delta^5+12*
      (2.546)^2*(2*(2.546)*(0.8577)^2-(2)-1)*delta^4-4*(2.546)^2*(0.8577)*(2*
      (2.546)*(0.8577)^2-6*(2)-3)*delta^3-6*(2)*(2.546)*(2*(2.546)*
      (0.8577)^2-(2))*delta^2-6*((2)-1)*(2)*(2.546)*(0.8577)*delta-(2)^3+3*
      (2)^2-2*(2)) - (-0.47575718)*delta^(4)*tau^(8.4)*exp(-(3.28)*
      (delta-(0.271))^2 - (18.8)*(tau-(1.426))^2)*(8*(3.28)^3*delta^6-24*
      (3.28)^3*(0.271)*delta^5+12*(3.28)^2*(2*(3.28)*(0.271)^2-(4)-1)*
      delta^4-4*(3.28)^2*(0.271)*(2*(3.28)*(0.271)^2-6*(4)-3)*delta^3-6*(4)*
      (3.28)*(2*(3.28)*(0.271)^2-(4))*delta^2-6*((4)-1)*(4)*(3.28)*(0.271)*
      delta-(4)^3+3*(4)^2-2*(4)) - (-0.017486824)*delta^(1)*tau^(6.75)*
      exp(-(14.6)*(delta-(0.948))^2 - (547.8)*(tau-(1.093))^2)*(8*(14.6)^3*
      delta^6-24*(14.6)^3*(0.948)*delta^5+12*(14.6)^2*(2*(14.6)*
      (0.948)^2-(1)-1)*delta^4-4*(14.6)^2*(0.948)*(2*(14.6)*(0.948)^2-6*
      (1)-3)*delta^3-6*(1)*(14.6)*(2*(14.6)*(0.948)^2-(1))*delta^2-6*
      ((1)-1)*(1)*(14.6)*(0.948)*delta-(1)^3+3*(1)^2-2*(1));
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  algorithm
    tdd_fRes_tdd := (0.042910051)*(4)*(1)*(4-1)*
      delta^(4)*tau^(1) + (1.7313671)*(1)*(0.33)*(1-1)*delta^(1)*tau^(0.33) +
      (-2.4516524)*(1)*(0.8)*(1-1)*delta^(1)*tau^(0.8) + (0.34157466)*(2)*
      (0.43)*(2-1)*delta^(2)*tau^(0.43) + (-0.46047898)*(2)*(0.9)*(2-1)*
      delta^(2)*tau^(0.9) + (-0.66847295)*(2.46)*delta^(1)*tau^(2.46)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(1)+1)+(1)*
      ((1)-1)) + (0.20889705)*(2.09)*delta^(3)*tau^(2.09)*exp(-delta^(1))*
      ((1)*delta^(1)*((1)*(delta^(1)-1)-2*(3)+1)+(3)*((3)-1)) + (0.19421381)*
      (0.88)*delta^(6)*tau^(0.88)*exp(-delta^(1))*((1)*delta^(1)*((1)*
      (delta^(1)-1)-2*(6)+1)+(6)*((6)-1)) + (-0.22917851)*(1.09)*delta^(6)*
      tau^(1.09)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(6)+1)+
      (6)*((6)-1)) + (-0.60405866)*(3.25)*delta^(2)*tau^(3.25)*exp(-delta^(2))
      *((2)*delta^(2)*((2)*(delta^(2)-1)-2*(2)+1)+(2)*((2)-1)) +
      (0.066680654)*(4.62)*delta^(3)*tau^(4.62)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)-1)-2*(3)+1)+(3)*((3)-1)) + (0.017534618)*
      delta^(1)*tau^(0.76)*exp(-(0.963)*(delta - (1.283))^2 - (2.33)*
      (tau - (0.684))^2)*((0.76)-2*(2.33)*tau*(tau-(0.684)))*(((1)-2*(0.963)*
      delta*(delta-(1.283)))^2-(1)-2*(0.963)*delta^2) + (0.33874242)*
      delta^(1)*tau^(2.5)*exp(-(1.977)*(delta - (0.6936))^2 - (3.47)*
      (tau - (0.829))^2)*((2.5)-2*(3.47)*tau*(tau-(0.829)))*(((1)-2*(1.977)*
      delta*(delta-(0.6936)))^2-(1)-2*(1.977)*delta^2) + (0.22228777)*
      delta^(1)*tau^(2.75)*exp(-(1.917)*(delta - (0.788))^2 - (3.15)*
      (tau - (1.419))^2)*((2.75)-2*(3.15)*tau*(tau-(1.419)))*(((1)-2*
      (1.917)*delta*(delta-(0.788)))^2-(1)-2*(1.917)*delta^2) + (-0.23219062)*
      delta^(2)*tau^(3.05)*exp(-(2.307)*(delta - (0.473))^2 - (3.19)*
      (tau - (0.817))^2)*((3.05)-2*(3.19)*tau*(tau-(0.817)))*(((2)-2*(2.307)*
      delta*(delta-(0.473)))^2-(2)-2*(2.307)*delta^2) + (-0.09220694)*
      delta^(2)*tau^(2.55)*exp(-(2.546)*(delta - (0.8577))^2 - (0.92)*
      (tau - (1.5))^2)*((2.55)-2*(0.92)*tau*(tau-(1.5)))*(((2)-2*(2.546)*
      delta*(delta-(0.8577)))^2-(2)-2*(2.546)*delta^2) + (-0.47575718)*
      delta^(4)*tau^(8.4)*exp(-(3.28)*(delta - (0.271))^2 - (18.8)*
      (tau - (1.426))^2)*((8.4)-2*(18.8)*tau*(tau-(1.426)))*(((4)-2*
      (3.28)*delta*(delta-(0.271)))^2-(4)-2*(3.28)*delta^2) + (-0.017486824)*
      delta^(1)*tau^(6.75)*exp(-(14.6)*(delta - (0.948))^2 - (547.8)*
      (tau - (1.093))^2)*((6.75)-2*(547.8)*tau*(tau-(1.093)))*(((1)-2*(14.6)*
      delta*(delta-(0.948)))^2-(1)-2*(14.6)*delta^2);
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  algorithm
    ttd_fRes_ttd := (0.042910051)*(4)*(1)*(1-1)*
      delta^(4)*tau^(1) + (1.7313671)*(1)*(0.33)*(0.33-1)*delta^(1)*
      tau^(0.33) + (-2.4516524)*(1)*(0.8)*(0.8-1)*delta^(1)*tau^(0.8) +
      (0.34157466)*(2)*(0.43)*(0.43-1)*delta^(2)*tau^(0.43) + (-0.46047898)*
      (2)*(0.9)*(0.9-1)*delta^(2)*tau^(0.9) + (-0.66847295)*(2.46)*((2.46)-1)*
      delta^(1)*tau^(2.46)*exp(-delta^(1))*((1)-(1)*delta^(1)) + (0.20889705)*
      (2.09)*((2.09)-1)*delta^(3)*tau^(2.09)*exp(-delta^(1))*((3)-(1)*
      delta^(1)) + (0.19421381)*(0.88)*((0.88)-1)*delta^(6)*tau^(0.88)*
      exp(-delta^(1))*((6)-(1)*delta^(1)) + (-0.22917851)*(1.09)*((1.09)-1)*
      delta^(6)*tau^(1.09)*exp(-delta^(1))*((6)-(1)*delta^(1)) + (-0.60405866)*
      (3.25)*((3.25)-1)*delta^(2)*tau^(3.25)*exp(-delta^(2))*((2)-(2)*
      delta^(2)) + (0.066680654)*(4.62)*((4.62)-1)*delta^(3)*tau^(4.62)*
      exp(-delta^(2))*((3)-(2)*delta^(2)) + (0.017534618)*delta^(1)*
      tau^(0.76)*exp(-(0.963)*(delta - (1.283))^2 - (2.33)*(tau - (0.684))^2)*
      ((1)-2*(0.963)*delta*(delta-(1.283)))*(((0.76)-2*(2.33)*tau*
      (tau-(0.684)))^2-(0.76)-2*(2.33)*tau^2) + (0.33874242)*delta^(1)*
      tau^(2.5)*exp(-(1.977)*(delta - (0.6936))^2 - (3.47)*(tau - (0.829))^2)*
      ((1)-2*(1.977)*delta*(delta-(0.6936)))*(((2.5)-2*(3.47)*tau*
      (tau-(0.829)))^2-(2.5)-2*(3.47)*tau^2) + (0.22228777)*delta^(1)*
      tau^(2.75)*exp(-(1.917)*(delta - (0.788))^2 - (3.15)*(tau - (1.419))^2)*
      ((1)-2*(1.917)*delta*(delta-(0.788)))*(((2.75)-2*(3.15)*tau*
      (tau-(1.419)))^2-(2.75)-2*(3.15)*tau^2) + (-0.23219062)*delta^(2)*
      tau^(3.05)*exp(-(2.307)*(delta - (0.473))^2 - (3.19)*(tau - (0.817))^2)*
      ((2)-2*(2.307)*delta*(delta-(0.473)))*(((3.05)-2*(3.19)*tau*
      (tau-(0.817)))^2-(3.05)-2*(3.19)*tau^2) + (-0.09220694)*delta^(2)*
      tau^(2.55)*exp(-(2.546)*(delta - (0.8577))^2 - (0.92)*(tau - (1.5))^2)*
      ((2)-2*(2.546)*delta*(delta-(0.8577)))*(((2.55)-2*(0.92)*tau*
      (tau-(1.5)))^2-(2.55)-2*(0.92)*tau^2) + (-0.47575718)*delta^(4)*
      tau^(8.4)*exp(-(3.28)*(delta - (0.271))^2 - (18.8)*(tau - (1.426))^2)*
      ((4)-2*(3.28)*delta*(delta-(0.271)))*(((8.4)-2*(18.8)*tau*
      (tau-(1.426)))^2-(8.4)-2*(18.8)*tau^2) + (-0.017486824)*delta^(1)*
      tau^(6.75)*exp(-(14.6)*(delta - (0.948))^2 - (547.8)*
      (tau - (1.093))^2)*((1)-2*(14.6)*delta*(delta-(0.948)))*
      (((6.75)-2*(547.8)*tau*(tau-(1.093)))^2-(6.75)-2*(547.8)*tau^2);
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
      p := fluidConstants[1].criticalPressure *
        exp((fluidConstants[1].criticalTemperature/T) * ((-6.7722)*OM^(1) +
        (1.6938)*OM^(1.5) + (-1.3341)*OM^(2.2) + (-3.1876)*OM^(4.8) +
        (0.94937)*OM^(6.5)));
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
    x := (p - (1570581.06473046))/(2557900);
    T := (314.714456959068) + (89.9988984287752) * (x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*((398148862.940126)*x + (-199919955.396472)) + (-757908233.955288)) +
      (367952699.725659)) + (667046798.608578)) + (-312549990.204649)) +
      (-357938868.07772)) + (161410013.061604)) + (130510724.837043)) +
      (-56445981.8598188)) + (-34132767.2831829)) + (14097753.337877)) +
      (6597033.14683305)) + (-2588996.07334184)) + (-956016.453555908)) +
      (354129.363109993)) + (104671.21653575)) + (-36365.4299997343)) +
      (-8551.71765339857)) + (2737.41277992834)) + (548.032269738263)) +
      (-169.618396241937)) + (-14.0609083306686)) + (-0.171965430903563)) +
      (5.1496074119545)) + (-3.2101839991522)) + (2.10314346387695)) +
      (-1.50075370184942)) + (1.08909694031671)) + (-0.809987090417357)) +
      (0.624647765942656)) + (-0.509758482228388)) + (0.452113517399419)) +
      (-0.485252422559269)) + (0.812915722176255)) + (0.049784532));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (303.15))/(90);
    dl := (479.63605641964) + (158.710809951891) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(
      (168.562039493205)*x + (102.498679842295)) + (-417.252850518645)) +
      (-379.369839448631)) + (259.875445333347)) + (360.650888848736)) +
      (-34.286073230572)) + (-167.388526468939)) + (-38.3089822429208)) +
      (32.2321439731247)) + (16.240179568742)) + (-1.02099838936652)) +
      (-2.73648898021723)) + (-1.28146729979824)) + (-0.699142505344287)) +
      (-0.486571806528472)) + (-0.362711228684454)) + (-0.295698328266597)) +
      (-0.257687633710071)) + (-0.232292001969948)) + (-0.214228995994567)) +
      (-0.20556940574841)) + (-0.209973677149465)) + (-0.241754621811309)) +
      (-0.31988094531161)) + (-0.921191170759037)) + (0.0299586382685047));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (303.15))/(90);
    dv := (28.4811865500103) + (66.6559013317995) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(
      (24729.5537485333)*x + (-4790.47306548912)) + (-52999.2668562323)) +
      (7058.92241323013)) + (52982.2892015502)) + (-2370.58912808463)) +
      (-31858.637385946)) + (-1861.34451993193)) + (12491.6995976091)) +
      (2253.53926320725)) + (-3122.52067135369)) + (-1051.27601610942)) +
      (412.3820502853)) + (267.637744405501)) + (12.9822226129711)) +
      (-27.0147438072994)) + (-10.2971934822874)) + (-0.739113632299647)) +
      (1.49114325185849)) + (1.35527523720564)) + (0.923630488185071)) +
      (0.672792235972464)) + (0.560751132479985)) + (0.509690199864535)) +
      (0.490192151807828)) + (0.495282411314377)) + (0.590898303947074)) +
      (0.811832008381672)) + (0.808375476827012)) + (-0.0754744015174044));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1570581.06473046))/(2557900);
    hl := (315624.984387066) + (256478.426329608) * (x*(x*(x*(x*(x*(x*(x*(x*
    (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
    (x*(x*(x*(x*(x*(x*(x*((-9294767843.63885)*x + (4601044486.87677)) +
    (20637884091.3137)) + (-9916466348.59996)) + (-21359403718.5665)) +
    (9947264847.89552)) + (13636958532.2276)) + (-6142679157.11019)) +
    (-6000574809.17466)) + (2607836222.80069)) + (1926833832.78873)) +
    (-805551262.020446)) + (-466601813.162386)) + (187005402.363897)) +
    (86860131.7909424)) + (-33235234.3082519)) + (-12561996.4230609)) +
    (4567071.19402525)) + (1416354.0638898)) + (-486313.365924655)) +
    (-124542.594195178)) + (40167.0083231862)) + (8397.46595050577)) +
    (-2498.28167363608)) + (-462.619336965067)) + (137.536958919031)) +
    (6.47029425217843)) + (2.64758244293881)) + (-5.32098880051055)) +
    (3.46672373461629)) + (-2.26302221729487)) + (1.59069973995372)) +
    (-1.13913175345066)) + (0.832473481266347)) + (-0.610337601733258)) +
    (0.487787294421858)) + (-0.381084129429948)) + (0.372237411342447)) +
    (-0.34966667159822)) + (0.849926390294104)) + (0.0361438659731507));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1570581.06473046))/(2557900);
    hv := (611770.95439052) + (72569.9367503185) * (x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*((-18775386313.6055)*x + (9394086287.20505)) +
      (41644196829.4943)) + (-20247895189.1885)) + (-43051291028.3205)) +
      (20309540510.172)) + (27452478313.3802)) + (-12538264110.1784)) +
      (-12063991762.716)) + (5319760814.06607)) + (3868950611.13826)) +
      (-1641348684.22018)) + (-936106557.039505)) + (380310593.940752)) +
      (174364505.252102)) + (-67425029.5319391)) + (-25335355.2373842)) +
      (9258056.41821587)) + (2898773.57918601)) + (-997509.402878578)) +
      (-263711.217390457)) + (88279.4166642683)) + (18539.6674822496)) +
      (-7265.37195240485)) + (-791.349145978091)) + (783.380077339674)) +
      (-118.386708715477)) + (-87.4509889200359)) + (28.7466309562791)) +
      (22.7165909170454)) + (-12.9134840899498)) + (0.37918804346481)) +
      (-1.09461342269619)) + (2.21831905224981)) + (-1.37432108544607)) +
      (0.840516589045987)) + (-0.879264408088915)) + (0.602870738214699)) +
      (-0.988765189667206)) + (0.73697777870168)) + (0.0980593948500622));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1570581.06473046))/(2557900);
    sl := (1376.30588505819) + (826.068105213303) * (x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*((-15349607814.6221)*x + (7636274154.59154)) +
      (34083168950.6415)) + (-16468859514.8044)) + (-35274256182.5208)) +
      (16529163595.4961)) + (22520438414.7263)) + (-10212384678.3319)) +
      (-9909434496.20396)) + (4337708567.68782)) + (3182094478.82347)) +
      (-1340537038.4187)) + (-770642130.02999)) + (311344581.740643)) +
      (143483390.503767)) + (-55358907.3112437)) + (-20756825.7164981)) +
      (7610600.46375838)) + (2341379.49521742)) + (-810782.536880512)) +
      (-205991.835180489)) + (66975.5024566354)) + (13911.5167143464)) +
      (-4172.85884728481)) + (-763.056131634308)) + (226.059931948838)) +
      (12.7752539636391)) + (3.11268958206643)) + (-7.85167676769299)) +
      (5.00328992083909)) + (-3.24391515196012)) + (2.26101216009097)) +
      (-1.60045805379047)) + (1.15217954418816)) + (-0.838779616598381)) +
      (0.651059130787342)) + (-0.506702271997059)) + (0.465184273228716)) +
      (-0.435627195532008)) + (0.805470640142587)) + (0.0457609974234471));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
    "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1570581.06473046))/(2557900);
    sv := (2335.75170536325) + (97.9077112667096) * (x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*
      (x*(x*(x*(x*(x*(x*(x*((77490431827.9399)*x + (-38415276654.6987)) +
      (-172242854661.379)) + (82962121367.1925)) + (178399484846.286)) +
      (-83356734431.6106)) + (-113970547248.801)) + (51553752249.9676)) +
      (50177422017.5857)) + (-21921194748.1992)) + (-16120343329.1663)) +
      (6783508534.79747)) + (3904793200.14042)) + (-1578181058.50373)) +
      (-726577962.8212)) + (281202937.346275)) + (104799948.851401)) +
      (-38715062.2946953)) + (-11716161.8016396)) + (4105031.67420979)) +
      (1007213.05553646)) + (-326165.883627773)) + (-65541.5043152719)) +
      (16329.6212516804)) + (3852.60757433586)) + (91.0319174951408)) +
      (-343.494332982509)) + (-224.377993905924)) + (107.45943824896)) +
      (24.4635507698644)) + (-8.50688453256311)) + (-13.0500554559933)) +
      (6.58097770859788)) + (-1.42438707828771)) + (1.58146106221061)) +
      (-1.50959232991508)) + (0.66941156982168)) + (-0.759627313555789)) +
      (-0.113920392204933)) + (-0.624499077638527)) + (-0.00619048868799449));
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
     x1 := (p-(1682457.5126701))/(720642.233056887);
     y1 := (h-(247137.397786416))/(54003.5903158973);
     T := (0) + (1) * ((291.384236041825) + y1*(y1*(y1*(y1*(
      (-0.0016300055996751)*y1 + (-0.00751600683912493) +
      (0.00140205757787774)*x1) + (-0.038647246926071) + x1*(
      (-0.000392485634748443)*x1 + (0.00767135438646387))) +
      (-0.770247506716285) + x1*(x1*((0.000134930636679386)*x1 +
      (-0.00177519423682889)) + (0.0309332207143316))) +
      (20.5578417380748) + x1*(x1*(x1*((-1.12691051342428e-05)*x1 +
      (0.000273729410002939)) + (-0.0044760279738207)) +
      (0.136811720776647))) + x1*(x1*(x1*(x1*((7.98267274869292e-07)*x1 +
      (-9.71248676197528e-06)) + (0.000202836611783306)) +
      (-0.00678884566695906)) + (-0.0704729863184529)));
    elseif h>h_dew+dh then
     x2 := (p-(382099.574228781))/(403596.556578661);
     y2 := (h-(639399.497939419))/(37200.2691858212);
     T := (0) + (1) * ((308.060027778396) + y2*(y2*(y2*(y2*(
      (-0.000577281104194347)*y2 + (0.0046513295424428) +
      (0.00590025752789791)*x2) + (-0.00497446957449581) + x2*(
      (-0.00176606807260317)*x2 + (-0.0432200997543392))) +
      (-0.411365889418558) + x2*(x2*((0.00281445602040784)*x2 +
      (0.00660309588666398)) + (0.255977908649908))) +
      (20.795024314138) + x2*(x2*(x2*((0.000787074643540945)*x2 +
      (-0.00847992074678385)) + (-0.0188305448625778)) +
      (-1.43969687581506))) + x2*(x2*(x2*(x2*((-4.64422678045603e-05)*x2 +
      (-0.000196566506959251)) + (0.00540769150996739)) +
      (0.0453108439023189)) + (6.59039876392094)));
    else
     if h<h_bubble then
      x1 := (p-(1682457.5126701))/(720642.233056887);
      y1 := (h-(247137.397786416))/(54003.5903158973);
      T1 := (0) + (1) * ((291.384236041825) + y1*(y1*(y1*(y1*(
       (-0.0016300055996751)*y1 + (-0.00751600683912493) +
       (0.00140205757787774)*x1) + (-0.038647246926071) + x1*(
       (-0.000392485634748443)*x1 + (0.00767135438646387))) +
       (-0.770247506716285) + x1*(x1*((0.000134930636679386)*x1 +
       (-0.00177519423682889)) + (0.0309332207143316))) +
       (20.5578417380748) + x1*(x1*(x1*((-1.12691051342428e-05)*x1 +
       (0.000273729410002939)) + (-0.0044760279738207)) +
       (0.136811720776647))) + x1*(x1*(x1*(x1*((7.98267274869292e-07)*x1 +
       (-9.71248676197528e-06)) + (0.000202836611783306)) +
       (-0.00678884566695906)) + (-0.0704729863184529)));
      T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
        T1*(h_bubble - h)/dh;
     elseif h>h_dew then
      x2 := (p-(382099.574228781))/(403596.556578661);
      y2 := (h-(639399.497939419))/(37200.2691858212);
      T2 := (0) + (1) * ((308.060027778396) + y2*(y2*(y2*(y2*(
       (-0.000577281104194347)*y2 + (0.0046513295424428) +
       (0.00590025752789791)*x2) + (-0.00497446957449581) + x2*(
       (-0.00176606807260317)*x2 + (-0.0432200997543392))) +
       (-0.411365889418558) + x2*(x2*((0.00281445602040784)*x2 +
       (0.00660309588666398)) + (0.255977908649908))) +
       (20.795024314138) + x2*(x2*(x2*((0.000787074643540945)*x2 +
       (-0.00847992074678385)) + (-0.0188305448625778)) +
       (-1.43969687581506))) + x2*(x2*(x2*(x2*((-4.64422678045603e-05)*x2 +
       (-0.000196566506959251)) + (0.00540769150996739)) +
       (0.0453108439023189)) + (6.59039876392094)));
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
     x1 := (log(p)-(14.2251890031606))/(0.499169296800688);
     y1 := (s-(1152.46506841802))/(179.299713840403);
     T := (0) + (1) * ((290.574168937952) + y1*(y1*(y1*(y1*(
      (-0.00192723964571896)*y1 + (-0.0124017661200968) +
      (0.00127247920370296)*x1) + (-0.0857625427384498) +
      x1*((0.00090717580273224)*x1 + (0.00799217399325639))) +
      (-0.040817223566116) + x1*(x1*((0.000459514035453056)*x1 +
      (0.00622225803519055)) + (0.0324083687227166))) + (19.8608752914032) +
      x1*(x1*(x1*((0.000243666235393007)*x1 + (0.0037715016370504)) +
      (0.0292848788419663)) + (0.130154107880201))) + x1*(x1*(x1*(x1*(
      (0.00011497599662102)*x1 +(0.00191602988674819)) + (0.0181671755438826))
      + (0.117871744016533)) + (0.490828546245446)));
    elseif s>s_dew+ds then
     x2 := (log(p)-(12.3876547448383))/(0.961902709412239);
     y2 := (s-(2715.6535956075))/(207.473158311391);
     T := (0) + (1) * ((305.667994209752) + y2*(y2*(y2*(y2*(
     (-0.00049456983306658)*y2 + (0.0160903628800248) +
     (0.0036583657279175)*x2) + (-0.100508863694088) + x2*(
     (-0.00773556171071259)*x2 + (-0.00125351482775024))) +
     (0.702977715170277) + x2*(x2*((0.00736011556482272)*x2 +
     (0.0826586807740864)) + (0.00081428356388169))) +
     (36.3220486736092) + x2*(x2*(x2*((-0.00720862103838031)*x2 +
     (-0.0264862744961215)) + (-0.30336257516708)) + (0.23922945375389))) +
     x2*(x2*(x2*(x2*((0.0132124973316544)*x2 +(0.0577060502424694)) +
     (0.129780738468536)) + (0.95682930429454)) + (34.3546579581206)));
    else
     if s<s_bubble then
      x1 := (log(p)-(14.2251890031606))/(0.499169296800688);
      y1 := (s-(1152.46506841802))/(179.299713840403);
      T1 := (0) + (1) * ((290.574168937952) + y1*(y1*(y1*(y1*(
       (-0.00192723964571896)*y1 + (-0.0124017661200968) +
       (0.00127247920370296)*x1) + (-0.0857625427384498) +
       x1*((0.00090717580273224)*x1 + (0.00799217399325639))) +
       (-0.040817223566116) + x1*(x1*((0.000459514035453056)*x1 +
       (0.00622225803519055)) + (0.0324083687227166))) + (19.8608752914032) +
       x1*(x1*(x1*((0.000243666235393007)*x1 + (0.0037715016370504)) +
       (0.0292848788419663)) + (0.130154107880201))) + x1*(x1*(x1*(x1*(
       (0.00011497599662102)*x1 +(0.00191602988674819)) + (0.0181671755438826))
       + (0.117871744016533)) + (0.490828546245446)));
      T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
        T1*(s_bubble - s)/ds;
     elseif s>s_dew then
      x2 := (log(p)-(12.3876547448383))/(0.961902709412239);
      y2 := (s-(2715.6535956075))/(207.473158311391);
      T2 := (0) + (1) * ((305.667994209752) + y2*(y2*(y2*(y2*(
      (-0.00049456983306658)*y2 + (0.0160903628800248) +
      (0.0036583657279175)*x2) + (-0.100508863694088) + x2*(
      (-0.00773556171071259)*x2 + (-0.00125351482775024))) +
      (0.702977715170277) + x2*(x2*((0.00736011556482272)*x2 +
      (0.0826586807740864)) + (0.00081428356388169))) +
      (36.3220486736092) + x2*(x2*(x2*((-0.00720862103838031)*x2 +
      (-0.0264862744961215)) + (-0.30336257516708)) + (0.23922945375389))) +
      x2*(x2*(x2*(x2*((0.0132124973316544)*x2 +(0.0577060502424694)) +
      (0.129780738468536)) + (0.95682930429454)) + (34.3546579581206)));
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
     x1 := (p-(382099.574228781))/(403596.556578661);
     y1 := (T-(307.564799259815))/(22.5879133275781);
     d := (0) + (1) * ((6.99012116216078) + y1*(y1*(y1*(y1*(
      (-2.13433530006928e-05)*y1 + (0.00116677386847406) +
      (0.00162333280148309)*x1) + (-0.00894774750115025) + x1*(
      (-0.0137994983041971)*x1 + (-0.021065201099773))) + (0.0644646531072409)
      + x1*(x1*((0.0269207717408464)*x1 + (0.0715858695051831)) +
      (0.113487112138254))) + (-0.618509525341628) + x1*(x1*(x1*(
      (-0.01655069884562)*x1 + (-0.0614336770277778)) + (-0.227438027200113))
      + (-0.827135398454184))) + x1*(x1*(x1*(x1*((0.00292620516208197)*x1 +
      (0.0141066470211284)) + (0.0745135118619033)) + (0.561456406237816)) +
      (7.85762798977443)));
    elseif p>sat.psat+dp then
     x2 := (p-(1682457.5126701))/(720642.233056887);
     y2 := (T-(290.645659315997))/(19.9347318052857);
     d := (0) + (1) * ((506.208387981876) + y2*(y2*(y2*(y2*(
      (-0.0227711391125435)*y2 + (-0.104815271970145) +
      (0.0141806356166424)*x2) + (-0.419234944193293) + x2*(
      (-0.00424731659901982)*x2 + (0.0699901864638379))) + (-2.21393734916457)
      + x2*(x2*((0.00117322708291575)*x2 + (-0.0156164603769147)) +
      (0.222243208624831))) + (-29.9062841232497) + x2*(x2*(x2*(
      (1.90380071619604e-06)*x2 + (0.00219916470789359)) +
      (-0.0298496253585084)) + (0.693501535440458))) + x2*(x2*(x2*(x2*(
      (1.34663813731525e-05)*x2 +(7.69903677841526e-06)) +
      (0.00126962771607607)) + (-0.0351624357762205)) + (1.8705425621798)));
    else
     if p<sat.psat then
      x1 := (p-(382099.574228781))/(403596.556578661);
      y1 := (T-(307.564799259815))/(22.5879133275781);
      d1 := (0) + (1) * ((6.99012116216078) + y1*(y1*(y1*(y1*(
       (-2.13433530006928e-05)*y1 + (0.00116677386847406) +
       (0.00162333280148309)*x1) + (-0.00894774750115025) + x1*(
       (-0.0137994983041971)*x1 + (-0.021065201099773))) + (0.0644646531072409)
       + x1*(x1*((0.0269207717408464)*x1 + (0.0715858695051831)) +
       (0.113487112138254))) + (-0.618509525341628) + x1*(x1*(x1*(
       (-0.01655069884562)*x1 + (-0.0614336770277778)) + (-0.227438027200113))
       + (-0.827135398454184))) + x1*(x1*(x1*(x1*((0.00292620516208197)*x1 +
       (0.0141066470211284)) + (0.0745135118619033)) + (0.561456406237816)) +
       (7.85762798977443)));
      d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
     elseif p>=sat.psat then
      x2 := (p-(1682457.5126701))/(720642.233056887);
      y2 := (T-(290.645659315997))/(19.9347318052857);
      d2 := (0) + (1) * ((506.208387981876) + y2*(y2*(y2*(y2*(
       (-0.0227711391125435)*y2 + (-0.104815271970145) +
       (0.0141806356166424)*x2) + (-0.419234944193293) + x2*(
       (-0.00424731659901982)*x2 + (0.0699901864638379))) + (-2.21393734916457)
       + x2*(x2*((0.00117322708291575)*x2 + (-0.0156164603769147)) +
       (0.222243208624831))) + (-29.9062841232497) + x2*(x2*(x2*(
       (1.90380071619604e-06)*x2 + (0.00219916470789359)) +
       (-0.0298496253585084)) + (0.693501535440458))) + x2*(x2*(x2*(x2*(
       (1.34663813731525e-05)*x2 +(7.69903677841526e-06)) +
       (0.00126962771607607)) + (-0.0351624357762205)) + (1.8705425621798)));
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

  protected
    Real tv[:] = {0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 2.0, 2.0,
                  2.0, 3.0, 4.0, 1.0, 2.0};
    Real dv[:] = {1.0, 2.0, 3.0, 13.0, 12.0, 16.0, 0.0, 18.0,
                  20.0, 13.0, 4.0, 0.0, 1.0};
    Real nv[:] = {-0.7548580e-1, 0.7607150, -0.1665680, 0.1627612e-5,
                  0.1443764e-4, -0.2759086e-6, -0.1032756, -0.2498159e-7,
                  0.4069891e-8, -0.1513434e-5, 0.2591327e-2, 0.5650076,
                  0.1207253};

    Real d_crit = MM/fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;

    ThermodynamicState dewState = setDewState(setSat_T(state.T));
    ThermodynamicState bubbleState = setBubbleState(setSat_T(state.T));
    Real dr;
    Real drL;
    Real drG;
    Real etaL;
    Real etaG;
    Real Hc = 17.1045;
    Real Tr = state.T/fluidConstants[1].criticalTemperature;

    SaturationProperties sat = setSat_T(state.T);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;
    Real quality;

  algorithm
    if state.phase==1 or phase_dT==1 then
      eta := 0;
      dr := state.d/d_crit;
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
      drG := dewState.d/d_crit;
      drL := bubbleState.d/d_crit;
      quality :=if state.phase == 2 then (bubbleState.d/state.d - 1)/(
      bubbleState.d/dewState.d - 1) else 1;
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

    Real d_crit = MM/fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;

    Real delta;
    Real deltaL;
    Real deltaG;
    Real tau = fluidConstants[1].criticalTemperature/state.T;

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
    Real quality;

  algorithm
    delta :=state.d/d_crit;
    if state.phase==1 or phase_dT==1 then
      for i in 1:5 loop
          lambdar := lambdar + (B1[i] + B2[i]/tau)*delta^i;
      end for;
      lambda := (lambda0 + lambdar + (C[1]/(C[2] + abs(1.0/tau - 1.0))*
        exp(-(C[3]*(delta - 1.0))^2)));
    elseif state.phase==2 or phase_dT==2 then
      deltaL :=bubbleDensity(setSat_T(state.T))/d_crit;
      deltaG :=dewDensity(setSat_T(state.T))/d_crit;
      quality :=if state.phase == 2 then (bubbleDensity(setSat_T(state.T))/
        state.d - 1)/(bubbleDensity(setSat_T(state.T))/dewDensity(setSat_T(
        state.T)) - 1) else 1;
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
  annotation (Documentation(revisions="<html><ul>
  <li>June 12, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides a refrigerant model for R290 using a hybrid
  approach developed by Sangi et al.. The hybrid approach is
  implemented in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a>
  and the refrigerant model is implemented by complete the template
  <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  .
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The implemented coefficients are fitted to external data by Sangi et
  al. and are valid within the following range:<br/>
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
        0.5
      </p>
    </td>
    <td>
      <p>
        30
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
        263.15
      </p>
    </td>
    <td>
      <p>
        343.15
      </p>
    </td>
  </tr>
</table>
<h4>
  Validation
</h4>
<p>
  Sangi et al. validated their model by comparing it to results
  obtained from the Helmholtz equation of state. They found out that
  relative error of the refrigerant model compared to HelmholtzMedia
  (Thorade and Saadat, 2012) is close to zero.
</p>
<h4>
  References
</h4>
<p>
  Thorade, Matthis; Saadat, Ali (2012): <a href=
  \"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A
  fluid properties library</a>. In: <i>Proceedings of the 9th
  International Modelica Conference</i>; September 3-5; 2012; Munich;
  Germany. Linköping University Electronic Press, S. 63–70.
</p>
<p>
  Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
  Müller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A
  Medium Model for the Refrigerant Propane for Fast and Accurate
  Dynamic Simulations</a>. In: <i>The 10th International Modelica
  Conference</i>. Lund, Sweden, March 10-12, 2014: Linköping University
  Electronic Press (Linköping Electronic Conference Proceedings), S.
  1271–1275
</p>
<p>
  Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat
  Pumps - Modeling, Simulation and Exergy Analysis. <i>Master
  thesis</i>
</p>
<p>
  Scalabrin, G.; Marchi, P.; Span, R. (2006): A Reference
  Multiparameter Viscosity Equation for Propane with an Optimized
  Functional Form. In: <i>J. Phys. Chem. Ref. Data, Vol. 35, No. 3</i>,
  S. 1415-1442
</p>
</html>"));
end R290_IIR_P05_30_T263_343_Horner;
