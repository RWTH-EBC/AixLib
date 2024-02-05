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

  Interfaces.PassThroughMedium passThroughMedium2
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
  Interfaces.PassThroughMedium passThroughMedium1 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={56,-30})));
  Interfaces.PassThroughMedium passThroughMedium
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
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

protected
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-24,-4},{-16,4}}),
        iconTransformation(extent={{-24,-4},{-16,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-76,-4},{-84,4}}),
        iconTransformation(extent={{-76,-4},{-84,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}),
        iconTransformation(extent={{-76,-4},{-84,4}})));
protected
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-4,-64},{4,-56}}),
        iconTransformation(extent={{-24,-4},{-16,4}})));
protected
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-84,-64},{-76,-56}}),
        iconTransformation(extent={{-24,-4},{-16,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-16,-64},{-24,-56}}),
        iconTransformation(extent={{-76,-4},{-84,4}})));
equation
  connect(port_a, port_b1) annotation (Line(
      points={{-100,0},{-80,0}},
      color={0,127,255},
      thickness=1));
  connect(port_a1, port_b2) annotation (Line(
      points={{-20,0},{0,0}},
      color={0,127,255},
      thickness=1));
  connect(port_a2, port_b3) annotation (Line(
      points={{0,-60},{-20,-60}},
      color={0,127,255},
      thickness=1));
  connect(port_a3, port_b) annotation (Line(
      points={{-80,-60},{-100,-60}},
      color={0,127,255},
      thickness=1));
  connect(port_b3, passThroughMedium2.port_a)
    annotation (Line(points={{-20,-60},{-40,-60}}, color={0,127,255}));
  connect(passThroughMedium2.port_b, port_a3)
    annotation (Line(points={{-60,-60},{-80,-60}}, color={0,127,255}));
  connect(port_b2, passThroughMedium1.port_a)
    annotation (Line(points={{0,0},{56,0},{56,-20}}, color={0,127,255}));
  connect(passThroughMedium1.port_b, port_a2)
    annotation (Line(points={{56,-40},{56,-60},{0,-60}}, color={0,127,255}));
  connect(port_b1, passThroughMedium.port_b)
    annotation (Line(points={{-80,0},{-60,0}}, color={0,127,255}));
  connect(passThroughMedium.port_a, port_a1) annotation (Line(points={{-40,0},{
          -32,0},{-32,0},{-20,0}}, color={0,127,255}));
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
          extent={{-80,20},{-20,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,-24},{-36,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Flow Control"),
        Rectangle(
          extent={{0,40},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{74,40},{100,28}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HVAC"),
        Rectangle(
          extent={{-100,100},{100,40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-12,102},{14,90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Inputs")}),
    Documentation(revisions="<html>
<ul>
<li>
June 18, 2017, by Marcus Fuchs:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>", info="<html>
<p>Base class for a substation model that uses replaceable components
for modeling the heat transfer and the flow control parts.</p>
</html>"));
end PartialGeneralSubstation;
