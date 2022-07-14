within AixLib.Utilities.MassTransfer;
model MassDiffusion
  "Lumped element transporting mass without storing it"

  Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate from solid -> fluid";
  Modelica.Units.SI.PartialPressure dp "= solid.p - fluid.p";
  Modelica.Blocks.Interfaces.RealInput Gd(unit="m.m.m/(s.Pa)")
    "Signal representing the convective mass transfer coefficient in [m³/(s Pa)]"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  MassPort solid
    annotation (Placement(transformation(extent={{-118,-18},{-82,18}})));
  MassPort fluid
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));
protected
  constant Modelica.Units.SI.Density rho=1.21 "density of moist air";
equation
  dp = solid.p - fluid.p;
  solid.m_flow = m_flow;
  fluid.m_flow = -m_flow;
  m_flow = -Gd*rho*dp;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-90,70},{90,-70}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-90,70},{-90,-70}},
          thickness=0.5),
        Line(
          points={{90,70},{90,-70}},
          thickness=0.5),
        Text(
          extent={{-150,115},{150,75}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-150,-75},{150,-105}},
          textString="G=%G")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-80,0},{80,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-20},{100,-40}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-100,40},{100,20}},
          textString="dT = port_a.T - port_b.T")}),
    Documentation(info="<html><p>
  This is a model for transport of mass without storing it; It may be
  used for complicated geometries where the mass diffusion Gd is
  determined by measurements and is assumed to be constant over the
  range of operations. If the component consists mainly of one type of
  material and a regular geometry, it may be calculated, e.g., with one
  of the following equations:
</p>
<ul>
  <li>
    <p>
      Diffusion for a <strong>box</strong> geometry under the
      assumption that mass flows along the box length:
    </p>
    <pre>
    Gd = D*A/L
    D: Diffusifity (material constant)
    A: Area of box
    L: Length of box
    </pre>
  </li>
  <li>
    <p>
      Diffusion for a <strong>cylindrical</strong> geometry under the
      assumption that heat flows from the inside to the outside radius
      of the cylinder:
    </p>
    <pre>
    Gd = 2*pi*D*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    D    : Diffusivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
  </li>
</ul>
</html>", revisions="<html>
<ul>
  <li>November 20, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
</ul>
</html>"));
end MassDiffusion;
