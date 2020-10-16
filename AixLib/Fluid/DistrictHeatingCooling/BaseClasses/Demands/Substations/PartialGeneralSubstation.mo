within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.Substations;
partial model PartialGeneralSubstation
  "Base class for a DHC substation model"
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

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

protected
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default, nominal = Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default, nominal = Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-70},{-110,-50}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-110,70},{-90,50}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-110,-50},{-90,-70}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,40},{40,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-12,42},{14,30}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Flow Control"),
        Rectangle(
          extent={{-80,-20},{80,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,-22},{16,-34}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HVAC"),
        Rectangle(
          extent={{-100,100},{100,50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-12,102},{14,90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Inputs"),
        Line(
          points={{-98,0},{-40,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-98,-60},{-80,-60}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{40,0},{92,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{92,0},{92,-60}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{80,-60},{92,-60}},
          color={0,0,255},
          thickness=1)}),
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
end PartialGeneralSubstation;
