within AixLib.Media.Refrigerants.Validation;
model RefrigerantIntegration
  "Model that checks the implementation of derivatives wrt. to time"
  extends Modelica.Icons.Example;

  // Definition of the refrigerant that shall be tested
  //
  package Medium =
     AixLib.Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner
    "Internal medium model";

  // Definition of parameters and constants
  //
  parameter Medium.AbsolutePressure p0 = 20e5
    "Fixed pressure for calculations at initialization";
  parameter Medium.Density d0 = 75
    "Fixed density for calculations at initialization";

  constant Real convT(unit="K/s3") = 125
  "Conversion factor to satisfy derivative check";
  constant Real convH(unit="J/(kg.s3)") = 200e3
  "Conversion factor to satisfy derivative check";
  constant Real convS(unit="J/(kg.K.s3)") = 1250
  "Conversion factor to satisfy derivative check";

  // Definition of variables
  //
  Medium.AbsolutePressure p
    "Pressure used for calculations";
  Medium.Temperature T
    "Temperature used for calculations";
  Medium.Density d
    "Density used for calculations";
  Medium.SpecificEnthalpy h
    "Specific enthalpy used for calculations";
  Medium.SpecificEntropy s
    "Specific entropy used for calculations";
  Real tau
    "Reduced temperature used for calculations";
  Real delta
    "Recuded density used for calculations";

  // Definition of variables for testing state variables
  //
  record StateVariables
    "Record that containts state variables"
    Medium.AbsolutePressure pdT_Calc
      "Pressure calculated by p and d from EoS";
    Medium.AbsolutePressure pdT_Sym
      "Pressure calculated by p and d from derivative";

    Medium.Temperature Tph_Calc
      "Temperature calculated by p and h from EoS";
    Medium.Temperature Tph_Sym
      "Temperature calculated by p and h from derivative";
    Medium.Temperature Tps_Calc
      "Temperature calculated by p and s from EoS";
    Medium.Temperature Tps_Sym
      "Temperature calculated by p and s from derivative";

    Medium.Density dpT_Calc
      "Density calculated by p and T from EoS";
    Medium.Density dpT_Sym
      "Density calculated by p and T from derivative";
    Medium.Density dph_Calc
      "Density calculated by p and h from EoS";
    Medium.Density dph_Sym
      "Density calculated by p and h from derivative";
    Medium.Density dps_Calc
      "Density calculated by p and s from EoS";
    Medium.Density dps_Sym
      "Density calculated by p and s from derivative";

    Medium.SpecificEnthalpy hdT_Calc
      "Specific enthalpy calculated by d and T from EoS";
    Medium.SpecificEnthalpy hdT_Sym
      "Specific enthalpy calculated by d and T from derivative";
    Medium.SpecificEnthalpy hpT_Calc
      "Specific enthalpy calculated by p and T from EoS";
    Medium.SpecificEnthalpy hpT_Sym
      "Specific enthalpy calculated by p and T from derivative";
    Medium.SpecificEnthalpy hps_Calc
      "Specific enthalpy calculated by p and s from EoS";
    Medium.SpecificEnthalpy hps_Sym
      "Specific enthalpy calculated by p and s from derivative";
  end StateVariables;
  StateVariables stateVariables "Record containing state variables";

  // Definition of variables for testing the Helmholtz equation of state
  //
  record EoS
    "Record that contains variables of the Helmholtz equation of state"
    Real alpha_0_Calc
      "Dimensionless ideal gas Helmholz energy calculated by medium model";
    Real alpha_0_Sym
      "Dimensionless ideal gas Helmholz energy calculated by derivative";
    Real alpha_0_t_Calc
      "Tau*(dalpha_0/dtau)_delta=const calculated by medium model";
    Real alpha_0_t_Sym
      "Tau*(dalpha_0/dtau)_delta=const calculated by derivative";
    Real alpha_0_tt_Calc
      "Tau*tau*(ddalpha_0/(dtau*dtau))_delta=const calculated by medium model";
    Real alpha_0_tt_Sym
      "Tau*tau*(ddalpha_0/(dtau*dtau))_delta=const calculated by derivative";
    Real alpha_r_Calc
      "Dimensionless residual Helmholz energy calculated by medium model";
    Real alpha_r_Sym
      "Dimensionless residual Helmholz energy calculated by derivative";
    Real alpha_r_t_Calc
      "Tau*(dalpha_r/dtau)_delta=const calculated by medium model";
    Real alpha_r_t_Sym
      "Tau*(dalpha_r/dtau)_delta=const energy calculated by derivative";
    Real alpha_r_tt_Calc
      "Tau*tau*(ddalpha_r/(dtau*dtau))_delta=const calculated by medium model";
    Real alpha_r_tt_Sym
      "Tau*tau*(ddalpha_r/(dtau*dtau))_delta=const calculated by derivative";
    Real alpha_r_d_Calc
      "Delta*(dalpha_r/(ddelta))_tau=const calculated by medium model";
    Real alpha_r_d_Sym
      "Delta*(dalpha_r/(ddelta))_tau=const calculated by derivative";
    Real alpha_r_dd_Calc
      "Delta*delta(ddalpha_r/(ddelta*delta))_tau=const calculated
      by medium model";
    Real alpha_r_dd_Sym
      "Delta*delta(ddalpha_r/(ddelta*delta))_tau=const
      calculated by derivative";
    Real alpha_r_td_Calc
      "Tau*delta*(ddalpha_r/(dtau*ddelta)) calculated by medium model";
    Real alpha_r_td_Sym
      "Tau*delta*(ddalpha_r/(dtau*ddelta)) calculated by derivative";
  end EoS;
  EoS eoS "Record containing variables of the Helmholtz equation of state";

