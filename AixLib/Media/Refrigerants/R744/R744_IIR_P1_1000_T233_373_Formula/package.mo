within AixLib.Media.Refrigerants.R744;
package R744_IIR_P1_1000_T233_373_Formula "Refrigerant model for R744 using a hybrid approach with explicit formulas"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
    each chemicalFormula="CO2",
    each structureFormula="CO2",
    each casRegistryNumber="124-38-9",
    each iupacName="Carbon dioxide",
    each molarMass=0.0440098,
    each criticalTemperature=304.1282,
    each criticalPressure=7377300,
    each criticalMolarVolume=0.0021*0.044,
    each triplePointTemperature=216.55,
    each triplePointPressure=518000,
    each normalBoilingPoint=195.15,
    each meltingPoint=216.6,
    each acentricFactor=0.22394,
    each dipoleMoment=0,
    each hasCriticalData=true) "Thermodynamic constants for R744";
  //(sublimes)

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R744",
    substanceNames={"R744"},
    singleState=false,
    SpecificEnthalpy(
      start=2.0e5,
      nominal=2.0e5,
      min=110000,
      max=503750),
    Density(
      start=500,
      nominal=350,
      min=14.53,
      max=1139),
    AbsolutePressure(
      start=10e5,
      nominal=50e5,
      min=10e5,
      max=100e5),
    Temperature(
      start=268.37,
      nominal=333.15,
      min=243.15,
      max=373.15),
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
  redeclare record SmoothTransition "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph=2.5;
    SpecificEntropy T_ps=2.5;
    AbsolutePressure d_pT=2.5;
    SpecificEnthalpy d_ph=2.5;
    Real d_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  final constant Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,0.62105248,
      0.41195293,1.04028922,0.08327678};
  final constant Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792};

  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"

  algorithm
    f_Idg := log(delta) + idealAlpha0[1] - idealAlpha0[2]*tau + idealAlpha0[3]*
      log(tau) + idealAlpha0[4]*log(1 - exp(-tau*idealPhi0[4])) + idealAlpha0[5]
      *log(1 - exp(-tau*idealPhi0[5])) + idealAlpha0[6]*log(1 - exp(-tau*
      idealPhi0[6])) + idealAlpha0[7]*log(1 - exp(-tau*idealPhi0[7])) +
      idealAlpha0[8]*log(1 - exp(-tau*idealPhi0[8]));
  end f_Idg;
  final constant Real residualN0[42] = {
    0.38856823203161,
    0.29385475942740E+01,
   -0.55867188534934E+01,
   -0.76753199592477E+00,
    0.31729005580416E+00,
    0.54803315897737E+00,
    0.12279411220335E+00,
    0.21658961543220E+01,
    0.15841735109724E+01,
   -0.23132705405503E+00,
    0.58116916431436E-01,
   -0.55369137205382E+00,
    0.48946615909422E+00,
   -0.24275739843501E-01,
    0.62494790501678E-01,
   -0.12175860225246E+00,
   -0.37055685270086E+00,
   -0.16775879700426E-01,
   -0.11960736637987E+00,
   -0.45619362508778E-01,
    0.35612789270346E-01,
   -0.74427727132052E-02,
   -0.17395704902432E-02,
   -0.21810121289527E-01,
    0.24332166559236E-01,
   -0.37440133423463E-01,
    0.14338715756878E+00,
   -0.13491969083286E+00,
   -0.23151225053480E-01,
    0.12363125492901E-01,
    0.21058321972940E-02,
   -0.33958519026368E-03,
    0.55993651771592E-02,
   -0.30335118055646E-03,
   -0.21365488688320E+03,
    0.26641569149272E+05,
   -0.24027212204557E+05,
   -0.28341603423999E+03,
    0.21247284400179E+03,
   -0.66642276540751E+00,
    0.72608632349897E+00,
    0.550686686128E-01};

end R744_IIR_P1_1000_T233_373_Formula;
