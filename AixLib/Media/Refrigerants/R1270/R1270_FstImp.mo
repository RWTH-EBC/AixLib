within AixLib.Media.Refrigerants.R1270;
package R1270_FstImp "Refrigerant model developed by Engelpracht"

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
     each criticalMolarVolume = 5e3,
     each normalBoilingPoint = 231.036,
     each triplePointTemperature = 85.525,
     each meltingPoint = 85.45,
     each acentricFactor = 0.153,
     each triplePointPressure = 0.00017,
     each dipoleMoment = 0.1,
     each hasCriticalData=true) "Thermodynamic constants for R1270";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium(
    mediumName="Propane",
    substanceNames={"Propane"},
    singleState=false,
    SpecificEnthalpy(
      start=1.0e5,
      nominal=1.0e5,
      min=177e3,
      max=576e3),
    Density(
      start=500,
      nominal=529,
      min=0.77,
      max=547),
    AbsolutePressure(
      start=1e5,
      nominal=5e5,
      min=0.5e5,
      max=30e5),
    Temperature(
      start=273.15,
      nominal=273.15,
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
    extends AixLib.DataBase.Media.Refrigerants.R1270.EoS_Engelpracht;
  end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Engelpracht;
  end BDSP;

  redeclare record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R1270.TSP_Engelpracht;
  end TSP;

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

  /*Provide functions to calculate further thermodynamic properties depending on
    the independent state properties. These functions are polynomial fits in 
    order to reduce computing time. Moreover, these functions may have a
    heuristic to deal with discontinuities. Add further fits if necessary.
  */
  redeclare function extends temperature_ph
  "Calculates temperature as function of pressure and specific enthalpy"
  protected
    SpecificEnthalpy dh = 10;
  end temperature_ph;

  redeclare function extends temperature_ps
  "Calculates temperature as function of pressure and specific entropy"
  protected
    SpecificEntropy ds = 10;
  end temperature_ps;

  redeclare function extends density_pT
  "Calculates density as function of pressure and temperature"
  protected
    AbsolutePressure dp = 10;
  end density_pT;

  redeclare function extends density_ph
  "Computes density as a function of pressure and enthalpy"
  protected
    SpecificEnthalpy dh = 10;
  end density_ph;

  redeclare function extends density_ps
  "Computes density as a function of pressure and entropy"
  protected
    SpecificEntropy ds = 50*p/(30e5-0.5e5);
  end density_ps;

  redeclare function extends specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and entropy"
  protected
    SpecificEntropy ds = 100*p/(30e5-0.5e5);
  end specificEnthalpy_ps;

  redeclare function extends density_derh_p
  "Calculates density derivative (dd/dh)@p=const"
  protected
    AbsolutePressure dp = 0.2;
  end density_derh_p;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 20, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides a refrigerant model for R1270 using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a> and the refrigerant model is implemented by complete the template <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>. The fitting coefficients required in the template are saved in the package <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.R1270\">AixLib.DataBase.Media.Refrigerants.R1270</a>.</p>
<p><b>Assumptions and limitations</b> </p>
<p>The implemented coefficients are fitted to external data by Engelpracht and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>?</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>?</p></td>
<td><p>?</p></td>
</tr>
</table>
<p><b>Validation</b> </p>
<p> The model is validated by comparing results obtained from the example model <a href=\"modelica://AixLib.Media.Refrigerants.Examples.RefrigerantProperties\">AixLib.Media.Refrigerants.Examples.RefrigerantProperties</a> to external data (i.e. NIST RefProp 9.1).</p>
<p><b>References</b> </p>
<p>Engelpracht, Mirko (2017): Development of scalable and modular simulation models for heat pumps and refrigerating machines. <i>Master Thesis</i></p>
</html>"));
end R1270_FstImp;
