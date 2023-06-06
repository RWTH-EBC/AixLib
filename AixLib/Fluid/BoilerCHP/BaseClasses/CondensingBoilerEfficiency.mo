within AixLib.Fluid.BoilerCHP.BaseClasses;
model CondensingBoilerEfficiency
  "Model for temperature depending efficiency of a condensing boiler"
  parameter Real lambda=0.01 "Offset variable of weighting coefficients sigmas";

  parameter Modelica.Units.SI.Temperature T_nom=343.15 "Nominal temperature";
  parameter Modelica.Units.SI.Temperature T_part=308.15
    "Intermediate temperature";
  parameter Modelica.Units.SI.Efficiency eta_nom=1
    "Nominal net heating value efficiency";
  parameter Modelica.Units.SI.Efficiency eta_int=1
    "Intermediate net heating value efficiency";
  parameter Real eta_max=1.11
    "Ratio gross (high) heating value / net (low) heating value defined according to the fuel";

  parameter Real ak=-0.0002 "Sensible temperature depending efficiency decrease per K";
  Real etaSens;
  Real etaCond;
  Real sigmaSens;
  Real sigmaCond;
  Real etaRP;
  Modelica.Units.SI.Temperature Tc(
    start=360,
    max=380,
    min=323,
    nominal=360)
    "Temperature of Sensitive and Latent characteristic intersection";
  //start value is important: equation below has two solutions

  Modelica.Blocks.Interfaces.RealInput T_in(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Ambient air temperature" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}),iconTransformation(extent={{-120,
            -10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput eta "Value of Real output" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-10},{120,10}})));
algorithm
  //The boiler is launched for partLoadRate (boilerBus.PLR) > PLR_min, if partLoadRate < PLR_min there is no combustion and the efficiency etaRP is zero
  //Determination of the efficiency for the law without condensation
  etaSens := eta_nom + ak*(T_in - T_nom);
  //Determination of the efficiency for the law characterizing the condensation
  etaCond := eta_int + (eta_max - eta_int)*(1 - AixLib.Utilities.Psychrometrics.Functions.saturationPressure(T_in)/AixLib.Utilities.Psychrometrics.Functions.saturationPressure(T_part)*T_part/T_in);
  sigmaCond := 1/(1 + exp(T_in - Tc - lambda));
  sigmaSens := 1 - 1/(1 + exp(T_in - Tc + lambda));
  etaRP := sigmaSens*etaSens + sigmaCond*etaCond;


equation
  //Calculation of Tc
  eta_nom + ak*(Tc - T_nom) = eta_int + (eta_max - eta_int)*(1 - AixLib.Utilities.Psychrometrics.Functions.saturationPressure(Tc)/AixLib.Utilities.Psychrometrics.Functions.saturationPressure(T_part)*
    T_part/Tc);

  eta = etaRP;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the efficiency of a condensing boiler and is
  based upon the literature <i><a href=
  \"https://core.ac.uk/download/pdf/46816799.pdf\">Règles de modélisation
  des systèmes énergétiques dans les bâtiments basse
  consommation</a></i>
</p>
<p>
  The efficiency depends on the inflow temperature of the boiler
  (T_in).
</p>
<ul>
  <li>
    <i>September 19, 2019&#160;</i> by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end CondensingBoilerEfficiency;
