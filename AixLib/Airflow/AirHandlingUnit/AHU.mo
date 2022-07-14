within AixLib.Airflow.AirHandlingUnit;
model AHU
  "Air Handling Unit with Heat Recovery System, Cooling, Heating, Humidification (adiabatic), Dehumidification"
  extends AixLib.Airflow.AirHandlingUnit.BaseClasses.PartialAHU;
  /*
 indices and abbreviations:
 HRS = heat recovery system
 sup = supply air
 eta = extract air
 oda = outdoor air
 eha = exhaust air
 BPF = By-pass factor
 DeHu = dehumidification
 Hu = humidification
 H = heat(ing)
 C = cool(ing)
 sat = saturation
 phi_t is the HRS' efficiency not a relative humidity like other phis
 */

  //// Variables
  // Booleans for transitions to State Machines
  inner Boolean stateToDeHuHRS_true;
  inner Boolean stateToDeHuHRS_false;
  inner Boolean stateToHuPreHHRS_true;
  inner Boolean stateToHuPreHHRS_false;
  inner Boolean stateToHuCHRS_true;
  inner Boolean stateToHuCHRS_false;
  inner Boolean stateToOnlyHeatingHRS_true;
  inner Boolean stateToOnlyHeatingHRS_false;
  inner Boolean stateToOnlyCoolingHRS_true;
  inner Boolean stateToOnlyCoolingHRS_false;

  Boolean tooHighX(start=false);
  Boolean tooLowX(start=false);
  Boolean choiceX(start=true);
  Boolean allCond(start=false);

  // Variables that will be set with parameteres of HRS efficiency
  inner Real phi_t_withHRS(start=efficiencyHRS_enabled)
    "efficiency of HRS in the AHU modes when HRS is enabled";
  inner Real phi_t_withoutHRS(start=efficiencyHRS_disabled)
    "efficiency of HRS in the AHU modes when HRS is disabled";
  inner Real phi_t(start=0.5);

  inner Modelica.Units.SI.Temperature T_oda;
                                      //(start=288.15);
  inner Modelica.Units.SI.Temperature T_1(start=290.15);
  inner Modelica.Units.SI.Temperature T_5(start=293.15);
  inner Modelica.Units.SI.Temperature T_sup(start=295.15);
  inner Modelica.Units.SI.Temperature T_eta(start=296.15);
  inner Modelica.Units.SI.Temperature T_6;
                                    //(start=296.15);

  inner Modelica.Units.SI.MassFraction X_oda(start=0.007);
  Modelica.Units.SI.MassFraction X_odaSat(start=0.007);
  Modelica.Units.SI.MassFraction X_odaRaw(start=0.007);
  inner Modelica.Units.SI.MassFraction X_sup(start=0.008);
  Modelica.Units.SI.MassFraction X_supplyMin(start=0.006);
  Modelica.Units.SI.MassFraction X_supplyMax(start=0.010);
  inner Modelica.Units.SI.MassFraction X_supMin(start=0.006);
  inner Modelica.Units.SI.MassFraction X_supMax(start=0.010);
  Modelica.Units.SI.MassFraction X_extractAir(start=0.008);
  Modelica.Units.SI.MassFraction X_eta(start=0.008);
  Real phi_sup(start=0.5);

  inner Modelica.Units.SI.HeatFlowRate Q_dot_C(start=1e-3);
  inner Modelica.Units.SI.HeatFlowRate Q_dot_H(start=1e-3);
  Modelica.Units.SI.Power P_el_sup(start=1e-3);
  Modelica.Units.SI.Power P_el_eta(start=1e-3);
  inner Modelica.Units.SI.VolumeFlowRate V_dot_sup(start=1e-3);
  inner Modelica.Units.SI.VolumeFlowRate V_dot_eta(start=1e-3);

  // Constants from formulas collection of Thermodynamik (institute: LTT)
  constant Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure c_pL_iG=1E3;
  constant Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure c_pW_iG=
      1.86E3;
  constant Modelica.Units.SI.SpecificEnthalpy r_0=2465E3
    "enthalpy of vaporization at temperature between T_dew(X_sup=0.008)=11 degC and T_sup = 22 degC";
  constant Modelica.Units.SI.Density rho=1.2;
  constant Modelica.Units.SI.Pressure p_0=101325;
  constant Modelica.Units.SI.SpecificEnthalpy dhV=2501.3E3;
  constant Modelica.Units.SI.Temperature T_0=273.15;
  constant Real molarMassRatio=Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
      /Modelica.Media.Air.SimpleAir.MM_const;

  // auxiliary variable
  Modelica.Units.SI.TemperatureDifference dTFan;
  Modelica.Units.SI.Temperature TsupplyAirOut(start=295.15);

  // Sampler (time-continous to time-discrete variables)

  Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked sample(n=9)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-66,14})));

  Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(
    solverMethod="ExplicitRungeKutta4",
    useSolver=true,
    period=clockPeriodGeneric)
    annotation (Placement(transformation(extent={{-94,8},{-82,20}})));

  //
  ////////////////////////////
  //State Machines////////////
  ////////////////////////////
  //
  //Start State

  block StartState
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;

  equation
    Q_dot_C = previous(Q_dot_C);
    Q_dot_H = previous(Q_dot_H);
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end StartState;

  StartState startState
    annotation (Placement(transformation(extent={{-82,-24},{-62,-4}})));

  //
  //
  // (comments for state machines only in the dehumidification state machine as representive comments)
  //
  // Dehumidification

  block DeHuHRS_true
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2(start=290);
    Modelica.Units.SI.Temperature T_3(start=282);
    Modelica.Units.SI.Temperature T_4(start=282);
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMax;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withHRS;
    outer parameter Real BPF_DeHu;
    Modelica.Units.SI.SpecificEnthalpy h_2(start=0.003) "h_in of cooler";
    Modelica.Units.SI.SpecificEnthalpy h_surface(start=0.002)
      "h_surface of cooler";
    Modelica.Units.SI.SpecificEnthalpy h_CoilOut(start=0.001) "h_out of cooler";
    Modelica.Units.SI.Pressure p_sat_surface(start=2300);
    Modelica.Units.SI.MassFraction X_surface(start=0.005);
    Modelica.Units.SI.Temperature T_surface(start=280);
    Modelica.Units.SI.Temperature T_CoilOut(start=278);

  equation
    phi_t = phi_t_withHRS "heat recovery system is enabled";
    X_sup = previous(X_supMax);
    T_1 = T_2;
    T_3 = T_CoilOut;
    T_4 = T_3;

    BPF_DeHu = (h_CoilOut - h_surface)/max(h_2 - h_surface, 0.01);
    h_2 = c_pL_iG*(previous(T_2) - T_0) + previous(X_oda)*(c_pW_iG*(previous(
      T_2) - T_0) + dhV);
    h_surface = c_pL_iG*(T_surface - T_0) + X_surface*(c_pW_iG*(T_surface - T_0)
       + dhV);
    h_CoilOut = c_pL_iG*(T_CoilOut - T_0) + X_sup*(c_pW_iG*(T_CoilOut - T_0) +
      dhV);
    (previous(T_2) - T_surface)/max(previous(X_oda) - X_surface, 0.00009) = (
      T_CoilOut - T_surface)/max(previous(X_supMax) - X_surface, 0.00001);

    /*
  p_sat_surface = 611.2*exp(17.62*(T_surface - T_0)/(243.12 + T_surface - T_0));
  //Magnus formula over water, improved by Sonntag (1990), Range: -45 degC to +60 degC
  2 Alternatives for calculation of water vapor pressure, which are not so stable during simulation:
  p_sat_surface = 10^(-7.90298*(373.15/T_surface - 1)
          +5.02808*log10(373.15/T_surface)
          -1.3816*10^(-7)*(10^(11.344*(1 - T_surface/373.15))-1)
          +8.1328*10^(-3)*(10^(-3.49149*(373.15/T_surface - 1))-1)
          +log10(1013.246))*100; //The Goff Gratch equation for the vapor pressure over liquid water covers a region of -50 degC to +102 degC.
*/
    p_sat_surface = Modelica.Media.Air.MoistAir.saturationPressure(T_surface);

    X_surface = molarMassRatio*p_sat_surface/(p_0 - p_sat_surface);

    Q_dot_C = previous(V_dot_sup)*rho*((c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - T_CoilOut) + (previous(X_oda) - X_sup)*r_0);
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + X_sup*c_pW_iG)*(previous(T_5) -
      T_CoilOut);

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end DeHuHRS_true;
  DeHuHRS_true deHuHRS_true "Dehumidification and Heat Recovery System enabled"
    annotation (Placement(transformation(extent={{-84,-68},{-70,-56}})));

  //
  //
  //
  //

  block DeHuHRS_false
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2(start=290);
    Modelica.Units.SI.Temperature T_3(start=282);
    Modelica.Units.SI.Temperature T_4(start=282);
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMax;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withoutHRS;
    outer parameter Real BPF_DeHu;
    Modelica.Units.SI.SpecificEnthalpy h_2(start=0.003) "h_in of cooler";
    Modelica.Units.SI.SpecificEnthalpy h_surface(start=0.002)
      "h_surface of cooler";
    Modelica.Units.SI.SpecificEnthalpy h_CoilOut(start=0.001) "h_out of cooler";
    Modelica.Units.SI.Pressure p_sat_surface(start=2300);
    Modelica.Units.SI.MassFraction X_surface(start=0.005);
    Modelica.Units.SI.Temperature T_surface(start=280);
    Modelica.Units.SI.Temperature T_CoilOut(start=278);

  equation
    phi_t = phi_t_withoutHRS "heat recovery system is disabled";
    X_sup = previous(X_supMax);
    T_1 = T_2;
    T_3 = T_CoilOut;
    T_4 = T_3;

    BPF_DeHu = (h_CoilOut - h_surface)/max(h_2 - h_surface, 0.01);
    h_2 = c_pL_iG*(previous(T_2) - T_0) + previous(X_oda)*(c_pW_iG*(previous(
      T_2) - T_0) + dhV);
    h_surface = c_pL_iG*(T_surface - T_0) + X_surface*(c_pW_iG*(T_surface - T_0)
       + dhV);
    h_CoilOut = c_pL_iG*(T_CoilOut - T_0) + X_sup*(c_pW_iG*(T_CoilOut - T_0) +
      dhV);
    (previous(T_2) - T_surface)/max(previous(X_oda) - X_surface, 0.00009) = (
      T_CoilOut - T_surface)/max(previous(X_supMax) - X_surface, 0.00001);

    /*
  p_sat_surface = 611.2*exp(17.62*(T_surface - T_0)/(243.12 + T_surface - T_0));
  //Magnus formula over water, improved by Sonntag (1990), Range: -45 degC to +60 degC
  2 Alternatives for calculation of water vapor pressure, which are not so stable during simulation:
  p_sat_surface = 10^(-7.90298*(373.15/T_surface - 1)
          +5.02808*log10(373.15/T_surface)
          -1.3816*10^(-7)*(10^(11.344*(1 - T_surface/373.15))-1)
          +8.1328*10^(-3)*(10^(-3.49149*(373.15/T_surface - 1))-1)
          +log10(1013.246))*100; //The Goff Gratch equation for the vapor pressure over liquid water covers a region of -50 degC to +102 degC.
*/
    p_sat_surface = Modelica.Media.Air.MoistAir.saturationPressure(T_surface);

    X_surface = molarMassRatio*p_sat_surface/(p_0 - p_sat_surface);

    Q_dot_C = previous(V_dot_sup)*rho*((c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - T_CoilOut) + (previous(X_oda) - X_sup)*r_0);
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + X_sup*c_pW_iG)*(previous(T_5) -
      T_CoilOut);

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end DeHuHRS_false;
  DeHuHRS_false deHuHRS_false
    "Dehumidification and Heat Recovery System disabled"
    annotation (Placement(transformation(extent={{-58,-68},{-44,-56}})));

  //
  //
  //
  // Humidification

  block HuPreHHRS_true
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMin;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withHRS;

  equation
    phi_t = phi_t_withHRS;
    X_sup = previous(X_supMin);

    Q_dot_C = 0;
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_5) - previous(T_1)) + previous(V_dot_sup)*rho*(previous(
      X_supMin) - previous(X_oda))*r_0
      "Thermal Power consumption for Humidification due to Eurovent 6/8 eq. (7.3) or (7.8)";

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end HuPreHHRS_true;
  HuPreHHRS_true huPreHHRS_true
    "Humidification with Preheating and Heat Recovery System enabled"
    annotation (Placement(transformation(extent={{-16,-28},{-2,-16}})));

  //
  //
  //
  //

  block HuPreHHRS_false
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMin;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withoutHRS;

  equation
    phi_t = phi_t_withoutHRS;
    X_sup = previous(X_supMin);

    Q_dot_C = 0;
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_5) - previous(T_1)) + previous(V_dot_sup)*rho*(previous(
      X_supMin) - previous(X_oda))*r_0
      "Thermal Power consumption for Humidification due to Eurovent 6/8 eq. (7.3) or (7.8)";

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end HuPreHHRS_false;
  HuPreHHRS_false huPreHHRS_false
    "Humidification with Preheating and Heat Recovery System disabled"
    annotation (Placement(transformation(extent={{12,-28},{26,-16}})));

  //
  //
  //
  //

  block HuCHRS_true
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMin;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withHRS;

  equation
    phi_t = phi_t_withHRS;
    X_sup = previous(X_supMin);
    T_1 = T_2;
    T_3 = T_4;
    T_4 = T_5;

    Q_dot_C = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - previous(T_3)) - previous(V_dot_sup)*rho*(previous(
      X_supMin) - previous(X_oda))*r_0
      "Thermal Power consumption for Humidification due to Eurovent 6/8 eq. (7.3) or (7.8)";
    Q_dot_H = 0;

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end HuCHRS_true;
  HuCHRS_true huCHRS_true
    "Humidification with additional Cooling and Heat Recovery System enabled"
    annotation (Placement(transformation(extent={{50,-28},{64,-16}})));

  //
  //
  //
  //

  block HuCHRS_false
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer input Modelica.Units.SI.MassFraction X_supMin;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withoutHRS;

  equation
    phi_t = phi_t_withoutHRS;
    X_sup = previous(X_supMin);
    T_1 = T_2;
    T_3 = T_4;
    T_4 = T_5;

    Q_dot_C = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - previous(T_3)) - previous(V_dot_sup)*rho*(previous(
      X_supMin) - previous(X_oda))*r_0
      "Thermal Power consumption for Humidification due to Eurovent 6/8 eq. (7.3) or (7.8)";
    Q_dot_H = 0;

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end HuCHRS_false;
  HuCHRS_false huCHRS_false
    "Humidification with additional Cooling and Heat Recovery System disabled"
    annotation (Placement(transformation(extent={{78,-28},{92,-16}})));

  //
  //
  //
  // Only Heating

  block OnlyHeatingHRS_true
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withHRS;

  equation
    phi_t = phi_t_withHRS;
    T_1 = T_2;
    T_2 = T_3;
    T_3 = T_4;
    X_sup = previous(X_oda);

    Q_dot_C = 0;
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_5) - previous(T_4));

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end OnlyHeatingHRS_true;
  OnlyHeatingHRS_true onlyHeatingHRS_true
    "Heating and Heat Recovery System enabled"
    annotation (Placement(transformation(extent={{-24,-80},{-10,-68}})));

  //
  //
  //
  //

  block OnlyHeatingHRS_false
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withoutHRS;

  equation
    phi_t = phi_t_withoutHRS;
    T_1 = T_2;
    T_2 = T_3;
    T_3 = T_4;
    X_sup = previous(X_oda);

    Q_dot_C = 0;
    Q_dot_H = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_5) - previous(T_4));

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end OnlyHeatingHRS_false;
  OnlyHeatingHRS_false onlyHeatingHRS_false
    "Heating and Heat Recovery System disabled"
    annotation (Placement(transformation(extent={{12,-80},{26,-68}})));

  //
  //
  //
  // Only Cooling

  block OnlyCoolingHRS_true
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withHRS;

  equation
    phi_t = phi_t_withHRS;
    T_1 = T_2;
    T_3 = T_4;
    T_4 = T_5;
    X_sup = previous(X_oda);

    Q_dot_C = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - previous(T_3));
    Q_dot_H = 0;

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end OnlyCoolingHRS_true;
  OnlyCoolingHRS_true onlyCoolingHRS_true
    "Cooling and Heat Recovery System enabled"
    annotation (Placement(transformation(extent={{42,-72},{56,-60}})));

  //
  //
  //
  //

  block OnlyCoolingHRS_false
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_C;
    outer output Modelica.Units.SI.HeatFlowRate Q_dot_H;
    outer input Modelica.Units.SI.Temperature T_oda;
    outer input Modelica.Units.SI.Temperature T_1;
    Modelica.Units.SI.Temperature T_2;
    Modelica.Units.SI.Temperature T_3;
    Modelica.Units.SI.Temperature T_4;
    outer input Modelica.Units.SI.Temperature T_5;
    outer input Modelica.Units.SI.Temperature T_6;
    outer input Modelica.Units.SI.MassFraction X_oda;
    outer output Modelica.Units.SI.MassFraction X_sup;
    outer input Modelica.Units.SI.VolumeFlowRate V_dot_sup;
    outer output Real phi_t;
    outer input Real phi_t_withoutHRS;

  equation
    phi_t = phi_t_withoutHRS;
    T_1 = T_2;
    T_3 = T_4;
    T_4 = T_5;
    X_sup = previous(X_oda);

    Q_dot_C = previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(
      previous(T_2) - previous(T_3));
    Q_dot_H = 0;

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end OnlyCoolingHRS_false;
  OnlyCoolingHRS_false onlyCoolingHRS_false
    "Cooling and Heat Recovery System disabled"
    annotation (Placement(transformation(extent={{78,-72},{92,-60}})));

  //
  //
  //
  ////////////////////////////
  //EQUATION//////EQUATION////
  ////////////////////////////
  //
  //
  //

  Modelica.Blocks.Sources.RealExpression hold_phi_sup(y=hold(previous(phi_sup)))
    annotation (Placement(transformation(extent={{58,-1},{78,19}})));
  Modelica.Blocks.Sources.RealExpression TsupAirOut(y=hold(TsupplyAirOut))
    "see if else decision in source code"                                                           annotation (Placement(transformation(extent={{58,47},{78,67}})));
  StateExtra stateExtra
    annotation (Placement(transformation(extent={{-98,-40},{-88,-30}})));
