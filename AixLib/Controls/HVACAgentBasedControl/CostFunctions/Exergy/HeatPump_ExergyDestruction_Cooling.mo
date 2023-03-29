within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Exergy;
model HeatPump_ExergyDestruction_Cooling
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";

  parameter Real tablePower[:, :] = fill(0.0, 0, 2)
    "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
  parameter Real tableHeatFlowCondenser[:, :] = fill(0.0, 0, 2)
    "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";

  Real COP "Cooefficient of performance";

  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - (1/COP))
    annotation (Placement(transformation(extent={{-90,-44},{-70,-24}})));
  Modelica.Blocks.Math.Add add1(k2=+1)
    annotation (Placement(transformation(extent={{60,28},{80,48}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{60,-8},{80,12}})));
  Modelica.Blocks.Math.Add add4(k2=-1)
    annotation (Placement(transformation(extent={{-22,-6},{-2,14}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-68,-6},{-48,14}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_0)
    annotation (Placement(transformation(extent={{-96,0},{-76,20}})));
  Modelica.Blocks.Interfaces.RealInput T_cold annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-78,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-28,-80})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-2,22},{18,42}})));
  Modelica.Blocks.Interfaces.RealInput T_hot annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-2,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={22,-80})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{-66,-78},{-46,-58}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=T_0)
    annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{-44,-72},{-24,-52}})));
  Modelica.Blocks.Math.Add add5(k2=-1)
    annotation (Placement(transformation(extent={{-20,-78},{0,-58}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-34,-44},{-14,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=COP)
    annotation (Placement(transformation(extent={{-80,54},{-60,74}})));
  Modelica.Blocks.Math.Division division4
    annotation (Placement(transformation(extent={{-28,60},{-8,80}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-68,22},{-48,42}})));
  Modelica.Blocks.Tables.CombiTable2Ds PowerTable(table=tablePower)
    annotation (Placement(transformation(extent={{54,-62},{74,-42}})));
  Modelica.Blocks.Tables.CombiTable2Ds HeatFlowCondenserTable(table=
        tableHeatFlowCondenser)
    annotation (Placement(transformation(extent={{54,-94},{74,-74}})));
equation

 COP = HeatFlowCondenserTable.y/PowerTable.y;
  connect(add1.y, add2.u1) annotation (Line(
      points={{81,38},{84,38},{84,20},{52,20},{52,8},{58,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division1.u1, realExpression1.y) annotation (Line(
      points={{-70,10},{-75,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division1.u2, T_cold) annotation (Line(
      points={{-70,-2},{-94,-2},{-94,-100},{-78,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add4.u1, realExpression2.y) annotation (Line(
      points={{-24,10},{-25,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division1.y, add4.u2) annotation (Line(
      points={{-47,4},{-34,4},{-34,-2},{-24,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add4.y, product.u2) annotation (Line(
      points={{-1,4},{2,4},{2,20},{-16,20},{-16,26},{-4,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression3.y, division2.u1) annotation (Line(
      points={{-73,-62},{-68,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division2.u2, T_hot) annotation (Line(
      points={{-68,-74},{-74,-74},{-74,-100},{-2,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add5.u2, division2.y) annotation (Line(
      points={{-22,-74},{-45,-74},{-45,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add5.y, product1.u2) annotation (Line(
      points={{1,-68},{8,-68},{8,-52},{-12,-52},{-12,-46},{-2,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression4.y, add5.u1) annotation (Line(
      points={{-23,-62},{-22,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cost, add2.y) annotation (Line(points={{40,-100},{40,-64},{84,
          -64},{84,2},{81,2}}, color={0,0,127}));
  connect(product1.y, add1.u1) annotation (Line(points={{21,-40},{32,-40},
          {32,44},{58,44}}, color={0,0,127}));
  connect(division3.u2, realExpression.y) annotation (Line(points={{-36,-40},{
          -58,-40},{-58,-34},{-69,-34}},                 color={0,0,127}));
  connect(product1.u1, division3.y)
    annotation (Line(points={{-2,-34},{-13,-34}}, color={0,0,127}));
  connect(capacity, division3.u1) annotation (Line(points={{-40,-100},{-40,
          -28},{-36,-28}}, color={0,0,127}));
  connect(realExpression5.y, division4.u2) annotation (Line(points={{-59,
          64},{-59,64},{-30,64}}, color={0,0,127}));
  connect(division4.u1, division3.y) annotation (Line(points={{-30,76},{
          -38,76},{-38,-16},{-8,-16},{-8,-34},{-13,-34}}, color={0,0,127}));
  connect(add2.u2, product.y) annotation (Line(points={{58,-4},{22,-4},{
          22,32},{19,32}}, color={0,0,127}));
  connect(add1.u2, division4.y) annotation (Line(points={{58,32},{30,32},
          {30,70},{-7,70}}, color={0,0,127}));
  connect(add3.u2, division4.y) annotation (Line(points={{-70,26},{-82,26},
          {-82,58},{2,58},{2,70},{-7,70}}, color={0,0,127}));
  connect(add3.u1, division3.u1) annotation (Line(points={{-70,38},{-74,
          38},{-74,38},{-76,38},{-76,44},{-40,44},{-40,-28},{-36,-28}},
        color={0,0,127}));
  connect(add3.y, product.u1) annotation (Line(points={{-47,32},{-38,32},
          {-38,32},{-22,32},{-22,38},{-4,38}}, color={0,0,127}));
  connect(T_hot, HeatFlowCondenserTable.u1) annotation (Line(points={{-2,-100},{
          14,-100},{30,-100},{30,-78},{52,-78}}, color={0,0,127}));
  connect(T_hot, PowerTable.u1) annotation (Line(points={{-2,-100},{30,-100},{30,
          -46},{52,-46}}, color={0,0,127}));
  connect(T_cold, PowerTable.u2) annotation (Line(points={{-78,-100},{-80,-100},
          {-80,-80},{-80,-82},{36,-82},{36,-58},{52,-58}}, color={0,0,127}));
  connect(HeatFlowCondenserTable.u2, T_cold) annotation (Line(points={{52,-90},{
          48,-90},{48,-100},{-78,-100}}, color={0,0,127}));
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
          textString="Heat Pump")}),        Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-98,-22},{26,-88}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,86},{96,-32}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,46},{26,-20}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,96},{26,48}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-106,92},{-58,84}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Work"),
        Text(
          extent={{-100,-10},{-52,-18}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="ExergyIn"),
        Text(
          extent={{40,82},{92,68}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Exergy Destruction
"),     Text(
          extent={{-90,-40},{-60,-52}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="ExergyOut")}),
    Documentation(info="<html><h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span>
</h4>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model determines
    the exergy destruction of a heat pump in cooling mode based on the
    inputs of the component.</span>
  </li>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">It is used together with
    a HeatProducerAgent.</span>
  </li>
</ul>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span>
</h4>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\"><img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/HeatPump.png\"
  alt=\"Heat Pump\"></span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The figure above shows the
  control volume for the heat pump. Based on this volume the following
  function for exergy destruction has been developed. Details can be
  found in the reference.</span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\"><img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/HPcoolingCostfkt.PNG\"
  alt=\"Heat pump cooling cost function\"></span>
</p>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">References</span>
</h4>
<ul>
  <li>Felix Bünning. Development of a Modelica-library for agent-based
  control of HVAC systems. Bachelor thesis, 2016, RWTH Aachen
  University, Aachen, Germany.
  </li>
</ul>
</html>",
    revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
  <li>December 2016, by Roozbeh Sangi:<br/>
    revised
  </li>
</ul>
</html>"));
end HeatPump_ExergyDestruction_Cooling;
