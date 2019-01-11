within AixLib.Media.Refrigerants;
package R32 "Package with models for R32"
  extends Modelica.Icons.VariantsPackage;

  package R32_IIR_P1_57_T233_373_Formula
    "\"Refrigerant model for R32 using a hybrid approach with explicit formulas\""
   /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
      constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
      refrigerantConstants(
      each chemicalFormula="CH2F2",
      each structureFormula="CH2F2",
      each casRegistryNumber="75-10-5",
      each iupacName="Difluoromethane",
      each molarMass=0.052024,
      each criticalTemperature=351.255,
      each criticalPressure=5782000,
      each criticalMolarVolume=0.052024/424,
      each triplePointTemperature=136.34,
      each triplePointPressure=47.9998938761,
      each normalBoilingPoint= 221,
      each meltingPoint= 137,
      each acentricFactor=0.2769,
      each dipoleMoment=0,
      each hasCriticalData=true) "Thermodynamic constants for R744";

      /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
    extends
      AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
      mediumName="R32",
      substanceNames={"R32"},
      singleState=false,
      SpecificEnthalpy(
        start=200000,
        nominal=200000,
        min=135338.010258576,
        max=627424.654013774),
      Density(
        start=500,
        nominal=350,
        min=1.68595438516567,
        max=1191.29136885037),
      AbsolutePressure(
        start=10e5,
        nominal=10e5,
        min=1e5,
        max=57.82e5),
      Temperature(
        start=268.37,
        nominal=333.15,
        min=233.15,
        max=373.15),
      smoothModel=true,
      onePhase=false,
      ThermoStates=Choices.IndependentVariables.phX,
      fluidConstants=refrigerantConstants);

      redeclare record SmoothTransition "Record that contains ranges to calculate a smooth transition between different regions"
      SpecificEnthalpy T_ph=2.5;
      SpecificEntropy T_ps=2.5;
      AbsolutePressure d_pT=2.5;
      SpecificEnthalpy d_ph=2.5;
      Real d_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
      Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
      end SmoothTransition;

       redeclare function extends f_Idg
      "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
       algorithm
      f_Idg :=
         log(delta) +
         (3.004486)*log(tau^(1)) +
         (-8.258096)*tau^(0) +
         (6.353098)*tau^(1) +
         (1.160761)*log(1 - exp(-(2.2718538)*tau)) +
         (2.645151)*log(1 - exp(-(11.9144210)*tau)) +
         (5.794987)*log(1 - exp(-(5.1415638)*tau)) +
         (1.129475)*log(1 - exp(-(32.7682170)*tau));
       end f_Idg;

    redeclare function extends f_Res
      "Dimensionless Helmholtz energy (Residual part alpha_r)"
    algorithm
      f_Res :=
      (0.1046634e1) * delta^(1) * tau^(0.25) +
      (-0.5451165) * delta^(2) * tau^(1) +
      (-0.2448595e-2) * delta^(5) * tau^(-0.25) +
      (-0.4877002e-1) * delta^(1) * tau^(-1) +
      (0.3520158e-1) * delta^(1) * tau^(2) +
      (0.1622750e-2) * delta^(3) * tau^(2) +
      (0.2377225e-4) * delta^(8) * tau^(0.75) +
      (0.29149e-1) * delta^(4) * tau^(0.25) +
      (0.3386203e-2)* delta^(4) * tau^(18) * exp(-delta^(4)) +
      (-0.4202444e-2)* delta^(4) * tau^(26) * exp(-delta^(3)) +
      (0.4782025e-3)* delta^(8) * tau^(-1) * exp(-delta^(1)) +
      (-0.5504323e-2)* delta^(3) * tau^(25) * exp(-delta^(4)) +
      (-0.2418396e-1)* delta^(5) * tau^(1.75) * exp(-delta^(1)) +
      (0.4209034)* delta^(1) * tau^(4) * exp(-delta^(2)) +
      (-0.4616537)* delta^(1) * tau^(5) * exp(-delta^(2)) +
      (-0.1200513e1)* delta^(3) * tau^(1) * exp(-delta^(1)) +
      (-0.2591550e1)* delta^(1) * tau^(1.5) * exp(-delta^(1)) +
      (-0.1400145e1)* delta^(2) * tau^(1) * exp(-delta^(1)) +
      (0.8263017)* delta^(3) * tau^(0.5) * exp(-delta^(1));
    end f_Res;

    redeclare function extends t_fIdg_t
      "Short form for tau*(dalpha_0/dtau)_delta=const"
    algorithm
      t_fIdg_t :=
       (3.004486)*(1) +
       (6.353098)*(1)*tau^(1) +
       tau*(1.160761)*(2.2718538)/(exp((2.2718538)*tau)-1) +
       tau*(2.645151)*(11.9144210)/(exp((11.9144210)*tau)-1) +
       tau*(5.794987)*(5.1415638)/(exp((5.1415638)*tau)-1) +
       tau*(1.129475)*(32.7682170)/(exp((32.7682170)*tau)-1);
    end t_fIdg_t;



  end R32_IIR_P1_57_T233_373_Formula;

  package R32_IIR_P1_57_T233_373_Record
    "Refrigerant model for R744 using a hybrid approach with records"

    /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
      constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
      refrigerantConstants(
      each chemicalFormula="CH2F2",
      each structureFormula="CH2F2",
      each casRegistryNumber="75-10-5",
      each iupacName="Difluoromethane",
      each molarMass=0.052024,
      each criticalTemperature=351.255,
      each criticalPressure=5782000,
      each criticalMolarVolume=0.052024/424,
      each triplePointTemperature=136.34,
      each triplePointPressure=47.9998938761,
      each normalBoilingPoint= 221,
      each meltingPoint= 137,
      each acentricFactor=0.2769,
      each dipoleMoment=0,
      each hasCriticalData=true) "Thermodynamic constants for R744";

      /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
    extends
      AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord(
      mediumName="R32",
      substanceNames={"R32"},
      singleState=false,
      SpecificEnthalpy(
        start=200000,
        nominal=200000,
        min=135338.010258576,
        max=627424.654013774),
      Density(
        start=500,
        nominal=350,
        min=1.68595438516567,
        max=1191.29136885037),
      AbsolutePressure(
        start=10e5,
        nominal=10e5,
        min=1e5,
        max=57.82e5),
      Temperature(
        start=268.37,
        nominal=333.15,
        min=233.15,
        max=373.15),
      smoothModel=true,
      onePhase=false,
      ThermoStates=Choices.IndependentVariables.phX,
      fluidConstants=refrigerantConstants);

      redeclare record EoS
      "Record that contains fitting coefficients of the Helmholtz EoS"
      extends AixLib.DataBase.Media.Refrigerants.R744.EoS_I0_P1_1000_T233_373;
      end EoS;

    redeclare record BDSP
      "Record that contains fitting coefficients of the state properties at
    bubble and dew lines"
      extends AixLib.DataBase.Media.Refrigerants.R744.BDSP_I0_P1_1000_T233_373;
    end BDSP;

    redeclare record TSP
      "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
      extends AixLib.DataBase.Media.Refrigerants.R744.TSP_I0_P1_1000_T233_373;
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

  end R32_IIR_P1_57_T233_373_Record;
end R32;
