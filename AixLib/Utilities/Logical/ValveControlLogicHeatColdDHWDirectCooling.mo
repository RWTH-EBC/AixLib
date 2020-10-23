within AixLib.Utilities.Logical;
model ValveControlLogicHeatColdDHWDirectCooling
  "Controls a valve based on cold, heat and dhw input, aswell as network temperature"

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,-20},{-440,20}}),    iconTransformation(
          extent={{-480,-20},{-440,20}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,-80},{-440,-40}}),   iconTransformation(
          extent={{-480,-80},{-440,-40}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,40},{-440,80}}),     iconTransformation(
          extent={{-480,40},{-440,80}})));

  Modelica.Blocks.Interfaces.RealOutput m_flow_valve "M flow of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-240,0}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-422,100})));
  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-340,-60},{-320,-40}})));
  Modelica.Blocks.Math.Division m_flow
    "Computes the mass flow that is necessary to supply the chosen demand at the current Temperature Difference "
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-290,-10})));
  Modelica.Blocks.Math.Add sub_P_HP(k2=-1)
    "The demand series is Q_con of the HP. The network though is connected to the Evaporador, and only extracts Q_eva. The Rest is supplied by the electrical Power of the HP. Therefore, we subtract P_el_HP"
    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-324,4})));
  Modelica.Blocks.Math.Max maxDemand1
    "Takes the Maximum of the Heat and Cold Demand"
    annotation (Placement(transformation(extent={{-380,-20},{-360,0}})));
  Modelica.Blocks.Math.Add heat_load(k2=+1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-410,-30})));
  Modelica.Blocks.Interfaces.RealInput P_el_HP "P_el_HP" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-420,100}), iconTransformation(extent={{-480,40},{-440,80}})));
  Modelica.Blocks.Interfaces.BooleanInput  direct_cooling
    "cold demand can be directly supplied by the network pipe"
                            annotation (Placement(transformation(extent={{-20,-20},
            {20,20}},
        rotation=270,
        origin={-340,100}),
                       iconTransformation(extent={{-254,40},{-214,80}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_Network2
    "dT of Network in heating or cooling mode" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-360,-100}), iconTransformation(extent={{-480,40},{-440,80}})));
equation
  connect(cp_dT.y,m_flow. u2)
    annotation (Line(points={{-319,-50},{-312,-50},{-312,-16},{-302,-16}},
                                                             color={0,0,127}));
  connect(sub_P_HP.y,m_flow. u1)
    annotation (Line(points={{-315.2,4},{-308,4},{-308,-4},{-302,-4}},
                                                     color={0,0,127}));
  connect(dhw_input, heat_load.u1) annotation (Line(points={{-460,-60},{-432,
          -60},{-432,-36},{-422,-36}}, color={0,0,127}));
  connect(heat_input, heat_load.u2) annotation (Line(points={{-460,0},{-436,0},
          {-436,-24},{-422,-24}}, color={0,0,127}));
  connect(heat_load.y, maxDemand1.u2) annotation (Line(points={{-399,-30},{-392,
          -30},{-392,-16},{-382,-16}}, color={0,0,127}));
  connect(P_el_HP, sub_P_HP.u2) annotation (Line(points={{-420,100},{-420,40},{
          -348,40},{-348,8.8},{-333.6,8.8}}, color={0,0,127}));
  connect(maxDemand1.y, sub_P_HP.u1) annotation (Line(points={{-359,-10},{-348,
          -10},{-348,-0.8},{-333.6,-0.8}}, color={0,0,127}));
  connect(deltaT_Network2, cp_dT.u) annotation (Line(points={{-360,-100},{-360,
          -50},{-342,-50}}, color={0,0,127}));
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
end ValveControlLogicHeatColdDHWDirectCooling;
