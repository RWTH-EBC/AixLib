within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
model CrossFlowReduction
  "model that calculates reduction factor for mass transfer in quasi-counter flow arrangement"

  // Parameters
  parameter Integer n=1 "number of discrete elements in flow direction";
  parameter Integer nParallel=1 "number of parallel membranes";

  parameter Modelica.Units.SI.Length thicknessMem "thickness of membranes";
  parameter Modelica.Units.SI.Area[n] surfaceAreas "Heat transfer areas";
  parameter Real aspRatCroToTot "ratio of cross flow of air duct";

  // Constants
  constant Real C_conv = 3.35*10^(-16)
    "conversion factor for permeance to calculate SI-units from Barrer";
  constant Modelica.Units.SI.MolarMass M_steam=0.01802;

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
  input Modelica.Units.SI.MassFlowRate m_flow1 "mass flow rate of air flow 1";
  input Modelica.Units.SI.MassFlowRate m_flow2 "mass flow rate of air flow 2";

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
           false)),
    Documentation(info="<html><p>
  This model calculates a reduction factor for a cross-counter-flow
  arrangement. The calculation is based on the Efficiency-NTU-Method.
</p>
<p>
  The number of transfer units <i>NTU</i> is calculated with the total
  mass transfer coeeficient <i>k<sub>tot</sub></i>, the surface area
  <i>A</i> and the minimum mass flow rate <i>ṁ</i>.
</p>
<p style=\"text-align:center;\">
  <i>NTU = (k<sub>tot</sub> A) ⁄ ṁ<sub>min</sub></i>
</p>
<p>
  Using the number of transfer units and the cross-flow portion of the
  whole transfer area the coeefficient for the mass transfer reduction
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
