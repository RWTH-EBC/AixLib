within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic;
partial function baseEfficiency
  "Base class: efficiency characteristic (eta = f(Q,H,P))"
  extends Modelica.Icons.Function;
  input Real Q "Volume flow in m³/h";
  input Modelica.Units.SI.Height H "Head in m";
  input Modelica.Units.SI.Power P "Power in W";
  input Modelica.Units.SI.Density rho "Density in kg/m³";
  output Real eta "efficiency";
  annotation(preferredView="text");
end baseEfficiency;
