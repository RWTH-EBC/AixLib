within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  TBA_Pipe OpenPlanOffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
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

  Modelica.Blocks.Sources.Ramp ramp1(
    duration=10,
    startTime=2000,
    offset=1,
    height=-0.5)
    annotation (Placement(transformation(extent={{34,-62},{54,-42}})));
  Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={76,24})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={88,-24})));
equation
  connect(OpenPlanOffice.HeatPort_TBA_OpenPlanOffice,
    HeatPort_TBA_OpenPlanOffice)
    annotation (Line(points={{80,60},{80,100}}, color={191,0,0}));
  connect(OpenPlanOffice.Fluid_in, val.port_2)
    annotation (Line(points={{74,40},{74,34},{76,34}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, val1.port_2)
    annotation (Line(points={{86,40},{86,-14},{88,-14}}, color={0,127,255}));
  connect(val.port_3, Fluid_in_warm) annotation (Line(points={{66,24},{-18,24},
          {-18,26},{-100,26}}, color={0,127,255}));
  connect(val1.port_3, Fluid_out_warm) annotation (Line(points={{78,-24},{-10,
          -24},{-10,-14},{-100,-14}}, color={0,127,255}));
  connect(val.port_1, Fluid_in_cold) annotation (Line(points={{76,14},{-12,14},
          {-12,-40},{-100,-40}}, color={0,127,255}));
  connect(val1.port_1, Fluid_out_cold) annotation (Line(points={{88,-34},{-4,
          -34},{-4,-80},{-100,-80}}, color={0,127,255}));
  connect(ramp1.y, val1.y) annotation (Line(points={{55,-52},{114,-52},{114,-24},
          {100,-24}}, color={0,0,127}));
  connect(val.y, val1.y) annotation (Line(points={{88,24},{114,24},{114,-24},{
          100,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