initial equation
  // Provide initial values for thermodynamic properties
  //
  stateVariables.pdT_Sym = stateVariables.pdT_Calc;
  stateVariables.Tph_Sym = stateVariables.Tph_Calc;
  stateVariables.Tps_Sym = stateVariables.Tps_Calc;
  stateVariables.dpT_Sym = stateVariables.dpT_Calc;
  stateVariables.dph_Sym = stateVariables.dph_Calc;
  stateVariables.dps_Sym = stateVariables.dps_Calc;
  stateVariables.hdT_Sym = stateVariables.hdT_Calc;
  stateVariables.hpT_Sym = stateVariables.hpT_Calc;
  stateVariables.hps_Sym = stateVariables.hps_Calc;

  // Provide initial values for terms of equation of state
  //
  eoS.alpha_0_Sym = eoS.alpha_0_Calc;
  eoS.alpha_0_t_Sym = eoS.alpha_0_t_Calc;
  eoS.alpha_0_tt_Sym = eoS.alpha_0_tt_Calc;
  eoS.alpha_r_Sym = eoS.alpha_r_Calc;
  eoS.alpha_r_t_Sym = eoS.alpha_r_t_Calc;
  eoS.alpha_r_tt_Sym = eoS.alpha_r_tt_Calc;
  eoS.alpha_r_d_Sym = eoS.alpha_r_d_Calc;
  eoS.alpha_r_dd_Sym = eoS.alpha_r_dd_Calc;
  eoS.alpha_r_td_Sym = eoS.alpha_r_td_Calc;

