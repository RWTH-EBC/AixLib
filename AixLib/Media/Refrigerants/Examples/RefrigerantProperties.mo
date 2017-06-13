within AixLib.Media.Refrigerants.Examples;
model RefrigerantProperties
  "Model that tests the implementation of the fluid properties"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  package Medium = AixLib.Media.Refrigerants.R1270.R1270_FastPropane;

  // Define the fluid limits of the medium that shall be tested
  parameter Modelica.SIunits.SpecificEnthalpy h_min = 177e3
    "Fluid limit: Minimum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.SpecificEnthalpy h_max = 576e3
    "Fluid limit: Maximum specific enthalpy"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_min = 0.77
    "Fluid limit: Minimum density"
    annotation (Dialog(group="Fluid limits"));
  parameter Modelica.SIunits.Density d_max = 547
    "Fluid limit: Maximum density"
    annotation (Dialog(group="Fluid limits"));
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
  parameter Real errorTemperature_dT= 0.0000001
    "Accuracy of temperature_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorPressure_dT = 350
    "Accuracy of pressure_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorDensity_dT = 0.0000001
    "Accuracy of density_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorSpecificEnthalpy_dT = 0.0000001
    "Accuracy of specificEnthalpy_dT"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorTemperature_ph = 0.005
    "Accuracy of temperature_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorPressure_ph = 0.0000001
    "Accuracy of pressure_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorDensity_ph = 0.00006
    "Accuracy of density_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorSpecificEnthalpy_ph = 0.0000001
    "Accuracy of specificEnthalpy_ph"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorTemperature_ps = 0.3
    "Accuracy of temperature_ps"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorPressure_ps = 0.0000001
    "Accuracy of pressure_ps"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorDensity_ps = 0.005
    "Accuracy of density_ps"
    annotation (Dialog(group="Accuraties"));
  parameter Real errorSpecificEnthalpy_ps = 320
    "Accuracy of specificEnthalpy_ps"
    annotation (Dialog(group="Accuraties"));

  // Define the conversion factor for the test
  constant Real convT(unit="K/s") = (343.15-263.15)/80
  "Conversion factor for temperature to satisfy unit check";
  constant Real convP(unit="Pa/s") = (30e5-0.5e5)/(80*80)
  "Conversion factor to pressure satisfy unit check";

  // Define variables that shall be tested
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
  Real delta_T(unit="J/(Pa.kg)")
    "Actual isothermal throttling coefficient";
  Real my(unit="K/Pa")
    "Actual Joule-Thomson coefficient";
  Medium.DynamicViscosity eta
    "Actual dynamic viscosity";
  Medium.ThermalConductivity lambda
    "Actual thermal conductivity";
  Medium.SurfaceTension sigma
    "Acutal surface tension";

  Modelica.SIunits.Temperature errorTemperature_dTmax
    "Error of temperature_dT compared to T";
  Modelica.SIunits.AbsolutePressure errorPressure_dTmax
    "Error of pressure_dT compared to p";
  Modelica.SIunits.Density errorDensity_dTmax
    "Error of density_dT compared to density_pT";
  Modelica.SIunits.SpecificEnthalpy errorSpecificEnthalpy_dTmax
    "Error of specificEnthalpy_dT compared to specificEnthalpy_pT";
  Modelica.SIunits.Temperature errorTemperature_phmax
    "Error of temperature_ph compared to T";
  Modelica.SIunits.AbsolutePressure errorPressure_phmax
    "Error of pressure_ph compared to p";
  Modelica.SIunits.Density errorDensity_phmax
    "Error of density_ph compared to density_pT";
  Modelica.SIunits.SpecificEnthalpy errorSpecificEnthalpy_phmax
    "Error of specificEnthalpy_ph compared to specificEnthalpy_pT";
  Modelica.SIunits.Temperature errorTemperature_psmax
    "Error of temperature_ps compared to T";
  Modelica.SIunits.AbsolutePressure errorPressure_psmax
    "Error of pressure_ps compared to p";
  Modelica.SIunits.Density errorDensity_psmax
    "Error of density_ps compared to density_pT";
  Modelica.SIunits.SpecificEnthalpy errorSpecificEnthalpy_psmax
    "Error of specificEnthalpy_ps compared to specificEnthalpy_pT";

protected
  Modelica.SIunits.Time convTChange(start = 0)
    "Time to reset calculation of actual temperature";
  Modelica.SIunits.Time convTChangee(start = 0)
    "Time to reset calculation of actual temperature";

algorithm
  convTChange := if delay(T,1) >= T_max-1 then time else convTChangee;

equation
  // Change correction factors for temperature and pressure calculation
  convTChangee = convTChange;


  // Change independent thermodynamic state properties acording to time
  T =  T_min + convT * (time - convTChange);
  p =  p_min;

  // Calculate and check furhter thermodynamic state properties
  d = Medium.density(state_pT);
  h = Medium.specificEnthalpy(state_pT);
  s = Medium.specificEntropy(state_pT);
  u = Medium.specificInternalEnergy(state_pT);
  g = Medium.specificGibbsEnergy(state_pT);
  f = Medium.specificHelmholtzEnergy(state_pT);

  // Calculate and check saturation properties
  satT = Medium.setSat_T(T);
  satP = Medium.setSat_p(satT.psat);
  assert(abs(satT.Tsat-satP.Tsat) < 1E-2,
    "Model has an error within saturation properties - Tsat");
  assert(abs(satT.psat-satP.psat) < 1E-2,
    "Model has an error within saturation properties - psat");

  // Calculate and check state functions
  bubbleState = Medium.setBubbleState(satT,1);
  dewState = Medium.setDewState(satT,1);
  state_pT = Medium.setState_pT(p,T);
  state_dT = Medium.setState_dT(d,T);
  state_ph = Medium.setState_ph(p,h);
  state_ps = Medium.setState_ps(p,s);
  assert(abs(Medium.temperature(state_pT)-Medium.temperature(state_dT))
      < errorPressure_dT, "Error in temperature of state_dT");
  assert(abs(Medium.pressure(state_pT)-Medium.pressure(state_dT))
      < errorPressure_dT, "Error in pressure of state_dT");
  assert(abs(Medium.density(state_pT)-Medium.density(state_dT))
      < errorDensity_dT, "Error in density of state_dT");
  assert(abs(Medium.specificEnthalpy(state_pT)-Medium.specificEnthalpy(state_dT))
      < errorSpecificEnthalpy_dT, "Error in specific enthalpy of state_dT");
  assert(abs(Medium.temperature(state_pT)-Medium.temperature(state_ph))
      < errorTemperature_ph, "Error in temperature of state_ph");
  assert(abs(Medium.pressure(state_pT)-Medium.pressure(state_ph))
      < errorPressure_ph, "Error in pressure of state_ph");
  assert(abs(Medium.density(state_pT)-Medium.density(state_ph))
      < errorDensity_ph, "Error in density of state_ph");
  assert(abs(Medium.specificEnthalpy(state_pT)-Medium.specificEnthalpy(state_ph))
      < errorSpecificEnthalpy_ph, "Error in specific enthalpy of state_ph");
  assert(abs(Medium.temperature(state_pT)-Medium.temperature(state_ps))
       < errorTemperature_ps, "Error in temperature of state_ps");
  assert(abs(Medium.pressure(state_pT)-Medium.pressure(state_ps))
       < errorPressure_ps, "Error in pressure of state_ps");
  assert(abs(Medium.density(state_pT)-Medium.density(state_ps))
       < errorDensity_ps, "Error in density of state_ps");
  assert(abs(Medium.specificEnthalpy(state_pT)-Medium.specificEnthalpy(state_ps))
       < errorSpecificEnthalpy_ps, "Error in specific enthalpy of state_ps");


  // Calculate further properties
  cp = Medium.specificHeatCapacityCp(state_pT);
  cv = Medium.specificHeatCapacityCv(state_pT);
  w = Medium.velocityOfSound(state_pT);
  betta = Medium.isobaricExpansionCoefficient(state_pT);
  kappa = Medium.isothermalCompressibility(state_pT);
  delta_T = Medium.isothermalThrottlingCoefficient(state_pT);
  my = Medium.jouleThomsonCoefficient(state_pT);
  eta = Medium.dynamicViscosity(state_pT);
  lambda = Medium.thermalConductivity(state_pT);
  sigma = Medium.surfaceTension(satT);


  // Calculate errors of thermodynamic state properties
  errorTemperature_dTmax = abs(state_dT.T - state_pT.T);
  errorPressure_dTmax = abs(state_dT.p - state_pT.p);
  errorDensity_dTmax = abs(state_dT.d - state_pT.d);
  errorSpecificEnthalpy_dTmax = abs(state_dT.h - state_pT.h);
  errorTemperature_phmax = abs(state_ph.T - state_pT.T);
  errorPressure_phmax = abs(state_ph.p - state_pT.p);
  errorDensity_phmax = abs(state_ph.d - state_pT.d);
  errorSpecificEnthalpy_phmax = abs(state_ph.h - state_pT.h);
  errorTemperature_psmax = abs(state_ps.T - state_pT.T);
  errorPressure_psmax = abs(state_ps.p - state_pT.p);
  errorDensity_psmax = abs(state_ps.d - state_pT.d);
  errorSpecificEnthalpy_psmax = abs(state_ps.h - state_pT.h);

   annotation(experiment(StopTime=6400, Tolerance=1e-006),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Examples/WaterProperties.mos"
        "Simulate and plot"),
      Documentation(info="<html>
<p>This example checks thermophysical properties of the medium. </p>
<p>Es muss angegeben werden (aufz&auml;hlen)</p>
<p>Es wird xy bestimmt (aufz&auml;hlen)</p>
<p>Auf Fehlerberechnung eingehen!</p>
</html>",
revisions="<html>
<ul>
  <li>
  June 13, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantProperties;
