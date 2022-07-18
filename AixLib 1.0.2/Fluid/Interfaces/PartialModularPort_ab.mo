within AixLib.Fluid.Interfaces;
partial model PartialModularPort_ab
  "Base model for all modular models with multiple inlet and outlet ports"

  // Definition of the medium model
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
    annotation (choicesAllMatching = true);

  // Definition of parameters describing modular approach
  //
  parameter Integer nPorts = 1
    "Number of inlet and outlet ports"
    annotation(Dialog(group="Modular approach"));

  // Definition of parameters describing assumptions
  //
  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);

  // Definition of parameters describing initialisation and numeric limits
  //
  parameter Medium.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab = "Advanced",group="Numeric limitations"));
  parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced",group="Numeric limitations"));

  // Definition of connectors
  //
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a[nPorts](
    redeclare final package Medium = Medium,
     m_flow(each min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(each start = Medium.h_default))
    "Fluid connectors a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](
    redeclare each final package Medium = Medium,
    m_flow(each max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(each start = Medium.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,40},{110,-40}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-100,140},{100,100}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This component transports fluid between its multiple inlet and outlet
  ports, without storing mass or energy. Energy may be exchanged with
  the environment though, for example, in the form of work.
  <code>PartialModularPort_a</code> is intended as base class for
  devices like modular sensors that are used, for example, in modular
  heat pumps.
</p>
<p>
  Three equations need to be added by an extending class using this
  component:
</p>
<ul>
  <li>The momentum balance specifying the relationship between the
  pressure drops <code>dp_i</code> and the mass flow rates
  <code>m_flow_i</code> if these variables are introduced by the
  modeller
  </li>
  <li>
    <code>port_b.h_outflow_i</code> for flow in design direction.
  </li>
  <li>
    <code>port_a.h_outflow_i</code> for flow in reverse direction.
  </li>
</ul>
<p>
  Moreover, appropriate values shall be assigned to the following
  parameters:
</p>
<ul>
  <li>
    <code>dp_start</code> for a guess of the pressure drop
  </li>
  <li>
    <code>m_flow_small</code> for regularization of zero flow.
  </li>
  <li>
    <code>dp_nominal</code> for nominal pressure drop.
  </li>
  <li>
    <code>m_flow_nominal</code> for nominal mass flow rate.
  </li>
</ul>
</html>"));
end PartialModularPort_ab;
