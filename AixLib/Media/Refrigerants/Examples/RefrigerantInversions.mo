within AixLib.Media.Refrigerants.Examples;
model RefrigerantInversions
  "Model to check computation of the main thermodynamic properties and theirs inverses"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  package Medium = AixLib.Media.Refrigerants.R1270.R1270_FastPropane;

  // Define the fluid limits of the medium that shall be tested
  parameter Modelica.SIunits.AbsolutePressure p_min = 0.5e5
    "Fluid limit: Minimum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.AbsolutePressure p_max = 30e5
    "Fluid limit: Maximum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Temperature T_min = 263.15
    "Fluid limit: Minimum temperature"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Temperature T_max = 343.15
    "Fluid limit: Maximum temperature"
    annotation (Dialog(group="Fluid limits"));

  // Define accuracies for formulas denpending on fitted formulas
  parameter Real errorTemperature_ph = 0.095
    "Accuracy of temperature_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorTemperature_ps = 3
    "Accuracy of temperature_ps"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorPressure_dT = 120000
    "Accuracy of pressure_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorDensity_ph = 0.26
    "Accuracy of density_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorDensity_ps = 120
    "Accuracy of density_ps"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorSpecificEnthalpy_dT = 0.0000001
    "Accuracy of specificEnthalpy_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorSpecificEnthalpy_ps = 43700
    "Accuracy of specificEnthalpy_ps"
    annotation (Dialog(group="Accuraties"));

  // Define the conversion factor for the unit test
  Real convT
    "Conversion factor for temperature to satisfy unit check";

  // Define variables that shall be calculated
  Modelica.SIunits.Temperature T
    "Actual temperature";
  Modelica.SIunits.Temperature TInv_h
    "Actual inverse temperature calculated with h and p";
  Modelica.SIunits.Temperature TInv_s
    "Actual inverse temperature calculated with s and p";
  Modelica.SIunits.AbsolutePressure p
    "Actual pressure";
  Modelica.SIunits.AbsolutePressure pInv_d
    "Actual inverse pressure calculated with d and T";
  Modelica.SIunits.SpecificEnthalpy h
    "Actual enthalpy";
  Modelica.SIunits.SpecificEnthalpy hInv_d
    "Actual inverse enthalpy calculated with d and T";
  Modelica.SIunits.SpecificEnthalpy hInv_s
    "Actual inverse enthalpy calculated with s and p";
  Modelica.SIunits.Density d
    "Actual density";
  Modelica.SIunits.Density dInv_h
    "Actual inverse density calculated with h and p";
  Modelica.SIunits.Density dInv_s
    "Actual inverse density calculated with h and s";
  Modelica.SIunits.SpecificEntropy s
    "Actual specific entropy";

equation
  // Calculate the conversion factors for the unit test
  convT = (T_max - T_min) / (80^3);

  // Calculate independent state properties
  T = T_min + convT * time^3;
  p = p_min + 1 / (1 + exp(-0.1 * (time - 40))) * (p_max - p_min);

  // Calculate thermodynamic properties depending on p and T
  h = Medium.specificEnthalpy_pT(p = p, T = T);
  d = Medium.density_pT(p = p, T = T);
  s = Medium.specificEntropy(Medium.setState_pT(p = p, T = T));

  // Calculate inverse thermodynamic properties
  TInv_h = Medium.temperature_ph(p = p, h = h, phase = 0);
  assert(abs(T - TInv_h) < errorTemperature_ph,
    "Error in implementation of temperature_ph");
  TInv_s = Medium.temperature_ps(p = p, s = s, phase = 0);
  assert(abs(T - TInv_s) < errorTemperature_ps,
    "Error in implementation of temperature_ph");
  pInv_d = Medium.pressure_dT(d = d, T = T, phase = 0);
  assert(abs(p - pInv_d) < errorPressure_dT,
    "Error in implementation of temperature_ph");
  dInv_h = Medium.density_ph(p = p, h = h, phase = 0);
  assert(abs(d - dInv_h) < errorDensity_ph,
    "Error in implementation of density_ph");
  dInv_s = Medium.density_ps(p = p, s = s, phase = 0);
  assert(abs(d - dInv_s) < errorDensity_ps,
    "Error in implementation of density_ps");
  hInv_d = Medium.specificEnthalpy_dT(d = d, T = T, phase = 0);
  assert(abs(h - hInv_d) < errorSpecificEnthalpy_dT,
    "Error in implementation of specificEnthalpy_dT");
  hInv_s = Medium.specificEnthalpy_ps(p = p, s = s, phase = 0);
  assert(abs(h - hInv_s) < errorSpecificEnthalpy_ps,
    "Error in implementation of specificEnthalpy_ps");

  annotation (
experiment(Tolerance=1e-6, StopTime=80),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Examples/WaterTemperatureEnthalpyInversion.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example models checks the<b> </b>calculation of the <b>refrigerant&apos;s main inversions</b> depending on the independent variables pressure and temperature. Therefore, the user has first to introduce some information about the refrigerant and afterwards the different inversions are calculated. The following <b>refrigerant&apos;s information</b> is required:</p>
<ol>
<li>The <i>refrigerant package</i> that shall be tested.</li>
<li>The <i>refrigerant&apos;s fluid limits</i> that are determined by the fitting procedure.</li>
<li>The <i>accuracies of formulas</i> (e.g. temperature_ph) that are directly fitted to external data or that depend on further fitted formula.</li>
</ol>
<p>The following <b>inversions</b> are calculated and checked:</p>
<ol>
<li>Temperature calculated with pressure and specific enthalpy.</li>
<li>Temperature calculated with pressure and specific entropy.</li>
<li>Pressure calculated with density and temperature.</li>
<li>Density calculated with pressure and specific enthalpy.</li>
<li>Density calculated with pressure and specific entropy.</li>
<li>Specific enthalpy calculated with density and temperature.</li>
<li>Specific enthalpy calculated with pressure and specific entropy.</li>
</ol>
</html>",     revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantInversions;
