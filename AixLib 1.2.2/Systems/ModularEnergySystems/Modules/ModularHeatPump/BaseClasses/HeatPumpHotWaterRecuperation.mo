within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model HeatPumpHotWaterRecuperation

  extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses.HeatPumpTConInControl(
      conPID(yMax=1)) annotation (Icon(coordinateSystem(preserveAspectRatio=
            false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

  Fluid.HeatExchangers.ConstantEffectiveness        hexMain1(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    m1_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    m2_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    dp1_nominal=2500,
    dp2_nominal=2500,
    eps=1) annotation (Placement(transformation(
        extent={{-13,-12},{13,12}},
        rotation=0,
        origin={-1,0})));
  Fluid.Actuators.Valves.TwoWayLinear valBaypass(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2,
    dpValve_nominal=6000,
    riseTime=60,
    y_start=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={30,-40})));
  Fluid.Sensors.MassFlowRate mFlowBypass(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=true)
    "Mass flow sensor bypass" annotation (Placement(transformation(
        origin={30,-18},
        extent={{-8,-8},{8,8}},
        rotation=90)));
  Fluid.Actuators.Valves.TwoWayLinear valMain(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2,
    dpValve_nominal=6000,
    riseTime=60)
    annotation (Placement(transformation(extent={{2,-48},{-22,-72}})));
equation
  connect(hexMain1.port_b2, mFlowMainInlet_b.port_a) annotation (Line(points={{-14,
          -7.2},{-52,-7.2},{-52,-60}}, color={0,127,255}));
  connect(mFlowMainOutlet_a.port_b, hexMain1.port_a1) annotation (Line(points={{
          -36,60},{-20,60},{-20,7.2},{-14,7.2}}, color={0,127,255}));
  connect(hexMain1.port_b1, mFlowMainOutlet_b.port_a) annotation (Line(points={{
          12,7.2},{24,7.2},{24,60},{36,60}}, color={0,127,255}));
  connect(valBaypass.port_b, mFlowBypass.port_a)
    annotation (Line(points={{30,-30},{30,-26}}, color={0,127,255}));
  connect(hexMain1.port_a2, mFlowBypass.port_b) annotation (Line(points={{12,
          -7.2},{30,-7.2},{30,-10}}, color={0,127,255}));
  connect(valBaypass.port_a, mFlowMainInlet_a.port_b)
    annotation (Line(points={{30,-50},{30,-60},{56,-60}}, color={0,127,255}));
  connect(mFlowMainInlet_a.port_b, valMain.port_a)
    annotation (Line(points={{56,-60},{2,-60}}, color={0,127,255}));
  connect(valMain.port_b, mFlowMainInlet_b.port_a)
    annotation (Line(points={{-22,-60},{-52,-60}}, color={0,127,255}));
  connect(positionMain.y, valMain.y) annotation (Line(points={{-0.7,-79},{-0.7,
          -80},{-10,-80},{-10,-74.4}}, color={0,0,127}));
end HeatPumpHotWaterRecuperation;
