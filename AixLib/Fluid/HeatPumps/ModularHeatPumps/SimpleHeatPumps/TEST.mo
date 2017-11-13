within AixLib.Fluid.HeatPumps.ModularHeatPumps.SimpleHeatPumps;
model TEST
  Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
    compressor(redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,0})));
  Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsothermalExpansionValve
    valve(redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,0})));
  HeatExchangers.ConstantEffectiveness condenser(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    dp1_nominal=10,
    dp2_nominal=10)
    annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  HeatExchangers.ConstantEffectiveness evaporator(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    dp1_nominal=10,
    dp2_nominal=10)
    annotation (Placement(transformation(extent={{10,-36},{-10,-56}})));

  Sources.MassFlowSource_T sourceEvaporator(
    nPorts=1,
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    T=293.15)
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  Sources.MassFlowSource_T sourceCondensator(
    nPorts=1,
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    T=313.15)
    annotation (Placement(transformation(extent={{-62,60},{-42,80}})));

  Sources.Boundary_ph sinkEvaporator(
    nPorts=1,
    redeclare package Medium = Media.Water,
    p=1e5)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Sources.Boundary_ph sinkCondenser(
    nPorts=1,
    redeclare package Medium = Media.Water,
    p=1e5)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));




  Modelica.Blocks.Sources.Constant const(k=60)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation



  connect(evaporator.port_b2, compressor.port_a)
    annotation (Line(points={{10,-40},{60,-40},{60,-10}}, color={0,127,255}));
  connect(compressor.port_b, condenser.port_a2)
    annotation (Line(points={{60,10},{60,40},{10,40}}, color={0,127,255}));
  connect(condenser.port_b2, valve.port_a)
    annotation (Line(points={{-10,40},{-60,40},{-60,10}}, color={0,127,255}));
  connect(valve.port_b,evaporator. port_a2) annotation (Line(points={{-60,-10},{
          -60,-40},{-10,-40}}, color={0,127,255}));
  connect(sourceCondensator.ports[1], condenser.port_a1) annotation (Line(
        points={{-42,70},{-30,70},{-30,52},{-10,52}}, color={0,127,255}));
  connect(sourceEvaporator.ports[1],evaporator. port_a1) annotation (Line(
        points={{40,-70},{30,-70},{30,-52},{10,-52}}, color={0,127,255}));
  connect(sinkEvaporator.ports[1],evaporator. port_b1) annotation (Line(points={
          {-40,-70},{-30,-70},{-30,-52},{-10,-52}}, color={0,127,255}));
  connect(sinkCondenser.ports[1], condenser.port_b1) annotation (Line(points={{40,
          70},{28,70},{28,52},{10,52}}, color={0,127,255}));
  connect(const.y, compressor.manVarCom)
    annotation (Line(points={{31,0},{40,0},{40,-6},{50,-6}}, color={0,0,127}));
  connect(const1.y, valve.manVarVal) annotation (Line(points={{-31,0},{-40,0},{
          -40,5},{-49.4,5}}, color={0,0,127}));
  connect(fixedTemperature.port, compressor.heatPort)
    annotation (Line(points={{80,0},{70,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TEST;
