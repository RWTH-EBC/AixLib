within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses.HeatTransfer;
model ConvectiveHeatTransferCoefficient
  "model that calculates the convective heat transfer coefficient for plane gaps in an air heat exchanger"

  //Inputs
  input Modelica.Units.SI.MassFlowRate m_flow "mass flow rate of air";

  //parameters
  parameter Modelica.Units.SI.Length s "distance between fins";
  parameter Modelica.Units.SI.Length length "length of heat exchanger";
  parameter Modelica.Units.SI.Length width "width of heat exchanger";
  parameter Real nFins "number of parallel plates in heat exchanger";

  //Variables
  Real Pr "Prandtl number";
  Real Re "Reynolds number";
  Real Nu "Nusselt number";
  Modelica.Units.SI.Velocity v "velocity of air";

  //outputs
  output Modelica.Units.SI.CoefficientOfHeatTransfer alpha "convective heat transfer coefficient";

protected
  constant Modelica.Units.SI.Density rho = 1.18 "density of air";
  constant Modelica.Units.SI.DynamicViscosity mu = 17.1E-6  "dynamic viscosity of air";
  constant Modelica.Units.SI.ThermalConductivity lambda = 0.0262 "thermal conductivity of air";
  constant Modelica.Units.SI.SpecificHeatCapacity cp =  1006 "heat capacity of air";

  Modelica.Units.SI.Length diameter "hydraulic diameter";

equation
  Pr = mu*cp/lambda;
  Re = abs(v)*rho*diameter/mu;

  diameter = 2 * s;
  v = m_flow/(nFins * width * s);

  Nu = 7.55 + (0.024*(Re*Pr*diameter/length)^1.14)/(1+0.0358*(Re*Pr*diameter/length)^0.64*Pr^0.17);
  // Nusselt number according to: VDI-Waermeatlas 2013, p.800 eq.45

  Nu = alpha * diameter / lambda;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConvectiveHeatTransferCoefficient;
