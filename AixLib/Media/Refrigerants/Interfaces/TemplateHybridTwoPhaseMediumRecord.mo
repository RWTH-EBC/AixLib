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
      each hasCriticalData=true) "Thermodynamic constants for refrigerant";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
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
    extends AixLib.DataBase.Media.Refrigerants.R290.EoS_IIR_P05_30_T263_343;
  end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R290.BDSP_IIR_P05_30_T263_343;
  end BDSP;

  redeclare record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R290.TSP_IIR_P05_30_T263_343;
  end TSP;

  redeclare record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph = 10;
    SpecificEntropy T_ps = 10;
    AbsolutePressure d_pT = 10;
    SpecificEnthalpy d_ph = 10;
    Real d_ps(unit="J/(Pa.K.kg)") =  50/(30e5-0.5e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 100/(30e5-0.5e5);
    AbsolutePressure d_derh_p = 0.2;
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
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>This package is a <b>template</b> for <b>new refrigerant</b> models using a hybrid approach based on the &QUOT;Fast_Propane&QUOT; model developed by Sangi et al. (for detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a>). For a new refrigerant model just make a copy of this package, remove the &QUOT;partial&QUOT; keyword from the package and provide the information that is requested in the comments of the Modelica code. The following <b>information is requested</b>:</p>
<ol>
<li><u>Fluid constants:</u><i> </i>Provide basic information of the refrigerant and add the reference.</li>
<li><u>Basic information:</u><i> </i>Provide basic information like the refrigerant name and its valid fluid limits in terms of different thermodynamic state properties.</li>
<li><u>Base properties:</u> Provide information about the refrigerant&apos;s base properties like the relation between specific enthalpy, specific internal energy, pressure and density.</li>
<li><u>Helmholtz EoS:</u> Provide the records that contain the fitting coefficients for the Helmholtz equation of state.</li>
<li><u>Saturation state properties:</u> Provide the records that contain the fitting coefficients for the thermodynamic state properties at bubble and dew line.</li>
<li><u>Fitted state properties:</u> Provide the records that contain the fitting coefficients for thermodynamic state properties that depend on two independent state properties.</li>
<li><u>Further thermodynamic properties:</u> Provide formulas for further thermodynamic properties like the thermal conductivity or surface tension.</li>
</ol>
<p>A refrigerant package inherits from <b>PartialHybridTwoPhaseMediumRecord</b> and provides the equations for the refrigerant. Moreover, the PartialHybridTwoPhaseMedium package inherits from <b>PartialMedium</b> and, therefore, the details of this package are described in <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</p>
<p><b>References</b> </p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
</html>"));
end TemplateHybridTwoPhaseMediumRecord;
