within AixLib.FastHVAC.BaseClass;
model EnergyBalance "Base class depicts energy and mass balances"

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a
    "Enthalpie input port includes the parameter temperature, specific enthalpy, specific heat capacity and mass flow"
    annotation (Placement(transformation(extent={{-100,-20},{-40,38}}),
        iconTransformation(extent={{-100,-20},{-60,20}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b
    "Enthalpie output port includes the parameter temperature, specific enthalpy, specific heat capacity and mass flow"
    annotation (Placement(transformation(extent={{40,-20},{100,40}}),
        iconTransformation(extent={{60,-20},{100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a therm
    "Heat port includes the parameter temperature and heat flow"
                                                               annotation (Placement(
        transformation(extent={{-20,60},{20,100}}), iconTransformation(extent={{
            -20,60},{20,100}})));

equation
  // Mass and energy balances
  enthalpyPort_a.m_flow + enthalpyPort_b.m_flow = 0;
  enthalpyPort_b.T = therm.T;
  enthalpyPort_b.h = enthalpyPort_a.c*therm.T;
  enthalpyPort_b.c = enthalpyPort_a.c;
  therm.Q_flow = -(enthalpyPort_a.h*enthalpyPort_a.m_flow + enthalpyPort_b.h*enthalpyPort_b.m_flow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-44,34},{44,-16}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="energyBalance")}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>Base class EnergyBalance depicts change of condition of the fluid due to heat transfer.</li>
<li>Two enthalpy ports describe the input and output condition of the fluid (temperature, specific enthalpy, specific heat capacity, mass flow).</li>
<li>One thermal port depicts the heat flow, which is transfered on the fluid. </li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Five equations are used to describe the energy and mass balances:</p>
<ul>
<li>mass balance</li>
<li>Thermal port sets new temperature of the fluid </li>
</ul>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>"));
end EnergyBalance;
