within AixLib.Building.Benchmark.Generation;
model Generation_AirCooling
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow_nominal=100,
    V=1) annotation (Placement(transformation(extent={{-6,-2},{14,18}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={78,-2})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-116,8},{-92,32}})));
  Modelica.Blocks.Interfaces.RealInput T_in1
    "Prescribed fluid temperature"
    annotation (Placement(transformation(extent={{-120,-52},{-96,-28}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    m_flow_nominal=5,
    V=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-2,54})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_airCooler(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_airCooler(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Fluid.Movers.FlowControlled_dp fan2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{42,30},{62,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=20000)
    annotation (Placement(transformation(extent={{-18,70},{2,90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        23000)
    annotation (Placement(transformation(extent={{-44,26},{-24,46}})));
equation
  connect(boundary.ports[1], vol.ports[1])
    annotation (Line(points={{-50,-2},{2,-2}}, color={0,127,255}));
  connect(vol.ports[2], bou.ports[1])
    annotation (Line(points={{6,-2},{68,-2}}, color={0,127,255}));
  connect(boundary.m_flow_in, m_flow_in) annotation (Line(points={{-70,6},{-84,
          6},{-84,20},{-104,20}}, color={0,0,127}));
  connect(boundary.T_in, T_in1) annotation (Line(points={{-72,2},{-74,2},{-74,
          -40},{-108,-40}}, color={0,0,127}));
  connect(bou.T_in, T_in1) annotation (Line(points={{90,2},{102,2},{102,-40},{
          -108,-40}}, color={0,0,127}));
  connect(Fluid_in_airCooler, vol1.ports[1]) annotation (Line(points={{100,60},
          {58,60},{58,52},{8,52}}, color={0,127,255}));
  connect(fan2.port_b, Fluid_out_airCooler)
    annotation (Line(points={{62,40},{100,40}}, color={0,127,255}));
  connect(fan2.port_a, vol1.ports[2]) annotation (Line(points={{42,40},{26,40},
          {26,56},{8,56}}, color={0,127,255}));
  connect(realExpression5.y, fan2.dp_in) annotation (Line(points={{3,80},{26,80},
          {26,82},{52,82},{52,52}}, color={0,0,127}));
  connect(thermalConductor.port_b, vol1.heatPort) annotation (Line(points={{-24,
          36},{-20,36},{-20,44},{-2,44}}, color={191,0,0}));
  connect(thermalConductor.port_a, vol.heatPort)
    annotation (Line(points={{-44,36},{-44,8},{-6,8}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_AirCooling;
