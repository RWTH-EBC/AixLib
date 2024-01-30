within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model CrossFlowReduction
  "model that calculates reduction factor for heat transfer in quasi-counter flow arrangement"

  // Parameters
  parameter Integer n=1 "number of discrete elements in flow direction";
  parameter Integer nParallel=1 "number of parallel membranes";

  parameter Modelica.Units.SI.Length thicknessMem "thickness of membranes";
  parameter Modelica.Units.SI.ThermalConductivity lambdaMem
    "thermal conductivity of membrane";
  parameter Modelica.Units.SI.Area[n] surfaceAreas "Heat transfer areas";
  parameter Real aspRatCroToTot "cross flow portion of transfer area";

  // Variables
  Real[n] h_tots "total heat transfer coefficient";
  Real[n] NTUs "number of heat transfer units";

  // Inputs
  input Modelica.Units.SI.HeatCapacity cp1 "heat capacity of air flow 1";
  input Modelica.Units.SI.HeatCapacity cp2 "heat capacity of air flow 2";
  input Modelica.Units.SI.CoefficientOfHeatTransfer[n] hCons1
    "convective heat transfer coefficients of air flow 1";
  input Modelica.Units.SI.CoefficientOfHeatTransfer[n] hCons2
    "convective heat transfer coefficients of air flow 2";
  input Modelica.Units.SI.MassFlowRate m_flow1 "mass flow rate of air flow 1";
  input Modelica.Units.SI.MassFlowRate m_flow2 "mass flow rate of air flow 2";

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
           false)),
    Documentation(info="<html><p>
  This model calculates a reduction factor for a cross-counter-flow
  arrangement. The calculation is based on the Efficiency-NTU-Method.
</p>
<p>
  The number of transfer units <i>NTU</i> is calculated with the total
  heat transfer coeeficient <i>h<sub>tot</sub></i>, the surface area
  <i>A</i> and the minimum heat capacity flow consiting of the mass
  flow rate <i>ṁ</i> and the specific heat capacitiy
  <i>c<sub>p</sub></i>.
</p>
<p style=\"text-align:center;\">
  <i>NTU = (h<sub>tot</sub> A) ⁄ (ṁ c<sub>p</sub>)<sub>min</sub></i>
</p>
<p>
  Using the number of transfer units and the cross-flow portion of the
  whole transfer area the coeefficient for the heat transfer reduction
  is calculated.
</p>
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end CrossFlowReduction;
