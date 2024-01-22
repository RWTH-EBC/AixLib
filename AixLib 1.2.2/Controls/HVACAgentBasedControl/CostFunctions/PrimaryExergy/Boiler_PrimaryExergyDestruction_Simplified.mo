within AixLib.Controls.HVACAgentBasedControl.CostFunctions.PrimaryExergy;
model Boiler_PrimaryExergyDestruction_Simplified
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";
  parameter Real eta = 0.84 "Overall efficiency of the boiler";
  parameter Real PEF = 1.1 "Primary energy factor of the fuel";

  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-26,56},{-6,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=eta)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-66,-22},{-46,-2}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_0)
    annotation (Placement(transformation(extent={{-96,-2},{-76,18}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-32,-4},{-12,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=1)
    annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{4,-10},{24,10}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{60,28},{80,48}})));
  Modelica.Blocks.Math.Gain gain(k=PEF*0.9257)
    annotation (Placement(transformation(extent={{2,56},{22,76}})));
  Modelica.Blocks.Interfaces.RealInput T_circuit annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-30}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-26})));
  Modelica.Blocks.Math.Max min
    annotation (Placement(transformation(extent={{-84,-32},{-74,-22}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=274.15)
    annotation (Placement(transformation(extent={{-96,-22},{-76,-2}})));
equation
  connect(division.u2, realExpression.y) annotation (Line(
      points={{-28,60},{-59,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division1.u1, realExpression1.y) annotation (Line(
      points={{-68,-6},{-72,-6},{-72,8},{-75,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division1.y, add.u2) annotation (Line(
      points={{-45,-12},{-42,-12},{-42,0},{-34,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u1, realExpression3.y) annotation (Line(
      points={{-34,12},{-45,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, product.u1) annotation (Line(
      points={{-11,6},{2,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(capacity, product.u2) annotation (Line(
      points={{-40,-100},{-40,-34},{-10,-34},{-10,-6},{2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.u1, product.u2) annotation (Line(
      points={{-28,72},{-38,72},{-38,36},{-8,36},{-8,-6},{2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, add1.u2) annotation (Line(
      points={{25,0},{34,0},{34,32},{58,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, cost) annotation (Line(
      points={{81,38},{86,38},{86,-68},{40,-68},{40,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.y, gain.u)
    annotation (Line(points={{-5,66},{0,66}}, color={0,0,127}));
  connect(gain.y, add1.u1) annotation (Line(points={{23,66},{46,66},{46,44},{58,
          44}}, color={0,0,127}));
  connect(min.y, division1.u2) annotation (Line(points={{-73.5,-27},{-68,
          -27},{-68,-18}}, color={0,0,127}));
  connect(min.u1, realExpression2.y) annotation (Line(points={{-85,-24},{
          -90,-24},{-90,-18},{-75,-18},{-75,-12}}, color={0,0,127}));
  connect(min.u2, T_circuit) annotation (Line(points={{-85,-30},{-120,-30}},
                                 color={0,0,127}));
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
          extent={{-58,94},{62,42}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Boiler")}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{36,86},{96,-50}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,28},{26,-50}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,86},{26,34}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-92,48},{-44,40}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Exergy Fuel"),
        Text(
          extent={{-92,-34},{-44,-42}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Exergy Product"),
        Text(
          extent={{40,80},{92,64}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Exergy Destruction
")}),
    Documentation(revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
  <li>December 2016, by Roozbeh Sangi:<br/>
    revised
  </li>
</ul>
</html>",
    info="<html><h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span>
</h4>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">Identical to the cost
    function in the Exergy package, except a primary energy factor is
    included.</span>
  </li>
</ul>
</html>"));
end Boiler_PrimaryExergyDestruction_Simplified;
