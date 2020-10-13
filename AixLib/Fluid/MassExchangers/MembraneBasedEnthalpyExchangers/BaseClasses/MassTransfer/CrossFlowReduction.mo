within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
model CrossFlowReduction
  "model that calculates reduction factor for mass transfer in quasi-counter flow arrangement"

  // Parameters
  parameter Integer n=1 "number of discrete elements in flow direction";
  parameter Integer nParallel=1 "number of parallel membranes";

  parameter Modelica.SIunits.Length thicknessMem "thickness of membranes";
  parameter Modelica.SIunits.Area[n] surfaceAreas "Heat transfer areas";
  parameter Real aspRatCroToTot "ratio of cross flow of air duct";

  // Constants
  constant Real C_conv = 3.35*10^(-16)
    "conversion factor for permeance to calculate SI-units from Barrer";
  constant Modelica.SIunits.MolarMass M_steam = 0.01802;

  // Variables
  Real[n] k_tots "total mass transfer coefficient";
  Real[n] NTUs "number of heat transfer units";

  // Inputs
  Modelica.Blocks.Interfaces.RealInput perMem(unit="mol/(m.s.Pa)")
    "membrane permeability in Barrer";
  input Real[n] kCons1
    "convective mass transfer coefficients of air flow 1";
  input Real[n] kCons2
    "convective mass transfer coefficients of air flow 2";
  input Modelica.SIunits.MassFlowRate m_flow1 "mass flow rate of air flow 1";
  input Modelica.SIunits.MassFlowRate m_flow2 "mass flow rate of air flow 2";

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput[n] coeCroCous
    "coefficient for heat transfer reduction due to cross-flow portion";

equation

  for i in 1:n loop
    1/k_tots[i] = 1/kCons1[i]+thicknessMem/(perMem*C_conv*M_steam)+1/kCons2[i];
    NTUs[i] = k_tots[i]*(surfaceAreas[i]*nParallel)/min(m_flow1,m_flow2);
    coeCroCous[i] = BaseClasses.Functions.CoefficientCrossToCounterFlow(NTUs[i])*
      aspRatCroToTot + (1 - aspRatCroToTot);
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                     Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            fillColor={0,140,72},
            fillPattern=FillPattern.HorizontalCylinder,
          lineColor={0,0,0}),                            Text(
            extent={{-40,22},{38,-18}},
            textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end CrossFlowReduction;
