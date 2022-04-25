within AixLib.Fluid.Movers.Compressors.SimpleCompressors.RotaryCompressors;
model RotaryCompressorPressureHeatLosses
  "Model that describes a simple rotary compressor with pressure and heat losses"
  extends BaseClasses.PartialCompressor(
    redeclare final model CompressionProcess =
    SimpleCompressors.CompressionProcesses.RotaryCompression,
    final simCom = Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses);
  extends Modelica.Icons.UnderConstruction;

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

  Utilities.HeatTransfer.SimpleHeatTransfer heaTraInl(
    redeclare final package Medium=Medium,
    final allowFlowReversal=allowFlowReversal,
    final show_T=show_T,
    final show_V_flow=show_V_flow,
    final heaTraMod=heaTraMod,
    final kAMea=kAMeaInl,
    final m_flow_nominal=m_flow_nominal)
    "Model to calculate heat transfer at inlet of compressor"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

  Utilities.HeatTransfer.SimpleHeatTransfer heaTraOut(
    redeclare final package Medium=Medium,
    final allowFlowReversal=allowFlowReversal,
    final show_T=show_T,
    final show_V_flow=show_V_flow,
    final heaTraMod=heaTraMod,
    final kAMea=kAMeaOut,
    final m_flow_nominal=m_flow_nominal)
    "Model to calculate heat transfer at outlet of compressor"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
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

  Utilities.HeatTransfer.SimpleFictitiousWall ficWal(
    final mWal=mWal,
    final cpWal=cpWal,
    final kAMeaAmb=kAMeaAmb,
    final TWal0=TWal0,
    final iniTWal0=iniTWal0)
    "Simple fictitious wall to calculate heat losses at compressor's inlet
    and outlet"
    annotation (Placement(transformation(extent={{-40,-90},{40,-10}})));

equation
  // Connection of main components
  //
  connect(port_a, hydResInl.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(hydResInl.port_b, heaTraInl.port_a)
    annotation (Line(points={{-60,0},{-55,0},{-50,0}}, color={0,127,255}));
  connect(heaTraInl.port_b,comPro.port_a)
    annotation (Line(points={{-30,0},{-20,0},{-10,0}}, color={0,127,255}));
  connect(comPro.port_b, heaTraOut.port_a)
    annotation (Line(points={{10,0},{20,0},{30,0}}, color={0,127,255}));
  connect(heaTraOut.port_b, hydResOut.port_a)
    annotation (Line(points={{50,0},{55,0},{60,0}}, color={0,127,255}));
  connect(hydResOut.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));

  // Connection of heat ports
  //
  connect(heaTraInl.heatPort, ficWal.heaPorComInl)
    annotation (Line(points={{-40,-10},{-40,-10},{-40,-30},
                {-20,-30},{-20,-42}}, color={191,0,0}));
  connect(comPro.heatPort, ficWal.heaPorCom)
    annotation (Line(points={{0,-10},{0,-26},{0,-42},{0,-42}},
                color={191,0,0}));
  connect(heaTraOut.heatPort, ficWal.heaPorComOut)
    annotation (Line(points={{40,-10},{40,-30},{20,-30},{20,-42}},
                color={191,0,0}));
  connect(ficWal.heaPorAmb, heatPort)
    annotation (Line(points={{0,-58},{0,-100}}, color={191,0,0}));

  annotation (Icon(graphics={
                Ellipse(
                  extent={{80,80},{-80,-80}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
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
          fillPattern=FillPattern.Solid),
        Line(
          points={{-76,-8},{-76,-82},{0,-82},{0,-90}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.Filled,Arrow.Filled}),
        Line(
          points={{76,-8},{76,-82},{0,-82},{0,-90}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.Filled,Arrow.Filled})}),
                                            Documentation(revisions="<html><ul>
  <li>October 28, 2017, by Mirko Engelpracht:<br/>
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
  For this model, pressure and heat losses are assumed at inlet and
  outlet of the compressor. These pressure losses may occur due to
  reduction or enlargement of the cross-section and these heat losses
  may occure due to heat exchange with a fictitious wall that describes
  the shell of the compressor.
</p>
<h4>
  References
</h4>
<p>
  The modelling approach presented here is alligned to the modelling
  approaches presented in the literature:
</p>
<p>
  P. Byrne, R. Ghoubali and J. Miriel (2012): <a href=
  \"https://hal.archives-ouvertes.fr/hal-00719934/document\">Development
  of a scroll compressor model for propane</a> . In: <i>The 10th Gustav
  Lorentzen Conference</i>
</p>
</html>"));
end RotaryCompressorPressureHeatLosses;
