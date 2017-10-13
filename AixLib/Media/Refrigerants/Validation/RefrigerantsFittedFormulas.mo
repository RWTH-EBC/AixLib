within AixLib.Media.Refrigerants.Validation;
model RefrigerantsFittedFormulas
  "Model that checks the fitted formulas by comparing the
  results to external media models"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  //
  package MediumInt =
    AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
    "Internal medium model";
  package MediumExt =
    HelmholtzMedia.HelmholtzFluids.R134a "External medium model";

  // Define parameters that define the range for calculating the fitted formulas
  //
  parameter Modelica.SIunits.SpecificEnthalpy h_min = 180e3
    "Fluid limit: Minimum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.SpecificEnthalpy h_max = 550e3
    "Fluid limit: Maximum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.SpecificEntropy s_min = 1.0e3
    "Fluid limit: Minimum specific entropy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.SpecificEntropy s_max = 1.8e3
    "Fluid limit: Maximum specific entropy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_min = 2.0
    "Fluid limit: Minimum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_max = 1425 "Fluid limit: Maximum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.AbsolutePressure p_min = 1e5
    "Fluid limit: Minimum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.AbsolutePressure p_max = 38.5e5
    "Fluid limit: Maximum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Temperature T_min = 233.15
    "Fluid limit: Minimum temperature"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Temperature T_max = 455.15
    "Fluid limit: Maximum temperature"
    annotation (Dialog(group="Fluid limits"));

  // Define the conversion factor for the test
  //
  Real convT(start = (T_max-T_min)/80)
    "Conversion factor in K/s for temperature to satisfy unit check";
  Real convD(start = (d_max-d_min)/(80*80))
    "Conversion factor in kg/m³/s for density to satisfy unit check";
  Real convH(start = (h_max-h_min)/(80*80))
    "Conversion factor in J/kg/s for specific enthalpy to satisfy unit check";
  Real convS(start = (s_max-s_min)/(80*80))
    "Conversion factor in J/kg/K/s for specific entropy to satisfy unit check";

  // Defines state variables
  //
  Modelica.SIunits.AbsolutePressure p_sat
    "Actual pressure for calculating saturation properties";
  Modelica.SIunits.Temperature T "Actual pulsating temperature";
  Modelica.SIunits.Temperature T_sat
    "Actual temperature for calculating saturation properties";
  Modelica.SIunits.Density d "Actual raising density";
  Modelica.SIunits.SpecificEnthalpy h
    "Actual pulsating specific enthalpy for calculating state properties";
  Modelica.SIunits.SpecificEntropy s
    "Actual pulsating specific enthalpy for calculating state properties";
  Real tauInt "Actual dimensionless temperature of internal medium";
  Real deltaInt "Actual dimensionless density of internal medium";

  // Define variables for the derivates of the EoS
  //
  record EoS "Record that contains calculated properties of the EoS"
    Real f_iInt "Ideal part of the internal Helmholtz energy";
    Real f_iExt "Ideal part of the external Helmholtz energy";
    Real f_rInt "Residual part of the internal Helmholtz energy";
    Real f_rExt "Residual part of the external Helmholtz energy";
    Real f_itInt "Derivative di/dt of the internal Helmholtz energy";
    Real f_itExt "Derivative di/dt of the external Helmholtz energy";
    Real f_ittInt "Derivative ddi/dtt of the internal Helmholtz energy";
    Real f_ittExt "Derivative ddi/dtt of the external Helmholtz energy";
    Real f_itttInt "Derivative dddi/dttt of the internal Helmholtz energy";
    Real f_itttExt "Derivative dddi/dttt of the external Helmholtz energy";
    Real f_rtInt "Derivative dr/dt of the internal Helmholtz energy";
    Real f_rtExt "Derivative dr/dt of the external Helmholtz energy";
    Real f_rttInt "Derivative ddr/dtt of the internal Helmholtz energy";
    Real f_rttExt "Derivative ddr/dtt of the external Helmholtz energy";
    Real f_rtttInt "Derivative dddr/dttt of the internal Helmholtz energy";
    Real f_rtttExt "Derivative dddr/dttt of the external Helmholtz energy";
    Real f_rdInt "Derivative dr/dd of the internal Helmholtz energy";
    Real f_rdExt "Derivative dr/dd of the external Helmholtz energy";
    Real f_rddInt "Derivative ddr/ddd of the internal Helmholtz energy";
    Real f_rddExt "Derivative ddr/ddd of the external Helmholtz energy";
    Real f_rdddInt "Derivative dddr/dddd of the internal Helmholtz energy";
    Real f_rdddExt "Derivative dddr/dddd of the external Helmholtz energy";
    Real f_rtdInt "Derivative ddr/dtd of the internal Helmholtz energy";
    Real f_rtdExt "Derivative ddr/dtd of the external Helmholtz energy";
    Real f_rtddInt "Derivative dddr/dtdd of the internal Helmholtz energy";
    Real f_rtddExt "Derivative dddr/dtdd of the external Helmholtz energy";
    Real f_rttdInt "Derivative dddr/dttd of the internal Helmholtz energy";
    Real f_rttdExt "Derivative dddr/dttd of the external Helmholtz energy";
    Real df_i "Difference of iddeal part of Helmholtz energy";
    Real df_r "Difference of residual part of Helmholtz energy";
    Real df_it "Difference of derivative di/dt of Helmholtz energy";
    Real df_itt "Difference of derivative ddi/dtt of Helmholtz energy";
    Real df_ittt "Difference of derivative dddi/dttt of Helmholtz energy";
    Real df_rt "Difference of derivative dr/dt of Helmholtz energy";
    Real df_rtt "Difference of derivative ddr/dtt of Helmholtz energy";
    Real df_rttt "Difference of derivative dddr/dttt of Helmholtz energy";
    Real df_rd "Difference of derivative dr/dd of Helmholtz energy";
    Real df_rdd "Difference of derivative ddr/ddd of Helmholtz energy";
    Real df_rddd "Difference of derivative dddr/dddd of Helmholtz energy";
    Real df_rtd "Difference of derivative ddr/dtd of Helmholtz energy";
    Real df_rtdd "Difference of derivative dddr/dtdd of Helmholtz energy";
    Real df_rttd "Difference of derivative dddr/dttd of Helmholtz energy";
  end EoS;

  record Saturation
    "Record that contains calculated saturation properties"
    Modelica.SIunits.AbsolutePressure p_satInt
      "Saturation pressure of internal medium";
    Modelica.SIunits.AbsolutePressure p_satExt
      "Saturation pressure of external medium";
    Modelica.SIunits.Temperature T_satInt
      "Saturation temperature of internal medium";
    Modelica.SIunits.Temperature T_satExt
      "Saturation temperature of external medium";
    Modelica.SIunits.Density d_lInt "Bubble density of internal medium";
    Modelica.SIunits.Density d_lExt "Bubble density of external medium";
    Modelica.SIunits.Density d_vInt "Dew density of internal medium";
    Modelica.SIunits.Density d_vExt "Dew density of external medium";
    Modelica.SIunits.SpecificEnthalpy h_lInt
      "Specific bubble enthalpy of internal medium";
    Modelica.SIunits.SpecificEnthalpy h_lExt
      "Specific bubble enthalpy of external medium";
    Modelica.SIunits.SpecificEnthalpy h_vInt
      "Specific dew enthalpy internal medium";
    Modelica.SIunits.SpecificEnthalpy h_vExt
      "Specific dew enthalpy of external medium";
    Modelica.SIunits.SpecificEntropy s_lInt
      "Specific bubble entropy of internal medium";
    Modelica.SIunits.SpecificEntropy s_lExt
      "Specific bubble entropy of external medium";
    Modelica.SIunits.SpecificEntropy s_vInt
      "Specific dew entropy of internal medium";
    Modelica.SIunits.SpecificEntropy s_vExt
      "Specific dew entropy of external medium";
    Real dp_sat "Relative difference of saturation pressure";
    Real dT_sat "Relative difference of saturation temperature";
    Real dd_l "Relative difference of bubble density";
    Real dd_v "Relative difference of dew density";
    Real dh_l "Relative difference of specific bubble enthalpy";
    Real dh_v "Relative difference of specific dew enthalpy";
    Real ds_l "Relative difference of specific bubble entropy";
    Real ds_v "Relative difference of specific dew entropyy";
  end Saturation;

  record Properties "Record that contains state properties"
    Real d_ptInt "Density of internal medium";
    Real d_ptExt "Density of external medium";
    Real T_phInt "Temperature calculated by p and h of internal medium";
    Real T_phExt "Temperature calculated by p and h of external medium";
    Real T_psInt "Temperature calculated by p and s of internal medium";
    Real T_psExt "Temperature calculated by p and s of external medium";
    Real dd_pt "Relative difference density";
    Real dT_ph "Relative difference calculated by p and h temperature";
    Real dT_ps "Relative difference calculated by p and s temperature";
  end Properties;

  EoS eos "Record that contains calculated properties of the EoS";
  Saturation saturation "Record that contains calculated saturation properties";
  Properties properties "Record that contains calculated state properties";

