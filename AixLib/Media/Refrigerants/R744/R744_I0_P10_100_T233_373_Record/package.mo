within AixLib.Media.Refrigerants.R744;
package R744_I0_P10_100_T233_373_Record "Refrigerant model for R744 using a hybrid approach with records"

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
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
    mediumName="R744",
    substanceNames={"R744"},
    singleState=false,
    SpecificEnthalpy(
      start=0,
      nominal=0,
      min=-3.958414680723884e+05,
      max=6.915853192761162e+04),
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
      min=233.15,
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
redeclare record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends AixLib.DataBase.Media.Refrigerants.R744.EoS_I0_P10_100_T233_373;
end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at
    bubble and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R744.BDSP_I0_P10_100_T233_373;
  end BDSP;

  redeclare record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R744.TSP_I0_P10_100_T233_373;
  end TSP;

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

    Real Tred = state.T/251.196 "Reduced temperature for lower density terms";
    Real omegaEta "Reduced effective collision cross section";
    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real etaL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaG "Dynamic viscosity for the limit of high density at dew line";
    Real etaExc;
    Real etaExcL;
    Real etaExcG;
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
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156-0.491266*Tred+0.05211155*Tred^2+0.05347906*Tred^3-0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T) / omegaEta;

      //Calculate excess viscosity
      etaExc := 0.4071119E-2 * state.d + 0.7198037E-4 * state.d^2 + 0.2411697E-16 * state.d^6 / Tred^3 + 0.2971072E-22 * state.d^8 - 0.1627888E-22 * state.d^8 / Tred;

      //Calculate the final dynamic viscosity
      eta := (etaExc+etaZd)*1e-6;

else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156-0.491266*Tred+0.05211155*Tred^2+0.05347906*Tred^3-0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T) / omegaEta;

      //Calculate excess viscosity
      etaExcL := 0.4071119E-2 * bubbleState.d + 0.7198037E-4 * bubbleState.d^2 + 0.2411697E-16 * bubbleState.d^6 / Tred^3 + 0.2971072E-22 * bubbleState.d^8 - 0.1627888E-22 * bubbleState.d^8 / Tred;
      etaExcG := 0.4071119E-2 * dewState.d + 0.7198037E-4 * dewState.d^2 + 0.2411697E-16 * dewState.d^6 / Tred^3 + 0.2971072E-22 * dewState.d^8 - 0.1627888E-22 * dewState.d^8 / Tred;

      //Calculate the final dynamic viscosity
      etaL := (etaExcL+etaZd)*1e-6;
      etaG := (etaExcG+etaZd)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
end if;

end dynamicViscosity;

redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"
    /*The functional form of the thermal conductivity is implented as presented in
    G. Scalabrin et al (2006), A Reference Multiparameter Thermal Conductivity
    Equation for Carbon Dioxide with an Optimized Functional Form*/
protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Integer phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";
    Real delta "Reduced density";
    Real deltaG "Reduced density at dew line";
    Real deltaL "Reduced density at bubble line";
    Real tau "Reduced temperature";
    Real lambdaG "thermal conductivity at bubble dew line";
    Real lambdaL "thermal conductivity at bubble dew line";
    Real lambdaR "Reduced thermal conductivity";
    Real lambdaRCri "Reduced thermal conductivity in critical region";
    Real lambdaRNonCri "Reduced thermal conductivity without critical region";
    Real lambdaRG "Reduced thermal conductivity";
    Real lambdaRCriG "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriG "Reduced thermal conductivity without critical region";
    Real lambdaRL "Reduced thermal conductivity";
    Real lambdaRCriL "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriL "Reduced thermal conductivity without critical region";
    Real alpha "coefficient for the critical region term";
    Real small = Modelica.Constants.small;

    final constant Real lambdaC = 4.81384;
    final constant Real n[11] = {
    7.69857587,
    0.159885811,
    1.56918621,
    -6.73400790,
    16.3890156,
    3.69415242,
    22.3205514,
    66.1420950,
    -0.171779133,
    0.00433043347,
    0.775547504};
    final constant Real g[10]= {
    0,
    0,
    1.5,
    0,
    1,
    1.5,
    1.5,
    1.5,
    3.5,
    5.5};
    final constant Integer h[10]= {
    1,
    5,
    1,
    1,
    2,
    0,
    5,
    9,
    0,
    0};
    final constant Real a[12]={
    3,
    6.70697,
    0.94604,
    0.3,
    0.3,
    0.39751,
    0.33791,
    0.77963,
    0.79857,
    0.90,
    0.02,
    0.20};

algorithm
  // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;
      delta := state.d/467.6;
      tau   := state.T/304.1282;
    if (state.phase == 1 or phase_dT == 1) then
      // Calculate properties

      alpha := 1-a[10]*Modelica.Math.acosh(1+a[11]*((1-tau)^2)^a[12]);
      lambdaRNonCri :=
      sum(n[i] * tau^g[i] * delta^h[i] for i in 1:3)+
      exp(-5*delta^2)*sum(n[i]*tau^g[i]*delta^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCri :=
      (delta * exp(-delta^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(delta-1))^2))/
      ( ((((1-1/tau)+a[4]*((delta-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(delta-alpha))^2)^a[8])^a[9]);
      lambdaR := lambdaRNonCri+n[11]*lambdaRCri;
      //Calculate the final thermal conductivity
      lambda :=lambdaC*lambdaR;
    else
      // Calculate properties
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);
      deltaL :=bubbleState.d/467.6;
      deltaG :=dewState.d/467.6;

      alpha := 1-a[10]*Modelica.Math.acosh(1+a[11]*((1-tau)^2)^a[12]);
      lambdaRNonCriG :=
      sum(n[i] * tau^g[i] * deltaG^h[i] for i in 1:3)+
      exp(-5*deltaG^2)*sum(n[i]*tau^g[i]*deltaG^h[i] for i in 4:10);
      lambdaRNonCriL :=
      sum(n[i] * tau^g[i] * deltaL^h[i] for i in 1:3)+
      exp(-5*deltaL^2)*sum(n[i]*tau^g[i]*deltaL^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCriL :=
      (delta * exp(-deltaL^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(deltaL-1))^2))/
      ( ((((1-1/tau)+a[4]*((deltaL-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(deltaL-alpha))^2)^a[8])^a[9]);
      lambdaRCriG :=
      (delta * exp(-deltaG^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(deltaG-1))^2))/
      ( ((((1-1/tau)+a[4]*((deltaG-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(deltaG-alpha))^2)^a[8])^a[9]);
      lambdaRG := lambdaRNonCriG+lambdaRCriG;
      lambdaRL := lambdaRNonCriL+lambdaRCriL;
      //Calculate the final thermal conductivity
      lambdaG :=lambdaC*lambdaRG;
      lambdaL :=lambdaC*lambdaRL;
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
    sigma := 0.07863*(1-sat.Tsat/304.1282)^1.254;
 end surfaceTension;
end R744_I0_P10_100_T233_373_Record;
