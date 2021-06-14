within AixLib.Fluid.Movers.Compressors.SimpleCompressors.RotaryCompressors;
model RotaryCompressorPressureLosses
  "Model that describes a simple rotary compressor with pressure losses"
  extends BaseClasses.PartialCompressor(
    redeclare final model CompressionProcess =
    SimpleCompressors.CompressionProcesses.RotaryCompression,
    final simCom = Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses);

  // Definition of submodels and connectors
  //
  FixedResistances.HydraulicResistance hydResInl(
    redeclare final package Medium=Medium,
    final zeta=zetInl,
    final diameter=diameterInl,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearized,
    final dp_start=(1/40)*dp_start,
    final m_flow_start=m_flow_start)
    "Calculation of pressure drop at inlet of compressor"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  FixedResistances.HydraulicResistance hydResOut(
    redeclare final package Medium=Medium,
    final zeta=zetOut,
    final diameter=diameterOut,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearized,
    final dp_start=(1/40)*dp_start,
    final m_flow_start=m_flow_start)
    "Calculation of pressure drop at outlet of compressor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));


equation
  // Connections of main components
  //
  connect(port_a, hydResInl.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(hydResInl.port_b,comPro.port_a)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(comPro.port_b, hydResOut.port_a)
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
  connect(hydResOut.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));

  // Connection of further components
  //
  connect(comPro.heatPort, heatPort)
    annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));

  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,40},{20,-40}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,28},{20,-32}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-26,6},{-14,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,46},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{80,80},{-80,-80}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{74,-30},{-60,-52}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{74,30},{-58,54}},
                  color={0,0,0},
                  thickness=0.5),
        Ellipse(
          extent={{-60,40},{20,-40}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,28},{20,-32}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-26,6},{-14,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,46},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,6},{-64,-6}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Backward),
        Ellipse(
          extent={{-86,6},{-66,-6}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,6},{-64,8}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,-8},{-64,-6}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,6},{-80,2},{-78,-2},{-80,-6},{-74,-2},{-76,2},{-74,6}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{64,6},{88,-6}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Backward),
        Ellipse(
          extent={{66,6},{86,-6}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{64,6},{88,8}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{64,-8},{88,-6}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{78,6},{72,2},{74,-2},{72,-6},{78,-2},{76,2},{78,6}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>October 27, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of a simple rotary compressor that is used, for
  example, in close-loop systems like heat pumps or chillers. It
  inherits from PartialCompressor which inherits from
  PartialCompression. Therefore, please checkout these sub-models for
  further information of underlying modeling approaches and
  parameterisation:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>.
  </li>
</ul>
<p>
  For this model, pressure losses are assumed at inlet and outlet of
  the compressor. These pressure losses may occur due to reduction or
  enlargement of the cross-section.
</p>
</html>"));
end RotaryCompressorPressureLosses;
