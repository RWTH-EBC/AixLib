within AixLib.Media.Refrigerants.R134a;
package R134a_IIR_P1_395_T233_370_Formula
  "Refrigerant model for R134a using a hybrid approach with explicit formulas"

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
     each criticalPressure = 4059280,
     each criticalMolarVolume = 0.102032/511.899952,
     each triplePointTemperature = 169.85,
     each triplePointPressure = 389.563789,
     each normalBoilingPoint = 247.076,
     each meltingPoint = 172.15,
     each acentricFactor = 0.32684,
     each dipoleMoment = 1.99,
     each hasCriticalData=true) "Thermodynamic constants for R134a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R134a",
    substanceNames={"R134a"},
    singleState=false,
    SpecificEnthalpy(
      start=2.0e5,
      nominal=2.0e5,
      min=151000,
      max=492700),
    Density(
      start=500,
      nominal=350,
      min=3.5,
      max=1425),
    AbsolutePressure(
      start=2.4541e5,
      nominal=5e5,
      min=1e5,
      max=39.5e5),
    Temperature(
      start=268.37,
      nominal=333.15,
      min=243.15,
      max=367.15),
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
      Real d_ps(unit="J/(Pa.K.kg)") =  25/(39.5e5-1e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5-1e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  algorithm
    f_Idg := log(delta) + (-1.629789) * log(tau^(1)) + (-1.02084672674949) *
      tau^(0) + (9.04757355104757) * tau^(1) + (-9.723916) * tau^(-0.5) +
      (-3.92717) * tau^(-0.75);
  end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    f_Res := (0.05586817) * delta^(2) * tau^(-0.5) + (0.498223) *
      delta^(1) * tau^(0) + (0.02458698) * delta^(3) * tau^(0) +
      (0.0008570145) * delta^(6) * tau^(0) + (0.0004788584) * delta^(6) *
      tau^(1.5) + (-1.800808) * delta^(1) * tau^(1.5) + (0.2671641) *
      delta^(1) * tau^(2) + (-0.04781652) * delta^(2) * tau^(2) + (0.01423987)
      * delta^(5) * tau^(1) * exp(-delta^(1)) + (0.3324062) * delta^(2) *
      tau^(3) * exp(-delta^(1)) + (-0.007485907) * delta^(2) * tau^(5) *
      exp(-delta^(1)) + (0.0001017263) * delta^(4) * tau^(1) * exp(-delta^(2))
      + (-0.5184567) * delta^(1) * tau^(5) * exp(-delta^(2)) + (-0.08692288)
      * delta^(4) * tau^(5) * exp(-delta^(2)) + (0.2057144) * delta^(1)
      * tau^(6) * exp(-delta^(2)) + (-0.005000457) * delta^(2) * tau^(10)
      * exp(-delta^(2)) + (0.0004603262) * delta^(4) * tau^(10) *
      exp(-delta^(2)) + (-0.003497836) * delta^(1) * tau^(10) *
      exp(-delta^(3)) + (0.006995038) * delta^(5) * tau^(18) * exp(-delta^(3))
      + (-0.01452184) * delta^(3) * tau^(22) * exp(-delta^(3)) +
      (-0.0001285458) * delta^(10) * tau^(50) * exp(-delta^(4));
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
  algorithm
    t_fIdg_t := (-1.629789)*(1) + (-1.02084672674949)*(0)*tau^(0)
      + (9.04757355104757)*(1)*tau^(1) + (-9.723916)*(-0.5)*tau^(-0.5) +
      (-3.92717)*(-0.75)*tau^(-0.75);
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
  algorithm
    tt_fIdg_tt := -(-1.629789)*(1) + (-1.02084672674949)*(0)*
      ((0)-1)*tau^(0) + (9.04757355104757)*(1)*((1)-1)*tau^(1) + (-9.723916)*
      (-0.5)*((-0.5)-1)*tau^(-0.5) + (-3.92717)*(-0.75)*((-0.75)-1)*
      tau^(-0.75);
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
  algorithm
    t_fRes_t := (0.05586817)*(-0.5)*delta^(2)*tau^(-0.5) +
      (0.498223)*(0)*delta^(1)*tau^(0) + (0.02458698)*(0)*delta^(3)*tau^(0) +
      (0.0008570145)*(0)*delta^(6)*tau^(0) + (0.0004788584)*(1.5)*delta^(6)*
      tau^(1.5) + (-1.800808)*(1.5)*delta^(1)*tau^(1.5) + (0.2671641)*(2)*
      delta^(1)*tau^(2) + (-0.04781652)*(2)*delta^(2)*tau^(2) + (0.01423987)*
      (1)*delta^(5)*tau^(1)*exp(-delta^(1)) + (0.3324062)*(3)*delta^(2)*
      tau^(3)*exp(-delta^(1)) + (-0.007485907)*(5)*delta^(2)*tau^(5)*
      exp(-delta^(1)) + (0.0001017263)*(1)*delta^(4)*tau^(1)*exp(-delta^(2)) +
      (-0.5184567)*(5)*delta^(1)*tau^(5)*exp(-delta^(2)) + (-0.08692288)*(5)*
      delta^(4)*tau^(5)*exp(-delta^(2)) + (0.2057144)*(6)*delta^(1)*tau^(6)*
      exp(-delta^(2)) + (-0.005000457)*(10)*delta^(2)*tau^(10)*exp(-delta^(2))
      + (0.0004603262)*(10)*delta^(4)*tau^(10)*exp(-delta^(2)) +
      (-0.003497836)*(10)*delta^(1)*tau^(10)*exp(-delta^(3)) +
      (0.006995038)*(18)*delta^(5)*tau^(18)*exp(-delta^(3)) +
      (-0.01452184)*(22)*delta^(3)*tau^(22)*exp(-delta^(3)) +
      (-0.0001285458)*(50)*delta^(10)*tau^(50)*exp(-delta^(4));
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
  algorithm
    tt_fRes_tt := (0.05586817)*(-0.5)*((-0.5)-1)*delta^(2)*
      tau^(-0.5) + (0.498223)*(0)*((0)-1)*delta^(1)*tau^(0) + (0.02458698)*
      (0)*((0)-1)*delta^(3)*tau^(0) + (0.0008570145)*(0)*((0)-1)*delta^(6)*
      tau^(0) + (0.0004788584)*(1.5)*((1.5)-1)*delta^(6)*tau^(1.5) +
      (-1.800808)*(1.5)*((1.5)-1)*delta^(1)*tau^(1.5) + (0.2671641)*(2)*
      ((2)-1)*delta^(1)*tau^(2) + (-0.04781652)*(2)*((2)-1)*delta^(2)*
      tau^(2) + (0.01423987)*(1)*((1)-1)*delta^(5)*tau^(1)*exp(-delta^(1)) +
      (0.3324062)*(3)*((3)-1)*delta^(2)*tau^(3)*exp(-delta^(1)) +
      (-0.007485907)*(5)*((5)-1)*delta^(2)*tau^(5)*exp(-delta^(1)) +
      (0.0001017263)*(1)*((1)-1)*delta^(4)*tau^(1)*exp(-delta^(2)) +
      (-0.5184567)*(5)*((5)-1)*delta^(1)*tau^(5)*exp(-delta^(2)) +
      (-0.08692288)*(5)*((5)-1)*delta^(4)*tau^(5)*exp(-delta^(2)) +
      (0.2057144)*(6)*((6)-1)*delta^(1)*tau^(6)*exp(-delta^(2)) +
      (-0.005000457)*(10)*((10)-1)*delta^(2)*tau^(10)*exp(-delta^(2)) +
      (0.0004603262)*(10)*((10)-1)*delta^(4)*tau^(10)*exp(-delta^(2)) +
      (-0.003497836)*(10)*((10)-1)*delta^(1)*tau^(10)*exp(-delta^(3)) +
      (0.006995038)*(18)*((18)-1)*delta^(5)*tau^(18)*exp(-delta^(3)) +
      (-0.01452184)*(22)*((22)-1)*delta^(3)*tau^(22)*exp(-delta^(3)) +
      (-0.0001285458)*(50)*((50)-1)*delta^(10)*tau^(50)*exp(-delta^(4));
  end tt_fRes_tt;

  redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
  algorithm
    d_fRes_d := (0.05586817)*(2)*delta^(2)*tau^(-0.5) +
      (0.498223)*(1)*delta^(1)*tau^(0) + (0.02458698)*(3)*delta^(3)*tau^(0) +
      (0.0008570145)*(6)*delta^(6)*tau^(0) + (0.0004788584)*(6)*delta^(6)*
      tau^(1.5) + (-1.800808)*(1)*delta^(1)*tau^(1.5) + (0.2671641)*(1)*
      delta^(1)*tau^(2) + (-0.04781652)*(2)*delta^(2)*tau^(2) + (0.01423987)*
      delta^(5)*tau^(1)*((5)-(1)*delta^(1))*exp(-delta^(1)) + (0.3324062)*
      delta^(2)*tau^(3)*((2)-(1)*delta^(1))*exp(-delta^(1)) + (-0.007485907)*
      delta^(2)*tau^(5)*((2)-(1)*delta^(1))*exp(-delta^(1)) + (0.0001017263)*
      delta^(4)*tau^(1)*((4)-(2)*delta^(2))*exp(-delta^(2)) + (-0.5184567)*
      delta^(1)*tau^(5)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.08692288)*
      delta^(4)*tau^(5)*((4)-(2)*delta^(2))*exp(-delta^(2)) + (0.2057144)*
      delta^(1)*tau^(6)*((1)-(2)*delta^(2))*exp(-delta^(2)) + (-0.005000457)*
      delta^(2)*tau^(10)*((2)-(2)*delta^(2))*exp(-delta^(2)) + (0.0004603262)*
      delta^(4)*tau^(10)*((4)-(2)*delta^(2))*exp(-delta^(2)) + (-0.003497836)*
      delta^(1)*tau^(10)*((1)-(3)*delta^(3))*exp(-delta^(3)) + (0.006995038)*
      delta^(5)*tau^(18)*((5)-(3)*delta^(3))*exp(-delta^(3)) + (-0.01452184)*
      delta^(3)*tau^(22)*((3)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0001285458)*
      delta^(10)*tau^(50)*((10)-(4)*delta^(4))*exp(-delta^(4));
  end d_fRes_d;

  redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
  algorithm
    dd_fRes_dd := (0.05586817)*(2)*((2)-1)*delta^(2)*
      tau^(-0.5) + (0.498223)*(1)*((1)-1)*delta^(1)*tau^(0) + (0.02458698)*
      (3)*((3)-1)*delta^(3)*tau^(0) + (0.0008570145)*(6)*((6)-1)*delta^(6)*
      tau^(0) + (0.0004788584)*(6)*((6)-1)*delta^(6)*tau^(1.5) + (-1.800808)*
      (1)*((1)-1)*delta^(1)*tau^(1.5) + (0.2671641)*(1)*((1)-1)*delta^(1)*
      tau^(2) + (-0.04781652)*(2)*((2)-1)*delta^(2)*tau^(2) + (0.01423987)*
      delta^(5)*tau^(1)*(((5)-(1)*delta^(1))*((5)-1-(1)*delta^(1))-(1)^2*
      delta^(1))*exp(-delta^(1)) + (0.3324062)*delta^(2)*tau^(3)*(((2)-(1)*
      delta^(1))*((2)-1-(1)*delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) +
      (-0.007485907)*delta^(2)*tau^(5)*(((2)-(1)*delta^(1))*((2)-1-(1)*
      delta^(1))-(1)^2*delta^(1))*exp(-delta^(1)) + (0.0001017263)*delta^(4)*
      tau^(1)*(((4)-(2)*delta^(2))*((4)-1-(2)*delta^(2))-(2)^2*delta^(2))*
      exp(-delta^(2)) + (-0.5184567)*delta^(1)*tau^(5)*(((1)-(2)*delta^(2))*
      ((1)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (-0.08692288)*
      delta^(4)*tau^(5)*(((4)-(2)*delta^(2))*((4)-1-(2)*delta^(2))-(2)^2*
      delta^(2))*exp(-delta^(2)) + (0.2057144)*delta^(1)*tau^(6)*(((1)-(2)*
      delta^(2))*((1)-1-(2)*delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) +
      (-0.005000457)*delta^(2)*tau^(10)*(((2)-(2)*delta^(2))*((2)-1-(2)*
      delta^(2))-(2)^2*delta^(2))*exp(-delta^(2)) + (0.0004603262)*delta^(4)*
      tau^(10)*(((4)-(2)*delta^(2))*((4)-1-(2)*delta^(2))-(2)^2*delta^(2))*
      exp(-delta^(2)) + (-0.003497836)*delta^(1)*tau^(10)*(((1)-(3)*delta^(3))*
      ((1)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) + (0.006995038)*
      delta^(5)*tau^(18)*(((5)-(3)*delta^(3))*((5)-1-(3)*delta^(3))-(3)^2*
      delta^(3))*exp(-delta^(3)) + (-0.01452184)*delta^(3)*tau^(22)*(((3)-
      (3)*delta^(3))*((3)-1-(3)*delta^(3))-(3)^2*delta^(3))*exp(-delta^(3)) +
      (-0.0001285458)*delta^(10)*tau^(50)*(((10)-(4)*delta^(4))*((10)-1-(4)*
      delta^(4))-(4)^2*delta^(4))*exp(-delta^(4));
  end dd_fRes_dd;

  redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  algorithm
    td_fRes_td := (0.05586817)*(2)*(-0.5)*delta^(2)*
      tau^(-0.5) + (0.498223)*(1)*(0)*delta^(1)*tau^(0) + (0.02458698)*(3)*(0)
      *delta^(3)*tau^(0) + (0.0008570145)*(6)*(0)*delta^(6)*tau^(0) +
      (0.0004788584)*(6)*(1.5)*delta^(6)*tau^(1.5) + (-1.800808)*(1)*(1.5)*
      delta^(1)*tau^(1.5) + (0.2671641)*(1)*(2)*delta^(1)*tau^(2) +
      (-0.04781652)*(2)*(2)*delta^(2)*tau^(2) + (0.01423987)*(1)*delta^(5)*
      tau^(1)*((5)-(1)*delta^(1))*exp(-delta^(1)) + (0.3324062)*(3)*delta^(2)*
      tau^(3)*((2)-(1)*delta^(1))*exp(-delta^(1)) + (-0.007485907)*(5)*
      delta^(2)*tau^(5)*((2)-(1)*delta^(1))*exp(-delta^(1)) + (0.0001017263)*
      (1)*delta^(4)*tau^(1)*((4)-(2)*delta^(2))*exp(-delta^(2)) +
      (-0.5184567)*(5)*delta^(1)*tau^(5)*((1)-(2)*delta^(2))*exp(-delta^(2)) +
      (-0.08692288)*(5)*delta^(4)*tau^(5)*((4)-(2)*delta^(2))*exp(-delta^(2))
      + (0.2057144)*(6)*delta^(1)*tau^(6)*((1)-(2)*delta^(2))*exp(-delta^(2))
      + (-0.005000457)*(10)*delta^(2)*tau^(10)*((2)-(2)*delta^(2))*
      exp(-delta^(2)) + (0.0004603262)*(10)*delta^(4)*tau^(10)*((4)-(2)*
      delta^(2))*exp(-delta^(2)) + (-0.003497836)*(10)*delta^(1)*tau^(10)*
      ((1)-(3)*delta^(3))*exp(-delta^(3)) + (0.006995038)*(18)*delta^(5)*
      tau^(18)*((5)-(3)*delta^(3))*exp(-delta^(3)) + (-0.01452184)*(22)*
      delta^(3)*tau^(22)*((3)-(3)*delta^(3))*exp(-delta^(3)) + (-0.0001285458)
      *(50)*delta^(10)*tau^(50)*((10)-(4)*delta^(4))*exp(-delta^(4));
  end td_fRes_td;

  redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fIdg_ttt := 2*(-1.629789)*(1) + (-1.02084672674949)*(0)*
      ((0)-1)*((0)-2) *tau^(0) + (9.04757355104757)*(1)*((1)-1)*((1)-2) *
      tau^(1) + (-9.723916)*(-0.5)*((-0.5)-1)*((-0.5)-2) *tau^(-0.5) +
      (-3.92717)*(-0.75)*((-0.75)-1)*((-0.75)-2) *tau^(-0.75);
  end ttt_fIdg_ttt;

  redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
  algorithm
    ttt_fRes_ttt := (0.05586817)*(-0.5)*((-0.5)-1)*((-0.5)-2)*
      delta^(2)*tau^(-0.5) + (0.498223)*(0)*((0)-1)*((0)-2)*delta^(1)*tau^(0)
      + (0.02458698)*(0)*((0)-1)*((0)-2)*delta^(3)*tau^(0) + (0.0008570145)*
      (0)*((0)-1)*((0)-2)*delta^(6)*tau^(0) + (0.0004788584)*(1.5)*((1.5)-1)*
      ((1.5)-2)*delta^(6)*tau^(1.5) + (-1.800808)*(1.5)*((1.5)-1)*((1.5)-2)*
      delta^(1)*tau^(1.5) + (0.2671641)*(2)*((2)-1)*((2)-2)*delta^(1)*tau^(2)
      + (-0.04781652)*(2)*((2)-1)*((2)-2)*delta^(2)*tau^(2) + (0.01423987)*
      (1)*((1)-1)*((1)-2)*delta^(5)*tau^(1)*exp(-delta^(1)) + (0.3324062)*
      (3)*((3)-1)*((3)-2)*delta^(2)*tau^(3)*exp(-delta^(1)) + (-0.007485907)*
      (5)*((5)-1)*((5)-2)*delta^(2)*tau^(5)*exp(-delta^(1)) + (0.0001017263)*
      (1)*((1)-1)*((1)-2)*delta^(4)*tau^(1)*exp(-delta^(2)) + (-0.5184567)*
      (5)*((5)-1)*((5)-2)*delta^(1)*tau^(5)*exp(-delta^(2)) + (-0.08692288)*
      (5)*((5)-1)*((5)-2)*delta^(4)*tau^(5)*exp(-delta^(2)) + (0.2057144)*
      (6)*((6)-1)*((6)-2)*delta^(1)*tau^(6)*exp(-delta^(2)) + (-0.005000457)*
      (10)*((10)-1)*((10)-2)*delta^(2)*tau^(10)*exp(-delta^(2)) +
      (0.0004603262)*(10)*((10)-1)*((10)-2)*delta^(4)*tau^(10)*exp(-delta^(2))
      +(-0.003497836)*(10)*((10)-1)*((10)-2)*delta^(1)*tau^(10)*exp(-delta^(3))
      + (0.006995038)*(18)*((18)-1)*((18)-2)*delta^(5)*tau^(18)*exp(-delta^(3))
      + (-0.01452184)*(22)*((22)-1)*((22)-2)*delta^(3)*tau^(22)*exp(-delta^(3))
      + (-0.0001285458)*(50)*((50)-1)*((50)-2)*delta^(10)*tau^(50)*
      exp(-delta^(4));
  end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd
    "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
  algorithm
    ddd_fRes_ddd := (0.05586817)*(2)*((2)-1)*((2)-2)*delta^(2)*
      tau^(-0.5) + (0.498223)*(1)*((1)-1)*((1)-2)*delta^(1)*tau^(0) +
      (0.02458698)*(3)*((3)-1)*((3)-2)*delta^(3)*tau^(0) + (0.0008570145)*
      (6)*((6)-1)*((6)-2)*delta^(6)*tau^(0) + (0.0004788584)*(6)*((6)-1)*
      ((6)-2)*delta^(6)*tau^(1.5) + (-1.800808)*(1)*((1)-1)*((1)-2)*delta^(1)*
      tau^(1.5) + (0.2671641)*(1)*((1)-1)*((1)-2)*delta^(1)*tau^(2) +
      (-0.04781652)*(2)*((2)-1)*((2)-2)*delta^(2)*tau^(2) - (0.01423987)*
      delta^(5)*tau^(1)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1)-3)-3*(5)+3)+(1)+3*(5)-3)+3*(5)^2-6*(5)+2)-((5)-2)*((5)-1)*
      (5)) - (0.3324062)*delta^(2)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*
      ((1)*(delta^(1)*((1)*(delta^(1)-3)-3*(2)+3)+(1)+3*(2)-3)+3*(2)^2-6*
      (2)+2)-((2)-2)*((2)-1)*(2)) - (-0.007485907)*delta^(2)*tau^(5)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1)-3)-3*
      (2)+3)+(1)+3*(2)-3)+3*(2)^2-6*(2)+2)-((2)-2)*((2)-1)*(2)) -
      (0.0001017263)*delta^(4)*tau^(1)*exp(-delta^(2))*((2)*delta^(2)*((2)*
      (delta^(2)*((2)*(delta^(2)-3)-3*(4)+3)+(2)+3*(4)-3)+3*(4)^2-6*(4)+2)-
      ((4)-2)*((4)-1)*(4)) - (-0.5184567)*delta^(1)*tau^(5)*exp(-delta^(2))*
      ((2)*delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(1)+3)+(2)+3*(1)-3)+
      3*(1)^2-6*(1)+2)-((1)-2)*((1)-1)*(1)) - (-0.08692288)*delta^(4)*tau^(5)*
      exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(4)+
      3)+(2)+3*(4)-3)+3*(4)^2-6*(4)+2)-((4)-2)*((4)-1)*(4)) - (0.2057144)*
      delta^(1)*tau^(6)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*
      (delta^(2)-3)-3*(1)+3)+(2)+3*(1)-3)+3*(1)^2-6*(1)+2)-((1)-2)*((1)-1)*
      (1)) - (-0.005000457)*delta^(2)*tau^(10)*exp(-delta^(2))*((2)*delta^(2)*
      ((2)*(delta^(2)*((2)*(delta^(2)-3)-3*(2)+3)+(2)+3*(2)-3)+3*(2)^2-6*(2)+
      2)-((2)-2)*((2)-1)*(2)) - (0.0004603262)*delta^(4)*tau^(10)*
      exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*(delta^(2)-3)-
      3*(4)+3)+(2)+3*(4)-3)+3*(4)^2-6*(4)+2)-((4)-2)*((4)-1)*(4)) -
      (-0.003497836)*delta^(1)*tau^(10)*exp(-delta^(3))*((3)*delta^(3)*((3)*
      (delta^(3)*((3)*(delta^(3)-3)-3*(1)+3)+(3)+3*(1)-3)+3*(1)^2-6*(1)+2)-
      ((1)-2)*((1)-1)*(1)) - (0.006995038)*delta^(5)*tau^(18)*exp(-delta^(3))*
      ((3)*delta^(3)*((3)*(delta^(3)*((3)*(delta^(3)-3)-3*(5)+3)+(3)+3*(5)-3)+
      3*(5)^2-6*(5)+2)-((5)-2)*((5)-1)*(5)) - (-0.01452184)*delta^(3)*
      tau^(22)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)*((3)*
      (delta^(3)-3)-3*(3)+3)+(3)+3*(3)-3)+3*(3)^2-6*(3)+2)-((3)-2)*((3)-1)*
      (3)) - (-0.0001285458)*delta^(10)*tau^(50)*exp(-delta^(4))*((4)*
      delta^(4)*((4)*(delta^(4)*((4)*(delta^(4)-3)-3*(10)+3)+(4)+3*(10)-3)+3*
      (10)^2-6*(10)+2)-((10)-2)*((10)-1)*(10));
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  algorithm
    tdd_fRes_tdd := (0.05586817)*(2)*(-0.5)*(2-1)*
      delta^(2)*tau^(-0.5) + (0.498223)*(1)*(0)*(1-1)*delta^(1)*tau^(0) +
      (0.02458698)*(3)*(0)*(3-1)*delta^(3)*tau^(0) + (0.0008570145)*(6)*(0)*
      (6-1)*delta^(6)*tau^(0) + (0.0004788584)*(6)*(1.5)*(6-1)*delta^(6)*
      tau^(1.5) + (-1.800808)*(1)*(1.5)*(1-1)*delta^(1)*tau^(1.5) +
      (0.2671641)*(1)*(2)*(1-1)*delta^(1)*tau^(2) + (-0.04781652)*(2)*(2)*
      (2-1)*delta^(2)*tau^(2) + (0.01423987)*(1)*delta^(5)*tau^(1)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(5)+1)+(5)*((5)-1))
      + (0.3324062)*(3)*delta^(2)*tau^(3)*exp(-delta^(1))*((1)*delta^(1)*
      ((1)*(delta^(1)-1)-2*(2)+1)+(2)*((2)-1)) + (-0.007485907)*(5)*delta^(2)*
      tau^(5)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)-1)-2*(2)+1)+(2)*
      ((2)-1)) + (0.0001017263)*(1)*delta^(4)*tau^(1)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)-1)-2*(4)+1)+(4)*((4)-1)) + (-0.5184567)*(5)*
      delta^(1)*tau^(5)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)-1)-2*
      (1)+1)+(1)*((1)-1)) + (-0.08692288)*(5)*delta^(4)*tau^(5)*
      exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)-1)-2*(4)+1)+(4)*((4)-1))
      + (0.2057144)*(6)*delta^(1)*tau^(6)*exp(-delta^(2))*((2)*delta^(2)*((2)*
      (delta^(2)-1)-2*(1)+1)+(1)*((1)-1)) + (-0.005000457)*(10)*delta^(2)*
      tau^(10)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)-1)-2*(2)+1)+(2)*
      ((2)-1)) + (0.0004603262)*(10)*delta^(4)*tau^(10)*exp(-delta^(2))*((2)*
      delta^(2)*((2)*(delta^(2)-1)-2*(4)+1)+(4)*((4)-1)) + (-0.003497836)*
      (10)*delta^(1)*tau^(10)*exp(-delta^(3))*((3)*delta^(3)*((3)*
      (delta^(3)-1)-2*(1)+1)+(1)*((1)-1)) + (0.006995038)*(18)*delta^(5)*
      tau^(18)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3)-1)-2*(5)+1)+(5)*
      ((5)-1)) + (-0.01452184)*(22)*delta^(3)*tau^(22)*exp(-delta^(3))*
      ((3)*delta^(3)*((3)*(delta^(3)-1)-2*(3)+1)+(3)*((3)-1)) +
      (-0.0001285458)*(50)*delta^(10)*tau^(50)*exp(-delta^(4))*((4)*delta^(4)*
      ((4)*(delta^(4)-1)-2*(10)+1)+(10)*((10)-1));
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  algorithm
    ttd_fRes_ttd := (0.05586817)*(2)*(-0.5)*(-0.5-1)*
      delta^(2)*tau^(-0.5) + (0.498223)*(1)*(0)*(0-1)*delta^(1)*tau^(0) +
      (0.02458698)*(3)*(0)*(0-1)*delta^(3)*tau^(0) + (0.0008570145)*(6)*(0)*
      (0-1)*delta^(6)*tau^(0) + (0.0004788584)*(6)*(1.5)*(1.5-1)*delta^(6)*
      tau^(1.5) + (-1.800808)*(1)*(1.5)*(1.5-1)*delta^(1)*tau^(1.5) +
      (0.2671641)*(1)*(2)*(2-1)*delta^(1)*tau^(2) + (-0.04781652)*(2)*(2)*
      (2-1)*delta^(2)*tau^(2) + (0.01423987)*(1)*((1)-1)*delta^(5)*tau^(1)*
      exp(-delta^(1))*((5)-(1)*delta^(1)) + (0.3324062)*(3)*((3)-1)*delta^(2)*
      tau^(3)*exp(-delta^(1))*((2)-(1)*delta^(1)) + (-0.007485907)*(5)*((5)-1)*
      delta^(2)*tau^(5)*exp(-delta^(1))*((2)-(1)*delta^(1)) + (0.0001017263)*
      (1)*((1)-1)*delta^(4)*tau^(1)*exp(-delta^(2))*((4)-(2)*delta^(2)) +
      (-0.5184567)*(5)*((5)-1)*delta^(1)*tau^(5)*exp(-delta^(2))*((1)-(2)*
      delta^(2)) + (-0.08692288)*(5)*((5)-1)*delta^(4)*tau^(5)*exp(-delta^(2))*
      ((4)-(2)*delta^(2)) + (0.2057144)*(6)*((6)-1)*delta^(1)*tau^(6)*
      exp(-delta^(2))*((1)-(2)*delta^(2)) + (-0.005000457)*(10)*((10)-1)*
      delta^(2)*tau^(10)*exp(-delta^(2))*((2)-(2)*delta^(2)) + (0.0004603262)*
      (10)*((10)-1)*delta^(4)*tau^(10)*exp(-delta^(2))*((4)-(2)*delta^(2)) +
      (-0.003497836)*(10)*((10)-1)*delta^(1)*tau^(10)*exp(-delta^(3))*((1)-(3)*
      delta^(3)) + (0.006995038)*(18)*((18)-1)*delta^(5)*tau^(18)*
      exp(-delta^(3))*((5)-(3)*delta^(3)) + (-0.01452184)*(22)*((22)-1)*
      delta^(3)*tau^(22)*exp(-delta^(3))*((3)-(3)*delta^(3)) + (-0.0001285458)*
      (50)*((50)-1)*delta^(10)*tau^(50)*exp(-delta^(4))*((10)-(4)*delta^(4));
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
      p := 1.007*fluidConstants[1].criticalPressure *
        exp((fluidConstants[1].criticalTemperature/T) * ((-5.29535582243675)*
        OM^(0.927890501793078) + (-5.15024230998653)*OM^(0.927889861253321) +
        (-3.13553371894143)*OM^(3.24457658937591) + (3.81009392578704)*
        OM^(0.866053953377016) + (-10.0339381768489)*OM^(7.91909121618172)));
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
    x := (p - (1173800.40711465))/(1099321.32004152);
    T := (0) + (1) * (((318.322815465239) + (36.1617450994282)*x^1 +
      (-12.7560329244594)*x^2 + (7.26052113404336)*x^3 + (-2.89915392364256)*
      x^4 + (-4.89010119898524)*x^5 + (-20.8432510011223)*x^6 +
      (95.5617640252349)*x^7 + (83.7642169620632)*x^8 + (-591.55848346164)*
      x^9 + (-55.2137430573454)*x^10 + (2199.05007804956)*x^11 +
      (-1053.97842181797)*x^12 + (-4812.32805012381)*x^13 + (4762.95378316372)*
      x^14 + (5640.99015202781)*x^15 + (-9868.33934727912)*x^16 +
      (-1564.02920810349)*x^17 + (10945.3908704179)*x^18 + (-4453.93622361223)*
      x^19 + (-5643.63993911996)*x^20 + (5736.13316518914)*x^21 +
      (-153.61878036749)*x^22 + (-2373.87104764859)*x^23 + (1354.35656921788)*
      x^24 + (-66.889680648556)*x^25 + (-292.332077985936)*x^26 +
      (192.835068220202)*x^27 + (-67.2418238751773)*x^28 + (12.0552196723002)*
      x^29 + (-0.56578842983819)*x^30 + (0.350873407219832)*x^31 +
      (-0.203868199876426)*x^32 + (-0.0221624492210123)*x^33 +
      (0.0285800338394785)*x^34 + (-0.0224369802824247)*x^35 +
      (0.0132879323848205)*x^36 + (0.00144605394607974)*x^37 +
      (-0.00387216171551954)*x^38 + (0.000812655495029447)*x^39 +
      (0.000263544471499524)*x^40 + (-8.8004505404823e-05)*x^41 +
      (-2.34880154091625e-05)*x^42 + (1.45676923487723e-05)*x^43 +
      (-2.51410678214919e-06)*x^44 + (1.54078824620738e-07)*x^45));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (3.031500000000000e02))./(40.457817538765020);
    dl := (0) + (1) * (((1196.56605282943) + (-159.727367002064)*x^1 +
      (-23.3610969355503)*x^2 + (-7.63593969610268)*x^3 + (-1.69200599769564)*
      x^4 + (-6.45648421752394)*x^5 + (-25.0453395096642)*x^6 +
      (84.2002201352372)*x^7 + (305.562374521598)*x^8 + (-754.303131177625)*
      x^9 + (-2313.40684857554)*x^10 + (4294.75635803336)*x^11 +
      (11627.7646496055)*x^12 + (-16664.3675714077)*x^13 +
      (-41045.0235439939)*x^14 + (46017.3538315087)*x^15 +
      (105653.494874395)*x^16 + (-92974.0053711724)*x^17 +
      (-203413.444060992)*x^18 + (139542.906755691)*x^19 +
      (297641.54611928)*x^20 + (-155973.130039214)*x^21 +
      (-333529.603869706)*x^22 + (127830.260345799)*x^23 +
      (285747.546166906)*x^24 + (-72757.9476832706)*x^25 +
      (-184363.294029955)*x^26 + (23570.9797554869)*x^27 +
      (85905.3178848696)*x^28 + (1308.41019778136)*x^29 +
      (-25581.0559142409)*x^30 + (-5996.13044335048)*x^31 +
      (2353.3594353821)*x^32 + (3146.45218750924)*x^33 +
      (1761.84707403932)*x^34 + (-610.226996198121)*x^35 +
      (-859.48468801174)*x^36 + (-181.683550900637)*x^37 +
      (100.352770722198)*x^38 + (171.535249548539)*x^39 +
      (56.8020521069703)*x^40 + (-61.8153512769025)*x^41 +
      (-31.7450644002113)*x^42 + (13.4009909278429)*x^43 +
      (7.97544046479868)*x^44 + (-1.82395288996062)*x^45 +
      (-1.16726237424692)*x^46 + (0.144857990589315)*x^47 +
      (0.0965814503072823)*x^48 + (-0.0051580379775832)*x^49 +
      (-0.00352419814120293)*x^50));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.Tsat - (3.031500000000000e02))./(40.457817538765020);
    dv := (0) + (1) * (((37.7920259477397) + (44.9601731987046)*x^1 +
      (22.8841379731046)*x^2 + (7.45650506262154)*x^3 +
      (1.54774937069529)*x^4 + (6.71078750827968)*x^5 +
      (26.0367018503651)*x^6 + (-87.4191158401829)*x^7 +
      (-317.322783612849)*x^8 + (783.202988492362)*x^9 +
      (2402.29470924636)*x^10 + (-4459.21050037244)*x^11 +
      (-12073.8168754595)*x^12 + (17301.75826985)*x^13 +
      (42616.5117812756)*x^14 + (-47774.8025384588)*x^15 +
      (-109689.578460464)*x^16 + (96517.4282752838)*x^17 +
      (211163.498509716)*x^18 + (-144845.545577487)*x^19 +
      (-308945.463671975)*x^20 + (161873.719238785)*x^21 +
      (346146.181681826)*x^22 + (-132629.575901049)*x^23 +
      (-296500.979192201)*x^24 + (75446.4637710722)*x^25 +
      (191251.949508916)*x^26 + (-24396.147383262)*x^27 +
      (-89079.8043571255)*x^28 + (-1406.59981060971)*x^29 +
      (26505.848889568)*x^30 + (6249.17042512684)*x^31 +
      (-2428.03282530501)*x^32 + (-3275.90468897169)*x^33 +
      (-1828.93235899714)*x^34 + (636.298667648207)*x^35 +
      (889.436057503728)*x^36 + (187.987443782542)*x^37 +
      (-102.486577824078)*x^38 + (-177.972153492235)*x^39 +
      (-59.5651148209404)*x^40 + (64.1589511321415)*x^41 +
      (33.0986104378207)*x^42 + (-13.9104041772412)*x^43 +
      (-8.30322148217756)*x^44 + (1.8933138763485)*x^45 +
      (1.21437618965309)*x^46 + (-0.150363600886821)*x^47 +
      (-0.100436390057465)*x^48 + (0.0053538769982365)*x^49 +
      (0.00366375716685372)*x^50));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711509))/(1099321.32004199);
    hl := (0) + (1) * (((264165.769863097) + (55045.0924054574)*x^1 +
      (-15530.9613962048)*x^2 + (9323.02142560806)*x^3 +
      (-3713.55063995873)*x^4 + (-5668.24234828214)*x^5 +
      (-25097.6059600101)*x^6 + (114542.458212433)*x^7 +
      (100403.959019043)*x^8 + (-708605.95775703)*x^9 +
      (-66756.3566692043)*x^10 + (2634880.09022467)*x^11 +
      (-1261137.45165689)*x^12 + (-5767487.65638426)*x^13 +
      (5704097.14300617)*x^14 + (6763949.30238296)*x^15 +
      (-11823004.0525545)*x^16 + (-1881959.25885099)*x^17 +
      (13118286.5709535)*x^18 + (-5330455.34053076)*x^19 +
      (-6768870.58089433)*x^20 + (6871922.20419042)*x^21 +
      (-179385.075668919)*x^22 + (-2846012.05183644)*x^23 +
      (1621602.99991981)*x^24 + (-79149.6184000711)*x^25 +
      (-350354.845541073)*x^26 + (230931.822047154)*x^27 +
      (-80546.6165653585)*x^28 + (14451.1767301123)*x^29 +
      (-675.810930446719)*x^30 + (418.633103433743)*x^31 +
      (-243.891647476847)*x^32 + (-27.0840074954698)*x^33 +
      (34.4573923119077)*x^34 + (-26.8117923739426)*x^35 +
      (15.8672736904888)*x^36 + (1.7383261464603)*x^37 +
      (-4.63930659057721)*x^38 + (0.974770473817121)*x^39 +
      (0.315194701935429)*x^40 + (-0.105207275191974)*x^41 +
      (-0.0282560159402985)*x^42 + (0.0174899646269803)*x^43 +
      (-0.0030179158953129)*x^44 + (0.000184961183468728)*x^45));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711465))/(1099321.32004152);
    hv := (409576.287023374) + (16957.9188539679) * (((0.716885920461567) +
      (0.847986730088046)*x^1 + (-0.550946254566628)*x^2 +
      (0.246372277496221)*x^3 + (-0.245243281452568)*x^4 +
      (0.206740480104201)*x^5 + (-0.130568776308635)*x^6 +
      (0.096151215082195)*x^7 + (0.0767890190523656)*x^8 +
      (-0.308799991735697)*x^9 + (0.165337515949091)*x^10 +
      (0.191088567972776)*x^11 + (-0.277432585048023)*x^12 +
      (0.147469798302808)*x^13 + (-0.0665601068588061)*x^14 +
      (0.0499552429639684)*x^15 + (-0.0311947330620793)*x^16 +
      (0.0109988406358016)*x^17 + (-0.0019919160005003)*x^18 +
      (0.000146114755723916)*x^19));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711509))/(1099321.32004199);
    sl := (0) + (1) * (((1214.3997345905) + (169.757060451784)*x^1 +
      (-58.7522396485261)*x^2 + (36.7035466683415)*x^3 +
      (-13.0844367240743)*x^4 + (-32.2623996097734)*x^5 +
      (-123.098484249474)*x^6 + (574.322894904955)*x^7 +
      (501.449619305607)*x^8 + (-3562.0724687124)*x^9 +
      (-313.368646868979)*x^10 + (13226.7122676853)*x^11 +
      (-6394.80667362487)*x^12 + (-28912.1120633901)*x^13 +
      (28745.7895776656)*x^14 + (33811.7330015974)*x^15 +
      (-59432.1771053041)*x^16 + (-9213.65456150566)*x^17 +
      (65805.1780388705)*x^18 + (-26951.4046285962)*x^19 +
      (-33831.6703317772)*x^20 + (34546.516132289)*x^21 +
      (-1011.92405629391)*x^22 + (-14253.0603537498)*x^23 +
      (8167.35604991928)*x^24 + (-420.688351064553)*x^25 +
      (-1754.92919607002)*x^26 + (1161.67231329233)*x^27 +
      (-405.466030416176)*x^28 + (72.6461571722029)*x^29 +
      (-3.38412616555908)*x^30 + (2.10119705402605)*x^31 +
      (-1.22607691354417)*x^32 + (-0.128293354719008)*x^33 +
      (0.168969874580144)*x^34 + (-0.135254807011812)*x^35 +
      (0.0805687876822656)*x^36 + (0.00863828261595032)*x^37 +
      (-0.023370265008107)*x^38 + (0.00490073872961946)*x^39 +
      (0.00159622206078928)*x^40 + (-0.000533996613727705)*x^41 +
      (-0.000140844251958289)*x^42 + (8.77316967122217e-05)*x^43 +
      (-1.5150913803503e-05)*x^44 + (9.28755787765749e-07)*x^45));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
    "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    Real x;

  algorithm
    x := (sat.psat - (1173800.40711465))/(1099321.32004152);
    sv := (0) + (1) * (((1709.22837116714) + (-13.7886033447905)*x^1 +
      (0.564362494967034)*x^2 + (-5.50913731662347)*x^3 +
      (-1.4710810714657)*x^4 + (21.1056166847968)*x^5 +
      (55.3988893994062)*x^6 + (-278.8342183201)*x^7 +
      (-238.319982484079)*x^8 + (1741.94692574345)*x^9 +
      (110.433794468402)*x^10 + (-6435.0171344795)*x^11 +
      (3235.84611771843)*x^12 + (13990.5043701977)*x^13 +
      (-14203.8869477235)*x^14 + (-16180.5286901209)*x^15 +
      (29080.9454888102)*x^16 + (4039.97184361304)*x^17 +
      (-31938.750447298)*x^18 + (13480.1370544075)*x^19 +
      (16191.4119093199)*x^20 + (-16906.205356694)*x^21 +
      (697.553504737119)*x^22 + (6873.61207413149)*x^23 +
      (-4022.96989824516)*x^24 + (247.736627905861)*x^25 +
      (846.143321140556)*x^26 + (-569.493750614901)*x^27 +
      (199.561613366245)*x^28 + (-35.6318873943596)*x^29 +
      (1.6208955320976)*x^30 + (-1.00920319342854)*x^31 +
      (0.596694219851247)*x^32 + (0.049805775690857)*x^33 +
      (-0.0749446096999996)*x^34 + (0.0666478893759725)*x^35 +
      (-0.0407765869650566)*x^36 + (-0.00405980844377531)*x^37 +
      (0.0115494481330778)*x^38 + (-0.00241040447476498)*x^39 +
      (-0.000802286705973783)*x^40 + (0.000270926474744898)*x^41 +
      (6.70715032108244e-05)*x^42 + (-4.27648894607494e-05)*x^43 +
      (7.41017757537388e-06)*x^44 + (-4.54727474435905e-07)*x^45));
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEntropy;
  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on
    the Helmholtz EoS.
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
      x1 := (p-(3258359.21215142))/(1352817.03780238);
      y1 := (h-(258541.38494292))/(87545.3330013087);
      T := (0) + (1) * (314.827695408612 + (0.0532548969281581)*x1^1 +
        (-0.0327402932674217)*x1^2 + (0.00529495748475652)*x1^3 +
        (-0.0147899438674052)*x1^4 + (59.7998195834653)*y1^1 +
        (-6.62177534265252)*y1^2 + (-2.9999979725331)*y1^3 +
        (1.18395227550521)*y1^4 + (2.80248047103141)*y1^5 +
        (-2.62761643515741)*y1^6 + (-3.56947078020548)*y1^7 +
        (0.491461507071165)*y1^8 + (0.927463043044066)*y1^9 +
        (-1.19878518364951)*y1^8*x1^1 + (-0.962577907835024)*y1^7*x1^1 +
        (0.878481585133851)*y1^7*x1^2 + (3.91182176711109)*y1^6*x1^1 +
        (1.04265487024909)*y1^6*x1^2 + (-0.48195831147019)*y1^6*x1^3 +
        (3.9963905002665)*y1^5*x1^1 + (-1.69733815644078)*y1^5*x1^2 +
        (-0.731437549563384)*y1^5*x1^3 + (0.0770329850582095)*y1^5*x1^4 +
        (-1.83698529629045)*y1^4*x1^1 + (-2.43696481656084)*y1^4*x1^2 +
        (0.468070335493652)*y1^4*x1^3 + (0.181462921419216)*y1^4*x1^4 +
        (-1.82312663184436)*y1^3*x1^1 + (-0.0230311877679581)*y1^3*x1^2 +
        (0.982708752218969)*y1^3*x1^3 + (0.0536451024965748)*y1^3*x1^4 +
        (1.14817103067673)*y1^2*x1^1 + (0.640727250560578)*y1^2*x1^2 +
        (0.128969357549004)*y1^2*x1^3 + (-0.134539808379163)*y1^2*x1^4 +
        (1.23170727519629)*y1^1*x1^1 + (0.0597699698084911)*y1^1*x1^2 +
        (-0.129555670548255)*y1^1*x1^3 + (-0.0975402807270774)*y1^1*x1^4);
    elseif h>h_dew+dh then
      x2 := (p-(1623982.43177388))/(1517145.25710131);
      y2 := (h-(464371.882231745))/(51004.186742787);
      T := (0) + (1) * (363.221803450648 + (19.7159455145757)*x2^1 +
        (-0.349661716358068)*x2^2 + (-0.0779836049824056)*x2^3 +
        (-0.0404894448559818)*x2^4 + (44.9076643959871)*y2^1 +
        (1.61226716995587)*y2^2 + (-1.69537088625365)*y2^3 +
        (1.26072555204728)*y2^4 + (-0.567008612580563)*y2^5 +
        (0.0701057832233571)*y2^6 + (0.0254180887275049)*y2^7 +
        (-0.0124041988508943)*y2^8 + (0.0028610409309618)*y2^9 +
        (-0.00106840793875426)*y2^8*x2^1 + (0.0416365945399298)*y2^7*x2^1 +
        (-0.0195802880749286)*y2^7*x2^2 + (-0.179660544834243)*y2^6*x2^1 +
        (-0.076962508011698)*y2^6*x2^2 + (0.0509650798466933)*y2^6*x2^3 +
        (-0.00279310782986392)*y2^5*x2^1 + (0.617814317683068)*y2^5*x2^2 +
        (-0.0790534022062859)*y2^5*x2^3 + (-0.0468161156252338)*y2^5*x2^4 +
        (1.14842192548223)*y2^4*x2^1 + (-0.919924069116996)*y2^4*x2^2 +
        (-0.322612907855446)*y2^4*x2^3 + (0.169304169481087)*y2^4*x2^4 +
        (-2.53676746445355)*y2^3*x2^1 + (0.126032916849538)*y2^3*x2^2 +
        (0.683339136223397)*y2^3*x2^3 + (-0.12360236699935)*y2^3*x2^4 +
        (4.44394813815231)*y2^2*x2^1 + (0.335016787119797)*y2^2*x2^2 +
        (-0.246814891775665)*y2^2*x2^3 + (-0.113020154572386)*y2^2*x2^4 +
        (-10.1366697046488)*y2^1*x2^1 + (0.120870986010151)*y2^1*x2^2 +
        (-0.0231738848883972)*y2^1*x2^3 + (0.136566349184184)*y2^1*x2^4);
    else
      if h<h_bubble then
        x1 := (p-(3258359.21215142))/(1352817.03780238);
        y1 := (h-(258541.38494292))/(87545.3330013087);
        T1 := (0) + (1) * (314.827695408612 + (0.0532548969281581)*x1^1 +
          (-0.0327402932674217)*x1^2 + (0.00529495748475652)*x1^3 +
          (-0.0147899438674052)*x1^4 + (59.7998195834653)*y1^1 +
          (-6.62177534265252)*y1^2 + (-2.9999979725331)*y1^3 +
          (1.18395227550521)*y1^4 + (2.80248047103141)*y1^5 +
          (-2.62761643515741)*y1^6 + (-3.56947078020548)*y1^7 +
          (0.491461507071165)*y1^8 + (0.927463043044066)*y1^9 +
          (-1.19878518364951)*y1^8*x1^1 + (-0.962577907835024)*y1^7*x1^1 +
          (0.878481585133851)*y1^7*x1^2 + (3.91182176711109)*y1^6*x1^1 +
          (1.04265487024909)*y1^6*x1^2 + (-0.48195831147019)*y1^6*x1^3 +
          (3.9963905002665)*y1^5*x1^1 + (-1.69733815644078)*y1^5*x1^2 +
          (-0.731437549563384)*y1^5*x1^3 + (0.0770329850582095)*y1^5*x1^4 +
          (-1.83698529629045)*y1^4*x1^1 + (-2.43696481656084)*y1^4*x1^2 +
          (0.468070335493652)*y1^4*x1^3 + (0.181462921419216)*y1^4*x1^4 +
          (-1.82312663184436)*y1^3*x1^1 + (-0.0230311877679581)*y1^3*x1^2 +
          (0.982708752218969)*y1^3*x1^3 + (0.0536451024965748)*y1^3*x1^4 +
          (1.14817103067673)*y1^2*x1^1 + (0.640727250560578)*y1^2*x1^2 +
          (0.128969357549004)*y1^2*x1^3 + (-0.134539808379163)*y1^2*x1^4 +
          (1.23170727519629)*y1^1*x1^1 + (0.0597699698084911)*y1^1*x1^2 +
          (-0.129555670548255)*y1^1*x1^3 + (-0.0975402807270774)*y1^1*x1^4);
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
          T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-(1623982.43177388))/(1517145.25710131);
        y2 := (h-(464371.882231745))/(51004.186742787);
        T2 := (0) + (1) * (363.221803450648 + (19.7159455145757)*x2^1 +
          (-0.349661716358068)*x2^2 + (-0.0779836049824056)*x2^3 +
          (-0.0404894448559818)*x2^4 + (44.9076643959871)*y2^1 +
          (1.61226716995587)*y2^2 + (-1.69537088625365)*y2^3 +
          (1.26072555204728)*y2^4 + (-0.567008612580563)*y2^5 +
          (0.0701057832233571)*y2^6 + (0.0254180887275049)*y2^7 +
          (-0.0124041988508943)*y2^8 + (0.0028610409309618)*y2^9 +
          (-0.00106840793875426)*y2^8*x2^1 + (0.0416365945399298)*y2^7*x2^1 +
          (-0.0195802880749286)*y2^7*x2^2 + (-0.179660544834243)*y2^6*x2^1 +
          (-0.076962508011698)*y2^6*x2^2 + (0.0509650798466933)*y2^6*x2^3 +
          (-0.00279310782986392)*y2^5*x2^1 + (0.617814317683068)*y2^5*x2^2 +
          (-0.0790534022062859)*y2^5*x2^3 + (-0.0468161156252338)*y2^5*x2^4 +
          (1.14842192548223)*y2^4*x2^1 + (-0.919924069116996)*y2^4*x2^2 +
          (-0.322612907855446)*y2^4*x2^3 + (0.169304169481087)*y2^4*x2^4 +
          (-2.53676746445355)*y2^3*x2^1 + (0.126032916849538)*y2^3*x2^2 +
          (0.683339136223397)*y2^3*x2^3 + (-0.12360236699935)*y2^3*x2^4 +
          (4.44394813815231)*y2^2*x2^1 + (0.335016787119797)*y2^2*x2^2 +
          (-0.246814891775665)*y2^2*x2^3 + (-0.113020154572386)*y2^2*x2^4 +
          (-10.1366697046488)*y2^1*x2^1 + (0.120870986010151)*y2^1*x2^2 +
          (-0.0231738848883972)*y2^1*x2^3 + (0.136566349184184)*y2^1*x2^4);
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
      x1 := (log(p)-(14.7875365886205))/(0.663511063673611);
      y1 := (s-(1126.31192475932))/(244.853512874793);
      T := (0) + (1) * (300.587264376628 + (0.94996237530845)*x1^1 +
        (0.303157516353388)*x1^2 + (0.0425905424516415)*x1^3 +
        (-0.00612110456282157)*x1^4 + (52.1272715438709)*y1^1 +
        (0.934991565642564)*y1^2 + (-1.66612434799561)*y1^3 +
        (-1.27792380300538)*y1^4 + (0.410987961018363)*y1^5 +
        (1.20370954075399)*y1^6 + (-0.533205810766702)*y1^7 +
        (-1.00320676865041)*y1^8 + (0.0173571141739969)*y1^9 +
        (0.180140992292161)*y1^10 + (-0.291069659186083)*y1^9*x1^1 +
        (-0.0872169090380506)*y1^8*x1^1 + (0.210931565927688)*y1^8*x1^2 +
        (1.54473840594432)*y1^7*x1^1 + (0.242658047959267)*y1^7*x1^2 +
        (-0.125471470126885)*y1^7*x1^3 + (1.27724167635143)*y1^6*x1^1 +
        (-0.749529598236941)*y1^6*x1^2 + (-0.260793835526211)*y1^6*x1^3 +
        (0.0285723567918958)*y1^6*x1^4 + (-1.20931903922332)*y1^5*x1^1 +
        (-1.20679390142769)*y1^5*x1^2 + (0.14579825633924)*y1^5*x1^3 +
        (0.0761667567718539)*y1^5*x1^4 + (-0.980601828987551)*y1^4*x1^1 +
        (-0.0414786123544972)*y1^4*x1^2 + (0.67239714034787)*y1^4*x1^3 +
        (0.0115047530756927)*y1^4*x1^4 + (0.633536586430794)*y1^3*x1^1 +
        (0.603963042415619)*y1^3*x1^2 + (0.449251036040618)*y1^3*x1^3 +
        (-0.143342451130932)*y1^3*x1^4 + (0.739997965709238)*y1^2*x1^1 +
        (0.284571979372862)*y1^2*x1^2 + (0.00615406154781733)*y1^2*x1^3 +
        (-0.170430522133426)*y1^2*x1^4 + (0.674829627189691)*y1^1*x1^1 +
        (0.191394330126145)*y1^1*x1^2 + (-0.041146019162364)*y1^1*x1^3 +
        (-0.0717852001683681)*y1^1*x1^4);
    elseif s>s_dew+ds then
      x2 := (log(p)-(13.204266881401))/(1.16895892611495);
      y2 := (s-(1831.0596916082))/(116.879525072462);
      T := (0) + (1) * (327.5152079225 + (40.390945841519)*x2^1 +
        (3.15200862940067)*x2^2 + (0.84009020654906)*x2^3 +
        (0.177443077694145)*x2^4 + (39.8941858976051)*y2^1 +
        (2.0764693478832)*y2^2 + (-0.364336953952206)*y2^3 +
        (0.0421908648150418)*y2^4 + (0.0677619152714318)*y2^5 +
        (-0.0204430553521217)*y2^6 + (-0.0190222016179443)*y2^7 +
        (0.0122643123754593)*y2^8 + (-0.00234908647943673)*y2^9 +
        (0.00012413799291331)*y2^10 + (-0.00140522490504156)*y2^9*x2^1 +
        (0.00329122730110688)*y2^8*x2^1 + (-0.00937491577006562)*y2^8*x2^2 +
        (0.0333827070862789)*y2^7*x2^1 + (0.0508721324649598)*y2^7*x2^2 +
        (-0.0216247475662101)*y2^7*x2^3 + (-0.148892361231698)*y2^6*x2^1 +
        (-0.0330211687434747)*y2^6*x2^2 + (0.122997152293476)*y2^6*x2^3 +
        (-0.023644132786541)*y2^6*x2^4 + (0.160671867686228)*y2^5*x2^1 +
        (-0.256585546262645)*y2^5*x2^2 + (-0.210848453821976)*y2^5*x2^3 +
        (0.131206121652008)*y2^5*x2^4 + (0.102631340846465)*y2^4*x2^1 +
        (0.499615855820928)*y2^4*x2^2 + (0.0559247407428316)*y2^4*x2^3 +
        (-0.207112807377818)*y2^4*x2^4 + (-0.320168181386132)*y2^3*x2^1 +
        (-0.147739984347582)*y2^3*x2^2 + (0.113844709544168)*y2^3*x2^3 +
        (0.0165765359506585)*y2^3*x2^4 + (0.588939883715035)*y2^2*x2^1 +
        (0.00902349232653274)*y2^2*x2^2 + (0.0295039397995595)*y2^2*x2^3 +
        (0.146603156395031)*y2^2*x2^4 + (-0.434825078991382)*y2^1*x2^1 +
        (-0.932894048645235)*y2^1*x2^2 + (-0.34837692742088)*y2^1*x2^3 +
        (-0.0914682411901647)*y2^1*x2^4);
    else
      if s<s_bubble then
        x1 := (log(p)-(14.7875365886205))/(0.663511063673611);
        y1 := (s-(1126.31192475932))/(244.853512874793);
        T1 := (0) + (1) * (300.587264376628 + (0.94996237530845)*x1^1 +
          (0.303157516353388)*x1^2 + (0.0425905424516415)*x1^3 +
          (-0.00612110456282157)*x1^4 + (52.1272715438709)*y1^1 +
          (0.934991565642564)*y1^2 + (-1.66612434799561)*y1^3 +
          (-1.27792380300538)*y1^4 + (0.410987961018363)*y1^5 +
          (1.20370954075399)*y1^6 + (-0.533205810766702)*y1^7 +
          (-1.00320676865041)*y1^8 + (0.0173571141739969)*y1^9 +
          (0.180140992292161)*y1^10 + (-0.291069659186083)*y1^9*x1^1 +
          (-0.0872169090380506)*y1^8*x1^1 + (0.210931565927688)*y1^8*x1^2 +
          (1.54473840594432)*y1^7*x1^1 + (0.242658047959267)*y1^7*x1^2 +
          (-0.125471470126885)*y1^7*x1^3 + (1.27724167635143)*y1^6*x1^1 +
          (-0.749529598236941)*y1^6*x1^2 + (-0.260793835526211)*y1^6*x1^3 +
          (0.0285723567918958)*y1^6*x1^4 + (-1.20931903922332)*y1^5*x1^1 +
          (-1.20679390142769)*y1^5*x1^2 + (0.14579825633924)*y1^5*x1^3 +
          (0.0761667567718539)*y1^5*x1^4 + (-0.980601828987551)*y1^4*x1^1 +
          (-0.0414786123544972)*y1^4*x1^2 + (0.67239714034787)*y1^4*x1^3 +
          (0.0115047530756927)*y1^4*x1^4 + (0.633536586430794)*y1^3*x1^1 +
          (0.603963042415619)*y1^3*x1^2 + (0.449251036040618)*y1^3*x1^3 +
          (-0.143342451130932)*y1^3*x1^4 + (0.739997965709238)*y1^2*x1^1 +
          (0.284571979372862)*y1^2*x1^2 + (0.00615406154781733)*y1^2*x1^3 +
          (-0.170430522133426)*y1^2*x1^4 + (0.674829627189691)*y1^1*x1^1 +
          (0.191394330126145)*y1^1*x1^2 + (-0.041146019162364)*y1^1*x1^3 +
          (-0.0717852001683681)*y1^1*x1^4);
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
          T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-(13.204266881401))/(1.16895892611495);
        y2 := (s-(1831.0596916082))/(116.879525072462);
        T2 := (0) + (1) * (327.5152079225 + (40.390945841519)*x2^1 +
          (3.15200862940067)*x2^2 + (0.84009020654906)*x2^3 +
          (0.177443077694145)*x2^4 + (39.8941858976051)*y2^1 +
          (2.0764693478832)*y2^2 + (-0.364336953952206)*y2^3 +
          (0.0421908648150418)*y2^4 + (0.0677619152714318)*y2^5 +
          (-0.0204430553521217)*y2^6 + (-0.0190222016179443)*y2^7 +
          (0.0122643123754593)*y2^8 + (-0.00234908647943673)*y2^9 +
          (0.00012413799291331)*y2^10 + (-0.00140522490504156)*y2^9*x2^1 +
          (0.00329122730110688)*y2^8*x2^1 + (-0.00937491577006562)*y2^8*x2^2 +
          (0.0333827070862789)*y2^7*x2^1 + (0.0508721324649598)*y2^7*x2^2 +
          (-0.0216247475662101)*y2^7*x2^3 + (-0.148892361231698)*y2^6*x2^1 +
          (-0.0330211687434747)*y2^6*x2^2 + (0.122997152293476)*y2^6*x2^3 +
          (-0.023644132786541)*y2^6*x2^4 + (0.160671867686228)*y2^5*x2^1 +
          (-0.256585546262645)*y2^5*x2^2 + (-0.210848453821976)*y2^5*x2^3 +
          (0.131206121652008)*y2^5*x2^4 + (0.102631340846465)*y2^4*x2^1 +
          (0.499615855820928)*y2^4*x2^2 + (0.0559247407428316)*y2^4*x2^3 +
          (-0.207112807377818)*y2^4*x2^4 + (-0.320168181386132)*y2^3*x2^1 +
          (-0.147739984347582)*y2^3*x2^2 + (0.113844709544168)*y2^3*x2^3 +
          (0.0165765359506585)*y2^3*x2^4 + (0.588939883715035)*y2^2*x2^1 +
          (0.00902349232653274)*y2^2*x2^2 + (0.0295039397995595)*y2^2*x2^3 +
          (0.146603156395031)*y2^2*x2^4 + (-0.434825078991382)*y2^1*x2^1 +
          (-0.932894048645235)*y2^1*x2^2 + (-0.34837692742088)*y2^1*x2^3 +
          (-0.0914682411901647)*y2^1*x2^4);
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) +
          T2*(s - s_dew)/ ds;
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
      x1 := (p-(1600766.20840426))/(1019029.80447803);
      y1 := (T-(345.780142922559))/(24.3460840999553);
      d := (0) + (0.999) * (73.118571695972 + (63.4239308958369)*x1^1 +
        (18.3003263667046)*x1^2 + (9.39421881473955)*x1^3 +
        (7.09177356543309)*x1^4 + (5.23708459011804)*x1^5 +
        (0.578782340741552)*x1^6 + (-1.54042394843668)*x1^7 +
        (1.25422245124727)*x1^8 + (3.20297513437295)*x1^9 +
        (2.27421493369135)*x1^10 + (-0.504581868379304)*x1^11 +
        (-1.12599416061308)*x1^12 + (1.55331005888042)*x1^13 +
        (1.16161743095121)*x1^14 + (-1.20184737545216)*x1^15 +
        (-0.74648142212366)*x1^16 + (0.278070675613861)*x1^17 +
        (0.1689335064038)*x1^18 + (-12.4136441424452)*y1^1 +
        (3.88226290732021)*y1^2 + (-1.70439246480624)*y1^3 +
        (0.562626262975482)*y1^4 + (-1.17017884482496)*x1^17*y1^1 +
        (-2.3852489066477)*x1^16*y1^1 + (3.06658887799103)*x1^16*y1^2 +
        (4.57803202704379)*x1^15*y1^1 + (7.60586826210336)*x1^15*y1^2 +
        (-3.6374054137502)*x1^15*y1^3 + (11.1305887867053)*x1^14*y1^1 +
        (-10.531890937117)*x1^14*y1^2 + (-10.6025332817454)*x1^14*y1^3 +
        (1.67395801589396)*x1^14*y1^4 + (-4.11656519288863)*x1^13*y1^1 +
        (-37.829721696342)*x1^13*y1^2 + (10.8160047767693)*x1^13*y1^3 +
        (5.39724210896898)*x1^13*y1^4 + (-15.8509141937486)*x1^12*y1^1 +
        (0.16539060896887)*x1^12*y1^2 + (56.1542951833691)*x1^12*y1^3 +
        (-4.37751446853329)*x1^12*y1^4 + (-0.700734627984774)*x1^11*y1^1 +
        (58.9914336041491)*x1^11*y1^2 + (12.6985686213048)*x1^11*y1^3 +
        (-30.0162045272803)*x1^11*y1^4 + (3.29957742403242)*x1^10*y1^1 +
        (29.3966215270787)*x1^10*y1^2 + (-98.1518521184536)*x1^10*y1^3 +
        (-11.3492996193995)*x1^10*y1^4 + (-11.3408317015857)*x1^9*y1^1 +
        (-14.6134355681511)*x1^9*y1^2 + (-70.1869342443377)*x1^9*y1^3 +
        (56.8538866067529)*x1^9*y1^4 + (-10.8064971385458)*x1^8*y1^1 +
        (-1.52226374447057)*x1^8*y1^2 + (45.0040674986077)*x1^8*y1^3 +
        (50.1097731625293)*x1^8*y1^4 + (2.5492410749415)*x1^7*y1^1 +
        (4.97951280387615)*x1^7*y1^2 + (44.4419747118542)*x1^7*y1^3 +
        (-34.0879999837732)*x1^7*y1^4 + (2.67944204720335)*x1^6*y1^1 +
        (-0.501886352998431)*x1^6*y1^2 + (-6.26134528520153)*x1^6*y1^3 +
        (-47.2205597266305)*x1^6*y1^4 + (-11.7666587360995)*x1^5*y1^1 +
        (9.71258637652847)*x1^5*y1^2 + (-10.6315428426648)*x1^5*y1^3 +
        (4.53156357787073)*x1^5*y1^4 + (-19.9076698455612)*x1^4*y1^1 +
        (20.8686520295642)*x1^4*y1^2 + (-11.5331539200892)*x1^4*y1^3 +
        (19.2381594479155)*x1^4*y1^4 + (-19.3570225767985)*x1^3*y1^1 +
        (23.2916795123783)*x1^3*y1^2 + (-17.0315966365249)*x1^3*y1^3 +
        (5.95211177024792)*x1^3*y1^4 + (-20.0890389234895)*x1^2*y1^1 +
        (18.9596025990082)*x1^2*y1^2 + (-12.5541351899702)*x1^2*y1^3 +
        (1.61845307417717)*x1^2*y1^4 + (-20.9996689026322)*x1^1*y1^1 +
        (11.4012827945148)*x1^1*y1^2 + (-6.08216841759289)*x1^1*y1^3 +
        (1.6139077221972)*x1^1*y1^4);
    elseif p>sat.psat+dp then
      x2 := (p-(3067141.02087822))/(1250016.64160742);
      y2 := (T-(306.333739723678))/(39.7052211222868);
      d := (0) + (1.007596524) * (1189.94427795653 + (7.87433412548864)*x2^1 +
        (-0.393021216688428)*x2^2 + (-0.0297809665090564)*x2^3 +
        (-152.964391932951)*y2^1 + (-26.5844725397398)*y2^2 +
        (-13.2573880132147)*y2^3 + (8.42443025706179)*y2^4 +
        (14.2596863645139)*y2^5 + (-18.3785897660491)*y2^6 +
        (-24.8669510003648)*y2^7 + (7.78387180871463)*y2^8 +
        (15.7146697953855)*y2^9 + (0.681093877003925)*y2^10 +
        (-3.80893784483356)*y2^11 + (-1.02415118562434)*y2^12 +
        (2.06494548963484)*y2^11*x2^1 + (7.57753444222479)*y2^10*x2^1 +
        (-1.26044732839976)*y2^10*x2^2 + (0.305045780960498)*y2^9*x2^1 +
        (-5.16251152860913)*y2^9*x2^2 + (0.227139340077688)*y2^9*x2^3 +
        (-24.4943337560739)*y2^8*x2^1 + (-2.88562398358126)*y2^8*x2^2 +
        (1.13671327198115)*y2^8*x2^3 + (-14.5056545529004)*y2^7*x2^1 +
        (11.723519090061)*y2^7*x2^2 + (1.48106761398927)*y2^7*x2^3 +
        (28.7134548150431)*y2^6*x2^1 + (12.5950803196686)*y2^6*x2^2 +
        (-1.02019713556307)*y2^6*x2^3 + (22.307603797593)*y2^5*x2^1 +
        (-8.24807441103373)*y2^5*x2^2 + (-3.24960897757928)*y2^5*x2^3 +
        (-10.5027246393796)*y2^4*x2^1 + (-12.0818129588016)*y2^4*x2^2 +
        (-0.922165432363117)*y2^4*x2^3 + (-6.49123842323816)*y2^3*x2^1 +
        (0.746728622500784)*y2^3*x2^2 + (1.59789449316334)*y2^3*x2^3 +
        (5.70882420483716)*y2^2*x2^1 + (2.56319794925055)*y2^2*x2^2 +
        (0.824892590067656)*y2^2*x2^3 + (7.146645111271)*y2^1*x2^1 +
        (-0.411530121945932)*y2^1*x2^2 + (-0.0588201589015566)*y2^1*x2^3);
    else
      if p<sat.psat then
        x1 := (p-(1600766.20840426))/(1019029.80447803);
        y1 := (T-(345.780142922559))/(24.3460840999553);
        d1 := (0) + (0.999) * (73.118571695972 + (63.4239308958369)*x1^1 +
          (18.3003263667046)*x1^2 + (9.39421881473955)*x1^3 +
          (7.09177356543309)*x1^4 + (5.23708459011804)*x1^5 +
          (0.578782340741552)*x1^6 + (-1.54042394843668)*x1^7 +
          (1.25422245124727)*x1^8 + (3.20297513437295)*x1^9 +
          (2.27421493369135)*x1^10 + (-0.504581868379304)*x1^11 +
          (-1.12599416061308)*x1^12 + (1.55331005888042)*x1^13 +
          (1.16161743095121)*x1^14 + (-1.20184737545216)*x1^15 +
          (-0.74648142212366)*x1^16 + (0.278070675613861)*x1^17 +
          (0.1689335064038)*x1^18 + (-12.4136441424452)*y1^1 +
          (3.88226290732021)*y1^2 + (-1.70439246480624)*y1^3 +
          (0.562626262975482)*y1^4 + (-1.17017884482496)*x1^17*y1^1 +
          (-2.3852489066477)*x1^16*y1^1 + (3.06658887799103)*x1^16*y1^2 +
          (4.57803202704379)*x1^15*y1^1 + (7.60586826210336)*x1^15*y1^2 +
          (-3.6374054137502)*x1^15*y1^3 + (11.1305887867053)*x1^14*y1^1 +
          (-10.531890937117)*x1^14*y1^2 + (-10.6025332817454)*x1^14*y1^3 +
          (1.67395801589396)*x1^14*y1^4 + (-4.11656519288863)*x1^13*y1^1 +
          (-37.829721696342)*x1^13*y1^2 + (10.8160047767693)*x1^13*y1^3 +
          (5.39724210896898)*x1^13*y1^4 + (-15.8509141937486)*x1^12*y1^1 +
          (0.16539060896887)*x1^12*y1^2 + (56.1542951833691)*x1^12*y1^3 +
          (-4.37751446853329)*x1^12*y1^4 + (-0.700734627984774)*x1^11*y1^1 +
          (58.9914336041491)*x1^11*y1^2 + (12.6985686213048)*x1^11*y1^3 +
          (-30.0162045272803)*x1^11*y1^4 + (3.29957742403242)*x1^10*y1^1 +
          (29.3966215270787)*x1^10*y1^2 + (-98.1518521184536)*x1^10*y1^3 +
          (-11.3492996193995)*x1^10*y1^4 + (-11.3408317015857)*x1^9*y1^1 +
          (-14.6134355681511)*x1^9*y1^2 + (-70.1869342443377)*x1^9*y1^3 +
          (56.8538866067529)*x1^9*y1^4 + (-10.8064971385458)*x1^8*y1^1 +
          (-1.52226374447057)*x1^8*y1^2 + (45.0040674986077)*x1^8*y1^3 +
          (50.1097731625293)*x1^8*y1^4 + (2.5492410749415)*x1^7*y1^1 +
          (4.97951280387615)*x1^7*y1^2 + (44.4419747118542)*x1^7*y1^3 +
          (-34.0879999837732)*x1^7*y1^4 + (2.67944204720335)*x1^6*y1^1 +
          (-0.501886352998431)*x1^6*y1^2 + (-6.26134528520153)*x1^6*y1^3 +
          (-47.2205597266305)*x1^6*y1^4 + (-11.7666587360995)*x1^5*y1^1 +
          (9.71258637652847)*x1^5*y1^2 + (-10.6315428426648)*x1^5*y1^3 +
          (4.53156357787073)*x1^5*y1^4 + (-19.9076698455612)*x1^4*y1^1 +
          (20.8686520295642)*x1^4*y1^2 + (-11.5331539200892)*x1^4*y1^3 +
          (19.2381594479155)*x1^4*y1^4 + (-19.3570225767985)*x1^3*y1^1 +
          (23.2916795123783)*x1^3*y1^2 + (-17.0315966365249)*x1^3*y1^3 +
          (5.95211177024792)*x1^3*y1^4 + (-20.0890389234895)*x1^2*y1^1 +
          (18.9596025990082)*x1^2*y1^2 + (-12.5541351899702)*x1^2*y1^3 +
          (1.61845307417717)*x1^2*y1^4 + (-20.9996689026322)*x1^1*y1^1 +
          (11.4012827945148)*x1^1*y1^2 + (-6.08216841759289)*x1^1*y1^3 +
          (1.6139077221972)*x1^1*y1^4);
        d := 0.995*bubbleDensity(sat)*(1 -(sat.psat - p)/dp) +
          d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-(3067141.02087822))/(1250016.64160742);
        y2 := (T-(306.333739723678))/(39.7052211222868);
        d2 := (0) + (1.007596524) * (1189.94427795653 + (7.87433412548864)*x2^1 +
          (-0.393021216688428)*x2^2 + (-0.0297809665090564)*x2^3 +
          (-152.964391932951)*y2^1 + (-26.5844725397398)*y2^2 +
          (-13.2573880132147)*y2^3 + (8.42443025706179)*y2^4 +
          (14.2596863645139)*y2^5 + (-18.3785897660491)*y2^6 +
          (-24.8669510003648)*y2^7 + (7.78387180871463)*y2^8 +
          (15.7146697953855)*y2^9 + (0.681093877003925)*y2^10 +
          (-3.80893784483356)*y2^11 + (-1.02415118562434)*y2^12 +
          (2.06494548963484)*y2^11*x2^1 + (7.57753444222479)*y2^10*x2^1 +
          (-1.26044732839976)*y2^10*x2^2 + (0.305045780960498)*y2^9*x2^1 +
          (-5.16251152860913)*y2^9*x2^2 + (0.227139340077688)*y2^9*x2^3 +
          (-24.4943337560739)*y2^8*x2^1 + (-2.88562398358126)*y2^8*x2^2 +
          (1.13671327198115)*y2^8*x2^3 + (-14.5056545529004)*y2^7*x2^1 +
          (11.723519090061)*y2^7*x2^2 + (1.48106761398927)*y2^7*x2^3 +
          (28.7134548150431)*y2^6*x2^1 + (12.5950803196686)*y2^6*x2^2 +
          (-1.02019713556307)*y2^6*x2^3 + (22.307603797593)*y2^5*x2^1 +
          (-8.24807441103373)*y2^5*x2^2 + (-3.24960897757928)*y2^5*x2^3 +
          (-10.5027246393796)*y2^4*x2^1 + (-12.0818129588016)*y2^4*x2^2 +
          (-0.922165432363117)*y2^4*x2^3 + (-6.49123842323816)*y2^3*x2^1 +
          (0.746728622500784)*y2^3*x2^2 + (1.59789449316334)*y2^3*x2^3 +
          (5.70882420483716)*y2^2*x2^1 + (2.56319794925055)*y2^2*x2^2 +
          (0.824892590067656)*y2^2*x2^3 + (7.146645111271)*y2^1*x2^1 +
          (-0.411530121945932)*y2^1*x2^2 + (-0.0588201589015566)*y2^1*x2^3);
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
  Huber et al. (2003), Model for the Viscosity and Thermal Conductivity of
  Refrigerants, Including a New Correlation for the Viscosity of R134a.
  Ind. Eng. Chem. Res(42)
  Afterwards, the coefficients are adapted to the HelmholtzMedia libary.
