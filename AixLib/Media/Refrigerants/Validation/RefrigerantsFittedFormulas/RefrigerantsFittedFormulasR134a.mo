within AixLib.Media.Refrigerants.Validation.RefrigerantsFittedFormulas;
model RefrigerantsFittedFormulasR134a
  "Model that checks the fitted formulas of R134a"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  //
  replaceable package MediumInt =
    AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
    "Internal medium model";

  // Define parameters that define the range for calculating the fitted formulas
  //
  parameter Modelica.Units.SI.SpecificEnthalpy h_min=180e3
    "Fluid limit: Minimum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_max=550e3
    "Fluid limit: Maximum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.SpecificEntropy s_min=1.0e3
    "Fluid limit: Minimum specific entropy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.SpecificEntropy s_max=1.8e3
    "Fluid limit: Maximum specific entropy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Density d_min=2.0 "Fluid limit: Minimum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Density d_max=1425 "Fluid limit: Maximum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.AbsolutePressure p_min=1e5
    "Fluid limit: Minimum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.AbsolutePressure p_max=38.5e5
    "Fluid limit: Maximum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Temperature T_min=233.15
    "Fluid limit: Minimum temperature" annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Temperature T_max=455.15
    "Fluid limit: Maximum temperature" annotation (Dialog(group="Fluid limits"));

  // Define submodels and connectors
  //
  Modelica.Blocks.Sources.CombiTimeTable extProp(
    tableOnFile=true,
    tableName="External",
    fileName=Modelica.Utilities.Files.loadResource(
      "modelica://AixLib/Resources/Media/Refrigerants/ValidationFittedFormulasR134a.txt"),
    columns=2:26,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    startTime=-0.000001)
    "Table that contains the results of the external media library"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

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
  Modelica.Units.SI.AbsolutePressure p_sat
    "Actual pressure for calculating saturation properties";
  Modelica.Units.SI.Temperature T "Actual pulsating temperature";
  Modelica.Units.SI.Temperature T_sat
    "Actual temperature for calculating saturation properties";
  Modelica.Units.SI.Density d "Actual raising density";
  Modelica.Units.SI.SpecificEnthalpy h
    "Actual pulsating specific enthalpy for calculating state properties";
  Modelica.Units.SI.SpecificEntropy s
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
  end EoS;

  record Saturation
    "Record that contains calculated saturation properties"
    Modelica.Units.SI.AbsolutePressure p_satInt
      "Saturation pressure of internal medium";
    Modelica.Units.SI.AbsolutePressure p_satExt
      "Saturation pressure of external medium";
    Modelica.Units.SI.Temperature T_satInt
      "Saturation temperature of internal medium";
    Modelica.Units.SI.Temperature T_satExt
      "Saturation temperature of external medium";
    Modelica.Units.SI.Density d_lInt "Bubble density of internal medium";
    Modelica.Units.SI.Density d_lExt "Bubble density of external medium";
    Modelica.Units.SI.Density d_vInt "Dew density of internal medium";
    Modelica.Units.SI.Density d_vExt "Dew density of external medium";
    Modelica.Units.SI.SpecificEnthalpy h_lInt
      "Specific bubble enthalpy of internal medium";
    Modelica.Units.SI.SpecificEnthalpy h_lExt
      "Specific bubble enthalpy of external medium";
    Modelica.Units.SI.SpecificEnthalpy h_vInt
      "Specific dew enthalpy internal medium";
    Modelica.Units.SI.SpecificEnthalpy h_vExt
      "Specific dew enthalpy of external medium";
    Modelica.Units.SI.SpecificEntropy s_lInt
      "Specific bubble entropy of internal medium";
    Modelica.Units.SI.SpecificEntropy s_lExt
      "Specific bubble entropy of external medium";
    Modelica.Units.SI.SpecificEntropy s_vInt
      "Specific dew entropy of internal medium";
    Modelica.Units.SI.SpecificEntropy s_vExt
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
  end Properties;

  EoS eos "Record that contains calculated properties of the EoS";
  Saturation saturation "Record that contains calculated saturation properties";
  Properties properties "Record that contains calculated state properties";