equation
  // Calculation of input variables
  //
  p = p0 + 10e5*time^3;
  T = 273.15 + convT*time^3;
  d = d0 + 125*time^3;
  h = 200e3 + convH*time^3;
  s = 1e3 + convS*time^3;
  tau = Medium.fluidConstants[1].criticalTemperature/T;
  delta = d/(Medium.fluidConstants[1].molarMass/
    Medium.fluidConstants[1].criticalMolarVolume);

  // Calculation of state variables
  //
  stateVariables.pdT_Calc = Medium.pressure_dT(d=d,T=T,phase=0);
  der(stateVariables.pdT_Sym) = der(stateVariables.pdT_Calc);

  stateVariables.Tph_Calc = Medium.temperature_ph(p=p,h=h);
  der(stateVariables.Tph_Sym) = der(stateVariables.Tph_Calc);
  stateVariables.Tps_Calc = Medium.temperature_ps(p=p,s=s);
  der(stateVariables.Tps_Sym) = der(stateVariables.Tps_Calc);

  stateVariables.dpT_Calc = Medium.density_pT(p=p,T= if T
    >= 303.15 then 303.15 else T);
  der(stateVariables.dpT_Sym) = der(stateVariables.dpT_Calc);
  stateVariables.dph_Calc = Medium.density_ph(p=p,h=h);
  der(stateVariables.dph_Sym) = der(stateVariables.dph_Calc);
  stateVariables.dps_Calc = Medium.density_ps(p=p,s=s);
  der(stateVariables.dps_Sym) = der(stateVariables.dps_Calc);

  stateVariables.hdT_Calc = Medium.specificEnthalpy_dT(d=d,T=T,phase=0);
  der(stateVariables.hdT_Sym) = der(stateVariables.hdT_Calc);
  stateVariables.hpT_Calc = Medium.specificEnthalpy_pT(p=p,T= if T
    >= 303.15 then 303.15 else T);
  der(stateVariables.hpT_Sym) = der(stateVariables.hpT_Calc);
  stateVariables.hps_Calc = Medium.specificEnthalpy_ps(p=p,s=s);
  der(stateVariables.hps_Sym) = der(stateVariables.hps_Calc);

  // Calculation of Helmholtz equations of state
  //
  eoS.alpha_0_Calc = Medium.f_Idg(delta=delta,tau=tau);
  der(eoS.alpha_0_Sym) = der(eoS.alpha_0_Calc);
  eoS.alpha_0_t_Calc = Medium.t_fIdg_t(tau=tau);
  der(eoS.alpha_0_t_Sym) = der(eoS.alpha_0_t_Calc);
  eoS.alpha_0_tt_Calc = Medium.tt_fIdg_tt(tau=tau);
  der(eoS.alpha_0_tt_Sym) = der(eoS.alpha_0_tt_Calc);
  eoS.alpha_r_Calc = Medium.f_Res(delta=delta,tau=tau);
  der(eoS.alpha_r_Sym) = der(eoS.alpha_r_Calc);
  eoS.alpha_r_t_Calc = Medium.t_fRes_t(delta=delta,tau=tau);
  der(eoS.alpha_r_t_Sym) = der(eoS.alpha_r_t_Calc);
  eoS.alpha_r_tt_Calc = Medium.tt_fRes_tt(delta=delta,tau=tau);
  der(eoS.alpha_r_tt_Sym) = der(eoS.alpha_r_tt_Calc);
  eoS.alpha_r_d_Calc = Medium.d_fRes_d(delta=delta,tau=tau);
  der(eoS.alpha_r_d_Sym) = der(eoS.alpha_r_d_Calc);
  eoS.alpha_r_dd_Calc = Medium.dd_fRes_dd(delta=delta,tau=tau);
  der(eoS.alpha_r_dd_Sym) = der(eoS.alpha_r_dd_Calc);
  eoS.alpha_r_td_Calc = Medium.td_fRes_td(
    delta=delta,tau=tau);
  der(eoS.alpha_r_td_Sym) = der(eoS.alpha_r_td_Calc);

  annotation (Documentation(revisions="<html><ul>
  <li>August 13, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This example models checks the implementation of the <b>refrigerant's
  main derivatives</b> wrt. to time. Therefore, the user has first to
  introduce some information about the refrigerant and afterwards the
  derivatives are calculated. The following <b>refrigerant's
  information</b> is required:
</p>
<ol>
  <li>The <i>refrigerant package</i> that shall be tested.
  </li>
  <li>The <i>independent variables</i> (i.e. independents variables'
  alteration with time).
  </li>
</ol>
<p>
  The following <b>refrigerant's derivatives</b> are c alculated and
  checked:
</p>
<ol>
  <li>Calculation of state variables depending on the independent state
  variables (e.g. pressure depending on density and temperature).
  </li>
  <li>Calculation of variables of the Helmholtz equation of state.
  </li>
</ol>
</html>"));
end RefrigerantIntegration;
