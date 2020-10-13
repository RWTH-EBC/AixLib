within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model CrossFlowReduction
  "model that calculates reduction factor for heat transfer in quasi-counter flow arrangement"

  // Parameters
  parameter Integer n=1 "number of discrete elements in flow direction";
  parameter Integer nParallel=1 "number of parallel membranes";

  parameter Modelica.SIunits.Length thicknessMem "thickness of membranes";
  parameter Modelica.SIunits.ThermalConductivity lambdaMem
    "thermal conductivity of membrane";
  parameter Modelica.SIunits.Area[n] surfaceAreas "Heat transfer areas";
  parameter Real aspRatCroToTot "ratio of cross flow of air duct";

  // Variables
  Real[n] h_tots "total heat transfer coefficient";
  Real[n] NTUs "number of heat transfer units";

  // Inputs
  input Modelica.SIunits.HeatCapacity cp1 "heat capacity of air flow 1";
  input Modelica.SIunits.HeatCapacity cp2 "heat capacity of air flow 2";
  input Modelica.SIunits.CoefficientOfHeatTransfer[n] hCons1
    "convective heat transfer coefficients of air flow 1";
  input Modelica.SIunits.CoefficientOfHeatTransfer[n] hCons2
    "convective heat transfer coefficients of air flow 2";
  input Modelica.SIunits.MassFlowRate m_flow1 "mass flow rate of air flow 1";
  input Modelica.SIunits.MassFlowRate m_flow2 "mass flow rate of air flow 2";

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput[n] coeCroCous
    "coefficient for heat transfer reduction due to cross-flow portion";

equation

  for i in 1:n loop
    1/h_tots[i] = 1/hCons1[i] + thicknessMem/lambdaMem + 1/hCons2[i];
    NTUs[i] = h_tots[i]*(surfaceAreas[i]*nParallel)/min(m_flow1*cp1,m_flow2*cp2);
    coeCroCous[i] = BaseClasses.Functions.CoefficientCrossToCounterFlow(NTUs[i])*
      aspRatCroToTot + (1 - aspRatCroToTot);
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                     Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder), Text(
            extent={{-40,22},{38,-18}},
            textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end CrossFlowReduction;
