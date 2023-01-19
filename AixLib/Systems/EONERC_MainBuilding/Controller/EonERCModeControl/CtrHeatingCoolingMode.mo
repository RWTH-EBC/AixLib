within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model CtrHeatingCoolingMode "Determination of heating or cooling mode"
  Modelica.StateGraph.TransitionWithSignal transitionCoolingMode(enableTimer=
        true, waitTime=1800)
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  Modelica.StateGraph.TransitionWithSignal transitionHeatingMode(enableTimer=
        true, waitTime=1800)
    annotation (Placement(transformation(extent={{78,40},{98,60}})));
  Modelica.StateGraph.StepWithSignal stepCoolingActive(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{48,40},{68,60}})));
  Modelica.StateGraph.InitialStepWithSignal stepHeatingActive(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Continuous.Derivative derivativeHS
    annotation (Placement(transformation(extent={{-60,-20},{-48,-8}})));
  Modelica.Blocks.Continuous.Integrator integratorHS(use_reset=true)
    annotation (Placement(transformation(extent={{0,-6},{12,-18}})));
  Modelica.StateGraph.Transition tran
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.StateGraph.StepWithSignal stepCooling(nIn=1, nOut=1)
                                                 "To reset integrator"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.StateGraph.Transition tran1
    annotation (Placement(transformation(extent={{26,40},{46,60}})));
  Modelica.StateGraph.StepWithSignal stepHeating(nOut=1, nIn=1)
                                                 "To reset integrator"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Math.Sum sumHS(nin=2, k={0.5,0.5})
    annotation (Placement(transformation(extent={{-94,-20},{-82,-8}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={30,2})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{24,-18},{36,-6}})));
  Modelica.Blocks.Continuous.Derivative derivativeCS
    annotation (Placement(transformation(extent={{-60,-40},{-48,-28}})));
  Modelica.Blocks.Continuous.Integrator integratorCS(use_reset=true)
    annotation (Placement(transformation(extent={{0,-28},{12,-40}})));
  Modelica.Blocks.Math.Sum sumCS(nin=2, k={0.5,0.5})
    annotation (Placement(transformation(extent={{-94,-40},{-82,-28}})));
  Modelica.Blocks.Math.Abs absHS
    annotation (Placement(transformation(extent={{-40,-20},{-28,-8}})));
  Modelica.Blocks.Math.Abs absCS
    annotation (Placement(transformation(extent={{-40,-40},{-28,-28}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={8,28})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-14,-14},{-6,-6}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-16,-36},{-8,-28}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-12,-24},{-18,-18}})));
  Modelica.Blocks.Interfaces.BooleanInput hp_on
    "Connector of Boolean input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.BooleanOutput heatingActive annotation (Placement(
        transformation(extent={{100,10},{120,30}}), iconTransformation(extent={
            {100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput coolingActive annotation (Placement(
        transformation(extent={{100,-30},{120,-10}}), iconTransformation(extent=
           {{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput T_HS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,0},{-100,40}}),  iconTransformation(extent={{-140,40},{
            -100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_CS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-140,-80},
            {-100,-40}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=10, period=3600)
    annotation (Placement(transformation(extent={{-14,8},{-4,18}})));
  Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={2,10})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=18 +
        273.15)
    annotation (Placement(transformation(extent={{-78,0},{-66,12}})));
  Modelica.Blocks.Math.Gain gain(k=4000)
    annotation (Placement(transformation(extent={{-76,-18},{-68,-10}})));
  Modelica.Blocks.Math.Gain gain1(k=5000)
    annotation (Placement(transformation(extent={{-76,-38},{-68,-30}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=273.15 + 25)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={88,-38})));
  Modelica.Blocks.Logical.Or or3 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-26,10})));
  Modelica.Blocks.Logical.Or or4 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={84,2})));