protected
  Modelica.SIunits.Time convChange(start = 0)
    "Time to reset calculation of actual temperature";
  Modelica.SIunits.Time convChangeTmp(start = 0)
    "Temporary time to reset calculation of actual temperature";

algorithm
    convT := (T_max - T_min)/80;
    convH := (h_max - h_min)/80;
    convS := (s_max - s_min)/80;
    convD := (d_max - d_min)/(80*80);
    convChange := if noEvent(delay(T,1)) >= T_max-convT then
      time else convChangeTmp;

equation

  // Change correction factors for temperature and pressure calculation
  //
  convChangeTmp = convChange;

  // Change independent thermodynamic state properties
  //
  T =  T_min + convT * (time - convChange);
  h =  h_min + convH * (time - convChange);
  s =  s_min + convS * (time - convChange);
  d =  d_min + convD * time;

  // Calculate dimensionless thermydynamic state properties
  //
  tauInt = MediumInt.fluidConstants[1].criticalTemperature/T;
  deltaInt = d/(MediumInt.fluidConstants[1].molarMass/
    MediumInt.fluidConstants[1].criticalMolarVolume);

  // Calculate state properties for calculating saturation properties
  //
  T_sat = T_min + (min(MediumInt.fluidConstants[1].criticalTemperature-2,
    T_max)-T_min)/(80*80) * time;
  p_sat = p_min + (min(MediumInt.fluidConstants[1].criticalPressure-1000,
    p_max)-p_min)/(80*80) * time;

  // Calculate derivatives of the EoS
  //
  eos.f_iInt = MediumInt.alpha_0(deltaInt,tauInt);
  eos.f_iExt = MediumExt.EoS.f_i(deltaInt,tauInt);
  eos.f_rInt = MediumInt.alpha_r(deltaInt,tauInt);
  eos.f_rExt = MediumExt.EoS.f_r(deltaInt,tauInt);
  eos.f_itInt = MediumInt.tau_d_alpha_0_d_tau(tauInt)
      /tauInt;
  eos.f_itExt = MediumExt.EoS.f_it(deltaInt,tauInt);
  eos.f_ittInt = MediumInt.tau2_d2_alpha_0_d_tau2(tauInt)
      /tauInt^2;
  eos.f_ittExt = MediumExt.EoS.f_itt(deltaInt,tauInt);
  eos.f_itttInt = MediumInt.tau3_d3_alpha_0_d_tau3(tauInt)
      /tauInt^3;
  eos.f_itttExt = MediumExt.EoS.f_ittt(deltaInt,tauInt);
  eos.f_rtInt = MediumInt.tau_d_alpha_r_d_tau(deltaInt,tauInt)
      /tauInt;
  eos.f_rtExt = MediumExt.EoS.f_rt(deltaInt,tauInt);
  eos.f_rttInt = MediumInt.tau2_d2_alpha_r_d_tau2(deltaInt,tauInt)
      /tauInt^2;
  eos.f_rttExt = MediumExt.EoS.f_rtt(deltaInt,tauInt);
  eos.f_rtttInt = MediumInt.tau3_d3_alpha_r_d_tau3(deltaInt,tauInt)
      /tauInt^3;
  eos.f_rtttExt = MediumExt.EoS.f_rttt(deltaInt,tauInt);
  eos.f_rdInt = MediumInt.delta_d_alpha_r_d_delta(deltaInt,tauInt)
      /deltaInt;
  eos.f_rdExt = MediumExt.EoS.f_rd(deltaInt,tauInt);
  eos.f_rddInt = MediumInt.delta2_d2_alpha_r_d_delta2(deltaInt,tauInt)
      /deltaInt^2;
  eos.f_rddExt = MediumExt.EoS.f_rdd(deltaInt,tauInt);
  eos.f_rdddInt = MediumInt.delta3_d3_alpha_r_d_delta3(deltaInt,tauInt)
      /deltaInt^3;
  eos.f_rdddExt = MediumExt.EoS.f_rddd(deltaInt,tauInt);
  eos.f_rtdInt = MediumInt.tau_delta_d2_alpha_r_d_tau_d_delta(deltaInt,tauInt)
      /tauInt/deltaInt;
  eos.f_rtdExt = MediumExt.EoS.f_rtd(deltaInt,tauInt);
  eos.f_rtddInt = MediumInt.tau_delta2_d3_alpha_r_d_tau_d_delta2(
    deltaInt,tauInt)/tauInt/deltaInt^2;
  eos.f_rtddExt = MediumExt.EoS.f_rtdd(deltaInt,tauInt);
  eos.f_rttdInt = MediumInt.tau2_delta_d3_alpha_r_d_tau2_d_delta(
    deltaInt,tauInt)/tauInt^2/deltaInt;
  eos.f_rttdExt = MediumExt.EoS.f_rttd(deltaInt,tauInt);

  eos.df_i = (eos.f_iInt-eos.f_iExt);
  eos.df_r = (eos.f_rInt-eos.f_rExt);
  eos.df_it = (eos.f_itInt-eos.f_itExt);
  eos.df_itt = (eos.f_ittInt-eos.f_ittExt);
  eos.df_ittt = (eos.f_itttInt-eos.f_itttExt);
  eos.df_rt = (eos.f_rtInt-eos.f_rtExt);
  eos.df_rtt = (eos.f_rttInt-eos.f_rttExt);
  eos.df_rttt = (eos.f_rtttInt-eos.f_rtttExt);
  eos.df_rd = (eos.f_rdInt-eos.f_rdExt);
  eos.df_rdd = (eos.f_rddInt-eos.f_rddExt);
  eos.df_rddd = (eos.f_rdddInt-eos.f_rdddExt);
  eos.df_rtd = (eos.f_rtdInt-eos.f_rtdExt);
  eos.df_rtdd = (eos.f_rtddInt-eos.f_rtddExt);
  eos.df_rttd = (eos.f_rttdInt-eos.f_rttdExt);

  // Calculate saturation properties
  //
  saturation.p_satInt = MediumInt.saturationPressure(T_sat);
  saturation.p_satExt = MediumExt.saturationPressure_sat(
    MediumExt.setSat_T(T_sat));
  saturation.T_satInt = MediumInt.saturationTemperature(p_sat);
  saturation.T_satExt = MediumExt.saturationTemperature_sat(
    MediumExt.setSat_p(p_sat));
  saturation.d_lInt = MediumInt.bubbleDensity(MediumInt.setSat_T(T_sat));
  saturation.d_lExt = MediumExt.bubbleDensity(MediumExt.setSat_T(T_sat));
  saturation.d_vInt = MediumInt.dewDensity(MediumInt.setSat_T(T_sat));
  saturation.d_vExt = MediumExt.dewDensity(MediumExt.setSat_T(T_sat));
  saturation.h_lInt = MediumInt.bubbleEnthalpy(MediumInt.setSat_p(p_sat));
  saturation.h_lExt = MediumExt.bubbleEnthalpy(MediumExt.setSat_p(p_sat));
  saturation.h_vInt = MediumInt.dewEnthalpy(MediumInt.setSat_p(p_sat));
  saturation.h_vExt = MediumExt.dewEnthalpy(MediumExt.setSat_p(p_sat));
  saturation.s_lInt = MediumInt.bubbleEntropy(MediumInt.setSat_p(p_sat));
  saturation.s_lExt = MediumExt.bubbleEntropy(MediumExt.setSat_p(p_sat));
  saturation.s_vInt = MediumInt.dewEntropy(MediumInt.setSat_p(p_sat));
  saturation.s_vExt = MediumExt.dewEntropy(MediumExt.setSat_p(p_sat));

  saturation.dp_sat = (saturation.p_satInt-saturation.p_satExt)
      /saturation.p_satExt*100;
  saturation.dT_sat = (saturation.T_satInt-saturation.T_satExt)
      /saturation.T_satExt*100;
  saturation.dd_l = (saturation.d_lInt-saturation.d_lExt)
      /saturation.d_lExt*100;
  saturation.dd_v = (saturation.d_vInt-saturation.d_vExt)
      /saturation.d_vExt*100;
  saturation.dh_l = (saturation.h_lInt-saturation.h_lExt)
      /saturation.h_lExt*100;
  saturation.dh_v = (saturation.h_vInt-saturation.h_vExt)
      /saturation.h_vExt*100;
  saturation.ds_l = (saturation.s_lInt-saturation.s_lExt)
      /saturation.s_lExt*100;
  saturation.ds_v = (saturation.s_vInt-saturation.s_vExt)
      /saturation.s_vExt*100;

  // Calculate further state properties
  //
  properties.d_ptInt = MediumInt.density_pT(p_sat, T);
  properties.d_ptExt = MediumExt.density_pT(p_sat, T);
  properties.T_phInt = MediumInt.temperature_ph(p_sat,h);
  properties.T_phExt = MediumExt.temperature_ph(p_sat,h);
  properties.T_psInt = MediumInt.temperature_ps(p_sat,s);
  properties.T_psExt = MediumExt.temperature_ps(p_sat,s);

  properties.dd_pt = (properties.d_ptInt-properties.d_ptExt)
    /properties.d_ptExt*100;
  properties.dT_ph = (properties.T_phInt-properties.T_phExt)
    /properties.T_phExt*100;
  properties.dT_ps = (properties.T_psInt-properties.T_psExt)
    /properties.T_psExt*100;
  annotation(experiment(StopTime=6400, Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>
This example models checks the implementation of the<b> refrigerant&apos;s
fitted formulas</b> depending on the independent variables density and
temperature. Therefore, the user has first to introduce some information
about the refrigerant and afterwards the fitted formulas are calculated.
The following <b>refrigerant&apos;s information</b> is required:
</p>
<ol>
<li>The <i>refrigerant package</i> that
shall be tested.</li>
<li>The <i>refrigerant&apos;s fluid limits</i> that are
determined by the fitting procedure.</li>
</ol>
<p>
The following <b>refrigerant&apos;s fitted formulas </b> are
calculated and checked:
</p>
<ol>
<li>Calculation of the Helmholtz equation of state.</li>
<li>Calculation of the saturation properties.</li>
<li>Calculation of further state propeties like the density
depending on pressure and temperature.</li>
</ol>
<p>
Additionally, the fitted formulas are also calculated with an external
media libary (i.e. HelmholtzMedia) and errors between the external and
internal medium are calculated.
</p>
</html>", revisions="<html>
<ul>
  <li>
  August 13, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantsFittedFormulas;
