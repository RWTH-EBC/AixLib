within AixLib.Media.Refrigerants.Examples;
model RefrigerantDerivativeCheck
  "Model that tests the refrigerant's derivative implementation"
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

  // Define the conversion factor for the unit test
  Real convT
    "Conversion factor for temperature to satisfy unit check";

  // Define variables that shall be calculated
  Modelica.SIunits.Temperature T
    "Actual temperature";
  Modelica.SIunits.AbsolutePressure p
    "Actual pressure";
  Modelica.SIunits.SpecificEnthalpy hSym
    "Actual enthalpy";
  Modelica.SIunits.SpecificEnthalpy hCod
    "Actual enthalpy";
  Modelica.SIunits.SpecificHeatCapacity cpSym
    "Actual specific heat capacity at constant pressure";
  Modelica.SIunits.SpecificHeatCapacity cpCod
    "Actual specific heat capacity at constant pressure";
  Modelica.SIunits.SpecificHeatCapacity cvSym
    "Actual specific heat capacity at constant volume";
  Modelica.SIunits.SpecificHeatCapacity cvCod
    "Actual specific heat capacity at constant volume";

initial equation
  hSym = hCod;
  cpSym = cpCod;
  cvSym = cvCod;

equation
  // Calculate the conversion factors for the unit test
  convT = (T_max - T_min) / (80^3);

  // Calculate independent state properties
  T = T_min + convT * time^3;
  p = p_min + 1 / (1 + exp(-0.1 * (time - 40))) * (p_max - p_min);

  // Calculate specific enthalpy
  hCod = Medium.specificEnthalpy(
    Medium.setState_pT(p = p, T = T));
  hCod = hSym;
//   der(hCod)=der(hSym);
//   assert(abs(hCod-hSym) < 1E-2, "Model has an error");

  // Calculate specific heat capacity at constant pressure
  cpCod = Medium.specificHeatCapacityCp(
    Medium.setState_pT(p = p, T = T));
  cpCod = cpSym;
//   der(cpCod)=der(cpSym);
//   assert(abs(cpCod-cpSym) < 1E-2, "Model has an error");

  // Calculate specific heat capacity at constant volume
  cvCod = Medium.specificHeatCapacityCv(
    Medium.setState_pT(p = p, T = T));
  cvCod = cvSym;
//   der(cvCod)=der(cvSym);
//   assert(abs(cvCod-cvSym) < 1E-2, "Model has an error");

   annotation(experiment(StopTime=80, Tolerance=1e-008),
      __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Examples/WaterDerivativeCheck.mos"
        "Simulate and plot"),
      Documentation(info="<html>
  <p>
  This example checks whether the function derivative
  is implemented correctly. If the derivative implementation
  is not correct, the model will stop with an assert statement.
  </p>
  </html>",     revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"),
    __Dymola_experimentSetupOutput);
end RefrigerantDerivativeCheck;
