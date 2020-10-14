within AixLib.Utilities.Logical;
model HPReversibleControlLogicHeatColdDHWDirectCoolingV2
  "Controls a reversible Heatpump based on cold, heat and dhw input, aswell as network temperature"

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,-40},{-440,0}}),     iconTransformation(
          extent={{-480,-40},{-440,0}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,-80},{-440,-40}}),   iconTransformation(
          extent={{-480,-80},{-440,-40}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,0},{-440,40}}),      iconTransformation(
          extent={{-480,0},{-440,40}})));

  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    "if theres a DHW demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,-70},{-400,-50}})));
  Modelica.Blocks.Logical.Less             pipe_warm
    "If Pipe Temp is above Threshhold, its too high for direct cooling"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-410,60})));

  Modelica.Blocks.Logical.GreaterThreshold c(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,20},{-400,40}})));
  Modelica.Blocks.Logical.Not no_dhw
    annotation (Placement(transformation(extent={{-380,-70},{-360,-50}})));
  Modelica.Blocks.Logical.Not pipe_cold "pipe is below 18°C"
    annotation (Placement(transformation(extent={{-380,50},{-360,70}})));
  Modelica.Blocks.Logical.GreaterThreshold h(threshold=10)
    "if theres a heat demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-420,-40},{-400,-20}})));
  Modelica.Blocks.Logical.Not no_c
    annotation (Placement(transformation(extent={{-380,20},{-360,40}})));
  Modelica.Blocks.Logical.Not no_h
    annotation (Placement(transformation(extent={{-380,-40},{-360,-20}})));
  Modelica.Blocks.Interfaces.RealInput supply_Temp
    "Temperature of the supply Pipe inside the Substation"
                                                  annotation (Placement(
        transformation(extent={{-480,40},{-440,80}}),     iconTransformation(
          extent={{-480,80},{-440,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_cooling_mode
    "hp is in cooling mode" annotation (Placement(transformation(extent={{-260,8},
            {-236,32}}),    iconTransformation(extent={{-254,0},{-214,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput hp_off
    "hp is off -> supply temp set to return temp" annotation (Placement(
        transformation(extent={{-260,-32},{-236,-8}}),iconTransformation(extent={{-254,
            -40},{-214,0}})));
  Modelica.Blocks.Interfaces.BooleanOutput dhw_now "true if dhw demand atm"
    annotation (Placement(transformation(extent={{-260,-72},{-236,-48}}),
        iconTransformation(extent={{-254,-80},{-214,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput direct_cooling
    "cold demand can be directly supplied by the network pipe"
                            annotation (Placement(transformation(extent={{-260,48},
            {-236,72}}),
                       iconTransformation(extent={{-254,40},{-214,80}})));
  Modelica.Blocks.Logical.Greater more_c
    annotation (Placement(transformation(extent={{-420,-10},{-400,10}})));
  TripleAnd nothing
    annotation (Placement(transformation(extent={{-340,-70},{-320,-50}})));
  TripleAnd active_cooling
    "HP goes into cooling mode, when the cold demand is higher than the heat demand, theres no dhw demand and its too warm for direct cooling"
    annotation (Placement(transformation(extent={{-340,30},{-320,50}})));
  TripleAnd only_dc
    annotation (Placement(transformation(extent={{-340,-20},{-320,0}})));
  Modelica.Blocks.Logical.Or hp_off_cases
    annotation (Placement(transformation(extent={{-300,-30},{-280,-10}})));
  Modelica.Blocks.Interfaces.RealInput threshhold
    "Temperature when its too hot for direct cooling. Good Estimate: 18°C"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-410,100}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-422,100})));
equation
  connect(dhw_input, dhw.u)
    annotation (Line(points={{-460,-60},{-422,-60}},   color={0,0,127}));
  connect(cold_input, c.u)
    annotation (Line(points={{-460,20},{-430,20},{-430,30},{-422,30}},
                                                   color={0,0,127}));
  connect(dhw.y, no_dhw.u) annotation (Line(points={{-399,-60},{-382,-60}},
                                color={255,0,255}));
  connect(pipe_warm.y, pipe_cold.u) annotation (Line(points={{-399,60},{-382,60}},
                                         color={255,0,255}));
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
  connect(dhw.y, dhw_now) annotation (Line(points={{-399,-60},{-392,-60},{-392,
          -74},{-268,-74},{-268,-60},{-248,-60}},         color={255,0,255}));
  connect(pipe_cold.y, direct_cooling)
    annotation (Line(points={{-359,60},{-248,60}},  color={255,0,255}));
  connect(no_dhw.y, nothing.u2) annotation (Line(points={{-359,-60},{-354,-60},
          {-354,-68},{-342,-68}}, color={255,0,255}));
  connect(no_c.y, nothing.u3) annotation (Line(points={{-359,30},{-356,30},{
          -356,-52},{-342,-52}}, color={255,0,255}));
  connect(no_h.y, nothing.u1) annotation (Line(points={{-359,-30},{-350,-30},{
          -350,-60},{-342,-60}}, color={255,0,255}));
  connect(no_dhw.y, active_cooling.u2) annotation (Line(points={{-359,-60},{
          -354,-60},{-354,32},{-342,32}}, color={255,0,255}));
  connect(more_c.y, active_cooling.u1) annotation (Line(points={{-399,0},{-352,
          0},{-352,40},{-342,40}}, color={255,0,255}));
  connect(pipe_warm.y, active_cooling.u3) annotation (Line(points={{-399,60},{
          -388,60},{-388,48},{-342,48}},                     color={255,0,255}));
  connect(active_cooling.y, hp_cooling_mode) annotation (Line(points={{-319,40},
          {-268,40},{-268,20},{-248,20}}, color={255,0,255}));
  connect(pipe_cold.y, only_dc.u3) annotation (Line(points={{-359,60},{-346,60},
          {-346,-2},{-342,-2}},   color={255,0,255}));
  connect(nothing.y, hp_off_cases.u2) annotation (Line(points={{-319,-60},{-314,
          -60},{-314,-28},{-302,-28}}, color={255,0,255}));
  connect(only_dc.y, hp_off_cases.u1)
    annotation (Line(points={{-319,-10},{-314,-10},{-314,-20},{-302,-20}},
                                                     color={255,0,255}));
  connect(hp_off_cases.y, hp_off)
    annotation (Line(points={{-279,-20},{-248,-20}}, color={255,0,255}));
  connect(no_h.y, only_dc.u2) annotation (Line(points={{-359,-30},{-350,-30},{
          -350,-18},{-342,-18}}, color={255,0,255}));
  connect(no_dhw.y, only_dc.u1) annotation (Line(points={{-359,-60},{-354,-60},
          {-354,-10},{-342,-10}}, color={255,0,255}));
  connect(threshhold, pipe_warm.u1) annotation (Line(points={{-410,100},{-410,
          76},{-430,76},{-430,60},{-422,60}}, color={0,0,127}));
  connect(supply_Temp, pipe_warm.u2) annotation (Line(points={{-460,60},{-436,
          60},{-436,52},{-422,52}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -80},{-260,80}}),  graphics={Rectangle(
          extent={{-440,80},{-260,-80}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-428,46},{-280,-46}},
          lineColor={0,0,0},
          textString="HP & DC
Control
Cases"),Ellipse(
          extent={{-265,-52},{-279,-66}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-265,-18},{-279,-32}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-267,24},{-281,10}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-269,70},{-283,56}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-415,-54},{-429,-68}},
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
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-415,66},{-429,52}},
          lineColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid),      Text(
          extent={{-394,118},{-268,88}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-80},{-260,80}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end HPReversibleControlLogicHeatColdDHWDirectCoolingV2;
