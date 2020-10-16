within AixLib.Fluid.Interfaces;
partial model PartialFourPortVector
  "Partial component with four ports, two of which being vectorized"

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15,
          X_a=0.40)
          "Propylene glycol water, 40% mass fraction")));
  parameter Integer nPorts "Number of ports"
    annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b1[nPorts](
    redeclare each package Medium = Medium,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{90,20},{110,100}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b2[nPorts](
    redeclare each package Medium = Medium,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-20}})));

  // Diagnostics
   parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  Medium.ThermodynamicState sta_a1=Medium.setState_phX(
      port_a1.p,
      noEvent(actualStream(port_a1.h_outflow)),
      noEvent(actualStream(port_a1.Xi_outflow))) if show_T
    "Medium properties in port_a";

  Medium.ThermodynamicState sta_b1[nPorts]=Medium.setState_phX(
      ports_b1.p,
      noEvent(actualStream(ports_b1.h_outflow)),
      noEvent(actualStream(ports_b1.Xi_outflow))) if show_T
    "Medium properties in ports_b";
  Medium.ThermodynamicState sta_a2=Medium.setState_phX(
      port_a2.p,
      noEvent(actualStream(port_a2.h_outflow)),
      noEvent(actualStream(port_a2.Xi_outflow))) if show_T
    "Medium properties in port_a";

  Medium.ThermodynamicState sta_b2[nPorts]=Medium.setState_phX(
      ports_b2.p,
      noEvent(actualStream(ports_b2.h_outflow)),
      noEvent(actualStream(ports_b2.Xi_outflow))) if show_T
    "Medium properties in ports_b";
  annotation (
    Documentation(info="<html><p>
  This partial model defines an interface for components with two
  ports, of which one is vectorized.
</p>
<p>
  The treatment of the design flow direction and of flow reversal are
  determined based on the parameter <code>allowFlowReversal</code>. The
  component may transport fluid and may have internal storage.
</p>
<h4>
  Implementation
</h4>
<p>
  This model is similar to <a href=
  \"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">Modelica.Fluid.Interfaces.PartialTwoPort</a>
  but it does not use the <code>outer system</code> declaration. This
  declaration is omitted as in building energy simulation, many models
  use multiple media, and in practice, users have not used this global
  definition to assign parameters.
</p>
<ul>
  <li>January 31, 2019, by Michael Mans:<br/>
    Added optional temperature state calculation as diagnostics option.
    See <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1092\">#1092</a>.
  </li>
  <li>January 18, 2019, by Jianjun Hu:<br/>
    Limited the media choice. See <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
  </li>
  <li>July 8, 2018, by Filip Jorissen:<br/>
    Added nominal value of <code>h_outflow</code> in
    <code>FluidPorts</code>. See <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/977\">#977</a>.
  </li>
  <li>November 19, 2015, by Michael Wetter:<br/>
    Removed parameters <code>port_a_exposesState</code> and
    <code>port_b_exposesState</code> for <a href=
    \"https://github.com/ibpsa/modelica/issues/351\">#351</a> and
    <code>showDesignFlowDirection</code> for <a href=
    \"https://github.com/ibpsa/modelica/issues/349\">#349</a>.
  </li>
  <li>November 13, 2015, by Michael Wetter:<br/>
    Assinged <code>start</code> attribute for leaving enthalpy at
    <code>port_a</code> and <code>port_b</code>. This was done to make
    the model similar to <a href=
    \"modelica://AixLib.Fluid.Interfaces.PartialFourPort\">AixLib.Fluid.Interfaces.PartialFourPort</a>.
  </li>
  <li>November 12, 2015, by Michael Wetter:<br/>
    Removed import statement.
  </li>
  <li>October 21, 2014, by Michael Wetter:<br/>
    Revised implementation. Declared medium in ports to be
    <code>final</code>.
  </li>
  <li>October 20, 2014, by Filip Jorisson:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Text(
          extent={{-149,-114},{151,-154}},
          lineColor={0,0,255},
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end PartialFourPortVector;
