within AixLib.Utilities.Logical;
model ValveControlLogic2PIdTSimple
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
    annotation (Placement(transformation(extent={{-514,-54},{-494,-34}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-514,-28},{-494,-8}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
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
  Modelica.Blocks.Math.Add dT_curr(k1=+1, k2=-1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-280,0},{-300,20}})));
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
        origin={-410,-10})));
  Modelica.Blocks.Logical.Switch pi_switch "return Temp of the Network"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-450,10})));
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
        origin={-410,30})));
  Modelica.Blocks.Interfaces.RealInput dhw_input annotation (Placement(
        transformation(extent={{-580,-80},{-540,-40}}), iconTransformation(
          extent={{-580,-80},{-540,-40}})));
  Modelica.Blocks.Logical.LessThreshold bigger0(threshold=10)
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-470,50})));
  Modelica.Blocks.Math.Gain neg(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-380,52})));
equation
  connect(mass_flow_heatExchangerHeating1.u3,open. y) annotation (Line(points={{-488,
          -52},{-488,-44},{-493,-44}},                          color={0,0,127}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating1. u2) annotation (Line(
        points={{-493,-18},{-480,-18},{-480,-52}},            color={255,0,255}));
  connect(mass_flow_heatExchangerHeating1.y, val_pos)
    annotation (Line(points={{-480,-75},{-480,-100}}, color={0,0,127}));
  connect(pControl_cold.y, pi_switch.u1) annotation (Line(points={{-421,-10},{
          -432,-10},{-432,2},{-438,2}}, color={0,0,127}));
  connect(pControl_heat.y, pi_switch.u3) annotation (Line(points={{-421,30},{
          -432,30},{-432,18},{-438,18}}, color={0,0,127}));
  connect(pi_switch.y, mass_flow_heatExchangerHeating1.u1) annotation (Line(
        points={{-461,10},{-472,10},{-472,-52}}, color={0,0,127}));
  connect(cold_input, sum_demands.u1) annotation (Line(points={{-560,60},{-532,
          60},{-532,58},{-522,58}}, color={0,0,127}));
  connect(heat_input, sum_demands.u2) annotation (Line(points={{-560,0},{-534,0},
          {-534,50},{-522,50}}, color={0,0,127}));
  connect(dhw_input, sum_demands.u3) annotation (Line(points={{-560,-60},{-530,
          -60},{-530,42},{-522,42}}, color={0,0,127}));
  connect(sum_demands.y, bigger0.u)
    annotation (Line(points={{-499,50},{-482,50}}, color={0,0,127}));
  connect(bigger0.y, pi_switch.u2) annotation (Line(points={{-459,50},{-430,50},
          {-430,10},{-438,10}}, color={255,0,255}));
  connect(pControl_heat.u_m, dT_curr.y)
    annotation (Line(points={{-410,18},{-410,10},{-301,10}}, color={0,0,127}));
  connect(pControl_cold.u_m, dT_curr.y)
    annotation (Line(points={{-410,2},{-410,10},{-301,10}}, color={0,0,127}));
  connect(return_temp, dT_curr.u1) annotation (Line(points={{-240,40},{-268,40},
          {-268,16},{-278,16}}, color={0,0,127}));
  connect(supply_temp, dT_curr.u2) annotation (Line(points={{-240,-40},{-268,
          -40},{-268,4},{-278,4}}, color={0,0,127}));
  connect(dT_Network, neg.u)
    annotation (Line(points={{-380,100},{-380,64}}, color={0,0,127}));
  connect(neg.y, pControl_heat.u_s)
    annotation (Line(points={{-380,41},{-380,30},{-398,30}}, color={0,0,127}));
  connect(dT_Network, pControl_cold.u_s) annotation (Line(points={{-380,100},{
          -380,74},{-356,74},{-356,-10},{-398,-10}}, color={0,0,127}));
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
end ValveControlLogic2PIdTSimple;
