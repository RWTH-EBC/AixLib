within AixLib.Media.Refrigerants.R410a;
package R410a_IIR_P1_48_T233_340_Record
  "Refrigerant model for R410a using a hybrid approach with recods"

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
     each dipoleMoment = 0,
     each hasCriticalData=true) "Thermodynamic constants for R410a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
    mediumName="R410a",
    substanceNames={"R410a"},
    singleState=false,
    SpecificEnthalpy(
      start=2.0e5,
      nominal=2.50e5,
      min=143.4e3,
      max=526.1e3),
    Density(
      start=500,
      nominal=750,
      min=5.1,
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

  /*Provide records thats contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state).
  */
  redeclare record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends AixLib.DataBase.Media.Refrigerants.R410a.EoS_IIR_P1_48_T233_340;
  end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R410a.BDSP_IIR_P1_48_T233_340;
  end BDSP;

  redeclare record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R410a.TSP_IIR_P1_48_T233_340;
  end TSP;

  redeclare record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph = 5;
    SpecificEntropy T_ps = 5;
    AbsolutePressure d_pT = 5;
    SpecificEnthalpy d_ph = 5;
    Real d_ps(unit="J/(Pa.K.kg)") =  1/(48e5-0.5e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 1/(48e5-0.5e5);
    AbsolutePressure d_derh_p = 0.2;
  end SmoothTransition;
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
    Real eta_zd "Dynamic viscosity for the limit of zero density";
    Real eta_hd "Dynamic viscosity for the limit of high density";

  algorithm

    // Calculate the dynamic visocity near the limit of zero density
    eta_zd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

    // Calculate the dynamic viscosity for limits of higher densities
    eta_hd := 9.047e-3 + 5.784e-5*state.d^2 + 1.309e-7*state.d^3 -
      2.422e-10*state.d^4 + 9.424e-14*state.d^5 + 3.933e-17*state.d^6;

    // Calculate the final dynamic visocity
    eta := (1.003684953*eta_zd + 1.055260736*eta_hd)*1e-6;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
  "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
    Geller et al. (2001), Thermal Conductivity of the Refrigerant Mixtures R404A,
    R407C, R410A, and R507A. International Journal of Thermophysics, Vol. 22, No. 4.
    Afterwards, the coefficients are adapted to the results obtained by the 
    ExternalMedia libaray (i.e. CoolProp)
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
    lambda := (lambda_0 + 0.9994549202*lambda_r)*1e-3;

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
end R410a_IIR_P1_48_T233_340_Record;
