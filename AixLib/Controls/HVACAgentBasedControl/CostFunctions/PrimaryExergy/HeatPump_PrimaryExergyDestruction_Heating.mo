within AixLib.Controls.HVACAgentBasedControl.CostFunctions.PrimaryExergy;
model HeatPump_PrimaryExergyDestruction_Heating
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";

  parameter Real tablePower[:, :] = fill(0.0, 0, 2)
    "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
  parameter Real tableHeatFlowCondenser[:, :] = fill(0.0, 0, 2)
    "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
  parameter Real PEF = 1.8 "Primary energy factor of the fuel";

  Real COP "Cooefficient of performance";

  Modelica.Blocks.Sources.RealExpression realExpression(y=COP)
    annotation (Placement(transformation(extent={{-84,56},{-64,76}})));
  Modelica.Blocks.Math.Add add1(k2=+1)
    annotation (Placement(transformation(extent={{60,28},{80,48}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{60,-8},{80,12}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-32,62},{-12,82}})));
  Modelica.Blocks.Math.Add add3(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-84,22},{-64,42}})));
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
        origin={-32,-80})));
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
        origin={16,-80})));
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
  Modelica.Blocks.Tables.CombiTable2Ds HeatFlowCondenserTable(table=
        tableHeatFlowCondenser)
    annotation (Placement(transformation(extent={{54,-96},{74,-76}})));
  Modelica.Blocks.Tables.CombiTable2Ds PowerTable(table=tablePower)
    annotation (Placement(transformation(extent={{54,-64},{74,-44}})));
  Modelica.Blocks.Math.Gain gain(k=PEF)
    annotation (Placement(transformation(extent={{2,62},{22,82}})));
equation
   COP = HeatFlowCondenserTable.y/PowerTable.y;
  connect(add1.y, add2.u1) annotation (Line(
      points={{81,38},{84,38},{84,20},{52,20},{52,8},{58,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.u2, realExpression.y) annotation (Line(
      points={{-34,66},{-63,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.u1, capacity) annotation (Line(
      points={{-34,78},{-40,78},{-40,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add3.u2, capacity) annotation (Line(
      points={{-86,26},{-92,26},{-92,20},{-40,20},{-40,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.y, add3.u1) annotation (Line(
      points={{-11,72},{-8,72},{-8,50},{-92,50},{-92,38},{-86,38}},
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
  connect(add3.y, product.u1) annotation (Line(
      points={{-63,32},{-32,32},{-32,38},{-4,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add4.y, product.u2) annotation (Line(
      points={{-1,4},{2,4},{2,20},{-16,20},{-16,26},{-4,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.u2, product.y) annotation (Line(
      points={{58,32},{19,32}},
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
  connect(product1.u1, capacity) annotation (Line(
      points={{-2,-34},{-40,-34},{-40,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product1.y, add2.u2) annotation (Line(
      points={{21,-40},{44,-40},{44,-4},{58,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression4.y, add5.u1) annotation (Line(
      points={{-23,-62},{-22,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add2.y, cost) annotation (Line(points={{81,2},{88,2},{88,-86},{40,-86},
          {40,-100}},                                     color={0,0,127}));
  connect(T_hot,HeatFlowCondenserTable. u1) annotation (Line(points={{-2,-100},{
          -2,-100},{30,-100},{30,-80},{52,-80}}, color={0,0,127}));
  connect(T_cold,PowerTable. u2) annotation (Line(points={{-78,-100},{-80,-100},
          {-80,-82},{-80,-84},{36,-84},{36,-60},{52,-60}}, color={0,0,127}));
  connect(T_hot,PowerTable. u1) annotation (Line(points={{-2,-100},{30,-100},{30,
          -48},{52,-48}}, color={0,0,127}));
  connect(HeatFlowCondenserTable.u2, T_cold) annotation (Line(points={{52,-92},{
          48,-92},{48,-100},{-78,-100}}, color={0,0,127}));
  connect(gain.u, division.y)
    annotation (Line(points={{0,72},{-11,72}}, color={0,0,127}));
  connect(gain.y, add1.u1) annotation (Line(points={{23,72},{40,72},{40,44},{58,
          44}}, color={0,0,127}));
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
          extent={{34,96},{96,-32}},
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
          extent={{-92,60},{-44,52}},
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
          extent={{42,90},{92,76}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Exergy Destruction
"),     Text(
          extent={{-98,-32},{-50,-40}},
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
    <span style=\"font-family: MS Shell Dlg 2;\">Identical to the cost
    function in the Exergy package, except a primary energy factor is
    included.</span>
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
end HeatPump_PrimaryExergyDestruction_Heating;
