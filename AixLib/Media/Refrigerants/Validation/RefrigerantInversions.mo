within AixLib.Media.Refrigerants.Validation;
model RefrigerantInversions
  "Model to check computation of the main thermodynamic properties
  and theirs inverses"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  package Medium =
      AixLib.Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record
      "Internal medium model";

  // Define the fluid limits of the medium that shall be tested
  parameter Modelica.Units.SI.AbsolutePressure p_min=1e5
    "Fluid limit: Minimum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.AbsolutePressure p_max=48e5
    "Fluid limit: Maximum absolute pressure"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Temperature T_min=233.15
    "Fluid limit: Minimum temperature" annotation (Dialog(group="Fluid limits"));
  parameter Modelica.Units.SI.Temperature T_max=340.15
    "Fluid limit: Maximum temperature" annotation (Dialog(group="Fluid limits"));

  // Define the conversion factor for the unit test
  //
  Real convT
    "Conversion factor for temperature to satisfy unit check";

  // Define variables that shall be calculated
  //
  Modelica.Units.SI.Temperature T "Actual temperature";
  Modelica.Units.SI.Temperature TInv_h
    "Actual inverse temperature calculated with h and p";
  Modelica.Units.SI.Temperature TInv_s
    "Actual inverse temperature calculated with s and p";
  Modelica.Units.SI.AbsolutePressure p "Actual pressure";
  Modelica.Units.SI.AbsolutePressure pInv_d
    "Actual inverse pressure calculated with d and T";
  Modelica.Units.SI.SpecificEnthalpy h "Actual enthalpy";
  Modelica.Units.SI.SpecificEnthalpy hInv_d
    "Actual inverse enthalpy calculated with d and T";
  Modelica.Units.SI.SpecificEnthalpy hInv_s
    "Actual inverse enthalpy calculated with s and p";
  Modelica.Units.SI.Density d "Actual density";
  Modelica.Units.SI.Density dInv_h
    "Actual inverse density calculated with h and p";
  Modelica.Units.SI.Density dInv_s
    "Actual inverse density calculated with h and s";
  Modelica.Units.SI.SpecificEntropy s "Actual specific entropy";

equation

  // Calculate the conversion factors for the unit test
  //
  convT = (T_max - T_min) / (80^3);

  // Calculate independent state properties
  //
  T = T_min + convT * time^3;
  p = p_min + 1 / (1 + exp(-0.1 * (time - 40))) * (p_max - p_min);

  // Calculate thermodynamic properties depending on p and T
  //
  h = Medium.specificEnthalpy_pT(p = p, T = T);
  d = Medium.density_pT(p = p, T = T);
  s = Medium.specificEntropy(Medium.setState_pT(p = p, T = T));

  // Calculate inverse thermodynamic properties
  //
  TInv_h = Medium.temperature_ph(p = p, h = h, phase = 0);
  TInv_s = Medium.temperature_ps(p = p, s = s, phase = 0);
  pInv_d = Medium.pressure_dT(d = d, T = T, phase = 0);
  dInv_h = Medium.density_ph(p = p, h = h, phase = 0);
  dInv_s = Medium.density_ps(p = p, s = s, phase = 0);
  hInv_d = Medium.specificEnthalpy_dT(d = d, T = T, phase = 0);
  hInv_s = Medium.specificEnthalpy_ps(p = p, s = s, phase = 0);

  annotation (
experiment(StopTime=80, Tolerance=1e-006),
    Documentation(info="<html><p>
  This example models checks the calculation of the <b>refrigerant's
  main inversions</b> depending on the independent variables pressure
  and temperature. Therefore, the user has first to introduce some
  information about the refrigerant and afterwards the different
  inversions are calculated. The following <b>refrigerant's
  information</b> is required:
</p>
<ol>
  <li>The <i>refrigerant package</i> that shall be tested.
  </li>
  <li>The <i>refrigerant's fluid limits</i> that are determined by the
  fitting procedure.
  </li>
</ol>
<p>
  The following <b>inversions</b> are calculated and checked:
</p>
<ol>
  <li>Temperature calculated with pressure and specific enthalpy.
  </li>
  <li>Temperature calculated with pressure and specific entropy.
  </li>
  <li>Pressure calculated with density and temperature.
  </li>
  <li>Density calculated with pressure and specific enthalpy.
  </li>
  <li>Density calculated with pressure and specific entropy.
  </li>
  <li>Specific enthalpy calculated with density and temperature.
  </li>
  <li>Specific enthalpy calculated with pressure and specific entropy.
  </li>
</ol>
</html>",
revisions="<html><ul>
  <li>June 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantInversions;
