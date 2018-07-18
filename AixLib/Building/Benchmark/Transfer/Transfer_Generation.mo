within AixLib.Building.Benchmark.Transfer;
model Transfer_Generation
  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-46,6},{-26,26}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-4,6},{16,26}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-2,-38},{18,-18}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "First port, typically inlet"
    annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-20,-78},{-6,-92}},
          lineColor={28,108,200},
          textString="4")}));
end Transfer_Generation;
