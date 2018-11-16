within AixLib.Fluid.Actuators.Valves;
model ThreeWay_two_characteristics
  "Three way valve with equal percentage and linear characteristics"
    extends AixLib.Fluid.Actuators.BaseClasses.PartialThreeWayValve(
    redeclare TwoWayEqualPercentage
                          res3(R=R, delta0=delta0),
    redeclare TwoWayEqualPercentage
                          res1(R=R, delta0=delta0),
    redeclare FixedResistances.LosslessPipe res2);

parameter Real R = 50 "Rangeability, R=50...100 typically" annotation(Evaluate=false);
  parameter Real delta0 = 0.01
    "Range of significant deviation from equal percentage law" annotation(Evaluate=false);

  Modelica.Blocks.Tables.CombiTable1D realValve12(table=[0,0; 0.1,0.01; 0.2,
        0.01; 0.3,0.05; 0.4,0.1; 0.5,0.3; 0.6,0.5; 0.7,0.7; 0.8,0.9; 0.9,0.99;
        1,1])                                     annotation (Dialog(enable=true,group="Valve parameters"),Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,26})));
  Modelica.Blocks.Tables.CombiTable1D realValve23(table=[0,0; 0.1,0.01; 0.2,
        0.01; 0.3,0.53; 0.4,0.75; 0.5,0.83; 0.6,0.9; 0.7,0.95; 0.8,1; 0.9,1; 1,
        1])                                       annotation (Dialog(enable=true,group="Valve parameters"),Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-50})));
equation
 connect(filter.y,y_filtered)  annotation (Line(
      points={{20.7,88},{50,88}},
      color={0,0,127}));
  connect(y,filter. u) annotation (Line(
      points={{1.11022e-15,120},{1.11022e-15,88},{4.6,88}},
      color={0,0,127}));
  connect(filter.y,y_actual)  annotation (Line(
      points={{20.7,88},{30,88},{30,70},{50,70}},
      color={0,0,127}));
  connect(realValve12.y[1], res1.y)
    annotation (Line(points={{-37,26},{-50,26},{-50,12}}, color={0,0,127}));
  connect(realValve23.y[1], res3.y)
    annotation (Line(points={{39,-50},{12,-50}}, color={0,0,127}));
  connect(y_actual, inv.u2) annotation (Line(points={{50,70},{50,38},{-68,38},{
          -68,41.2}}, color={0,0,127}));
  connect(y_actual, realValve12.u[1])
    annotation (Line(points={{50,70},{50,26},{-14,26}}, color={0,0,127}));
  connect(inv.y, realValve23.u[1]) annotation (Line(points={{-62.6,46},{78,46},
          {78,-50},{62,-50}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(
          points={{0,40},{0,100}}),
        Rectangle(
          visible=use_inputFilter,
          extent={{-32,40},{32,100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{-32,100},{32,40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          visible=use_inputFilter,
          extent={{-20,92},{20,48}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-100,44},{100,-36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,26},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{0,2},{-78,64},{-78,-56},{0,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-68,56},{0,2},{56,44},{76,60},{-68,56}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,-40},{0,2},{56,44},{60,-40},{-56,-40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,2},{82,64},{82,-54},{0,2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-24,-56},{24,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-14,-56},{14,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{0,2},{62,-80},{-58,-80},{0,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,46},{30,46}}),
        Line(
          points={{0,100},{0,-2}}),
        Rectangle(
          visible=use_inputFilter,
          extent={{-36,36},{36,100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{-36,100},{36,36}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          visible=use_inputFilter,
          extent={{-22,92},{20,46}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),   Text(
          extent={{-72,24},{-34,-20}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%")}));
end ThreeWay_two_characteristics;
