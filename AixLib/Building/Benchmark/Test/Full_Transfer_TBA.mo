within AixLib.Building.Benchmark.Test;
model Full_Transfer_TBA
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_TBA_OpenPlanOffice
    annotation (Placement(transformation(extent={{70,90},{90,110}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

  Modelica.Blocks.Sources.Ramp ramp1(
    duration=10,
    height=1,
    offset=0,
    startTime=2000)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    duration=10,
    startTime=2000,
    height=-1,
    offset=1)
    annotation (Placement(transformation(extent={{-66,54},{-46,74}})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{-18,-24},{2,-4}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{-18,-90},{2,-70}})));
  Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{30,-50},{10,-30}})));
  Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{20,16},{0,36}})));
equation
  connect(OpenPlanOffice.HeatPort_TBA, HeatPort_TBA_OpenPlanOffice)
    annotation (Line(points={{76,60},{76,80},{80,80},{80,100}},
                                                color={191,0,0}));
  connect(val4.port_b, Fluid_in_warm)
    annotation (Line(points={{0,26},{-100,26}}, color={0,127,255}));
  connect(val1.port_a, Fluid_out_warm)
    annotation (Line(points={{-18,-14},{-100,-14}}, color={0,127,255}));
  connect(val3.port_b, Fluid_in_cold)
    annotation (Line(points={{10,-40},{-100,-40}}, color={0,127,255}));
  connect(val2.port_a, Fluid_out_cold)
    annotation (Line(points={{-18,-80},{-100,-80}}, color={0,127,255}));
  connect(val2.port_b, OpenPlanOffice.Fluid_out_cold)
    annotation (Line(points={{2,-80},{86,-80},{86,40}}, color={0,127,255}));
  connect(val3.port_a, OpenPlanOffice.Fluid_in_cold)
    annotation (Line(points={{30,-40},{74,-40},{74,40}}, color={0,127,255}));
  connect(val4.port_a, OpenPlanOffice.Fluid_in_cold)
    annotation (Line(points={{20,26},{74,26},{74,40}}, color={0,127,255}));
  connect(val1.port_b, OpenPlanOffice.Fluid_out_cold)
    annotation (Line(points={{2,-14},{86,-14},{86,40}}, color={0,127,255}));
  connect(ramp2.y, val4.y)
    annotation (Line(points={{-45,64},{10,64},{10,38}}, color={0,0,127}));
  connect(val1.y, val4.y) annotation (Line(points={{-8,-2},{-8,64},{10,64},{10,
          38}}, color={0,0,127}));
  connect(val3.y, ramp1.y) annotation (Line(points={{20,-28},{20,-24},{-34,-24},
          {-34,-60},{-39,-60}}, color={0,0,127}));
  connect(val2.y, ramp1.y)
    annotation (Line(points={{-8,-68},{-8,-60},{-39,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
