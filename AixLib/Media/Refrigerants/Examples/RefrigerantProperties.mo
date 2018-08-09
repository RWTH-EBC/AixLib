within AixLib.Media.Refrigerants.Examples;
model RefrigerantProperties
  "Model that tests the implementation of the refrigerant properties"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  //
  package Medium =
      AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
      "Internal medium model";

  // Define way of calculating pressure and temperature
  //
  parameter Boolean wayOfCalc = true
    "true = Slowly raise pressure and change temperature | false = Slowly raise
    temperature and change pressure"
    annotation (Dialog(group="General"));

  // Define the fluid limits of the medium that shall be tested
  //
  parameter Modelica.SIunits.SpecificEnthalpy h_min = 145e3
    "Fluid limit: Minimum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.SpecificEnthalpy h_max = 480e3
    "Fluid limit: Maximum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_min = 2
    "Fluid limit: Minimum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_max = 1325
    "Fluid limit: Maximum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.AbsolutePressure p_min = 1e5
    "Fluid limit: Minimum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.AbsolutePressure p_max = 39e5
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
  Real convP(start = (p_max-p_min)/(80*80))
    "Conversion factor in Pa/s for pressure to satisfy unit check";

  // Define variables that shall be tested
  //
  Modelica.SIunits.Temperature T(start = T_min)
    "Actual temperature";
  Modelica.SIunits.AbsolutePressure p(start = p_min)
    "Actual absolute presure";
  Modelica.SIunits.Density d(start = d_min)
    "Actual density";
  Modelica.SIunits.SpecificEnthalpy h(start = h_min)
    "Actual specific enthalpy";
  Modelica.SIunits.SpecificEntropy s
    "Actual specific entropy";
  Modelica.SIunits.SpecificInternalEnergy u
    "Actual specific internal energy";
  Modelica.SIunits.SpecificEnergy g
    "Actual specific Gibbs energy";
  Modelica.SIunits.SpecificEnergy f
    "Actual specific Helmholtz energy";

  Medium.SaturationProperties satT
    "Actual saturation properties calculated with temperature";
  Medium.SaturationProperties satP
    "Actual saturation properties calculated with pressure";

  Medium.ThermodynamicState bubbleState
    "Actual bubble state";
  Medium.ThermodynamicState dewState
    "Actual dew state";
  Medium.ThermodynamicState state_pT
    "Actual state calculated by p and T";
  Medium.ThermodynamicState state_dT
    "Actual state calculated by d and T";
  Medium.ThermodynamicState state_ph
    "Actual state calculated by p and h";
  Medium.ThermodynamicState state_ps
    "Actual state calculated by p and s";

  // Define records to summarise further variables that shall be tested
  //
  record ThermodynamicProperties
    "Records that contains furhter thermodynamic properties"
    Medium.SpecificHeatCapacity cp
      "Actual specific heat capacity at constant pressure";
    Medium.SpecificHeatCapacity cv
      "Actual specific heat capacity at constant volume";
    Medium.VelocityOfSound w
      "Actual velocity of sound";
    Medium.IsobaricExpansionCoefficient betta
      "Actual isobaric expansion coefficient";
    Modelica.SIunits.IsothermalCompressibility kappa
      "Actual isothermal compressibility";
    Modelica.SIunits.IsentropicExponent gamma
      "Actual isentropic coefficient";
    Real delta_T(unit= "J/(Pa.kg)")
      "Actual isothermal throttling coefficient";
    Real my(unit="K/Pa")
      "Actual joule Thomson Coefficient";
    Medium.DynamicViscosity eta
      "Actual dynamic viscosity";
    Medium.ThermalConductivity lambda
      "Actual thermal conductivity";
    Medium.SurfaceTension sigma
      "Acutal surface tension";
  end ThermodynamicProperties;

  record StateErrors
    "Record that contains errors occuring using the different
    setState functions"
    extends Modelica.Icons.Record;

    Real errorTemperature_dTMax
      "Error of temperature_dT compared to T";
    Real errorPressure_dTMax
      "Error of pressure_dT compared to p";
    Real errorDensity_dTMax
      "Error of density_dT compared to density_pT";
    Real errorSpecificEnthalpy_dTMax
      "Error of specificEnthalpy_dT compared to specificEnthalpy_pT";
    Real errorTemperature_phMax
      "Error of temperature_ph compared to T";
    Real errorPressure_phMax
      "Error of pressure_ph compared to p";
    Real errorDensity_phMax
      "Error of density_ph compared to density_pT";
    Real errorSpecificEnthalpy_phMax
      "Error of specificEnthalpy_ph compared to specificEnthalpy_pT";
    Real errorTemperature_psMax
      "Error of temperature_ps compared to T";
    Real errorPressure_psMax
      "Error of pressure_ps compared to p";
    Real errorDensity_psMax
      "Error of density_ps compared to density_pT";
    Real errorSpecificEnthalpy_psMax
      "Error of specificEnthalpy_ps compared to specificEnthalpy_pT";
    Real relErrorTemperature_dTMax
     "Relative error of temperature_dT compared to T";
    Real relErrorPressure_dTMax
     "Relative error of pressure_dT compared to p";
    Real relErrorDensity_dTMax
     "Relative error of density_dT compared to density_pT";
    Real relErrorSpecificEnthalpy_dTMax
     "Relative error of specificEnthalpy_dT compared to specificEnthalpy_pT";
    Real relErrorTemperature_phMax
     "Relative error of temperature_ph compared to T";
    Real relErrorPressure_phMax
     "Relative error of pressure_ph compared to p";
    Real relErrorDensity_phMax
     "Relative error of density_ph compared to density_pT";
    Real relErrorSpecificEnthalpy_phMax
     "Relative error of specificEnthalpy_ph compared to specificEnthalpy_pT";
    Real relErrorTemperature_psMax
     "Relative error of temperature_ps compared to T";
    Real relErrorPressure_psMax
     "Relative error of pressure_ps compared to p";
    Real relErrorDensity_psMax
     "Relative error of density_ps compared to density_pT";
    Real relErrorSpecificEnthalpy_psMax
     "Relative error of specificEnthalpy_ps compared to specificEnthalpy_pT";
  end StateErrors;

  ThermodynamicProperties thermodynamicProperties
    "Record that contains further thermodynamic properties calculated during
    the test";
  StateErrors stateErros
    "Record that contains errors occuring using the different
    setState functions";

