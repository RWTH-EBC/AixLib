within AixLib.Utilities.Logical;
model ValveControlLogicPI "Controls a valve"

  Modelica.Blocks.Interfaces.RealInput cold_input annotation (Placement(
        transformation(extent={{-580,-60},{-540,-20}}),   iconTransformation(
          extent={{-580,-60},{-540,-20}})));
  Modelica.Blocks.Interfaces.RealInput hp_cond "heat flow condensor"
    annotation (Placement(transformation(extent={{-580,20},{-540,60}}),
        iconTransformation(extent={{-580,20},{-540,60}})));

  Modelica.Blocks.Interfaces.RealOutput val_pos "position of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-400,-100}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-360,-100})));
  Modelica.Blocks.Interfaces.RealInput dT_Network "dT Network" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-380,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-480,100})));
  Modelica.Blocks.Interfaces.BooleanInput  direct_cooling
    "cold demand can be directly supplied by the network pipe"
                            annotation (Placement(transformation(extent={{20,-20},
            {-20,20}},
        rotation=270,
        origin={-520,-100}),
                       iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-420,-100})));
  Modelica.Blocks.Interfaces.RealInput return_temp
    "Signal of the Netork Return Temperature"     annotation (Placement(
        transformation(extent={{-220,20},{-260,60}}),     iconTransformation(
          extent={{-220,20},{-260,60}})));
  Modelica.Blocks.Interfaces.RealInput supply_temp
    "Signal of the Network Supply Temperature"    annotation (Placement(
        transformation(extent={{-220,-60},{-260,-20}}),   iconTransformation(
          extent={{-220,-60},{-260,-20}})));
  Modelica.Blocks.Logical.Or            ret_hot1
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-430,50})));
  Modelica.Blocks.Logical.And dc_and_cold1
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-470,50})));
  Modelica.Blocks.Logical.Less hx_bigger_hp
    "the heat added to the network by the heat exchanger is vbigger than the heat taken from the nwtowkr by the condensor"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-510,50})));
  Modelica.Blocks.Interfaces.BooleanInput hp_off annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-460,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-480,-100})));
  Modelica.Blocks.Math.Add heat_ret(k1=-1)
    annotation (Placement(transformation(extent={{-360,60},{-340,40}})));
  Modelica.Blocks.Math.Add cold_ret(k1=+1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-360,0},{-340,20}})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-290,-10})));
  Modelica.Blocks.Sources.RealExpression open(y=1)
    annotation (Placement(transformation(extent={{-450,-56},{-434,-36}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-452,-28},{-434,-10}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-400,-62})));
  SmoothSwitch                   switch1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-310,30})));
equation
  connect(dc_and_cold1.y, ret_hot1.u1)
    annotation (Line(points={{-459,50},{-442,50}}, color={255,0,255}));
  connect(hx_bigger_hp.y, dc_and_cold1.u1)
    annotation (Line(points={{-499,50},{-482,50}}, color={255,0,255}));
  connect(hp_cond, hx_bigger_hp.u1) annotation (Line(points={{-560,40},{-532,40},
          {-532,50},{-522,50}}, color={0,0,127}));
  connect(cold_input, hx_bigger_hp.u2) annotation (Line(points={{-560,-40},{
          -530,-40},{-530,42},{-522,42}}, color={0,0,127}));
  connect(hp_off, ret_hot1.u2) annotation (Line(points={{-460,-100},{-460,14},{
          -450,14},{-450,42},{-442,42}}, color={255,0,255}));
  connect(direct_cooling, dc_and_cold1.u2) annotation (Line(points={{-520,-100},
          {-520,-62},{-490,-62},{-490,42},{-482,42}}, color={255,0,255}));
  connect(mass_flow_heatExchangerHeating1.u3,open. y) annotation (Line(points={{-408,
          -50},{-408.1,-50},{-408.1,-46},{-433.2,-46}},         color={0,0,127}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating1. u2) annotation (Line(
        points={{-433.1,-19},{-400,-19},{-400,-50}},          color={255,0,255}));
  connect(heat_ret.y,switch1. u3) annotation (Line(points={{-339,50},{-330,50},
          {-330,38},{-322,38}}, color={0,0,127}));
  connect(switch1.y,pControl. u_s)
    annotation (Line(points={{-299,30},{-290,30},{-290,2}},  color={0,0,127}));
  connect(mass_flow_heatExchangerHeating1.y, val_pos)
    annotation (Line(points={{-400,-73},{-400,-100}}, color={0,0,127}));
  connect(cold_ret.y, switch1.u1) annotation (Line(points={{-339,10},{-330,10},
          {-330,22},{-322,22}}, color={0,0,127}));
  connect(pControl.y, mass_flow_heatExchangerHeating1.u1) annotation (Line(
        points={{-290,-21},{-290,-32},{-392,-32},{-392,-50}}, color={0,0,127}));
  connect(return_temp, pControl.u_m) annotation (Line(points={{-240,40},{-266,
          40},{-266,-10},{-278,-10}}, color={0,0,127}));
  connect(supply_temp, cold_ret.u1) annotation (Line(points={{-240,-40},{-374,
          -40},{-374,16},{-362,16}}, color={0,0,127}));
  connect(supply_temp, heat_ret.u2) annotation (Line(points={{-240,-40},{-374,
          -40},{-374,56},{-362,56}}, color={0,0,127}));
  connect(dT_Network, heat_ret.u1) annotation (Line(points={{-380,100},{-380,44},
          {-362,44}}, color={0,0,127}));
  connect(dT_Network, cold_ret.u2)
    annotation (Line(points={{-380,100},{-380,4},{-362,4}}, color={0,0,127}));
  connect(ret_hot1.y, switch1.u2) annotation (Line(points={{-419,50},{-402,50},
          {-402,30},{-322,30}}, color={255,0,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-540,
            -80},{-260,80}}),  graphics={Rectangle(
          extent={{-540,80},{-260,-80}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-522,64},{-280,-62}},
          lineColor={0,0,0},
          textString="1PI dT
cond"),                                        Text(
          extent={{-460,120},{-260,80}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-540,-80},{-260,80}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlLogicPI;
