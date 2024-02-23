within AixLib.Utilities.MassTransfer;
model MassFlowSensor "Mass flow rate sensor"
  extends Modelica.Icons.RoundSensor;
  Modelica.Blocks.Interfaces.RealOutput m_flow(unit="kg/s")
    "Mass flow from port_a to port_b as output signal" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  MassPort port_a
    annotation (Placement(transformation(extent={{-112,-12},{-86,14}})));
  MassPort port_b
    annotation (Placement(transformation(extent={{86,-14},{114,14}})));
equation
  port_a.p = port_b.p;
  port_a.m_flow + port_b.m_flow = 0;
  m_flow = port_a.m_flow;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-70,0},{-95,0}}, color={0,140,72}),
        Line(points={{0,-70},{0,-90}}, color={0,0,127}),
        Line(points={{94,0},{69,0}}, color={0,140,72})}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{5,-86},{116,-110}},
          textString="m_flow",
          lineColor={0,0,0}),
        Line(points={{-70,0},{-90,0}}, color={0,140,72}),
        Line(points={{69,0},{90,0}}, color={0,140,72}),
        Line(points={{0,-70},{0,-90}}, color={0,0,127}),
        Text(
          extent={{-150,125},{150,85}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html><p>
  This model is capable of monitoring the mass flow rate flowing
  through this component. The sensed value of mass flow rate is the
  amount that passes through this sensor while keeping the partial
  pressure drop across the sensor zero. This is an ideal model so it
  does not absorb any mass and it has no direct effect on the mass
  transfer response of a system it is included in. The output signal is
  positive, if the mass flows from port_a to port_b.
</p>
</html>", revisions="<html>
<ul>
  <li>November 20, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
</ul>
</html>"));
end MassFlowSensor;
