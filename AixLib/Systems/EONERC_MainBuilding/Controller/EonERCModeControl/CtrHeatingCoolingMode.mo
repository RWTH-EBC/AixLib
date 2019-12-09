within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model CtrHeatingCoolingMode "Determination of heating or cooling mode"
  Modelica.StateGraph.TransitionWithSignal transitionCoolingMode(enableTimer=
        true, waitTime=600)
    annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
  Modelica.StateGraph.TransitionWithSignal transitionHeatingMode(enableTimer=
        true, waitTime=600)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.StateGraph.StepWithSignal stepCoolingActive
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Modelica.StateGraph.InitialStepWithSignal stepHeatingActive
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Continuous.Derivative derivativeHS
    annotation (Placement(transformation(extent={{-60,-18},{-48,-6}})));
  Modelica.Blocks.Continuous.Integrator integratorHS(use_reset=true)
    annotation (Placement(transformation(extent={{0,-6},{12,-18}})));
  Modelica.StateGraph.Transition transition
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.StateGraph.StepWithSignal stepCooling "To reset integrator"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.StateGraph.Transition transition1
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.StateGraph.StepWithSignal stepHeating "To reset integrator"
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Math.Sum sumHS(nin=2, k={0.5*4000,0.5*4000})
    annotation (Placement(transformation(extent={{-80,-18},{-68,-6}})));
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
  Modelica.Blocks.Math.Sum sumCS(nin=2, k={0.5*5000,0.5*5000})
    annotation (Placement(transformation(extent={{-80,-40},{-68,-28}})));
  Modelica.Blocks.Math.Abs absHS
    annotation (Placement(transformation(extent={{-40,-18},{-28,-6}})));
  Modelica.Blocks.Math.Abs absCS
    annotation (Placement(transformation(extent={{-40,-40},{-28,-28}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={10,8})));
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
        transformation(extent={{100,-30},{120,-10}}), iconTransformation(extent
          ={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput T_HS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,40},{
            -100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_CS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-142,-60},{-102,-20}}), iconTransformation(extent={{-140,-80},
            {-100,-40}})));
equation
  connect(stepHeatingActive.outPort[1],transitionCoolingMode. inPort)
    annotation (Line(points={{-29.5,50},{-20,50}},   color={0,0,0}));
  connect(stepCoolingActive.outPort[1],transitionHeatingMode. inPort)
    annotation (Line(points={{70.5,50},{76,50}},   color={0,0,0}));
  connect(transition.outPort,stepHeatingActive. inPort[1])
    annotation (Line(points={{-58.5,50},{-51,50}},   color={0,0,0}));
  connect(transitionCoolingMode.outPort,stepCooling. inPort[1])
    annotation (Line(points={{-14.5,50},{-1,50}},   color={0,0,0}));
  connect(stepCooling.outPort[1],transition1. inPort)
    annotation (Line(points={{20.5,50},{36,50}},   color={0,0,0}));
  connect(transition1.outPort,stepCoolingActive. inPort[1])
    annotation (Line(points={{41.5,50},{49,50}},   color={0,0,0}));
  connect(transition.inPort,stepHeating. outPort[1])
    annotation (Line(points={{-64,50},{-69.5,50}},   color={0,0,0}));
  connect(transitionHeatingMode.outPort,stepHeating. inPort[1]) annotation (
      Line(points={{81.5,50},{90,50},{90,66},{-91,66},{-91,50}},          color=
         {0,0,0}));
  connect(integratorHS.y,greater. u1)
    annotation (Line(points={{12.6,-12},{22.8,-12}},   color={0,0,127}));
  connect(integratorCS.y,greater. u2) annotation (Line(points={{12.6,-34},{22.8,
          -34},{22.8,-16.8}},  color={0,0,127}));
  connect(sumHS.y,derivativeHS. u)
    annotation (Line(points={{-67.4,-12},{-61.2,-12}}, color={0,0,127}));
  connect(sumCS.y,derivativeCS. u)
    annotation (Line(points={{-67.4,-34},{-61.2,-34}}, color={0,0,127}));
  connect(derivativeCS.y,absCS. u)
    annotation (Line(points={{-47.4,-34},{-41.2,-34}}, color={0,0,127}));
  connect(derivativeHS.y,absHS. u)
    annotation (Line(points={{-47.4,-12},{-41.2,-12}}, color={0,0,127}));
  connect(greater.y,transitionHeatingMode. condition) annotation (Line(points={{36.6,
          -12},{80,-12},{80,38}},       color={255,0,255}));
  connect(not1.u,transitionHeatingMode. condition) annotation (Line(points={{34.8,2},
          {40,2},{40,-12},{80,-12},{80,38}},       color={255,0,255}));
  connect(not1.y,transitionCoolingMode. condition) annotation (Line(points={{25.6,2},
          {-16,2},{-16,38}},         color={255,0,255}));
  connect(or1.u1,stepCooling. active) annotation (Line(points={{10,12.8},{10,39}},
                     color={255,0,255}));
  connect(integratorHS.reset,or1. y) annotation (Line(points={{9.6,-4.8},{10,
          -4.8},{10,3.6}},     color={255,0,255}));
  connect(or1.y, integratorCS.reset) annotation (Line(points={{10,3.6},{10,
          -26.8},{9.6,-26.8}}, color={255,0,255}));
  connect(stepHeating.active, or1.u2) annotation (Line(points={{-80,39},{-80,
          12.8},{6.8,12.8}}, color={255,0,255}));
  connect(absHS.y, switch2.u3) annotation (Line(points={{-27.4,-12},{-24,-12},{
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
    annotation (Line(points={{-40,39},{-40,20},{110,20}}, color={255,0,255}));
  connect(stepCoolingActive.active, coolingActive)
    annotation (Line(points={{60,39},{60,-20},{110,-20}}, color={255,0,255}));
  connect(sumHS.u, T_HS) annotation (Line(points={{-81.2,-12},{-98,-12},{-98,40},
          {-120,40}}, color={0,0,127}));
  connect(sumCS.u, T_CS) annotation (Line(points={{-81.2,-34},{-98,-34},{-98,
          -40},{-122,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrHeatingCoolingMode;