*/
  protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real Tred = state.T/299.363 "Reduced temperature for lower density terms";
    Real tau = state.T/374.21 "Reduced temperature for higher density terms";
    Real omegaEta "Reduced effective collision cross section";
    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real BEtaZd "Second viscosity virial coefficient for limits of zero density";
    Real BEta "Second viscosity virial coefficient";
    Real etaN "Dynamic viscosity for moderate density limits";
    Real etaNL "Dynamic viscosity for moderate density limits at bubble line";
    Real etaNG "Dynamic viscosity for moderate density limits at dew line";
    Real delta "Reduced density for higher density terms";
    Real deltaL "Reduced density for higher density terms";
    Real deltaG "Reduced density for higher density terms";
    Real deltaHd "Reduced close-pacled density";
    Real etaL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaG "Dynamic viscosity for the limit of high density at dew line";
    Real etaHd "Dynamic viscosity for the limit of high density";
    Real etaHdL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaHdG "Dynamic viscosity for the limit of high density at dew line";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;

    if (state.phase == 1 or phase_dT == 1) then
      // Calculate properties
      delta :=state.d/511.9 "Reduced density for higher density terms";

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.355404 - 0.464337*Tred + 0.257353E-1*Tred^2);
      etaZd := 0.1399787595 * sqrt(state.T) / (0.468932^2*omegaEta);

      // Calculate the second viscosity virial coefficient
      BEtaZd := -0.19572881E+2 + 0.21973999E+3*Tred^(-0.25) -
        0.10153226E+4*Tred^(-0.50) + 0.24710125E+4*Tred^(-0.75) -
        0.33751717E+4*Tred^(-1.00) + 0.24916597E+4*Tred^(-1.25) -
        0.78726086E+3*Tred^(-1.50) + 0.14085455E+2*Tred^(-2.50) -
        0.34664158E+0*Tred^(-5.50);
      BEta := BEtaZd*0.6022137*0.468932^3;
      etaN := etaZd*BEta*(state.d/(1000*fluidConstants[1].molarMass));

      // Calculate the dynamic viscosity for limits of higher densities
      deltaHd := 3.163695635587490/(1 - 0.8901733752064137E-1*tau +
        0.1000352946668359*tau^2);
      etaHd :=   -0.2069007192080741E-1*delta +
        0.3560295489828222E-3*tau^(-6.00)*delta^(2.00) +
        0.2111018162451597E-2*tau^(-2.00)*delta^(2.00) +
        0.1396014148308975E-1*tau^(-0.50)*delta^(2.00) -
        0.4564350196734897E-2*tau^(2.00)*delta^(2.00) -
        0.3515932745836890E-2*delta^(3.00) -
        0.2147633195397038*deltaHd^(-1) + (0.2147633195397038/
        (deltaHd - delta));
      etaHd := etaHd*1e3;

      // Calculate the final dynamic visocity
      eta := (etaZd + etaN + etaHd)*1e-6;
    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);
      deltaL :=bubbleState.d/511.9
        "Reduced density for higher density terms at bubble line";
      deltaG :=dewState.d/511.9
        "Reduced density for higher density terms at dew line";

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.355404 - 0.464337*Tred + 0.257353E-1*Tred^2);
      etaZd := 0.1399787595 * sqrt(state.T) / (0.468932^2*omegaEta);

      // Calculate the second viscosity virial coefficient
      BEtaZd := -0.19572881E+2 + 0.21973999E+3*Tred^(-0.25) -
        0.10153226E+4*Tred^(-0.50) + 0.24710125E+4*Tred^(-0.75) -
        0.33751717E+4*Tred^(-1.00) + 0.24916597E+4*Tred^(-1.25) -
        0.78726086E+3*Tred^(-1.50) + 0.14085455E+2*Tred^(-2.50) -
        0.34664158E+0*Tred^(-5.50);
      BEta := BEtaZd*0.6022137*0.468932^3;
      etaNL := etaZd*BEta*(bubbleState.d/(1000*fluidConstants[1].molarMass));
      etaNG := etaZd*BEta*(dewState.d/(1000*fluidConstants[1].molarMass));

      // Calculate the dynamic viscosity for limits of higher densities
      deltaHd := 3.163695635587490/(1 - 0.8901733752064137E-1*tau +
        0.1000352946668359*tau^2);
      etaHdL :=   -0.2069007192080741E-1*deltaL +
        0.3560295489828222E-3*tau^(-6.00)*deltaL^(2.00) +
        0.2111018162451597E-2*tau^(-2.00)*deltaL^(2.00) +
        0.1396014148308975E-1*tau^(-0.50)*deltaL^(2.00) -
        0.4564350196734897E-2*tau^(2.00)*deltaL^(2.00) -
        0.3515932745836890E-2*deltaL^(3.00) -
        0.2147633195397038*deltaHd^(-1) + (0.2147633195397038/
        (deltaHd - deltaL));
      etaHdG :=   -0.2069007192080741E-1*deltaG +
        0.3560295489828222E-3*tau^(-6.00)*deltaG^(2.00) +
        0.2111018162451597E-2*tau^(-2.00)*deltaG^(2.00) +
        0.1396014148308975E-1*tau^(-0.50)*deltaG^(2.00) -
        0.4564350196734897E-2*tau^(2.00)*deltaG^(2.00) -
        0.3515932745836890E-2*deltaG^(3.00) -
        0.2147633195397038*deltaHd^(-1) + (0.2147633195397038/
        (deltaHd - deltaG));
      etaHdL := etaHdL*1e3;
      etaHdG := etaHdG*1e3;

      // Calculate the dynamic visocity at bubble and dew state
      etaL := (etaZd + etaNL + etaHdL)*1e-6;
      etaG := (etaZd + etaNG + etaHdG)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
    end if;

  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
  Perkins et al. (2000), Experimental Thermal Conductivity Values for the IUPAC
  Round-Robin Sample of 1,1,1,2-Tetrafluoroethane (R134a).
  National Institute of Standards and Technology
  Afterwards, the coefficients are adapted to the HelmholtzMedia libary.
  */
  protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Integer phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real lambdaIdg "Thermal conductivity for the limit of zero density";
    Real delta "Reduced density for the residual part";
    Real deltaL "Reduced density for the residual part at bubble line";
    Real deltaG "Reduced density for the residual part at dew line";
    Real lambdaRes "Thermal conductivity for residual part";
    Real lambdaResL "Thermal conductivity for residual part at bubble line";
    Real lambdaResG "Thermal conductivity for residual part at dew line";
    ThermodynamicState stateRef "Reference state for crossover function";
    ThermodynamicState stateRefL
      "Reference state for crossover function at bubble line";
    ThermodynamicState stateRefG
      "Reference state for crossover function at dew line";
    Real chi "Dimensionless susceptibility";
    Real chiL "Dimensionless susceptibility at bubble line";
    Real chiG "Dimensionless susceptibility at dew line";
    Real xi "Correlation length";
    Real xiL "Correlation length";
    Real xiG "Correlation length";
    Real chiRef "Dimensionless susceptibility at reference state";
    Real chiRefL "Dimensionless susceptibility at reference state at bubble line";
    Real chiRefG "Dimensionless susceptibility at reference state at dew line";
    Real cp "Specific heat capacity at constant pressure";
    Real cpL "Specific heat capacity at constant pressure at bubble line";
    Real cpG "Specific heat capacity at constant pressure at dew line";
    Real cv "Specific heat capacity at constant volume";
    Real cvL "Specific heat capacity at constant volume at dew line";
    Real cvG "Specific heat capacity at constant volume at bubble line";
    Real eta "Dynamic viscosity";
    Real etaL "Dynamic viscosity at bubble line";
    Real etaG "Dynamic viscosity at dew line";
    Real omega "Crossover function";
    Real omegaL "Crossover functio at bubble line";
    Real omegaG "Crossover function at dew line";
    Real omegaRef "Crossover function at reference state";
    Real omegaRefL "Crossover function at reference state at bubble line";
    Real omegaRefG "Crossover function at reference state at dew line";
    Real lambdaCri
      "Thermal conductivity for the region of the critical point";
    Real lambdaCriL
      "Thermal conductivity for the region of the critical point at bubble line";
    Real lambdaCriG
      "Thermal conductivity for the region of the critical point at dew line";
    Real lambdaL "Thermal conductivity at bubble line";
    Real lambdaG "Thermal conductivity at dew line";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;

    if (state.phase == 1 or phase_dT == 1) then
      // Calculate properties
      delta :=state.d/515.2499684;
      stateRef :=setState_dTX(d=state.d,T=561.411,phase=phase_dT);

      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -0.0105248 + 0.0000800982*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaRes := 1.836526E+0*delta + 5.126143E+0*delta^2 -
        1.436883E+0*delta^3 + 6.261441E-1*delta^4;
      lambdaRes := lambdaRes*2.055E-3;

      // Calculate the thermal conductivity for the region of the critical point
      if state.d < 511.899952/100 then
        lambdaCri := 0;
      else
        chi := 4059280/511.899952^2*state.d/pressure_derd_T(state);
        chiRef := 4059280/511.899952^2*state.d/pressure_derd_T(stateRef)*
          561.411/state.T;
        if ((chi - chiRef) < 0) then
          lambdaCri := 0;
        else
          cp :=specificHeatCapacityCp(state);
          cv :=specificHeatCapacityCv(state);
          eta :=dynamicViscosity(state);

          xi := 1.94E-10*((chi - chiRef)/0.0496)^(0.63/1.239);
          omega := 2/Modelica.Constants.pi*((cp - cv)/cp*
            atan((1/5.285356E-10)*xi) + cv/cp*(1/5.285356E-10)*xi);
          omegaRef := 2/Modelica.Constants.pi*(1 - exp(-1/(1/((1/5.285356E-10)*
            xi) + (((1/5.285356E-10)*xi*511.899952/state.d)^2)/3)));
          lambdaCri := (state.d*cp*1.03*Modelica.Constants.k*state.T)/
            (6*Modelica.Constants.pi*eta*xi)*(omega - omegaRef);
          lambdaCri := max(0, lambdaCri);
        end if;
      end if;

      // Calculate the final thermal conductivity
      lambda := lambdaIdg + lambdaRes + lambdaCri;
    else
      // Calculate properties
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);
      deltaL :=bubbleState.d/515.2499684;
      deltaG :=dewState.d/515.2499684;
      stateRefL :=setState_dTX(d=bubbleState.d,T=561.411,phase=phase_dT);
      stateRefG :=setState_dTX(d=dewState.d,T=561.411,phase=phase_dT);

      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -0.0105248 + 0.0000800982*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaResL := 1.836526E+0*deltaL + 5.126143E+0*deltaL^2 -
        1.436883E+0*deltaL^3 + 6.261441E-1*deltaL^4;
      lambdaResG := 1.836526E+0*deltaG + 5.126143E+0*deltaG^2 -
        1.436883E+0*deltaG^3 + 6.261441E-1*deltaG^4;
      lambdaResL := lambdaResL*2.055E-3;
      lambdaResG := lambdaResG*2.055E-3;

      // Calculate the thermal conductivity for the region of the critical point
      if bubbleState.d < 511.899952/100 then
        lambdaCriL := 0;
      else
        chiL := 4059280/511.899952^2*bubbleState.d/pressure_derd_T(
          setState_dTX(d=bubbleState.d,T=state.T,phase=1));
        chiRefL := 4059280/511.899952^2*bubbleState.d/pressure_derd_T(stateRefL)*
          561.411/state.T;
        if ((chiL - chiRefL) < 0) then
          lambdaCriL := 0;
        else
          cpL :=specificHeatCapacityCp(setState_dTX(
            d=bubbleState.d,T=state.T,phase=1));
          cvL :=specificHeatCapacityCv(setState_dTX(
            d=bubbleState.d,T=state.T,phase=1));
          etaL :=dynamicViscosity(setState_dTX(
            d=bubbleState.d,T=state.T,phase=1));

          xiL := 1.94E-10*((chiL - chiRefL)/0.0496)^(0.63/1.239);
          omegaL := 2/Modelica.Constants.pi*((cpL - cvL)/cpL*
            atan((1/5.285356E-10)*xiL) + cvL/cpL*(1/5.285356E-10)*xiL);
          omegaRefL := 2/Modelica.Constants.pi*(1 - exp(-1/(1/((1/5.285356E-10)*
            xiL) + (((1/5.285356E-10)*xiL*511.899952/bubbleState.d)^2)/3)));
          lambdaCriL := (bubbleState.d*cpL*1.03*Modelica.Constants.k*state.T)/
            (6*Modelica.Constants.pi*etaL*xiL)*(omegaL - omegaRefL);
          lambdaCriL := max(0, lambdaCriL);
        end if;
      end if;

      if dewState.d < 511.899952/100 then
        lambdaCriG := 0;
      else
        chiG := 4059280/511.899952^2*dewState.d/pressure_derd_T(
          setState_dTX(d=dewState.d,T=state.T,phase=1));
        chiRefG := 4059280/511.899952^2*dewState.d/pressure_derd_T(stateRefG)*
          561.411/state.T;
        if ((chiG - chiRefG) < 0) then
          lambdaCriG := 0;
        else
          cpG :=specificHeatCapacityCp(setState_dTX(
            d=dewState.d,T=state.T,phase=1));
          cvG :=specificHeatCapacityCv(setState_dTX(
            d=dewState.d,T=state.T,phase=1));
          etaG :=dynamicViscosity(setState_dTX(
            d=dewState.d,T=state.T,phase=1));

          xiG := 1.94E-10*((chiG - chiRefG)/0.0496)^(0.63/1.239);
          omegaG := 2/Modelica.Constants.pi*((cpG - cvG)/cpG*
            atan((1/5.285356E-10)*xiG) + cvG/cpG*(1/5.285356E-10)*xiG);
          omegaRefG := 2/Modelica.Constants.pi*(1 - exp(-1/(1/((1/5.285356E-10)*
            xiG) + (((1/5.285356E-10)*xiG*511.899952/dewState.d)^2)/3)));
          lambdaCriG := (dewState.d*cpG*1.03*Modelica.Constants.k*state.T)/
            (6*Modelica.Constants.pi*etaG*xiG)*(omegaG - omegaRefG);
          lambdaCriG := max(0, lambdaCriG);
        end if;
      end if;

      // Calculate the final thermal conductivity at bubble and dew line
      lambdaL := lambdaIdg + lambdaResL + lambdaCriL;
      lambdaG := lambdaIdg + lambdaResG + lambdaCriG;

      // Calculate the final dynamic visocity
      lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);
    end if;

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
  annotation (Documentation(revisions="<html><ul>
  <li>June 20, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides a refrigerant model for R134a using a hybrid
  approach developed by Sangi et al.. The hybrid approach is
  implemented in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula</a>
  and the refrigerant model is implemented by complete the template
  <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula</a>
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
        39.5
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
        370.15
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
  Tillner-Roth, R.; Baehr, H. D. (1994): An International Standard
  Formulation for the thermodynamic Properties of
  1,1,1,2|Tetrafluoroethane (HFC|134a) for Temperatures from 170 K to
  455 K and Pressures up to 70 MPa. In: <i>Journal of physical and
  chemical reference data (23)</i>, S. 657–729. DOI: 10.1063/1.555958.
</p>
<p>
  Huber, Marcia L.; Laesecke, Arno; Perkins, Richard A. (2003): Model
  for the Viscosity and Thermal Conductivity of Refrigerants, Including
  a New Correlation for the Viscosity of R134a. In: <i>Ind. Eng. Chem.
  Res. 42 (13)</i> , S. 3163–3178. DOI: 10.1021/ie0300880.
</p>
<p>
  Perkins, R. A.; Laesecke, A.; Howley, J.; Ramires, M. L. V.; Gurova,
  A. N.; Cusco, L. (2000): Experimental thermal conductivity values for
  the IUPAC round-robin sample of 1,1,1,2-tetrafluoroethane (R134a).
  Gaithersburg, MD: <i>National Institute of Standards and
  Technology.</i>
</p>
<p>
  Mulero, A.; Cachadiña, I.; Parra, M. I. (2012): Recommended
  Correlations for the Surface Tension of Common Fluids. In: <i>Journal
  of physical and chemical reference data 41 (4)</i>, S. 43105. DOI:
  10.1063/1.4768782.
</p>
<p>
  Engelpracht, Mirko (2017): Development of modular and scalable
  simulation models for heat pumps and chillers considering various
  refrigerants. <i>Master Thesis</i>
</p>
</html>"));
end R134a_IIR_P1_395_T233_370_Formula;
