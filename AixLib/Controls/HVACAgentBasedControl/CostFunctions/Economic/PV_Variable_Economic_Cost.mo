within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic;
model PV_Variable_Economic_Cost
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real p = 0.30 "Price per kWh of fuel";
  parameter Real eta = 0.95 "thermal efficiency of the device";
  parameter Real rad_treshold = 310 "Treshold when electricity is free";

  Modelica.Blocks.Interfaces.RealInput rad "Input for solar radiation" annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={100,-10}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={80,-2})));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                                             lessEqualThreshold(threshold=
        rad_treshold)
    annotation (Placement(transformation(extent={{6,-36},{26,-16}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{66,-16},{54,-4}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period=
        300) annotation (Placement(transformation(extent={{82,-56},{70,-44}})));
  Modelica.Clocked.RealSignals.Sampler.Hold hold1(y_start=100)
    annotation (Placement(transformation(extent={{50,-16},{38,-4}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-32,-62},{-12,-42}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-20,40},{-40,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(p/eta))
    annotation (Placement(transformation(extent={{18,50},{-2,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.0001)
    annotation (Placement(transformation(extent={{40,12},{20,32}})));
  Modelica.Blocks.Interfaces.BooleanOutput electricity_free
    "Indicator if electricity is considered free"                                                         annotation (
      Placement(transformation(extent={{80,42},{100,62}}), iconTransformation(
          extent={{80,42},{100,62}})));
equation

  connect(sample1.u, rad)
    annotation (Line(points={{67.2,-10},{100,-10}}, color={0,0,127}));
  connect(periodicClock1.y, sample1.clock) annotation (Line(
      points={{69.4,-50},{60,-50},{60,-17.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, hold1.u)
    annotation (Line(points={{53.4,-10},{51.2,-10}}, color={0,0,127}));
  connect(hold1.y, lessEqualThreshold.u)
    annotation (Line(points={{37.4,-10},{34,-10},{34,-42},{4,-42},{4,-26}},
                                                   color={0,0,127}));
  connect(capacity, product.u2) annotation (Line(points={{-40,-100},{-40,-100},{
          -40,-58},{-34,-58}}, color={0,0,127}));
  connect(switch1.u2, lessEqualThreshold.y)
    annotation (Line(points={{-18,30},{-18,30},{-16,30},{0,30},{0,-8},{30,
          -8},{30,-26},{27,-26}},                        color={255,0,255}));
  connect(switch1.y, product.u1) annotation (Line(points={{-41,30},{-50,30},{-60,
          30},{-60,-46},{-34,-46}}, color={0,0,127}));
  connect(product.y, cost)
    annotation (Line(points={{-11,-52},{40,-52},{40,-100}}, color={0,0,127}));
  connect(lessEqualThreshold.y, electricity_free) annotation (Line(points={{27,-26},
          {30,-26},{30,-8},{0,-8},{0,52},{90,52}},
                                          color={255,0,255}));
  connect(switch1.u1, realExpression1.y)
    annotation (Line(points={{-18,22},{19,22},{19,22}}, color={0,0,127}));
  connect(switch1.u3, realExpression.y) annotation (Line(points={{-18,38},{-10,38},
          {-10,60},{-3,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
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
          textString="Heating Rod
(with PV)")}),                              Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html><ul>
  <li>December 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>",
    info="<html><p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b>
</p>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model</span>
    calculates the economic cost for PV systems based on the capacity
    and the variable solar radiation input.
  </li>
</ul>
</html>"));
end PV_Variable_Economic_Cost;
