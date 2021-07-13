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
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
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
    extends AixLib.DataBase.Media.Refrigerants.R134a.EoS_IIR_P1_395_T233_370;
  end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at
    bubble and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.R134a.BDSP_IIR_P1_395_T233_370;
  end BDSP;

  redeclare record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.R134a.TSP_IIR_P1_395_T233_370;
  end TSP;

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
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a>
  and the refrigerant model is implemented by complete the template
  <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  . The fitting coefficients required in the template are saved in the
  package <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.R134a\">AixLib.DataBase.Media.Refrigerants.R134a</a>.
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
end R134a_IIR_P1_395_T233_370_Record;
