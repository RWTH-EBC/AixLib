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
  Sensors.TemperatureTwoPort senT_b2 "Temperature at sink outlet"
    annotation (Placement(transformation(extent={{-20,-96},{-40,-76}})));
  Sensors.TemperatureTwoPort senT_b1 "Temperature at source outlet"
    annotation (Placement(transformation(extent={{24,92},{44,72}})));
  Sensors.TemperatureTwoPort senT_a2 "Temperature at sink inlet"
    annotation (Placement(transformation(extent={{38,-96},{18,-76}})));
  Sensors.TemperatureTwoPort senT_a1 "Temperature at source inlet"
    annotation (Placement(transformation(extent={{-46,92},{-26,72}})));
  Sensors.MassFlowRate mFlow_a2 "mass flow rate at sink inlet"
    annotation (Placement(transformation(extent={{86,-70},{66,-50}})));
  FixedResistances.PressureDrop preDro_2 "pressure drop at sink side"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  FixedResistances.PressureDrop preDro_1 "pressure drop at sink side"
    annotation (Placement(transformation(extent={{64,50},{84,70}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-130,4},{-100,34}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set Temperature of sink outlet"
    annotation (Placement(transformation(extent={{-130,-28},{-100,2}})));
  BaseClasses.SecurityControls.SecurityControl securityControl
    annotation (Placement(transformation(extent={{-48,-4},{-20,24}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-114,-8},{-96,18}}),
        iconTransformation(extent={{-114,-8},{-96,18}})));
  Modelica.Blocks.Interfaces.RealOutput N
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(port_a1, mFlow_a1.port_a) annotation (Line(points={{-100,60},{-88,60},
          {-88,74},{-74,74}}, color={0,127,255}));
  connect(mFlow_a1.port_b, senT_a1.port_a) annotation (Line(points={{-54,74},{-52,
          74},{-52,82},{-46,82}}, color={0,127,255}));
  connect(senT_a1.port_b, Condenser.ports[1]) annotation (Line(points={{-26,82},
          {-16,82},{-16,104},{0,104}}, color={0,127,255}));
  connect(Condenser.ports[2], senT_b1.port_a) annotation (Line(points={{4,104},
          {16,104},{16,82},{24,82}}, color={0,127,255}));
  connect(preDro_1.port_b, port_b1)
    annotation (Line(points={{84,60},{100,60}}, color={0,127,255}));
  connect(preDro_1.port_a, senT_b1.port_b) annotation (Line(points={{64,60},{56,
          60},{56,82},{44,82}}, color={0,127,255}));
  connect(mFlow_a2.port_a, port_a2)
    annotation (Line(points={{86,-60},{100,-60}}, color={0,127,255}));
  connect(senT_a2.port_a, mFlow_a2.port_b) annotation (Line(points={{38,-86},{
          52,-86},{52,-60},{66,-60}}, color={0,127,255}));
  connect(senT_a2.port_b, Evaporator.ports[1])
    annotation (Line(points={{18,-86},{18,-90},{2,-90}}, color={0,127,255}));
  connect(senT_b2.port_a, Evaporator.ports[2]) annotation (Line(points={{-20,-86},
          {-10,-86},{-10,-90},{6,-90}}, color={0,127,255}));
  connect(preDro_2.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(preDro_2.port_a, senT_b2.port_b) annotation (Line(points={{-60,-60},{
          -50,-60},{-50,-86},{-40,-86}}, color={0,127,255}));
  connect(nSet, securityControl.nSet) annotation (Line(points={{-115,19},{-97.5,
          19},{-97.5,15.18},{-49.75,15.18}}, color={0,0,127}));
  connect(mFlow_a1.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-64,63},
          {-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a2.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{76,-49},
          {76,-30},{-64,-30},{-64,5.065},{-104.955,5.065}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-30,-75},{-30,
          -30},{-64,-30},{-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{28,-75},{28,
          -30},{-64,-30},{-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a1.T, sigBusHP.T_ret_co) annotation (Line(points={{-36,71},{-36,
          42},{-64,42},{-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBusHP.T_flow_co) annotation (Line(points={{34,71},{34,
          42},{-64,42},{-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(N, sigBusHP.N) annotation (Line(points={{110,0},{112,0},{112,-30},{
          -64,-30},{-64,5.065},{-104.955,5.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(securityControl.heatPumpControlBus, sigBusHP) annotation (Line(
      points={{-49.9833,6.22},{-74.9916,6.22},{-74.9916,5},{-105,5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(securityControl.nOut, N) annotation (Line(points={{-18.8333,10},{40,
          10},{40,0},{110,0}}, color={0,0,127}));
end HeatPump;
