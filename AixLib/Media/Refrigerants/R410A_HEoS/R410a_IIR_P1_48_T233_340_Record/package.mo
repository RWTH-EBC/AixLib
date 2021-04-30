within AixLib.Media.Refrigerants.R410A_HEoS;
package R410a_IIR_P1_48_T233_340_Record "Refrigerant model for R410a using a hybrid approach with recods"

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
     each criticalMolarVolume = 1/6324,
     each normalBoilingPoint = 221.71,
     each triplePointTemperature = 200,
     each meltingPoint = 118.15,
     each acentricFactor = 0.296,
     each triplePointPressure = 29160,
     each dipoleMoment = 0,
     each hasCriticalData=true) "Thermodynamic constants for R410a";

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
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

  /*Provide records thats contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state).
  */
  redeclare record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends AixLib.DataBase.Media.Refrigerants.R410a.EoS_IIR_P1_48_T233_340;
  end EoS;

  redeclare record BDSP
    "Record that contains fitting coefficients of the state properties at
    bubble and dew lines"
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
      SpecificEnthalpy T_ph = 2.5;
      SpecificEntropy T_ps = 2.5;
      AbsolutePressure d_pT = 2.5;
      SpecificEnthalpy d_ph = 2.5;
      Real d_ps(unit="J/(Pa.K.kg)") =  50/(48e5-1e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 50/(48e5-1e5);
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
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real etaHd "Dynamic viscosity for the limit of high density";
    Real etaHdL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaHdG "Dynamic viscosity for the limit of high density at dew line";
    Real etaL "Dynamic viscosity at dew line";
    Real etaG "Dynamic viscosity at bubble line";

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
      etaZd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

      // Calculate the dynamic viscosity for limits of higher densities
      etaHd := 9.047e-3 + 5.784e-5*state.d^2 + 1.309e-7*state.d^3 -
        2.422e-10*state.d^4 + 9.424e-14*state.d^5 + 3.933e-17*state.d^6;

      // Calculate the final dynamic visocity
      eta := (1.003684953*etaZd + 1.055260736*etaHd)*1e-6;
    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      etaZd := -2.695 + 5.850e-2*state.T - 2.129e-5*state.T^2;

      // Calculate the dynamic viscosity for limits of higher densities
      etaHdL := 9.047e-3 + 5.784e-5*bubbleState.d^2 + 1.309e-7*bubbleState.d^3 -
        2.422e-10*bubbleState.d^4 + 9.424e-14*bubbleState.d^5 +
        3.933e-17*bubbleState.d^6;
      etaHdG := 9.047e-3 + 5.784e-5*dewState.d^2 + 1.309e-7*dewState.d^3 -
        2.422e-10*dewState.d^4 + 9.424e-14*dewState.d^5 +
        3.933e-17*dewState.d^6;

      // Calculate the dynamic visocity at bubble and dew line
      etaL := (1.003684953*etaZd + 1.055260736*etaHdL)*1e-6;
      etaG := (1.003684953*etaZd + 1.055260736*etaHdG)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
    end if;

  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"

  /*The functional form of the thermal conductify is implented as presented in
    Geller et al. (2001), Thermal Conductivity of the Refrigerant Mixtures
    R404A, R407C, R410A, and R507A. International Journal of Thermophysics,
    Vol. 22, No. 4. Afterwards, the coefficients are adapted to the results
    obtained by the ExternalMedia libaray (i.e. CoolProp)
  */
protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real lambdaIdg "Thermal conductivity for the limit of zero density";
    Real lambdaRes "Thermal conductivity for residual part";
    Real lambdaResL "Thermal conductivity for residual part at bubble line";
    Real lambdaResG "Thermal conductivity for residual part at dew line";
    Real lambdaL "Thermal conductivity at dew line";
    Real lambdaG "Thermal conductivity at bubble line";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;

    if (state.phase == 1 or phase_dT == 1) then
      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -8.872 + 7.41e-2*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaRes := 3.576e-2*state.d - 9.045e-6*state.d^2 + 4.343e-8*state.d^3
        - 3.705e-12*state.d^4;

      // Calculate the final thermal conductivity
      lambda := (lambdaIdg + 0.9994549202*lambdaRes)*1e-3;
    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the thermal conducitvity for the limit of zero density
      lambdaIdg := -8.872 + 7.41e-2*state.T;

      // Calculate the thermal conductivity for the residual part
      lambdaResL := 3.576e-2*bubbleState.d - 9.045e-6*bubbleState.d^2 +
        4.343e-8*bubbleState.d^3 - 3.705e-12*bubbleState.d^4;
      lambdaResG := 3.576e-2*dewState.d - 9.045e-6*dewState.d^2 +
        4.343e-8*dewState.d^3 - 3.705e-12*dewState.d^4;

      // Calculate the thermal conductivity at bubble and dew line
      lambdaL := (lambdaIdg + 0.9994549202*lambdaResL)*1e-3;
      lambdaG := (lambdaIdg + 0.9994549202*lambdaResG)*1e-3;

      // Calculate the final thermal conductivity
      lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);
    end if;

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
    sigma := (67.468*(1-tau)^1.26 * (1 - 0.051*(1-tau)^0.5 -
      0.193*(1-tau)))*1e-3;
  end surfaceTension;

  annotation (Documentation(revisions="<html><ul>
  <li>June 20, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides a refrigerant model for R410a using a hybrid
  approach developed by Sangi et al.. The hybrid approach is
  implemented in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">
  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a>
  and the refrigerant model is implemented by complete the template
  <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  . The fitting coefficients required in the template are saved in the
  package <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.R410a\">AixLib.DataBase.Media.Refrigerants.R410a</a>
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
        48
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
        340.15
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
  Assumptions and limitations
</h4>
<p>
  R410a is calculated as pseudo-pure fluid and, hence, only roughly
  valid withing the two-phase region.
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
  Lemmon, E. W. (2003): Pseudo-Pure Fluid Equations of State for the
  Refrigerant Blends R-410A, R-404A, R-507A, and R-407C. In:
  <i>International Journal of Thermophysics 24 (4)</i>, S. 991–1006.
  DOI: 10.1023/A:1025048800563.
</p>
<p>
  Geller, V. Z.; Bivens, D.; Yokozeki, A. (2000): Viscosity of Mixed
  Refrigerants, R404A, R407C, R410A, and R507C. In: <i>International
  refrigeration and air conditioning conference</i>. USA, S. 399–406.
  Online available at http://docs.lib.purdue.edu/iracc/508.
</p>
<p>
  Nabizadeh, H.; Mayinger, F. (1999): Viscosity of Gaseous R404A,
  R407C, R410A, and R507. In: <i>International Journal of Thermophysics
  20 (3)</i>, S. 777–790. DOI: 10.1007/978-1-4615-4777-8_1.
</p>
<p>
  Geller, V. Z.; Nemzer, B. V.; Cheremnykh, U. V. (2001): Thermal
  Conductivity of the Refrigerant Mixtures R404A, R407C, R410A, and
  R507A. In: <i>International Journal of Thermophysics 22 (4)</i>,
  1035–1043. DOI: 10.1023/A:1010691504352.
</p>
<p>
  Fröba, A. P.; Leipertz, A. (2003): Thermophysical Properties of the
  Refrigerant Mixtures R410A and R407C from Dynamic Light Scattering
  (DLS). In: <i>International Journal ofThermophysics 24 (5)</i>, S.
  1185–1206. DOI: 10.1023/A:1026152331710.
</p>
<p>
  Engelpracht, Mirko (2017): Development of modular and scalable
  simulation models for heat pumps and chillers considering various
  refrigerants. <i>Master Thesis</i>
</p>
</html>"));
end R410a_IIR_P1_48_T233_340_Record;
