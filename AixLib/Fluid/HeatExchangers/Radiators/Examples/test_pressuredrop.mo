within AixLib.Fluid.HeatExchangers.Radiators.Examples;
model test_pressuredrop
package Medium = AixLib.Media.Water "Medium model";
  BaseClasses.PressureDropRadiator pressureDropRadiator
    annotation (Placement(transformation(extent={{-14,2},{6,22}})));
  Sources.MassFlowSource_T source(redeclare package Medium = Medium,
    nPorts=1,
    m_flow=0.02761,
    T=328.15) annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
  FixedResistances.FixedResistanceDpM res(redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=100000)
    annotation (Placement(transformation(extent={{20,2},{40,22}})));
  Sources.FixedBoundary sink(redeclare package Medium = Medium,
  nPorts=1,
    T=283.15)
    annotation (Placement(transformation(extent={{92,2},{72,22}})));
equation
  connect(source.ports[1], pressureDropRadiator.port_a) annotation (Line(points=
         {{-48,10},{-32,10},{-32,12},{-14,12}}, color={0,127,255}));
  connect(pressureDropRadiator.port_b, res.port_a)
    annotation (Line(points={{6,12},{20,12}}, color={0,127,255}));
  connect(res.port_b, sink.ports[1])
    annotation (Line(points={{40,12},{72,12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_pressuredrop;
