within AixLib.Utilities.Logical;
model ValveControlLogic2PITempSimple
  "Controls a valve with 2 PI controllers and just adds all time series"

  Modelica.Blocks.Interfaces.RealInput cold_input annotation (Placement(
        transformation(extent={{-580,40},{-540,80}}),     iconTransformation(
          extent={{-580,40},{-540,80}})));
  Modelica.Blocks.Interfaces.RealInput heat_input "densor" annotation (
      Placement(transformation(extent={{-580,-20},{-540,20}}),
        iconTransformation(extent={{-580,-20},{-540,20}})));

  Modelica.Blocks.Interfaces.RealOutput val_pos "position of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-480,-100}), iconTransformation(
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
  Modelica.Blocks.Sources.RealExpression open(y=1)
    annotation (Placement(transformation(extent={{-520,-50},{-500,-30}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-520,-20},{-500,0}})));
    Modelica.Blocks.Logical.Switch val_pos_delay annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-480,-64})));
  Modelica.Blocks.Interfaces.RealInput return_temp
    "Signal of the Netork Return Temperature"     annotation (Placement(
        transformation(extent={{-220,20},{-260,60}}),     iconTransformation(
          extent={{-220,20},{-260,60}})));
  Modelica.Blocks.Interfaces.RealInput supply_temp
    "Signal of the Network Supply Temperature"    annotation (Placement(
        transformation(extent={{-220,-60},{-260,-20}}),   iconTransformation(
          extent={{-220,-60},{-260,-20}})));
  Modelica.Blocks.Math.Add3 sum_demands(k1=-1)
    "the heat added to the network by the heat exchanger is vbigger than the heat taken from the nwtowkr by the condensor"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-510,50})));
  Modelica.Blocks.Math.Add heat_ret(k1=-1)
    annotation (Placement(transformation(extent={{-300,20},{-320,40}})));
  Modelica.Blocks.Math.Add cold_ret(k1=+1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-300,-20},{-320,0}})));
  Modelica.Blocks.Continuous.LimPID pControl_cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-350,-10})));
  Modelica.Blocks.Logical.Switch pi_switch "return Temp of the Network"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-390,10})));
  Modelica.Blocks.Continuous.LimPID pControl_heat(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-350,30})));
  Modelica.Blocks.Interfaces.RealInput dhw_input annotation (Placement(
        transformation(extent={{-580,-80},{-540,-40}}), iconTransformation(
          extent={{-580,-80},{-540,-40}})));
  Modelica.Blocks.Logical.LessThreshold pipe_hotter(threshold=10)
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-470,50})));
equation
  connect(val_pos_delay.u3, open.y) annotation (Line(points={{-488,-52},{-488,
          -40},{-499,-40}}, color={0,0,127}));
  connect(booleanStep.y, val_pos_delay.u2) annotation (Line(points={{-499,-10},
          {-480,-10},{-480,-52}}, color={255,0,255}));
  connect(val_pos_delay.y, val_pos)
    annotation (Line(points={{-480,-75},{-480,-100}}, color={0,0,127}));
  connect(cold_ret.y, pControl_cold.u_s)
    annotation (Line(points={{-321,-10},{-338,-10}}, color={0,0,127}));
  connect(heat_ret.y, pControl_heat.u_s)
    annotation (Line(points={{-321,30},{-338,30}}, color={0,0,127}));
  connect(pControl_cold.y, pi_switch.u1) annotation (Line(points={{-361,-10},{
          -370,-10},{-370,2},{-378,2}}, color={0,0,127}));
  connect(pControl_heat.y, pi_switch.u3) annotation (Line(points={{-361,30},{
          -366,30},{-366,18},{-378,18}}, color={0,0,127}));
  connect(return_temp, pControl_heat.u_m) annotation (Line(points={{-240,40},{
          -272,40},{-272,8},{-350,8},{-350,18}}, color={0,0,127}));
  connect(return_temp, pControl_cold.u_m) annotation (Line(points={{-240,40},{
          -272,40},{-272,8},{-350,8},{-350,2}},   color={0,0,127}));
  connect(supply_temp, heat_ret.u2) annotation (Line(points={{-240,-40},{-282,
          -40},{-282,24},{-298,24}}, color={0,0,127}));
  connect(supply_temp, cold_ret.u1) annotation (Line(points={{-240,-40},{-282,
          -40},{-282,-4},{-298,-4}},   color={0,0,127}));
  connect(dT_Network, heat_ret.u1) annotation (Line(points={{-380,100},{-380,74},
          {-290,74},{-290,36},{-298,36}},                     color={0,0,127}));
  connect(dT_Network, cold_ret.u2) annotation (Line(points={{-380,100},{-380,74},
          {-290,74},{-290,-16},{-298,-16}},                     color={0,0,127}));
  connect(pi_switch.y, val_pos_delay.u1) annotation (Line(points={{-401,10},{
          -472,10},{-472,-52}}, color={0,0,127}));
  connect(cold_input, sum_demands.u1) annotation (Line(points={{-560,60},{-532,
          60},{-532,58},{-522,58}}, color={0,0,127}));
  connect(heat_input, sum_demands.u2) annotation (Line(points={{-560,0},{-534,0},
          {-534,50},{-522,50}}, color={0,0,127}));
  connect(dhw_input, sum_demands.u3) annotation (Line(points={{-560,-60},{-530,
          -60},{-530,42},{-522,42}}, color={0,0,127}));
  connect(sum_demands.y, pipe_hotter.u)
    annotation (Line(points={{-499,50},{-482,50}}, color={0,0,127}));
  connect(pipe_hotter.y, pi_switch.u2) annotation (Line(points={{-459,50},{-372,
          50},{-372,10},{-378,10}}, color={255,0,255}));
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
          textString="2PI - T
Simple"),                                      Text(
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
end ValveControlLogic2PITempSimple;
