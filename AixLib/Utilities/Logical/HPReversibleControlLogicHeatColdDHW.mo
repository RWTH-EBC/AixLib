within AixLib.Utilities.Logical;
model HPReversibleControlLogicHeatColdDHW
  "Controls a reversible Heatpump based on cold and heat"

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,-40},{-440,0}}),     iconTransformation(
          extent={{-480,-40},{-440,0}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,0},{-440,40}}),      iconTransformation(
          extent={{-480,0},{-440,40}})));

  Modelica.Blocks.Logical.GreaterThreshold c(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,20},{-400,40}})));
  Modelica.Blocks.Logical.GreaterThreshold h(threshold=10)
    "if theres a heat demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,-40},{-400,-20}})));
  Modelica.Blocks.Logical.Not no_c
    annotation (Placement(transformation(extent={{-380,20},{-360,40}})));
  Modelica.Blocks.Logical.Not no_h
    annotation (Placement(transformation(extent={{-380,-40},{-360,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_cooling_mode
    "hp is in cooling mode" annotation (Placement(transformation(extent={{-300,8},
            {-276,32}}),    iconTransformation(extent={{-300,2},{-260,42}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_off
    "hp is off -> supply temp set to return temp" annotation (Placement(
        transformation(extent={{-300,-32},{-276,-8}}),iconTransformation(extent={{-300,
            -38},{-260,2}})));
  Modelica.Blocks.Logical.Greater more_c
    annotation (Placement(transformation(extent={{-420,-10},{-400,10}})));
  Modelica.Blocks.Logical.And
            nothing
    annotation (Placement(transformation(extent={{-340,-10},{-320,-30}})));
equation
  connect(cold_input, c.u)
    annotation (Line(points={{-460,20},{-430,20},{-430,30},{-422,30}},
                                                   color={0,0,127}));
  connect(heat_input, h.u)
    annotation (Line(points={{-460,-20},{-436,-20},{-436,-30},{-422,-30}},
                                                     color={0,0,127}));
  connect(h.y, no_h.u) annotation (Line(points={{-399,-30},{-382,-30}},
                       color={255,0,255}));
  connect(c.y, no_c.u)
    annotation (Line(points={{-399,30},{-382,30}}, color={255,0,255}));
  connect(cold_input, more_c.u1) annotation (Line(points={{-460,20},{-430,20},{
          -430,0},{-422,0}},     color={0,0,127}));
  connect(heat_input, more_c.u2)
    annotation (Line(points={{-460,-20},{-436,-20},{-436,-8},{-422,-8}},
                                                     color={0,0,127}));
  connect(no_h.y, nothing.u1) annotation (Line(points={{-359,-30},{-350,-30},{
          -350,-20},{-342,-20}}, color={255,0,255}));
  connect(no_c.y, nothing.u2) annotation (Line(points={{-359,30},{-354,30},{
          -354,-12},{-342,-12}}, color={255,0,255}));
  connect(more_c.y, hp_cooling_mode) annotation (Line(points={{-399,0},{-348,0},
          {-348,20},{-288,20}}, color={255,0,255}));
  connect(nothing.y, hp_off)
    annotation (Line(points={{-319,-20},{-288,-20}}, color={255,0,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -60},{-300,60}}),  graphics={Rectangle(
          extent={{-440,60},{-300,-60}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-410,30},{-344,-28}},
          lineColor={0,0,0},
          textString="HP
Control"),
        Ellipse(
          extent={{-307,-16},{-321,-30}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-311,32},{-325,18}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-415,-14},{-429,-28}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-415,28},{-429,14}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),      Text(
          extent={{-440,100},{-300,60}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-60},{-300,60}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirctional low-temperature networks for
  buildings with heat pump and chiller. In the case of simultaneous
  cooling and heating demands, the return flows are used as supply
  flows for the other application. The mass flows are controlled
  equation-based. The mass flows are calculated using the heating and
  cooling demands and the specified temperature differences between
  flow and return (network side).
</p>
</html>"));
end HPReversibleControlLogicHeatColdDHW;
