within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  TBA_Pipe OpenPlanOffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
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
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=0.3,
    dpValve_nominal=2)
    annotation (Placement(transformation(extent={{-28,-14},{-8,6}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=10,
    offset=1,
    startTime=300)
    annotation (Placement(transformation(extent={{-60,38},{-40,58}})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=0.3,
    dpValve_nominal=2)
    annotation (Placement(transformation(extent={{-16,16},{-36,36}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=0.3,
    dpValve_nominal=2,
    y_start=0)
    annotation (Placement(transformation(extent={{10,-52},{-10,-32}})));
  Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=0.3,
    dpValve_nominal=2,
    y_start=0)
    annotation (Placement(transformation(extent={{-6,-86},{14,-66}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=10,
    startTime=300,
    height=1,
    offset=0)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
equation
  connect(OpenPlanOffice.HeatPort_TBA_OpenPlanOffice,
    HeatPort_TBA_OpenPlanOffice)
    annotation (Line(points={{80,60},{80,100}}, color={191,0,0}));
  connect(ramp.y, val.y)
    annotation (Line(points={{-39,48},{-18,48},{-18,8}}, color={0,0,127}));
  connect(Fluid_in_warm, val1.port_b)
    annotation (Line(points={{-100,26},{-36,26}}, color={0,127,255}));
  connect(val1.y, val.y) annotation (Line(points={{-26,38},{-26,48},{-18,48},{
          -18,8}}, color={0,0,127}));
  connect(val1.port_a, OpenPlanOffice.Fluid_in) annotation (Line(points={{-16,
          26},{24,26},{24,28},{74,28},{74,40}}, color={0,127,255}));
  connect(Fluid_out_warm, val.port_a) annotation (Line(points={{-100,-14},{-60,
          -14},{-60,-4},{-28,-4}}, color={0,127,255}));
  connect(val.port_b, OpenPlanOffice.Fluid_out)
    annotation (Line(points={{-8,-4},{86,-4},{86,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in, val2.port_a) annotation (Line(points={{74,40},
          {74,-38},{10,-38},{10,-42}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, val3.port_b)
    annotation (Line(points={{86,40},{86,-76},{14,-76}}, color={0,127,255}));
  connect(val3.port_a, Fluid_out_cold) annotation (Line(points={{-6,-76},{-52,
          -76},{-52,-80},{-100,-80}}, color={0,127,255}));
  connect(val2.port_b, Fluid_in_cold) annotation (Line(points={{-10,-42},{-56,
          -42},{-56,-40},{-100,-40}}, color={0,127,255}));
  connect(val2.y, ramp1.y) annotation (Line(points={{0,-30},{-2,-30},{-2,-26},{
          -34,-26},{-34,-60},{-39,-60}}, color={0,0,127}));
  connect(val3.y, ramp1.y)
    annotation (Line(points={{4,-64},{4,-60},{-39,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
