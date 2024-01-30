within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.Substations;
partial model PartialSubstation
  "Base class for a DHC substation model"
  extends Interfaces.PartialTwoPort;

  parameter Boolean use_Q_in = false
    "Get the prescribed heat flow rate from the input connector"
    annotation(Evaluate=true, HideResult=true);

  parameter Modelica.Units.SI.HeatFlowRate prescribedQ
    "Fixed value of prescribed heat flow rate"
    annotation (Dialog(enable = not use_Q_in));

  Modelica.Blocks.Interfaces.RealInput Q_in(final unit="W") if use_Q_in
    "Prescribed heat flow rate connector"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

  parameter Boolean use_m_flow_in = false
    "Get the prescribed heat flow rate from the input connector"
    annotation(Evaluate=true, HideResult=true);

  parameter Modelica.Units.SI.MassFlowRate prescribed_m_flow
    "Fixed value of prescribed mass flow rate"
    annotation (Dialog(enable = not use_m_flow_in));

  Modelica.Blocks.Interfaces.RealInput m_flow_in(final unit="kg/s") if use_m_flow_in
    "Prescribed heat flow rate connector"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));

protected
  Modelica.Blocks.Interfaces.RealInput Q_in_internal(final unit="W")
    "Needed to connect to conditional connector";

  Modelica.Blocks.Interfaces.RealInput m_flow_in_internal(final unit="kg/s")
    "Needed to connect to conditional connector";

public
  replaceable HeatTransfer.PartialHeatTransfer heatTransfer(redeclare package
      Medium =         Medium, use_Q_in=use_Q_in)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  replaceable FlowControl.PartialFlowControl flowControl(redeclare package
      Medium =         Medium, use_m_flow_in=use_m_flow_in)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(Q_in, Q_in_internal);
  if not use_Q_in then
    Q_in_internal = prescribedQ;
  /*  heatTransfer.prescribedQ = prescribedQ;
  else
    connect(heatTransfer.Q_in, Q_in_internal);*/
  end if;

  connect(m_flow_in, m_flow_in_internal);
  if not use_m_flow_in then
    m_flow_in_internal = prescribed_m_flow;
    /*flowControl.prescribed_m_flow = prescribed_m_flow;
  else
    connect(flowControl.m_flow_in, m_flow_in_internal);*/
  end if;

  connect(port_a, flowControl.port_a)
    annotation (Line(points={{-100,0},{-40,0}}, color={0,127,255}));
  connect(flowControl.port_b, heatTransfer.port_a)
    annotation (Line(points={{-20,0},{40,0}}, color={0,127,255}));
  connect(heatTransfer.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,40},{-6,-42}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,40},{84,-42}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  Base class for a substation model that uses replaceable components
  for modeling the heat transfer and the flow control parts.
</p>
</html>"));
end PartialSubstation;
