within AixLib.Utilities.Logical;
model HPReversibleControlLogicHeatColdDHWDirectCooling
  "Controls a reversible Heatpump based on cold, heat and dhw input, aswell as network temperature"

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,-60},{-440,-20}}),   iconTransformation(
          extent={{-480,-60},{-440,-20}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,-140},{-440,-100}}), iconTransformation(
          extent={{-480,-140},{-440,-100}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,20},{-440,60}}),     iconTransformation(
          extent={{-480,20},{-440,60}})));

  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    "if theres a DHW demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,-120},{-400,-100}})));
  Modelica.Blocks.Logical.GreaterThreshold pipe_warm(threshold=273.15 + 18)
    "If Pipe Temp is above Threshhold, its too high for direct cooling"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-410,110})));

  Modelica.Blocks.Logical.GreaterThreshold c(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,60},{-400,80}})));
  Modelica.Blocks.Logical.Not no_dhw
    annotation (Placement(transformation(extent={{-380,-120},{-360,-100}})));
  Modelica.Blocks.Logical.Not pipe_cold "pipe is below 18°C"
    annotation (Placement(transformation(extent={{-378,100},{-358,120}})));
  Modelica.Blocks.Logical.GreaterThreshold h(threshold=10)
    "if theres a heat demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,-80},{-400,-60}})));
  Modelica.Blocks.Logical.Not no_c
    annotation (Placement(transformation(extent={{-380,32},{-360,52}})));
  Modelica.Blocks.Logical.Not no_h
    annotation (Placement(transformation(extent={{-380,-80},{-360,-60}})));
  Modelica.Blocks.Logical.Less more_h
    annotation (Placement(transformation(extent={{-420,20},{-400,40}})));
  Modelica.Blocks.Interfaces.RealInput supply_Temp
    "Temperature of the supply Pipe inside the Substation"
                                                  annotation (Placement(
        transformation(extent={{-480,90},{-440,130}}),    iconTransformation(
          extent={{-480,140},{-440,100}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_cooling_mode
    "hp is in cooling mode" annotation (Placement(transformation(extent={{-60,
            28},{-36,52}}), iconTransformation(extent={{-60,20},{-20,60}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_off
    "hp is off -> supply temp set to return temp" annotation (Placement(
        transformation(extent={{-60,-52},{-36,-28}}), iconTransformation(extent
          ={{-60,-60},{-20,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput dhw_now "true if dhw demand atm"
    annotation (Placement(transformation(extent={{-60,-122},{-36,-98}}),
        iconTransformation(extent={{-60,-140},{-20,-100}})));
  Modelica.Blocks.Logical.Or hp_off_cases
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput direct_cooling
    "cold demand can be directly supplied by the network pipe"
                            annotation (Placement(transformation(extent={{-60,88},
            {-36,112}}),
                       iconTransformation(extent={{-60,100},{-20,140}})));
  Modelica.Blocks.Logical.And Cases1_4_5
    annotation (Placement(transformation(extent={{-320,-102},{-300,-82}})));
  Modelica.Blocks.Logical.And Case1
    annotation (Placement(transformation(extent={{-260,-120},{-240,-100}})));
  Modelica.Blocks.Logical.And Cases4_5
    annotation (Placement(transformation(extent={{-260,-82},{-240,-62}})));
  Modelica.Blocks.Logical.And Case4
    annotation (Placement(transformation(extent={{-200,-100},{-180,-80}})));
  Modelica.Blocks.Logical.And Case5
    annotation (Placement(transformation(extent={{-200,-60},{-180,-40}})));
  Modelica.Blocks.Logical.Or hp_cool_cases
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));
  Modelica.Blocks.Logical.Or dc_cases
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Logical.And Cases3_6to9
    annotation (Placement(transformation(extent={{-320,0},{-300,20}})));
  Modelica.Blocks.Logical.And Cases6to9
    annotation (Placement(transformation(extent={{-260,0},{-240,20}})));
  Modelica.Blocks.Logical.And Cases6_8
    annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
  Modelica.Blocks.Logical.And Cases7_9
    annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  Modelica.Blocks.Logical.Greater more_c
    annotation (Placement(transformation(extent={{-420,-42},{-400,-22}})));
  Modelica.Blocks.Logical.And Case7
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
equation
  connect(dhw_input, dhw.u)
    annotation (Line(points={{-460,-120},{-442,-120},{-442,-110},{-422,-110}},
                                                       color={0,0,127}));
  connect(cold_input, c.u)
    annotation (Line(points={{-460,40},{-430,40},{-430,70},{-422,70}},
                                                   color={0,0,127}));
  connect(dhw.y, no_dhw.u) annotation (Line(points={{-399,-110},{-382,-110}},
                                color={255,0,255}));
  connect(pipe_warm.y, pipe_cold.u) annotation (Line(points={{-399,110},{-380,
          110}},                         color={255,0,255}));
  connect(heat_input, h.u)
    annotation (Line(points={{-460,-40},{-436,-40},{-436,-70},{-422,-70}},
                                                     color={0,0,127}));
  connect(h.y, no_h.u) annotation (Line(points={{-399,-70},{-382,-70}},
                       color={255,0,255}));
  connect(c.y, no_c.u)
    annotation (Line(points={{-399,70},{-388,70},{-388,42},{-382,42}},
                                                   color={255,0,255}));
  connect(pipe_warm.u, supply_Temp)
    annotation (Line(points={{-422,110},{-460,110}},   color={0,0,127}));
  connect(cold_input, more_h.u1) annotation (Line(points={{-460,40},{-430,40},{
          -430,30},{-422,30}},
                          color={0,0,127}));
  connect(heat_input, more_h.u2) annotation (Line(points={{-460,-40},{-436,-40},
          {-436,22},{-422,22}},   color={0,0,127}));
  connect(hp_off_cases.y, hp_off) annotation (Line(points={{-79,-70},{-68,-70},
          {-68,-40},{-48,-40}}, color={255,0,255}));
  connect(no_dhw.y, Cases1_4_5.u2) annotation (Line(points={{-359,-110},{-340,
          -110},{-340,-100},{-322,-100}}, color={255,0,255}));
  connect(no_h.y, Cases1_4_5.u1) annotation (Line(points={{-359,-70},{-348,-70},
          {-348,-92},{-322,-92}}, color={255,0,255}));
  connect(no_c.y, Case1.u1) annotation (Line(points={{-359,42},{-284,42},{-284,
          -110},{-262,-110}}, color={255,0,255}));
  connect(Cases1_4_5.y, Case1.u2) annotation (Line(points={{-299,-92},{-288,-92},
          {-288,-118},{-262,-118}}, color={255,0,255}));
  connect(Case1.y, hp_off_cases.u1) annotation (Line(points={{-239,-110},{-134,
          -110},{-134,-70},{-102,-70}}, color={255,0,255}));
  connect(Cases1_4_5.y, Cases4_5.u2) annotation (Line(points={{-299,-92},{-288,
          -92},{-288,-80},{-262,-80}}, color={255,0,255}));
  connect(c.y, Cases4_5.u1) annotation (Line(points={{-399,70},{-278,70},{-278,
          -72},{-262,-72}}, color={255,0,255}));
  connect(Cases4_5.y, Case5.u2) annotation (Line(points={{-239,-72},{-222,-72},
          {-222,-58},{-202,-58}}, color={255,0,255}));
  connect(Cases4_5.y, Case4.u2) annotation (Line(points={{-239,-72},{-228,-72},
          {-228,-98},{-202,-98}},
                                color={255,0,255}));
  connect(pipe_warm.y, Case5.u1) annotation (Line(points={{-399,110},{-392,110},
          {-392,86},{-224,86},{-224,-50},{-202,-50}},    color={255,0,255}));
  connect(pipe_cold.y, Case4.u1) annotation (Line(points={{-357,110},{-216,110},
          {-216,-90},{-202,-90}},
                                color={255,0,255}));
  connect(hp_cool_cases.y, hp_cooling_mode) annotation (Line(points={{-79,28},{
          -68,28},{-68,40},{-48,40}}, color={255,0,255}));
  connect(Case4.y, dc_cases.u2) annotation (Line(points={{-179,-90},{-128,-90},
          {-128,62},{-102,62}}, color={255,0,255}));
  connect(Case4.y, hp_off_cases.u2) annotation (Line(points={{-179,-90},{-128,
          -90},{-128,-78},{-102,-78}}, color={255,0,255}));
  connect(no_dhw.y, Cases3_6to9.u2) annotation (Line(points={{-359,-110},{-340,
          -110},{-340,2},{-322,2}}, color={255,0,255}));
  connect(h.y, Cases3_6to9.u1) annotation (Line(points={{-399,-70},{-390,-70},{
          -390,10},{-322,10}}, color={255,0,255}));
  connect(Cases3_6to9.y, Cases6to9.u2) annotation (Line(points={{-299,10},{-290,
          10},{-290,2},{-262,2}}, color={255,0,255}));
  connect(c.y, Cases6to9.u1) annotation (Line(points={{-399,70},{-278,70},{-278,
          10},{-262,10}}, color={255,0,255}));
  connect(Cases6to9.y, Cases6_8.u2) annotation (Line(points={{-239,10},{-211.5,
          10},{-211.5,22},{-202,22}}, color={255,0,255}));
  connect(pipe_cold.y, Cases6_8.u1) annotation (Line(points={{-357,110},{-216,
          110},{-216,30},{-202,30}}, color={255,0,255}));
  connect(Cases6_8.y, dc_cases.u1) annotation (Line(points={{-179,30},{-168,30},
          {-168,70},{-102,70}}, color={255,0,255}));
  connect(Cases6to9.y, Cases7_9.u1) annotation (Line(points={{-239,10},{-212,10},
          {-212,-10},{-202,-10}}, color={255,0,255}));
  connect(pipe_warm.y, Cases7_9.u2) annotation (Line(points={{-399,110},{-392,
          110},{-392,86},{-224,86},{-224,-18},{-202,-18}}, color={255,0,255}));
  connect(cold_input, more_c.u1) annotation (Line(points={{-460,40},{-430,40},{
          -430,-32},{-422,-32}}, color={0,0,127}));
  connect(heat_input, more_c.u2)
    annotation (Line(points={{-460,-40},{-422,-40}}, color={0,0,127}));
  connect(Cases7_9.y, Case7.u1)
    annotation (Line(points={{-179,-10},{-162,-10}}, color={255,0,255}));
  connect(more_c.y, Case7.u2) annotation (Line(points={{-399,-32},{-314,-32},{
          -314,-46},{-230,-46},{-230,-32},{-170,-32},{-170,-18},{-162,-18}},
        color={255,0,255}));
  connect(Case5.y, hp_cool_cases.u2) annotation (Line(points={{-179,-50},{-112,
          -50},{-112,20},{-102,20}}, color={255,0,255}));
  connect(Case7.y, hp_cool_cases.u1) annotation (Line(points={{-139,-10},{-118,
          -10},{-118,28},{-102,28}}, color={255,0,255}));
  connect(dhw.y, dhw_now) annotation (Line(points={{-399,-110},{-390,-110},{
          -390,-128},{-120,-128},{-120,-110},{-48,-110}}, color={255,0,255}));
  connect(dc_cases.y, direct_cooling) annotation (Line(points={{-79,70},{-74,70},
          {-74,100},{-48,100}}, color={255,0,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -140},{-60,140}}), graphics={Rectangle(
          extent={{-440,140},{-58,-140}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-420,120},{-80,-120}},
          lineColor={0,0,0},
          textString="HP & DC
Control
Cases"),Ellipse(
          extent={{-71,-112},{-85,-126}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-71,-36},{-85,-50}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-73,42},{-87,28}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-75,124},{-89,110}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-411,-110},{-425,-124}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-411,-32},{-425,-46}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-409,48},{-423,34}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-409,126},{-423,112}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),      Text(
          extent={{-412,188},{-112,148}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-140},{-60,
            140}})),
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
end HPReversibleControlLogicHeatColdDHWDirectCooling;
