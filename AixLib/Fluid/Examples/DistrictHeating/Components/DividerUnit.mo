within AixLib.Fluid.Examples.DistrictHeating.Components;
model DividerUnit "Divider unit for direct or indirect supply"

  replaceable package Medium = AixLib.Media.Water;

  Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening dirSupplyValve( redeclare
      package Medium =
        Medium,
    m_flow_nominal=10,
    dpValve_nominal=6000) "Valve for direct supply"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening indirSupplyValve( redeclare
      package Medium =
        Medium,
    m_flow_nominal=10,
    dpValve_nominal=6000) "Valve for indirect supply"
                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-46})));
  Modelica.Blocks.Interfaces.RealInput ValveOpDir
    "valve opening of direct supply" annotation (Placement(transformation(
          extent={{-126,54},{-86,94}}), iconTransformation(extent={{-108,58},{-82,
            84}})));
  Modelica.Blocks.Interfaces.RealInput ValveOpIndir
    "valve opening of indirect supply" annotation (Placement(transformation(
          extent={{-126,26},{-86,66}}), iconTransformation(extent={{-108,30},{-82,
            56}})));
equation
  connect(port_a, dirSupplyValve.port_a)
    annotation (Line(points={{-100,0},{-74,0},{30,0}}, color={0,127,255}));
  connect(dirSupplyValve.port_b, port_b1)
    annotation (Line(points={{50,0},{100,0}},         color={0,127,255}));
  connect(port_a, indirSupplyValve.port_a)
    annotation (Line(points={{-100,0},{0,0},{0,-36}}, color={0,127,255}));
  connect(indirSupplyValve.port_b, port_b)
    annotation (Line(points={{0,-56},{0,-100}},          color={0,127,255}));
  connect(ValveOpIndir, indirSupplyValve.y) annotation (Line(points={{-106,46},{
          -38,46},{-38,-28},{22,-28},{22,-46},{12,-46}}, color={0,0,127}));
  connect(ValveOpDir, dirSupplyValve.y)
    annotation (Line(points={{-106,74},{40,74},{40,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DividerUnit;
