within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.Substations.FlowControl;
partial model PartialFlowControl
  "Base class for flow controlling components in DHC substations"
  extends Interfaces.PartialTwoPort;

  parameter Boolean use_m_flow_in = false
    "Get the prescribed heat flow rate from the input connector"
    annotation(Evaluate=true, HideResult=true);

  parameter Modelica.SIunits.MassFlowRate prescribed_m_flow
    "Fixed value of prescribed mass flow rate"
    annotation (Dialog(enable = not use_m_flow_in));

  Modelica.Blocks.Interfaces.RealInput m_flow_in(final unit="kg/s") if use_m_flow_in
    "Prescribed heat flow rate connector"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

protected
  Modelica.Blocks.Interfaces.RealInput m_flow_in_internal(final unit="kg/s")
    "Needed to connect to conditional connector";

equation
  connect(m_flow_in, m_flow_in_internal);
  if not use_m_flow_in then
    m_flow_in_internal = prescribed_m_flow;
  end if;

  annotation (Documentation(info="<html><p>
  A base class for modeling the flow control component within DHC
  substations.
</p>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialFlowControl;
