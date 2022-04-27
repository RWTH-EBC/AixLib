within AixLib.Systems.HydraulicModules;
model SimpleConsumer_1
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(volume(
        nPorts=2));
  parameter Integer demandType   "Choose between heating and cooling functionality" annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true));

  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-28,40})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_max(y=Q_flow_max)
    annotation (Placement(transformation(extent={{-98,38},{-78,58}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_min(y=0)
    annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
equation
  connect(senMasFlo.port_b, volume.ports[2]) annotation (Line(points={{-44,0},{-24,
          0},{-24,0},{-1.77636e-15,0}}, color={0,127,255}));
  connect(gain1.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21.4,40},{-16,40}}, color={0,0,127}));
  connect(Q_realExp.y, gain1.u) annotation (Line(points={{-41,60},{-40,60},{-40,
          40},{-35.2,40}}, color={0,0,127}, pattern=LinePattern.Dash));
  connect(variableLimiter.y, gain1.u) annotation (Line(points={{-43,40},{-35.2,
          40}},                                                                        color={0,0,127}, pattern=LinePattern.Dash));
  connect(Q_flow, variableLimiter.u) annotation (Line(points={{-60,120},{-60,
          100},{-72,100},{-72,40},{-66,40}}, color={0,0,127}));
  connect(Exp_Q_flow_max.y, variableLimiter.limit1)
    annotation (Line(points={{-77,48},{-66,48}}, color={0,0,127}));
  connect(Exp_Q_flow_min.y, variableLimiter.limit2)
    annotation (Line(points={{-77,32},{-66,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_1;