protected
  Modelica.SIunits.Time convChange(start = 0)
    "Time to reset calculation of actual temperature or pressure";
  Modelica.SIunits.Time convChangeTmp(start = 0)
    "Temporary time to reset calculation of actual temperature or pressure";

algorithm
  if wayOfCalc then
    convT := (T_max - T_min)/80;
    convP := (p_max - p_min)/(80*80);
    convChange := if noEvent(delay(T,1)) >=
      T_max-convT then time else convChangeTmp;
  else
    convT := (T_max - T_min)/(80*80);
    convP := (p_max - p_min)/80;
    convChange := if noEvent(delay(p,1)) >=
      p_max-convP then time else convChangeTmp;
  end if;

equation

  // Change correction factors for temperature and pressure calculation
  //
  convChangeTmp = convChange;

  // Change independent thermodynamic state properties acording to time
  //
  if wayOfCalc then
    T =  min((T_min + convT * (time - convChange)),T_max);
    p =  min((p_min + convP * time),p_max);
  else
    T =  min((T_min + convT * time),T_max);
    p =  min((p_min + convP * (time - convChange)),p_max);
  end if;

  // Calculate furhter thermodynamic state properties
  //
  d = Medium.density(state_pT);
  h = Medium.specificEnthalpy(state_pT);
  s = Medium.specificEntropy(state_pT);
  u = h - p/d;
  g = h - T*s;
  f = h - p/d -T*s;

  // Calculate and check saturation properties
  //
  satT = Medium.setSat_T(min(max(243.15,T),
    Medium.fluidConstants[1].criticalTemperature-3));
  satP = Medium.setSat_p(satT.psat);

  // Calculate and check state functions
  //
  bubbleState = Medium.setBubbleState(satT,1);
  dewState = Medium.setDewState(satT,1);
  state_pT = Medium.setState_pT(p,T);
  state_dT = Medium.setState_dT(d,T);
  state_ph = Medium.setState_ph(p,h);
  state_ps = Medium.setState_ps(p,s);

  // Calculate further properties
  //
  thermodynamicProperties.cp = Medium.specificHeatCapacityCp(state_pT);
  thermodynamicProperties.cv = Medium.specificHeatCapacityCv(state_pT);
  thermodynamicProperties.w = Medium.velocityOfSound(state_pT);
  thermodynamicProperties.betta =
    Medium.isobaricExpansionCoefficient(state_pT);
  thermodynamicProperties.kappa = Medium.isothermalCompressibility(state_pT);
  thermodynamicProperties.gamma = Medium.isentropicExponent(state_pT);
  thermodynamicProperties.delta_T =
    Medium.isothermalThrottlingCoefficient(state_pT);
  thermodynamicProperties.my = Medium.jouleThomsonCoefficient(state_pT);
  thermodynamicProperties.eta = Medium.dynamicViscosity(state_pT);
  thermodynamicProperties.lambda = Medium.thermalConductivity(state_pT);
  thermodynamicProperties.sigma = Medium.surfaceTension(satT);

  // Calculate errors of thermodynamic state properties
  //
  stateErros.errorTemperature_dTMax =  abs(state_dT.T - state_pT.T);
  stateErros.errorPressure_dTMax =  abs(state_dT.p - state_pT.p);
  stateErros.errorDensity_dTMax = abs(state_dT.d - state_pT.d);
  stateErros.errorSpecificEnthalpy_dTMax = abs(state_dT.h - state_pT.h);
  stateErros.errorTemperature_phMax = abs(state_ph.T - state_pT.T);
  stateErros.errorPressure_phMax = abs(state_ph.p - state_pT.p);
  stateErros.errorDensity_phMax = abs(state_ph.d - state_pT.d);
  stateErros.errorSpecificEnthalpy_phMax = abs(state_ph.h - state_pT.h);
  stateErros.errorTemperature_psMax = abs(state_ps.T - state_pT.T);
  stateErros.errorPressure_psMax = abs(state_ps.p - state_pT.p);
  stateErros.errorDensity_psMax = abs(state_ps.d - state_pT.d);
  stateErros.errorSpecificEnthalpy_psMax = abs(state_ps.h - state_pT.h);

  stateErros.relErrorTemperature_dTMax =  abs(state_dT.T - state_pT.T) /
    abs(state_pT.T)*100;
  stateErros.relErrorPressure_dTMax =  abs(state_dT.p - state_pT.p) /
    abs(state_pT.p)*100;
  stateErros.relErrorDensity_dTMax = abs(state_dT.d - state_pT.d) /
    abs(state_pT.d)*100;
  stateErros.relErrorSpecificEnthalpy_dTMax = abs(state_dT.h - state_pT.h) /
    abs(state_pT.h)*100;
  stateErros.relErrorTemperature_phMax = abs(state_ph.T - state_pT.T) /
    abs(state_pT.T)*100;
  stateErros.relErrorPressure_phMax = abs(state_ph.p - state_pT.p) /
    abs(state_pT.p)*100;
  stateErros.relErrorDensity_phMax = abs(state_ph.d - state_pT.d) /
    abs(state_pT.d)*100;
  stateErros.relErrorSpecificEnthalpy_phMax = abs(state_ph.h - state_pT.h) /
    abs(state_pT.h)*100;
  stateErros.relErrorTemperature_psMax = abs(state_ps.T - state_pT.T) /
    abs(state_pT.T)*100;
  stateErros.relErrorPressure_psMax = abs(state_ps.p - state_pT.p) /
    abs(state_pT.p)*100;
  stateErros.relErrorDensity_psMax = abs(state_ps.d - state_pT.d) /
    abs(state_pT.d)*100;
  stateErros.relErrorSpecificEnthalpy_psMax = abs(state_ps.h - state_pT.h) /
    abs(state_pT.h)*100;

   annotation(experiment(StopTime=6400, Tolerance=1e-006),
      Documentation(info="<html>
<p>
This example models checks the implementation of the<b> refrigerant&apos;s
thermophysical properties</b> depending on the independent variables pressure
and temperature. Therefore, the user has first to introduce some information
about the refrigerant and afterwards the thermophysical properties are
calculated. The following <b>refrigerant&apos;s information</b> is required:
</p>
<ol>
<li>The <i>refrigerant package</i> that shall be tested.
</li>
<li>The <i>way of calculating</i> the thermophysical properties. Therefore,
the user can choose between either (wayOfCalc = true) a slowly raising
pressure from p<sub>min</sub> to p<sub>max</sub> and a fast pulsating
temperature from T<sub>min</sub> to T<sub>max</sub> or (wayOfCalc = false) a
fast pulsating pressure from p<sub>min</sub> to p<sub>max</sub> and a slowly
raising temperature from T<sub>min</sub> to T<sub>max</sub>. In both modes,
the overall simulating time is set to 6400 s and, hence, the slowly raising
property will reach its maximum value after 6400 s. The fast pulsating
property will reach its maximum value after 80 s.
</li>
<li>The <i>refrigerant&apos;s fluid limits</i> that are determined by the
fitting procedure.
</li>
</ol>
<p>
The following <b>refrigerant&apos;s thermophysical properties</b> are
calculated and checked:
</p>
<ol>
<li>Calculation of basic properties like the specific enthalpy or density
using pressure and temperature.</li>
<li>Calculation of saturation properties using both pressure and temperature.
The results of both calculations are compared to each other.</li>
<li>Calculation of the &quot;setState&quot;-functions and comparing the
results to the &quot;setState_pT&quot;-results.</li>
<li>Calculation of furhter properties like the thermal conductivity or
isothermal compressbility.</li>
</ol>
<p>
Additionally, the &quot;setState&quot;-functions&apos; <b>absolute and
relative errors</b> compared to the &quot;setState_pT&quot;-results are
calculated.
</p>
</html>",
revisions="<html>
<ul>
  <li>
  June 13, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantProperties;
