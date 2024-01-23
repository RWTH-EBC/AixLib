within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Sinks;
model Sink "Simple sink model"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
    parameter Boolean isSource = false "For application as source enable true";
  /* *******************************************************************
      Components
      ******************************************************************* */

  FastHVAC.BaseClasses.WorkingFluid fluid(
    T0(start=333.15),
    m_fluid=1,
    medium=medium)
    annotation (Placement(transformation(extent={{-24,-20},{16,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                varHeatFlow
    annotation (Placement(transformation(extent={{34,34},{6,62}})));
  Modelica.Blocks.Interfaces.RealInput Load( unit="W")  annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,48}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-1,89})));
  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (
      Placement(transformation(extent={{-100,-10},{-80,10}}),
        iconTransformation(extent={{-100,-10},{-80,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (
      Placement(transformation(extent={{80,-10},{100,10}}),
        iconTransformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Math.Gain gain(k= (if isSource then 1 else -1))
                                  annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={54,48})));
equation
  connect(enthalpyPort_a1, fluid.enthalpyPort_a) annotation (Line(
      points={{-90,0},{-22,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(fluid.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
      points={{14,0},{90,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(varHeatFlow.port, fluid.heatPort) annotation (Line(
      points={{6,48},{-4,48},{-4,18.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gain.u, Load) annotation (Line(
      points={{63.6,48},{100,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varHeatFlow.Q_flow, gain.y) annotation (Line(
      points={{34,48},{45.2,48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={
       Rectangle(extent={{-80,80},{80,-80}},  lineColor={0,0,0}),
       Rectangle(extent={{-80,80},{80,-80}},  lineColor={0,0,0}),
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,128,255},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-68},{80,-80}},
          lineColor={0,127,0},
          lineThickness=1,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,26},{80,-68}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,26},{-22,26},{80,50},{80,26}},
          lineColor={255,85,85},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,62},{-42,34}},
          lineColor={255,255,0},
          lineThickness=1,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-38,44},{-26,34}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{-46,34},{-38,22}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{-56,30},{-56,16}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.None),
        Rectangle(
          extent={{2,26},{80,-60}},
          fillColor={127,0,127},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{44,2},{60,-10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{44,-10},{60,-22}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,-10},{44,-22}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,2},{44,-10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,-4},{-4,4}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          origin={45,18},
          rotation=180),
        Line(
          points={{-12,-24},{-18,-24}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1,
          origin={30,-2},
          rotation=180),
        Line(
          points={{-11,-37},{-11,-41},{-17,-41},{-17,-37}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1,
          origin={31,-15},
          rotation=180),
        Rectangle(
          extent={{42,26},{48,22}},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{54,-34},{72,-46}},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{55,-35},{71,-45}},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{54,-52},{58,-48},{68,-48},{72,-52},{54,-52}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{58,-51},{60,-49},{66,-49},{68,-51},{58,-51}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{20,-36},{26,-42}},
          lineColor={255,213,170},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{23,-39},{21,-37}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{25,-39},{23,-37}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{20,-39},{20,-39},{20,-39},{22,-41},{24,-41},{26,-39},{26,-39},
              {26,-39}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{19,-42},{27,-54}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
       Line(points={{-78,-32},{-78,-66}},
                                   color={0,0,0}),
       Line(points={{-80,-62},{-8,-62}},
                                   color={0,0,0}),
       Line(points={{-80,-34},{-78,-32}},
                                    color={0,0,0}),
       Line(points={{-76,-34},{-78,-32}},
                                    color={0,0,0}),
       Line(points={{-10,-60},{-8,-62}},
                                    color={0,0,0}),
       Line(points={{-10,-64},{-8,-62}},
                                    color={0,0,0}),
       Line(
         points={{-78,-48},{-66,-48},{-60,-38},{-46,-52},{-36,-44},{-30,-44},{
              -22,-50},{-16,-42}},
         color={255,0,0},
         thickness=0.5,
         smooth=Smooth.None),
          Text(
          extent={{-150,-72},{150,-112}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Sink model for variable heat flow. Can also be used as a source for
  variable heat flow
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The Sink model represents a variable heat flow sink, controlled by a
  real input port. This model possesses sink function as default, a
  source function can be chosen.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  Examples can be found in <a href=
  \"modelica:/AixLib.FastHVAC.Examples.Sinks.SinkSourceVesselTest\">SinkSourceVesselTest</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 16, 2014&#160;</i> Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>




"));
end Sink;
