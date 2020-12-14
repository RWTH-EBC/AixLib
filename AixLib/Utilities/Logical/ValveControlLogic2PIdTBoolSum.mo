within AixLib.Utilities.Logical;
model ValveControlLogic2PIdTBoolSum "Controls a valve with 2 PI controllers"

  Modelica.Blocks.Interfaces.RealOutput val_pos "position of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-420,-100}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-360,-100})));
  Modelica.Blocks.Interfaces.RealInput dT_Network "dT Network" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-320,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-480,100})));
  Modelica.Blocks.Sources.RealExpression open(y=1)
    annotation (Placement(transformation(extent={{-460,-50},{-440,-30}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-460,-20},{-440,0}})));
    Modelica.Blocks.Logical.Switch valve_pos annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-420,-64})));
  Modelica.Blocks.Interfaces.RealInput return_temp
    "Signal of the Netork Return Temperature"     annotation (Placement(
        transformation(extent={{-220,20},{-260,60}}),     iconTransformation(
          extent={{-220,20},{-260,60}})));
  Modelica.Blocks.Interfaces.RealInput supply_temp
    "Signal of the Network Supply Temperature"    annotation (Placement(
        transformation(extent={{-220,-60},{-260,-20}}),   iconTransformation(
          extent={{-220,-60},{-260,-20}})));
  Modelica.Blocks.Math.Add dT_curr(k1=+1, k2=-1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-280,-10},{-300,10}})));
  Modelica.Blocks.Continuous.LimPID pControl_cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.02,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.02,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-350,-50})));
  Modelica.Blocks.Logical.Switch pi_switch "return Temp of the Network"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-390,0})));
  Modelica.Blocks.Continuous.LimPID pControl_heat(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.02,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-350,30})));
  Modelica.Blocks.Logical.Or pipe_hotter
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-430,50})));
  Modelica.Blocks.Logical.And dc_now
    "heat flow from direct cooling is bigger than from the heatpump in heating mode"
                                                 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-470,30})));
  Modelica.Blocks.Interfaces.BooleanInput hp_cooling annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-560,60}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-560,58})));
  Modelica.Blocks.Interfaces.BooleanInput dc_mode annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-490,-100}),iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={-480,-100})));
  Modelica.Blocks.Math.Gain neg1(k=-1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-320,58})));
  Modelica.Blocks.Math.Gain neg2(k=-1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-350,-20})));
  Modelica.Blocks.Logical.Less hx_bigger_hp
    "the heat added to the network by the heat exchanger is vbigger than the heat taken from the nwtowkr by the condensor"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-510,30})));
  Modelica.Blocks.Interfaces.RealInput cold_input annotation (Placement(
        transformation(extent={{-580,-80},{-540,-40}}),   iconTransformation(
          extent={{-580,-80},{-540,-40}})));
  Modelica.Blocks.Interfaces.RealInput hp_cond "heat flow condensor"
    annotation (Placement(transformation(extent={{-580,-20},{-540,20}}),
        iconTransformation(extent={{-580,-20},{-540,20}})));
equation
  connect(valve_pos.u3, open.y) annotation (Line(points={{-428,-52},{-428,-40},
          {-439,-40}}, color={0,0,127}));
  connect(booleanStep.y, valve_pos.u2) annotation (Line(points={{-439,-10},{
          -420,-10},{-420,-52}}, color={255,0,255}));
  connect(valve_pos.y, val_pos)
    annotation (Line(points={{-420,-75},{-420,-100}}, color={0,0,127}));
  connect(pControl_cold.y, pi_switch.u1) annotation (Line(points={{-361,-50},{
          -370,-50},{-370,-8},{-378,-8}},
                                        color={0,0,127}));
  connect(pControl_heat.y, pi_switch.u3) annotation (Line(points={{-361,30},{
          -370,30},{-370,8},{-378,8}},   color={0,0,127}));
  connect(pi_switch.y, valve_pos.u1)
    annotation (Line(points={{-401,0},{-412,0},{-412,-52}}, color={0,0,127}));
  connect(return_temp, dT_curr.u1) annotation (Line(points={{-240,40},{-268,40},
          {-268,6},{-278,6}}, color={0,0,127}));
  connect(supply_temp, dT_curr.u2) annotation (Line(points={{-240,-40},{-268,
          -40},{-268,-6},{-278,-6}}, color={0,0,127}));
  connect(hp_cooling, pipe_hotter.u1) annotation (Line(points={{-560,60},{-486,
          60},{-486,50},{-442,50}}, color={255,0,255}));
  connect(dc_mode, dc_now.u2) annotation (Line(points={{-490,-100},{-490,22},{
          -482,22}},           color={255,0,255}));
  connect(dc_now.y, pipe_hotter.u2) annotation (Line(points={{-459,30},{-452,30},
          {-452,42},{-442,42}}, color={255,0,255}));
  connect(pipe_hotter.y, pi_switch.u2) annotation (Line(points={{-419,50},{-366,
          50},{-366,0},{-378,0}}, color={255,0,255}));
  connect(dT_curr.y, pControl_heat.u_m)
    annotation (Line(points={{-301,0},{-350,0},{-350,18}}, color={0,0,127}));
  connect(neg1.y, pControl_cold.u_s) annotation (Line(points={{-320,47},{-320,
          -50},{-338,-50}}, color={0,0,127}));
  connect(neg1.u, dT_Network)
    annotation (Line(points={{-320,70},{-320,100}}, color={0,0,127}));
  connect(pControl_cold.u_m, neg2.y)
    annotation (Line(points={{-350,-38},{-350,-31}}, color={0,0,127}));
  connect(neg2.u, dT_curr.y)
    annotation (Line(points={{-350,-8},{-350,0},{-301,0}}, color={0,0,127}));
  connect(neg1.y, pControl_heat.u_s)
    annotation (Line(points={{-320,47},{-320,30},{-338,30}}, color={0,0,127}));
  connect(hp_cond, hx_bigger_hp.u1) annotation (Line(points={{-560,0},{-536,0},
          {-536,30},{-522,30}}, color={0,0,127}));
  connect(cold_input,hx_bigger_hp. u2) annotation (Line(points={{-560,-60},{
          -528,-60},{-528,22},{-522,22}}, color={0,0,127}));
  connect(hx_bigger_hp.y, dc_now.u1)
    annotation (Line(points={{-499,30},{-482,30}}, color={255,0,255}));
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
          textString="2PI - dT
Bool"),                                        Text(
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
end ValveControlLogic2PIdTBoolSum;
