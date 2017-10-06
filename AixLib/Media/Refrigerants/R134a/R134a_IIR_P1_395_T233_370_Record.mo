within AixLib.Media.Refrigerants.R134a;
package R134a_IIR_P1_395_T233_370_Record
  "Refrigerant model for R134a using a hybrid approach with recods"

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
    are the refrigerant name as well as the valid refrigerant limits in terms of
    specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
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

  /*Provide records thats contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state).
  */
  redeclare record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends
      AixLib.DataBase.Media.Refrigerants.R134a.EoS_IIR_P1_395_T233_370;
  end EoS;

  redeclare record BDSP "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends
      AixLib.DataBase.Media.Refrigerants.R134a.BDSP_IIR_P1_395_T233_370;
  end BDSP;

  redeclare record TSP "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends
      AixLib.DataBase.Media.Refrigerants.R134a.TSP_IIR_P1_395_T233_370;
  end TSP;

  redeclare record SmoothTransition "Record that contains ranges to calculate a smooth transition between
    different regions"
      SpecificEnthalpy T_ph = 2.5;
      SpecificEntropy T_ps = 2.5;
      AbsolutePressure d_pT = 2.5;
      SpecificEnthalpy d_ph = 2.5;
      Real d_ps(unit="J/(Pa.K.kg)") =  25/(39.5e5-1e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5-1e5);
  end SmoothTransition;
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
    Real Tred = state.T/299.363
      "Reduced temperature for lower density terms";                           //valid
    Real omega_eta "Reduced effective collision cross section";
    Real eta_zd "Dynamic viscosity for the limit of zero density";
    Real B_eta_zd
      "Second viscosity virial coefficient for the limit of zero density";
    Real B_eta "Second viscosity virial coefficient";
    Real eta_n "Dynamic viscosity for moderate density limits";
    Real tau = state.T/374.21
      "Reduced temperature for higher density terms";                         //valid
    Real delta = state.d/511.9 "Reduced density for higher density terms"; //valid
    Real delta_hd "Reduced close-pacled density";
    Real eta_hd "Dynamic viscosity for the limit of high density";

  algorithm
    // Calculate the dynamic visocity near the limit of zero density
    if abs(Tred)<1E-20 then
      Tred := 1E-20;
    end if;
    omega_eta := exp(0.355404 - 0.464337*Tred + 0.257353E-1*Tred^2);
    eta_zd := 0.1399787595 * sqrt(state.T) / (0.468932^2*omega_eta);

    // Calculate the second viscosity virial coefficient
    B_eta_zd := -0.19572881E+2 + 0.21973999E+3*Tred^(-0.25) -
      0.10153226E+4*Tred^(-0.50) + 0.24710125E+4*Tred^(-0.75) -
      0.33751717E+4*Tred^(-1.00) + 0.24916597E+4*Tred^(-1.25) -
      0.78726086E+3*Tred^(-1.50) + 0.14085455E+2*Tred^(-2.50) -
      0.34664158E+0*Tred^(-5.50);
    B_eta_zd := B_eta_zd*0.6022137*0.468932^3;
    eta_n := eta_zd*B_eta_zd*(state.d/(1000*fluidConstants[1].molarMass));

    // Calculate the dynamic viscosity for limits of higher densities
    delta_hd := 3.163695635587490/(1 - 0.8901733752064137E-1*tau +
      0.1000352946668359*tau^2);
    eta_hd :=   -0.2069007192080741E-1*delta +
      0.3560295489828222E-3*tau^(-6.00)*delta^(2.00) +
      0.2111018162451597E-2*tau^(-2.00)*delta^(2.00) +
      0.1396014148308975E-1*tau^(-0.50)*delta^(2.00) -
      0.4564350196734897E-2*tau^(2.00)*delta^(2.00) -
      0.3515932745836890E-2*delta^(3.00) -
      0.2147633195397038*delta_hd^(-1) + (0.2147633195397038/(delta_hd - delta));
    eta_hd := eta_hd*1e3;

    // Calculate the final dynamic visocity
    eta := (eta_zd + eta_n + eta_hd)*1e-6;

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
    Real lambda_0 "Thermal conductivity for the limit of zero density";
    Real delta = state.d/515.2499684
      "Reduced density for the residual part";
    Real lambda_r "Thermal conductivity for residual part";
    ThermodynamicState state_0(
      d=state.d,
      T=561.411,
      p=pressure_dT(d=state.d,T=561.411,phase=state.phase),
      h = specificEnthalpy_dT(d=state.d,T=561.411,phase=state.phase),
      phase = state.phase) "Reference state for crossover function";
    Real chi "Dimensionless susceptibility";
    Real xi "Correlation length";
    Real chi_0 "Dimensionless susceptibility at reference state";
    Real cp = specificHeatCapacityCp(state)
      "Specific heat capacity at constant pressure";
    Real cv = specificHeatCapacityCv(state)
      "Specific heat capacity at constant volume";
    Real eta = dynamicViscosity(state) "Dynamic viscosity";
    Real omega "Crossover function";
    Real omega_0 "Crossover function at reference state";
    Real lambda_c
      "Thermal conductivity for the region of the critical point";
  algorithm

    // Calculate the thermal conducitvity for the limit of zero density
    lambda_0 := -0.0105248 + 0.0000800982*state.T;

    // Calculate the thermal conductivity for the residual part
    lambda_r := 1.836526E+0*delta + 5.126143E+0*delta^2 -
      1.436883E+0*delta^3 + 6.261441E-1*delta^4;
    lambda_r := lambda_r*2.055E-3;

    // Calculate the thermal conductivity for the regition of the critical point
    if state.d < 511.899952/100 then
      lambda_c := 0;
    else
      chi := 4059280/511.899952^2*state.d/pressure_derd_T(state);
      chi_0 := 4059280/511.899952^2*state.d/pressure_derd_T(state_0)*561.411/state.T;
      if ((chi - chi_0) < 0) then
        lambda_c := 0;
      else
        xi := 1.94E-10*((chi - chi_0)/0.0496)^(0.63/1.239);
        omega := 2/Modelica.Constants.pi*((cp - cv)/cp*atan((1/5.285356E-10)*xi)
          + cv/cp*(1/5.285356E-10)*xi);
        omega_0 := 2/Modelica.Constants.pi*(1 - exp(-1/(1/((1/5.285356E-10)*xi)
          + (((1/5.285356E-10)*xi*511.899952/state.d)^2)/3)));
        lambda_c := (state.d*cp*1.03*Modelica.Constants.k*state.T)/
          (6*Modelica.Constants.pi*eta*xi)*(omega - omega_0);
        lambda_c := max(0, lambda_c);
      end if;
    end if;

    // Calculate the final thermal conductivity
    lambda := lambda_0 + lambda_r + lambda_c;

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
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 20, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides a refrigerant model for R134a using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a> and the refrigerant model is implemented by complete the template <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>. The fitting coefficients required in the template are saved in the package <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.R134a\">AixLib.DataBase.Media.Refrigerants.R134a</a>.</p>
<h4>Assumptions and limitations</h4>
<p>The implemented coefficients are fitted to external data by Engelpracht and are valid within the following range:</p>
<p>
<table summary=\"Range of validiry\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\" style=\"border-collapse:collapse;\">
<tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>1</p></td>
<td><p>39.5</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>233.15</p></td>
<td><p>370.15</p></td>
</tr>
</table>
</p>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<h4>Validation</h4>
<p> The model is validated by comparing results obtained from the example model <a href=\"modelica://AixLib.Media.Refrigerants.Examples.RefrigerantProperties\">AixLib.Media.Refrigerants.Examples.RefrigerantProperties</a> to external data (e.g. obtained from measurements or external media libraries).</p>
<h4>References</h4>
<p>Tillner-Roth, R.; Baehr, H. D. (1994): An International Standard Formulation for the thermodynamic Properties of 1,1,1,2|Tetrafluoroethane (HFC|134a) for Temperatures from 170 K to 455 K and Pressures up to 70 MPa. In: <i>Journal of physical and chemical reference data (23)</i>, S. 657–729. DOI: 10.1063/1.555958.</p>
<p>Huber, Marcia L.; Laesecke, Arno; Perkins, Richard A. (2003): Model for the Viscosity and Thermal Conductivity of Refrigerants, Including a New Correlation for the Viscosity of R134a. In: <i>Ind. Eng. Chem. Res. 42 (13)</i>, S. 3163–3178. DOI: 10.1021/ie0300880.</p>
<p>Perkins, R. A.; Laesecke, A.; Howley, J.; Ramires, M. L. V.; Gurova, A. N.; Cusco, L. (2000): Experimental thermal conductivity values for the IUPAC round-robin sample of 1,1,1,2-tetrafluoroethane (R134a). Gaithersburg, MD: <i>National Institute of Standards and Technology.</i></p>
<p>Mulero, A.; Cachadiña, I.; Parra, M. I. (2012): Recommended Correlations for the Surface Tension of Common Fluids. In: <i>Journal of physical and chemical reference data 41 (4)</i>, S. 43105. DOI: 10.1063/1.4768782.</p>
<p>Engelpracht, Mirko (2017): Development of modular and scalable simulation models for heat pumps and chillers considering various refrigerants. <i>Master Thesis</i></p>
</html>"));
end R134a_IIR_P1_395_T233_370_Record;