equation
  // variables that will be set with parameteres of HRS efficiency
  phi_t_withHRS = if HRS then efficiencyHRS_enabled else 0;
  phi_t_withoutHRS = if HRS then efficiencyHRS_disabled else 0;

  //// sampler inputs
  // connecting clock signal with sampler
  connect(periodicClock.y, sample.clock) annotation (Line(
      points={{-81.4,14},{-78,14}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));

  // converting inputs (coming from the outside of AHUFull) into time-discrete variables for state machines.

  X_supplyMin = sample.u[5];
  X_supplyMax = sample.u[6];
  X_extractAir = sample.u[7];

  T_oda = sample.y[1];
  X_odaRaw = sample.y[2];
  T_sup = sample.y[3];
  T_eta = sample.y[4];
  X_supMin = sample.y[5];
  X_supMax = sample.y[6];
  X_eta = sample.y[7];
  V_dot_sup = sample.y[8];
  V_dot_eta = sample.y[9];

  // absolute humidity for state of saturated outdoor air
  X_odaSat = molarMassRatio*(611.2*exp(17.62*(T_oda - T_0)/(243.12 + T_oda -
    T_0)))/(p_0 - (611.2*exp(17.62*(T_oda - T_0)/(243.12 + T_oda - T_0))));
  // if absolute humidity from weather file should be in region of phi_oda>1 then restrict to absolute humdity for phi_oda=1. Prevents calculation errors!
  X_oda = if X_odaRaw > X_odaSat then X_odaSat else X_odaRaw;

  // calculates T_1 according to assumption of HRS' efficiency phi_t
  phi_t = (T_1 - T_oda)/(T_6 - T_oda + 1e-3);

  // conditions for transitions to State Machines
  tooHighX = if previous(X_oda) > previous(X_supMax) then true else false;
  tooLowX = if previous(X_oda) < previous(X_supMin) then true else false;
  choiceX = if
     (tooHighX and not dehumidification)
     or
     (tooLowX and not humidification)
     or
     (previous(X_oda) <= previous(X_supMax) and previous(X_oda) >= previous(X_supMin))
     then true else false;

  // now really the conditions for the transitions
  stateToDeHuHRS_true = if
     tooHighX
     and dehumidification and HRS then true else false;

  stateToDeHuHRS_false = if
    tooHighX
    and dehumidification and not HRS then true else false;

  stateToHuPreHHRS_true = if
    tooLowX
    and
    ((previous(T_5) >= previous(T_1))
    or
    ((previous(T_5) < previous(T_1))
    and
    (abs(previous(V_dot_sup)*rho*(previous(X_sup) - previous(X_oda))*r_0) >= abs(previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(previous(T_1) - previous(T_5))))))
    and humidification and HRS then true else false;

  stateToHuPreHHRS_false = if
    tooLowX
    and
    ((previous(T_5) >= previous(T_1))
    or
    ((previous(T_5) < previous(T_1))
    and
    (abs(previous(V_dot_sup)*rho*(previous(X_sup) - previous(X_oda))*r_0) >= abs(previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(previous(T_1) - previous(T_5))))))
    and humidification and not HRS then true else false;

  stateToHuCHRS_true = if
    tooLowX
    and
    (previous(T_5) < previous(T_1))
    and
    (abs(previous(V_dot_sup)*rho*(previous(X_sup) - previous(X_oda))*r_0) < abs(previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(previous(T_1) - previous(T_5))))
    and humidification and HRS then true else false;

  stateToHuCHRS_false = if
    tooLowX
    and
    (previous(T_5) < previous(T_1))
    and
    (abs(previous(V_dot_sup)*rho*(previous(X_sup) - previous(X_oda))*r_0) < abs(previous(V_dot_sup)*rho*(c_pL_iG + previous(X_oda)*c_pW_iG)*(previous(T_1) - previous(T_5))))
    and humidification and not HRS then true else false;

  stateToOnlyHeatingHRS_true = if
     choiceX
     and
     (previous(T_5) >= pre(T_oda) + phi_t_withoutHRS*(pre(T_6) - pre(T_oda)))
     and heating and HRS then true else false;

  stateToOnlyHeatingHRS_false = if
     choiceX
     and
     (previous(T_5) >= pre(T_oda) + phi_t_withoutHRS*(pre(T_6) - pre(T_oda)))
     and heating and not HRS then true else false;

  stateToOnlyCoolingHRS_true = if
     choiceX
     and
     (previous(T_5) < pre(T_oda) + phi_t_withoutHRS*(pre(T_6) - pre(T_oda)))
     and cooling and HRS then true else false;

  stateToOnlyCoolingHRS_false = if
     choiceX
     and
     (previous(T_5) < pre(T_oda) + phi_t_withoutHRS*(pre(T_6) - pre(T_oda)))
     and cooling and not HRS then true else false;

  X_supplyMin = (molarMassRatio*phi_supplyAir[1]*
    Modelica.Media.Air.MoistAir.saturationPressure(T_supplyAir))/(p_0 -
    phi_supplyAir[1]*Modelica.Media.Air.MoistAir.saturationPressure(T_supplyAir));
  X_supplyMax = (molarMassRatio*phi_supplyAir[2]*
    Modelica.Media.Air.MoistAir.saturationPressure(T_supplyAir))/(p_0 -
    phi_supplyAir[2]*Modelica.Media.Air.MoistAir.saturationPressure(T_supplyAir));
  X_extractAir = (molarMassRatio*phi_extractAir*
    Modelica.Media.Air.MoistAir.saturationPressure(T_extractAir))/(p_0 -
    phi_extractAir*Modelica.Media.Air.MoistAir.saturationPressure(T_extractAir));

  // calculation of T_5 and T_6 regarding the electrical power consumption
  P_el_sup = V_dot_sup*dp_sup/eta_sup
    "Calculation of electrical power consumption";
  P_el_sup = V_dot_sup*rho*(c_pL_iG + X_sup*c_pW_iG)*(T_sup - T_5)
    "Calculation of T_5 by using V_dot_sup, efficiency eta_sup and input variable T_sup";
  P_el_eta = V_dot_eta*dp_eta/eta_eta
    "Calculation of electrical power consumption";
  P_el_eta = V_dot_eta*rho*(c_pL_iG + X_eta*c_pW_iG)*(T_6 - T_eta)
    "Calculation of T_6 by using V_dot_eta, efficiency eta_eta and input variable T_eta";

  // Calculation of relativ humidity of supply Air. Necessary for some superior model assamblies.
  X_sup = (molarMassRatio*phi_sup*
    Modelica.Media.Air.MoistAir.saturationPressure(T_sup))/(p_0 - phi_sup*
    Modelica.Media.Air.MoistAir.saturationPressure(T_sup));

  // converts time-discrete outputs of state machines into time-continous variables and limitation of thermal energies so that they cannot be negative
  allCond = if stateToDeHuHRS_true or stateToDeHuHRS_false or
    stateToHuPreHHRS_true or stateToHuPreHHRS_false or stateToHuCHRS_true or
    stateToHuCHRS_false or stateToOnlyHeatingHRS_true or
    stateToOnlyHeatingHRS_false or stateToOnlyCoolingHRS_true or
    stateToOnlyCoolingHRS_false then true else false;

  Vflow_out = hold(V_dot_sup);
  if Vflow_out > 0 and hold(V_dot_eta) <= 0 then
    Pel = hold(P_el_sup);
  elseif Vflow_out <= 0 and hold(V_dot_eta) > 0 then
    Pel = hold(P_el_eta);
  elseif Vflow_out > 0 and hold(V_dot_eta) > 0 then
    Pel = hold(P_el_eta) + hold(P_el_sup);
  else
    Pel = 0;
  end if;

  QflowH = if hold(Q_dot_H) > 0 then hold(Q_dot_H) else 0;
  QflowC = if hold(Q_dot_C) > 0 then hold(Q_dot_C) else 0;

  // The following part decides whether T_supplyAir input connector is passed through or outdoor air temp (+ slight changes) is used. Only necessery if either only heating or cooling is activated.
  if
    heating and not cooling and not dehumidification and not humidification then
    TsupplyAirOut = if stateToOnlyHeatingHRS_true or stateToOnlyHeatingHRS_false then T_sup else T_oda + phi_t_withoutHRS*(T_6 - T_oda) + dTFan;
  elseif
    cooling and not heating and not dehumidification and not humidification then
    TsupplyAirOut = if stateToOnlyCoolingHRS_true or stateToOnlyCoolingHRS_false then T_sup else T_oda + phi_t_withoutHRS*(T_6 - T_oda) + dTFan;
  elseif
    not heating and not cooling and not dehumidification and not humidification then
    TsupplyAirOut = T_oda + phi_t_withoutHRS*(T_6 - T_oda) + dTFan;
  else
    TsupplyAirOut = T_sup;
  end if;
  // with:
  P_el_sup = dTFan * V_dot_sup * rho * (c_pL_iG + X_oda * c_pW_iG);

  // transitions and conditions between state machines.
  initialState(startState) annotation (Line(
      points={{-84,-8},{-98,-8}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier,
      arrow={Arrow.Filled,Arrow.None}));
  transition(
    startState,
    deHuHRS_true,
    stateToDeHuHRS_true,
    priority=1,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-68,-2},{-80,-54}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(
    deHuHRS_true,
    startState,
    true,
    priority=11,
    immediate=false,
    reset=false,
    synchronize=true) annotation (Line(
      points={{-74,-70},{-70,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  //stateToDeHuHRS_true==false,
  transition(
    startState,
    deHuHRS_false,
    stateToDeHuHRS_false,
    priority=2,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-61,-3},{-54,-54}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(
    deHuHRS_false,
    startState,
    true,
    priority=11,
    immediate=false,
    reset=false,
    synchronize=true) annotation (Line(
      points={{-52,-70},{-70,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  //stateToDeHuHRS_false==false,
  transition(
    startState,
    onlyHeatingHRS_true,
    stateToOnlyHeatingHRS_true,
    priority=7,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-80,-2},{-20,-66}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{50,-58},{50,-52}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    startState,
    onlyHeatingHRS_false,
    stateToOnlyHeatingHRS_false,
    priority=8,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-76,-2},{20,-66}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{70,-50},{70,-44}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    startState,
    onlyCoolingHRS_true,
    stateToOnlyCoolingHRS_true,
    priority=9,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-72,-2},{48,-58}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{110,-52},{110,-46}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    startState,
    onlyCoolingHRS_false,stateToOnlyCoolingHRS_false,
    priority=10,
    immediate=false,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-66,-2},{77,-59}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    onlyHeatingHRS_true,
    startState,true,
    immediate=false,
    reset=false,
    synchronize=false,
    priority=11) annotation (Line(
      points={{-18,-82},{-70,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  //stateToOnlyHeatingHRS_true==false,
  transition(
    onlyHeatingHRS_false,
    startState,
    true,
    immediate=false,
    reset=false,
    synchronize=true,
    priority=11) annotation (Line(
      points={{20,-82},{-70,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToOnlyHeatingHRS_false==false,
  transition(
    onlyCoolingHRS_true,
    startState,
    true,
    immediate=false,
    reset=false,
    synchronize=true,
    priority=11) annotation (Line(
      points={{50,-74},{-70,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToOnlyCoolingHRS_true==false,
  transition(
    onlyCoolingHRS_false,
    startState,
    true,
    immediate=false,
    reset=false,
    synchronize=true,
    priority=11) annotation (Line(
      points={{86,-74},{-68,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToOnlyCoolingHRS_false==false,
  transition(
    startState,
    huPreHHRS_true,
    stateToHuPreHHRS_true,
    priority=5,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-60,-10},{-8,-14}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{38,0},{38,6}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    huPreHHRS_true,
    startState,
    true,
    immediate=false,
    reset=false,
    synchronize=true,
    priority=11) annotation (Line(
      points={{-10,-30},{-76,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToHuPreHHRS_true==false,
  transition(
    startState,
    huPreHHRS_false,
    stateToHuPreHHRS_false,
    priority=6,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-60,-10},{18,-14}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{60,-2},{60,4}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    huPreHHRS_false,
    startState,
    true,
    priority=11,
    immediate=false,
    reset=false,
    synchronize=true) annotation (Line(
      points={{18,-30},{10,-32},{-76,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToHuPreHHRS_false==false,
  transition(
    startState,
    huCHRS_true,
    stateToHuCHRS_true,
    priority=3,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-60,-10},{56,-14}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{106,0},{106,6}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    huCHRS_true,
    startState,
    true,
    priority=11,
    immediate=false,
    reset=false,
    synchronize=true) annotation (Line(
      points={{58,-30},{42,-34},{-74,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToHuCHRS_true==false,
  transition(
    startState,
    huCHRS_false,
    stateToHuCHRS_false,
    priority=4,
    immediate=true,
    reset=false,
    synchronize=false) annotation (Line(
      points={{-60,-10},{86,-14}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(
    huCHRS_false,
    startState,
    true,
    priority=11,
    immediate=false,
    reset=false,
    synchronize=true) annotation (Line(
      points={{86,-30},{54,-38},{-74,-26}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  //stateToHuCHRS_false==false,

  connect(T_outdoorAir, sample.u[1]) annotation (Line(points={{-100,56},{-100,
          56},{-67.7778,56},{-67.7778,26}},
                                    color={0,0,127}));
  connect(X_outdoorAir, sample.u[2]) annotation (Line(points={{-100,36},{-100,
          36},{-67.3333,36},{-67.3333,26}},
                                    color={0,0,127}));
  connect(T_supplyAir, sample.u[3]) annotation (Line(points={{100,36},{100,42},
          {-66.8889,42},{-66.8889,26}},
                            color={0,0,127}));
  connect(T_extractAir, sample.u[4]) annotation (Line(points={{100,78},{-60,78},
          {-60,60},{-66.4444,60},{-66.4444,26}},
                            color={0,0,127}));
  connect(Vflow_in, sample.u[8]) annotation (Line(points={{-100,82},{-64.6667,
          82},{-64.6667,26}},
                       color={0,0,127}));
  connect(Vflow_in_extractAir_internal, sample.u[9]);
  connect(hold_phi_sup.y, phi_supply) annotation (Line(points={{79,9},{99,9},{99,
          5}},                color={0,0,127}));
  connect(TsupAirOut.y, T_supplyAirOut) annotation (Line(points={{79,57},{99,57},
          {99,49}},                                                                          color={0,0,127}));
public
  block StateExtra

    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end StateExtra;
equation
  transition(
    startState,
    stateExtra,Q_dot_C > 0 and Q_dot_H > 0,
    immediate=false,
    reset=false,
    priority=11,synchronize=false)
                 annotation (Line(
      points={{-83,-25},{-86,-37}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(
    stateExtra,
    startState,true,
    immediate=false,
    reset=false,synchronize=false,priority=1)
                 annotation (Line(
      points={{-94,-28},{-94,-18},{-84,-18}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=2,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
                   graphics={
        Bitmap(
          extent={{36,-42},{100,4}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/HumidifierCooling.jpg"),
        Bitmap(
          extent={{-100,-90},{-36,-44}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/Dehumidifier.jpg"),
        Bitmap(
          extent={{-32,-42},{32,4}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/HumidifierHeating.jpg"),
        Bitmap(
          extent={{-32,-90},{32,-44}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/Heating.jpg"),
        Bitmap(
          extent={{36,-90},{100,-44}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/Cooling.jpg")}),
    experiment(StopTime=13398, Interval=5),
    Icon(coordinateSystem(extent={{-100,-40},{100,40}}, preserveAspectRatio=false),
        graphics={Bitmap(
          extent={{-100,-28},{100,28}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/AHUaccToDINV18599-3.jpg"),
          Rectangle(
          extent={{68,24},{98,-18}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This is an ideal model of an air handling unit (AHU), primarily to
  calculate the thermal energy consumption of an air handling unit
  (AHU) but also the electric power. The model is mainly based on
  thermodynamic equations.
</p>
<p>
  It is based on incoming and outgoing enthalpy flows of moist air
  (thermodynamic principle).
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The model aims to need
  little computational effort. Therefore state machines represent the
  basis of the model and no Modelica Fluid is used.</span>
</p>
<p>
  If simulation runs instable, reduce clockPeriodGeneric and/or use one
  of the alternative equations for the calculation of
  <code>p_sat_surface</code> in both dehumidification state machines
  (see source code of these state machines).
</p>
<h4>
  <span style=\"color: #008000\">Assumptions</span>
</h4>
<p>
  For further explanation for each parameter see noted sources and [1]!
  Please note that the assumptions are made regarding AHUs which are
  implemented in laboratories.
</p>
<ul>
  <li>BPF_DeHu: by-pass factor of cooling coil during dehumidification;
  Expression for the amount of air that by-passes unaffectedly over a
  coil while the remaining fluid comes in direct contact with the coil.
  [2, p. 500]; BPF_DeHu between 10 % and 35 % acc. to [3]
  </li>
  <li>efficiencyHRS_enabled: temperature differential; efficiency of
  heat recovery system (HRS) when it is enabled (for HRSs without
  sorptive technology efficiencyHRS_enabled = 0.6 ... 0.8 [4])
  </li>
  <li>efficiencyHRS_disabled: temperature differential; efficiency of
  heat recovery system (HRS) when it is disabled (proposal for
  parameter efficiencyHRS_disabled = 0.2 ... 0.4 [1])
  </li>
  <li>dp_sup, dp_eta: pressure drop over ventilator; recommendation dp
  = 800 Pa [7]
  </li>
  <li>eta_sup, eta_eta: efficiency of supply/extract air fan. Assumed
  as constant in this model.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Known Limitations</span>
</h4>
<ul>
  <li>static model, not dynamic
  </li>
  <li>no technical restrictions (demanded goal/value will always be
  reached)
  </li>
  <li>no implementation of merging two or more mass flows
  </li>
  <li>only adiabatic humidification
  </li>
  <li>no moisture transfer in HRS
  </li>
  <li>the pinch temperature HRS component is 0 K
  </li>
  <li>if absolute humidity of outside air (input connector
  \"X_outdoorAir) exceeds X_saturated(T_oda) calculated with phi=1,
  X_oda is set to X_saturated
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<ul>
  <li>Producing output data (thermal and electric power and outgoing
  air flow rate) by using some input data (black-box-principle). The
  inner components of an AHU are considered within this model.
  </li>
  <li>Based on sketch/schema of AHU shown in figure 1 [5, appendix D].
  </li>
  <li>This model of an AHU is able to represent 5 cases: only heating,
  only cooling, dehumidification, humidification plus heating,
  humidification plus cooling.
  </li>
</ul>
<p>
  <br/>
  Figure 1 [5, appendix D]
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/AHUaccToDINV18599-3.jpg\"
  alt=\"schema of AHU\">
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>[1] Mehrfeld, P. (2014): Experimentelle Untersuchung von
  Lüftungstechnik in Laboren (master thesis). RWTH Aachen University,
  Aachen. E.ON Energy Research Center, Institute for Energy Efficient
  Buildings and Indoor Climate; supervised by: Lauster, M.; Müller, D.
  </li>
  <li>[2] Khurmi, R. S.; Gupta, J. K. (2009): Textbook of Refrigeration
  and Air Conditioning. 4th ed. New Delhi: Eurasia. (682 pages). ISBN
  9788121927819.
  </li>
  <li>[3] Lindeburg, M. R. (2013): Mechanical Engineering Reference
  Manual for the PE Exam. 13th ed. Belmont: Professional Publications,
  Inc. (1488 pages). ISBN 9781591264149.
  </li>
  <li>[4] Verein Deutscher Ingenieure e. V.: VDI 2071:1997-12:
  Wärmerückgewinnung in Raumlufttechnischen Anlagen. Richtlinie.
  Berlin: Beuth Verlag GmbH.
  </li>
  <li>[5] Deutsches Institut für Normung e. V.: DIN V 18599-3:2011-12:
  Energetische Bewertung von Gebäuden – Berechnung des Nutz-, End- und
  Primärenergiebedarfs für Heizung, Kühlung, Lüftung, Trinkwarmwasser
  und Beleuchtung – Teil 3: Nutzenergiebedarf für die energetische
  Luftaufbereitung. Vornorm. Berlin: Beuth Verlag GmbH.
  </li>
  <li>[6] Schweizerischer Ingenieur- und Architektenverein (2006): SIA
  2024: Standard- Nutzungsbedingungen für die Energie- und
  Gebäudetechnik. Merkblatt.
  </li>
  <li>[7] Gilroy, E.: Designing - Building Services: fan power, it will
  blow you away! PM Group. Online available at
  http://www.pmgroup-global.com/pmgroup/media/News-Attachments/
  Fan-Power,-it-will-blow-you-away!pdf, last accessed on 23 September
  2014.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  20 validation experiments are documented in [1, chapter 4 and 5].
</p>
<ul>
  <li>
    <i>February, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Added previous() functions in source code as decisions for state
    machines and calculations in state machines did not use values of
    the same time step.
  </li>
  <li>
    <i>June 17, 2015&#160;</i> by Philipp Mehrfeld:<br/>
    Changes in Inputs, transition conditions, BPF_DeHu, etc. Added
    functionality for mode selection.
  </li>
  <li>
    <i>Septmeber, 2014&#160;</i> by Philipp Mehrfeld:<br/>
    Model implemented
  </li>
</ul>
</html>"));
end AHU;