equation
  connect(integratorHS.y,greater. u1)
    annotation (Line(points={{12.6,-12},{22.8,-12}},   color={0,0,127}));
  connect(integratorCS.y,greater. u2) annotation (Line(points={{12.6,-34},{22.8,
          -34},{22.8,-16.8}},  color={0,0,127}));
  connect(derivativeCS.y,absCS. u)
    annotation (Line(points={{-47.4,-34},{-41.2,-34}}, color={0,0,127}));
  connect(derivativeHS.y,absHS. u)
    annotation (Line(points={{-47.4,-14},{-41.2,-14}}, color={0,0,127}));
  connect(or1.u1,stepCooling. active) annotation (Line(points={{8,32.8},{8,34},
          {10,34},{10,39}},
                     color={255,0,255}));
  connect(stepHeating.active, or1.u2) annotation (Line(points={{-90,39},{-90,
          32.8},{4.8,32.8}}, color={255,0,255}));
  connect(absHS.y, switch2.u3) annotation (Line(points={{-27.4,-14},{-24,-14},{
          -24,-13.2},{-14.8,-13.2}}, color={0,0,127}));
  connect(switch2.y, integratorHS.u) annotation (Line(points={{-5.6,-10},{-4,
          -10},{-4,-12},{-1.2,-12}}, color={0,0,127}));
  connect(switch3.u2, switch2.u2) annotation (Line(points={{-16.8,-32},{-24,-32},
          {-24,-10},{-14.8,-10}}, color={255,0,255}));
  connect(absCS.y, switch3.u3) annotation (Line(points={{-27.4,-34},{-22,-34},{
          -22,-35.2},{-16.8,-35.2}}, color={0,0,127}));
  connect(switch3.y, integratorCS.u) annotation (Line(points={{-7.6,-32},{-4,
          -32},{-4,-34},{-1.2,-34}}, color={0,0,127}));
  connect(zero.y, switch2.u1) annotation (Line(points={{-18.3,-21},{-18.3,-6.8},
          {-14.8,-6.8}}, color={0,0,127}));
  connect(zero.y, switch3.u1) annotation (Line(points={{-18.3,-21},{-18.3,-28.8},
          {-16.8,-28.8}}, color={0,0,127}));
  connect(switch3.u2, hp_on) annotation (Line(points={{-16.8,-32},{-24,-32},{
          -24,-100},{0,-100},{0,-120}}, color={255,0,255}));
  connect(stepHeatingActive.active, heatingActive)
    annotation (Line(points={{-50,39},{-50,20},{110,20}}, color={255,0,255}));
  connect(stepCoolingActive.active, coolingActive)
    annotation (Line(points={{58,39},{58,-20},{110,-20}}, color={255,0,255}));
  connect(sumHS.u, T_HS) annotation (Line(points={{-95.2,-14},{-98,-14},{-98,20},
          {-120,20}}, color={0,0,127}));
  connect(sumCS.u, T_CS) annotation (Line(points={{-95.2,-34},{-98,-34},{-98,
          -40},{-120,-40}}, color={0,0,127}));
  connect(or2.u1, or1.y) annotation (Line(points={{2,14.8},{6,14.8},{6,23.6},{8,
          23.6}}, color={255,0,255}));
  connect(or2.u2, booleanPulse.y) annotation (Line(points={{-1.2,14.8},{-1.35,
          14.8},{-1.35,13},{-3.5,13}}, color={255,0,255}));
  connect(or2.y, integratorHS.reset) annotation (Line(points={{2,5.6},{6,5.6},{
          6,-4.8},{9.6,-4.8}}, color={255,0,255}));
  connect(integratorHS.reset, integratorCS.reset) annotation (Line(points={{9.6,
          -4.8},{9.6,-16.4},{9.6,-16.4},{9.6,-26.8}}, color={255,0,255}));
  connect(sumCS.y, gain1.u)
    annotation (Line(points={{-81.4,-34},{-76.8,-34}}, color={0,0,127}));
  connect(gain1.y, derivativeCS.u)
    annotation (Line(points={{-67.6,-34},{-61.2,-34}}, color={0,0,127}));
  connect(sumHS.y, gain.u)
    annotation (Line(points={{-81.4,-14},{-76.8,-14}}, color={0,0,127}));
  connect(gain.y, derivativeHS.u)
    annotation (Line(points={{-67.6,-14},{-61.2,-14}}, color={0,0,127}));
  connect(sumCS.y, greaterThreshold.u) annotation (Line(points={{-81.4,-34},{
          -79.2,-34},{-79.2,6}}, color={0,0,127}));
  connect(or3.u2, not1.y) annotation (Line(points={{-22.8,5.2},{-22.8,2},{25.6,
          2}}, color={255,0,255}));
  connect(greaterThreshold.y, or3.u1) annotation (Line(points={{-65.4,6},{-44,6},
          {-44,5.2},{-26,5.2}}, color={255,0,255}));
  connect(sumHS.y, lessThreshold.u) annotation (Line(points={{-81.4,-14},{-82,
          -14},{-82,-45.2},{88,-45.2}}, color={0,0,127}));
  connect(greater.y, not1.u) annotation (Line(points={{36.6,-12},{42,-12},{42,2},
          {34.8,2}}, color={255,0,255}));
  connect(or3.y, transitionCoolingMode.condition) annotation (Line(points={{-26,
          14.4},{-22,14.4},{-22,38},{-18,38}}, color={255,0,255}));
  connect(greater.y, or4.u1) annotation (Line(points={{36.6,-12},{84,-12},{84,
          -2.8}}, color={255,0,255}));
  connect(lessThreshold.y, or4.u2) annotation (Line(points={{88,-31.4},{88,-18},
          {88,-2.8},{87.2,-2.8}}, color={255,0,255}));
  connect(or4.y, transitionHeatingMode.condition) annotation (Line(points={{84,
          6.4},{86,6.4},{86,38},{88,38}}, color={255,0,255}));
  connect(stepHeatingActive.outPort[1], transitionCoolingMode.inPort)
    annotation (Line(points={{-39.5,50},{-22,50}}, color={0,0,0}));
  connect(tran.outPort, stepHeatingActive.inPort[1])
    annotation (Line(points={{-68.5,50},{-61,50}}, color={0,0,0}));
  connect(stepHeating.outPort[1], tran.inPort)
    annotation (Line(points={{-79.5,50},{-74,50}}, color={0,0,0}));
  connect(transitionCoolingMode.outPort, stepCooling.inPort[1])
    annotation (Line(points={{-16.5,50},{-1,50}}, color={0,0,0}));
  connect(stepCooling.outPort[1], tran1.inPort)
    annotation (Line(points={{20.5,50},{32,50}}, color={0,0,0}));
  connect(tran1.outPort, stepCoolingActive.inPort[1])
    annotation (Line(points={{37.5,50},{47,50}}, color={0,0,0}));
  connect(stepCoolingActive.outPort[1], transitionHeatingMode.inPort)
    annotation (Line(points={{68.5,50},{84,50}}, color={0,0,0}));
  connect(transitionHeatingMode.outPort, stepHeating.inPort[1]) annotation (
      Line(points={{89.5,50},{94,50},{94,66},{-110,66},{-110,50},{-101,50}},
        color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrHeatingCoolingMode;
