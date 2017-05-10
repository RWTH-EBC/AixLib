within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic;
model ConstantFactor
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real p = 0.30 "Price per kWh of fuel";
  parameter Real eta = 0.95 "thermal efficiency of the device";

equation
  cost = (p/eta) * capacity;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={129,162,193},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,48},{46,-78}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="$"),
        Text(
          extent={{-64,94},{56,42}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Constant")}),         Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<p>
<ul>
<li>December 2015, by Felix Bünning: Developed and implemented</li>
</ul>
</p>
</html>",
    info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">This model determines the exergy destruction of a heating rod based on the inputs of the component.</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">It is used together with a HeatProducerAgent.</span></li>
</ul>
<p><br><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Instead of a calculation with the help of inflowing and outflowing enthaplies, this cost function calculates the exergy product based on a heat flux. The estimation of the average temperature of the heat flux causes a small uncertainty compared to the other approach. However, this cost function leads to a more stable and reliable simulation. Details can be found in the reference.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">References</span></b></p>
<ul>
<li>Roozbeh Sangi, Felix B&uuml;nning, Marc Baranski, Johannes F&uuml;tterer, Dirk M&uuml;ller. A Platform for the Agent-based Control of HVAC Systems. Modelica Conference, 2017, Prague, Czech Republic. </li>
</ul>
</html>"));
end ConstantFactor;
