within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic;
model Constant_Economic_Cost
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
    Documentation(revisions="<html><ul>
  <li>December 2015, by Felix Bünning: Developed and implemented
  </li>
  <li>July 2017, by Roozbeh Sangi Documentation revised
  </li>
</ul>
</html>",
    info="<html><p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b>
</p>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model calculates
    the economic cost based on the capacity and a constact
    factor.</span>
  </li>
</ul>
</html>"));
end Constant_Economic_Cost;
