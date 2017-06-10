within AixLib.Media.Refrigerants.Interfaces;
partial package TemplateHybridTwoPhaseMedium
  "Template for media models using a hybrid aprroach"

  /*Provide basic definitions of the refrigerent. Therefore, fullfill constants
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

  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium(
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

//   redeclare record extends ThermodynamicState "Thermodynamic state"
//     Density d "Density";
//     Temperature T "Temperature";
//     AbsolutePressure p "Pressure";
//     SpecificEnthalpy h "Enthalpy";
//   end ThermodynamicState;
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
    The code fragment above is for a single-substance medium with
    p,T as independent variables.
  */

  /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerents. However, the structure will not change and, therefore,
    the coefficients, which are obtained during the fitting procedure, are 
    provided by records.
    Just change if needed.
  */
  redeclare function extends alpha_0
  "Dimensionless Helmholz energy (Ideal gas contribution alpha_0)"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end alpha_0;

  redeclare function extends alpha_r
  "Dimensionless Helmholz energy (Residual part alpha_r)"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end alpha_r;

  redeclare function extends tau_d_alpha_0_d_tau
  "Short form for tau*(dalpha_0/dtau)@delta=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_d_alpha_0_d_tau;

  redeclare function extends tau2_d2_alpha_0_d_tau2
  "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau2_d2_alpha_0_d_tau2;

  redeclare function extends tau_d_alpha_r_d_tau
  "Short form for tau*(dalpha_r/dtau)@delta=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_d_alpha_r_d_tau;

  redeclare function extends tau_delta_d2_alpha_r_d_tau_d_delta
  "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  redeclare function extends tau2_d2_alpha_r_d_tau2
  "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end tau2_d2_alpha_r_d_tau2;

  redeclare function extends delta_d_alpha_r_d_delta
  "Short form for delta*(dalpha_r/(ddelta))@tau=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta_d_alpha_r_d_delta;

  redeclare function extends delta3_d3_alpha_r_d_delta3
  "Short form for delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta3_d3_alpha_r_d_delta3;

  redeclare function extends delta2_d2_alpha_r_d_delta2
  "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
  protected
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.EoS_Sangi();
  end delta2_d2_alpha_r_d_delta2;

  /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). Currently,
    just one fitting approach is implemented. Therefore, the coefficients, which are
    obtained during the fitting procedure, are provided by records.
  */
  redeclare function extends saturationPressure
  "Saturation pressure of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end saturationPressure;

  redeclare function extends saturationTemperature
  "Saturation temperature of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end saturationTemperature;

  redeclare function extends bubbleDensity
  "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleDensity;

  redeclare function extends dewDensity
  "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewDensity;

  redeclare function extends bubbleEnthalpy
  "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
  "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
  "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end bubbleEntropy;

  redeclare function extends dewEntropy
  "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.BDSP_Sangi();
  end dewEntropy;

  /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal concutivity. Also add references.
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
    thermodynamic properties. These functions are polynomial fits in order to
    reduce computing time. Moreover, these functions may have a heuristic to deal with
    discontinuities. Add furhter fits if necessary.
  */
  redeclare function extends temperature_ph
  "Calculates temperature as function of pressure and specific enthalpy"
  protected
    AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
    SpecificEnthalpy dh = 10;
  end temperature_ph;

  redeclare function extends temperature_ps
  "Calculates temperature as function of pressure and specific entroy"
  protected
    AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
    SpecificEntropy ds = 10;
  end temperature_ps;

  redeclare function extends density_pT
  "Calculates density as function of pressure and temperature"
  protected
    AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition
      cf =  AixLib.DataBase.Media.Refrigerants.R1270.TSP_Sangi();
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
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>This package is a <b>template</b> for <b>new medium</b> models using a hybrid approach (for detailed information please see <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a>). For a new refrigerant model just make a copy of this package, remove the &QUOT;partial&QUOT; keyword from the package and provide the information that is requested in the comments of the Modelica source. A refrigerant package inherits from <b>PartialHybridTwoPhaseMedium</b> and provides the equations for the refrigerant. Moreover, the PartialHybridTwoPhaseMedium package inherits from <b>PartialMedium</b> and, therefore, the details of this package are described in <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</p>
</html>"));
end TemplateHybridTwoPhaseMedium;
