within AixLib.Fluid.Examples.DistrictHeating.Components;
model CollectorUnit "Collector unit for direct or indirect supply"

  replaceable package Medium = AixLib.Media.Water;

  Modelica.Fluid.Interfaces.FluidPort_b port_a( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_b( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,100})));
  Modelica.Fluid.Interfaces.FluidPort_a port_b1( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening dirSupplyValve( redeclare
      package Medium =
        Medium,
    m_flow_nominal=10,
    dpValve_nominal=6000)
    "Valve for direct supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,0})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening indirSupplyValve( redeclare
      package Medium =
        Medium,
    m_flow_nominal=10,
    dpValve_nominal=6000) "Valve for indirect supply"
                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,44})));
  Modelica.Blocks.Interfaces.RealInput ValveOpDir
    "valve opening of direct supply" annotation (Placement(transformation(
          extent={{-126,54},{-86,94}}), iconTransformation(extent={{-108,58},{-82,
            84}})));
  Modelica.Blocks.Interfaces.RealInput ValveOpIndir
    "valve opening of indirect supply" annotation (Placement(transformation(
          extent={{-126,26},{-86,66}}), iconTransformation(extent={{-108,30},{-82,
            56}})));
equation
  connect(port_b, port_b)
    annotation (Line(points={{0,100},{0,100},{0,100}}, color={0,127,255}));
  connect(port_b, indirSupplyValve.port_a)
    annotation (Line(points={{0,100},{0,77},{0,54}}, color={0,127,255}));
  connect(indirSupplyValve.port_b, port_a)
    annotation (Line(points={{0,34},{0,0},{-100,0}}, color={0,127,255}));
  connect(port_b1, dirSupplyValve.port_a)
    annotation (Line(points={{100,0},{75,0},{50,0}}, color={0,127,255}));
  connect(dirSupplyValve.port_b, port_a)
    annotation (Line(points={{30,0},{-100,0},{-100,0}}, color={0,127,255}));
  connect(ValveOpDir, dirSupplyValve.y) annotation (Line(points={{-106,74},{-58,
          74},{-58,-38},{40,-38},{40,-12}}, color={0,0,127}));
  connect(ValveOpIndir, indirSupplyValve.y) annotation (Line(points={{-106,46},
          {-32,46},{-32,74},{30,74},{30,44},{12,44}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CollectorUnit;
