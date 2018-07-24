within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    m1_flow_nominal = QCon_flow_nominal/cp1_default/dTCon_nominal,
    m2_flow_nominal = QEva_flow_nominal/cp2_default/dTEva_nominal);
  MixingVolumes.MixingVolume Condenser(nPorts=2) "Volume of Condenser"
    annotation (Placement(transformation(extent={{-8,104},{12,84}})));
  MixingVolumes.MixingVolume Evaporator(nPorts=2) "Volume of Evaporator"
    annotation (Placement(transformation(extent={{-6,-90},{14,-70}})));
  Sensors.MassFlowRate mFlow_a1 "mass flow rate at source inlet"
    annotation (Placement(transformation(extent={{-74,84},{-54,64}})));
  Sensors.TemperatureTwoPort T_b2 "Temperature at sink outlet"
    annotation (Placement(transformation(extent={{-20,-96},{-40,-76}})));
  Sensors.TemperatureTwoPort T_b1 "Temperature at source outlet"
    annotation (Placement(transformation(extent={{24,92},{44,72}})));
  Sensors.TemperatureTwoPort T_a2 "Temperature at sink inlet"
    annotation (Placement(transformation(extent={{38,-96},{18,-76}})));
  Sensors.TemperatureTwoPort T_a1 "Temperature at source inlet"
    annotation (Placement(transformation(extent={{-46,92},{-26,72}})));
  Sensors.MassFlowRate mFlow_a2 "mass flow rate at sink inlet"
    annotation (Placement(transformation(extent={{86,-70},{66,-50}})));
  FixedResistances.PressureDrop preDro_2 "pressure drop at sink side"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  FixedResistances.PressureDrop preDro_1 "pressure drop at sink side"
    annotation (Placement(transformation(extent={{64,50},{84,70}})));
  Modelica.Blocks.Interfaces.RealInput N
    "input signal speed for compressor relative between 0 and 1"
    annotation (Placement(transformation(extent={{-130,12},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set Temperature of sink outlet"
    annotation (Placement(transformation(extent={{-130,-28},{-100,2}})));
  BaseClasses.SecurityControls.SecurityControl securityControl
    annotation (Placement(transformation(extent={{-86,-4},{-58,24}})));
  Modelica.Icons.SignalBus sigBusHP
    annotation (Placement(transformation(extent={{-144,-8},{-126,18}})));
equation
  connect(port_a1, mFlow_a1.port_a) annotation (Line(points={{-100,60},{-88,60},
          {-88,74},{-74,74}}, color={0,127,255}));
  connect(mFlow_a1.port_b, T_a1.port_a) annotation (Line(points={{-54,74},{-52,
          74},{-52,82},{-46,82}}, color={0,127,255}));
  connect(T_a1.port_b, Condenser.ports[1]) annotation (Line(points={{-26,82},{
          -16,82},{-16,104},{0,104}}, color={0,127,255}));
  connect(Condenser.ports[2], T_b1.port_a) annotation (Line(points={{4,104},{16,
          104},{16,82},{24,82}}, color={0,127,255}));
  connect(preDro_1.port_b, port_b1)
    annotation (Line(points={{84,60},{100,60}}, color={0,127,255}));
  connect(preDro_1.port_a, T_b1.port_b) annotation (Line(points={{64,60},{56,60},
          {56,82},{44,82}}, color={0,127,255}));
  connect(mFlow_a2.port_a, port_a2)
    annotation (Line(points={{86,-60},{100,-60}}, color={0,127,255}));
  connect(T_a2.port_a, mFlow_a2.port_b) annotation (Line(points={{38,-86},{52,
          -86},{52,-60},{66,-60}}, color={0,127,255}));
  connect(T_a2.port_b, Evaporator.ports[1])
    annotation (Line(points={{18,-86},{18,-90},{2,-90}}, color={0,127,255}));
  connect(T_b2.port_a, Evaporator.ports[2]) annotation (Line(points={{-20,-86},
          {-10,-86},{-10,-90},{6,-90}}, color={0,127,255}));
  connect(preDro_2.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(preDro_2.port_a, T_b2.port_b) annotation (Line(points={{-60,-60},{-50,
          -60},{-50,-86},{-40,-86}}, color={0,127,255}));
  connect(N, securityControl.n_in) annotation (Line(points={{-115,27},{-97.5,27},
          {-97.5,15.18},{-87.75,15.18}}, color={0,0,127}));
  connect(T_a1.T, sigBusHP.T_source_in) annotation (Line(points={{-36,71},{-36,
          52},{-136,52},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_b2.T, sigBusHP.T_sink_out) annotation (Line(points={{-30,-75},{-30,
          -44},{-136,-44},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_a2.T, sigBusHP.T_sink_in) annotation (Line(points={{28,-75},{28,-44},
          {-136,-44},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_b1.T, sigBusHP.T_source_out) annotation (Line(points={{34,71},{34,
          52},{-136,52},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a2.m_flow, sigBusHP.mFlow_sink) annotation (Line(points={{76,
          -49},{76,-44},{-136,-44},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a1.m_flow, sigBusHP.mFlow_source) annotation (Line(points={{-64,
          63},{-64,52},{-136,52},{-136,5},{-135,5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBusHP, securityControl.HeaPumSen) annotation (Line(
      points={{-135,5},{-126,5},{-126,5.8},{-87.1667,5.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end HeatPump;