protected
  Modelica.Units.SI.Time convChange(start=0)
    "Time to reset calculation of actual temperature";
  Modelica.Units.SI.Time convChangeTmp(start=0)
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
  eos.f_iInt = MediumInt.f_Idg(deltaInt,tauInt);
  eos.f_iExt = extProp.y[1];
  eos.f_rInt = MediumInt.f_Res(deltaInt,tauInt);
  eos.f_rExt = extProp.y[2];
  eos.f_itInt = MediumInt.t_fIdg_t(tauInt)/tauInt;
  eos.f_itExt = extProp.y[3];
  eos.f_ittInt = MediumInt.tt_fIdg_tt(tauInt)/tauInt^2;
  eos.f_ittExt = extProp.y[4];
  eos.f_itttInt = MediumInt.ttt_fIdg_ttt(tauInt)/tauInt^3;
  eos.f_itttExt = extProp.y[5];
  eos.f_rtInt = MediumInt.t_fRes_t(deltaInt,tauInt)/tauInt;
  eos.f_rtExt =extProp.y[6];
  eos.f_rttInt = MediumInt.tt_fRes_tt(deltaInt,tauInt)/tauInt^2;
  eos.f_rttExt = extProp.y[7];
  eos.f_rtttInt = MediumInt.ttt_fRes_ttt(deltaInt,tauInt)/tauInt^3;
  eos.f_rtttExt = extProp.y[8];
  eos.f_rdInt = MediumInt.d_fRes_d(deltaInt,tauInt)/deltaInt;
  eos.f_rdExt = extProp.y[9];
  eos.f_rddInt = MediumInt.dd_fRes_dd(deltaInt,tauInt)/deltaInt^2;
  eos.f_rddExt = extProp.y[10];
  eos.f_rdddInt = MediumInt.ddd_fRes_ddd(deltaInt,tauInt)/deltaInt^3;
  eos.f_rdddExt = extProp.y[11];
  eos.f_rtdInt = MediumInt.td_fRes_td(deltaInt,tauInt)/tauInt/deltaInt;
  eos.f_rtdExt = extProp.y[12];
  eos.f_rtddInt = MediumInt.tdd_fRes_tdd(deltaInt,tauInt)/tauInt/deltaInt^2;
  eos.f_rtddExt = extProp.y[13];
  eos.f_rttdInt = MediumInt.ttd_fRes_ttd(deltaInt,tauInt)/tauInt^2/deltaInt;
  eos.f_rttdExt = extProp.y[14];

  // Calculate saturation properties
  //
  saturation.p_satInt = MediumInt.saturationPressure(T_sat);
  saturation.p_satExt =extProp.y[15];
  saturation.T_satInt = MediumInt.saturationTemperature(p_sat);
  saturation.T_satExt = extProp.y[16];
  saturation.d_lInt = MediumInt.bubbleDensity(MediumInt.setSat_T(T_sat));
  saturation.d_lExt = extProp.y[17];
  saturation.d_vInt = MediumInt.dewDensity(MediumInt.setSat_T(T_sat));
  saturation.d_vExt = extProp.y[18];
  saturation.h_lInt = MediumInt.bubbleEnthalpy(MediumInt.setSat_p(p_sat));
  saturation.h_lExt = extProp.y[19];
  saturation.h_vInt = MediumInt.dewEnthalpy(MediumInt.setSat_p(p_sat));
  saturation.h_vExt = extProp.y[20];
  saturation.s_lInt = MediumInt.bubbleEntropy(MediumInt.setSat_p(p_sat));
  saturation.s_lExt = extProp.y[21];
  saturation.s_vInt = MediumInt.dewEntropy(MediumInt.setSat_p(p_sat));
  saturation.s_vExt = extProp.y[22];

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
  properties.d_ptExt = extProp.y[23];
  properties.T_phInt = MediumInt.temperature_ph(p_sat,h);
  properties.T_phExt = extProp.y[24];
  properties.T_psInt = MediumInt.temperature_ps(p_sat,s);
  properties.T_psExt = extProp.y[25];

  annotation(experiment(StopTime=6400, Tolerance=1e-006),
    Documentation(info="<html><p>
  This example models checks the implementation of the <b>refrigerant's
  fitted formulas</b> depending on the independent variables density
  and temperature. Therefore, the user has first to introduce some
  information about the refrigerant and afterwards the fitted formulas
  are calculated. The following <b>refrigerant's information</b> is
  required:
</p>
<ol>
  <li>The <i>refrigerant package</i> that shall be tested.
  </li>
  <li>The <i>refrigerant's fluid limits</i> that are determined by the
  fitting procedure.
  </li>
</ol>
<p>
  The following <b>refrigerant's fitted formulas</b> are calculated and
  checked:
</p>
<ol>
  <li>Calculation of the Helmholtz equation of state.
  </li>
  <li>Calculation of the saturation properties.
  </li>
  <li>Calculation of further state propeties like the density depending
  on pressure and temperature.
  </li>
</ol>
<p>
  Additionally, the fitted formulas are also calculated with an
  external media libary (i.e. <a href=
  \"https://github.com/thorade/HelmholtzMedia\">HelmholtzMedia</a>).
  Therefore, the parameters are not allowed to change (except for the
  medium package).
</p>
<ul>
  <li>August 13, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantsFittedFormulasR134a;
