within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model Example
  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT        bouEvap_b1(
    redeclare package Medium = AixLib.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-70,-58},{-52,-40}})));
  Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = AixLib.Media.Water,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=2,
    dpValve_nominal=6000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-18})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    freqHz=1/120,
    offset=0.5)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Fluid.Sources.Boundary_pT        bouEvap_b2(redeclare package Medium =
        AixLib.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{68,-22},{86,-4}})));
  Fluid.Sources.Boundary_pT        bouEvap_b3(redeclare package Medium =
        AixLib.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-80,-20},{-62,-2}})));
equation
  connect(bouEvap_b1.ports[1], val.port_3)
    annotation (Line(points={{-52,-49},{0,-49},{0,-28}}, color={0,127,255}));
  connect(sine.y, val.y)
    annotation (Line(points={{-19,40},{0,40},{0,-6}}, color={0,0,127}));
  connect(bouEvap_b2.ports[1], val.port_1) annotation (Line(points={{86,-13},{
          92,-13},{92,-18},{10,-18}}, color={0,127,255}));
  connect(bouEvap_b3.ports[1], val.port_2) annotation (Line(points={{-62,-11},{
          -42,-11},{-42,-10},{-28,-10},{-28,-18},{-10,-18}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Example;
