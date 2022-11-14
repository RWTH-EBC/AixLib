within AixLib.Media.Refrigerants.Interfaces;
partial package TemplateHybridTwoPhaseMediumRecord
  "Template for media models using a hybrid approach with records"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
  */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
      each chemicalFormula = "CXHY",
      each structureFormula = "CXHY",
      each casRegistryNumber = "xx-xx-x",
      each iupacName = "name",
      each molarMass = 1,
      each criticalTemperature = 1,
      each criticalPressure = 1,
      each criticalMolarVolume = 1,
      each normalBoilingPoint = 1,
      each triplePointTemperature = 1,
      each meltingPoint = 1,
      each acentricFactor = 1,
      each triplePointPressure = 1,
      each dipoleMoment = 1,
      each hasCriticalData=true)
    "Thermodynamic constants for refrigerant";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
    mediumName="Name",
    substanceNames={"Name"},
    singleState=false,
    SpecificEnthalpy(
      start=1.0e5,
      nominal=1.0e5,
      min=50e3,
      max=1000e3),
    Density(
      start=500,
      nominal=500,
      min=0.5,
      max=100),
    AbsolutePressure(
      start=1e5,
      nominal=5e5,
      min=0.5e5,
      max=30e5),
    Temperature(
      start=273.15,
      nominal=273.15,
      min=200.15,
      max=423.15),
    smoothModel=true,
    onePhase=false,
    ThermoStates=.Modelica.Media.Interfaces.Choices.IndependentVariables.phX,
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

  /*Provide records thats contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state).
  */
  redeclare record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends AixLib.DataBase.Media.Refrigerants.R290.EoS_IIR_P05_30_T263_343;
  end EoS;

  redeclare record BDSP "Record that contains fitting coefficients of the
    state properties at bubble and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R290.BDSP_IIR_P05_30_T263_343;
  end BDSP;

  redeclare record TSP "Record that contains fitting coefficients of the
    state properties calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R290.TSP_IIR_P05_30_T263_343;
  end TSP;

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
  /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal conductivity. Also add references.
  */
  redeclare function extends dynamicViscosity
    "Calculates dynamic viscosity of refrigerant"

  algorithm
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"

  algorithm
  end thermalConductivity;

  redeclare function extends surfaceTension
    "Surface tension in two phase region of refrigerant"

  algorithm
  end surfaceTension;
  annotation (Documentation(revisions="<html><ul>
  <li>June 6, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html><p>
  This package is a <b>template</b> for <b>new refrigerant</b> models
  using a hybrid approach based on the \"Fast_Propane\" model developed
  by Sangi et al. (for detailed information, please checkout <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a>
  ). For a new refrigerant model just make a copy of this package,
  remove the \"partial\" keyword from the package and provide the
  information that is requested in the comments of the Modelica code.
  The following <b>information is requested</b>:
</p>
<ol>
  <li>
    <u>Fluid constants:</u> Provide basic information of the
    refrigerant and add the reference.
  </li>
  <li>
    <u>Basic information:</u> Provide basic information like the
    refrigerant name and its valid fluid limits in terms of different
    thermodynamic state properties.
  </li>
  <li>
    <u>Base properties:</u> Provide information about the refrigerant's
    base properties like the relation between specific enthalpy,
    specific internal energy, pressure and density.
  </li>
  <li>
    <u>Helmholtz EoS:</u> Provide the records that contain the fitting
    coefficients for the Helmholtz equation of state.
  </li>
  <li>
    <u>Saturation state properties:</u> Provide the records that
    contain the fitting coefficients for the thermodynamic state
    properties at bubble and dew line.
  </li>
  <li>
    <u>Fitted state properties:</u> Provide the records that contain
    the fitting coefficients for thermodynamic state properties that
    depend on two independent state properties.
  </li>
  <li>
    <u>Further thermodynamic properties:</u> Provide formulas for
    further thermodynamic properties like the thermal conductivity or
    surface tension.
  </li>
</ol>
<p>
  A refrigerant package inherits from
  <b>PartialHybridTwoPhaseMediumRecord</b> and provides the equations
  for the refrigerant. Moreover, the PartialHybridTwoPhaseMedium
  package inherits from <b>PartialMedium</b> and, therefore, the
  details of this package are described in <a href=
  \"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>
  .
</p>
<h4>
  References
</h4>
<p>
  Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
  Müller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A
  Medium Model for the Refrigerant Propane for Fast and Accurate
  Dynamic Simulations</a>. In: <i>The 10th International Modelica
  Conference</i>. Lund, Sweden, March 10-12, 2014: Linköping University
  Electronic Press (Linköping Electronic Conference Proceedings), S.
  1271–1275
</p>
</html>"));
end TemplateHybridTwoPhaseMediumRecord;
