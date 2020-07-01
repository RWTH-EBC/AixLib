within AixLib.Utilities.HeatTransfer;
model HeatConvInside
  "Natural convection computation according to B. Glueck or EN ISO 6946, with choice between several types of surface orientation, or a constant convective heat transfer coefficient"
  /* calculation of natural convection in the inside of a building according to B.Glueck, EN ISO 6946 or using a constant convective heat transfer coefficient hCon_const
  */
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient" annotation (
    Dialog(descriptionLabel=true),
    choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      radioButtons=true),
    Evaluate=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon_const=2.5 "Custom convective heat transfer coefficient"
                                         annotation (Dialog(descriptionLabel=true,
        enable=if calcMethod == 3 then true else false));

  parameter Modelica.SIunits.TemperatureDifference dT_small = 1 "Linearized function around dT = 0 K +/-" annotation (Dialog(descriptionLabel=true,
        enable=if calcMethod == 1 then true else false));

  // which orientation of surface?
  parameter Integer surfaceOrientation "Surface orientation" annotation (
      Dialog(descriptionLabel=true, enable=if calcMethod == 3 then false else true),
      choices(
      choice=1 "vertical",
      choice=2 "horizontal facing up",
      choice=3 "horizontal facing down",
      radioButtons=true),
      Evaluate=true);
  parameter Modelica.SIunits.Area A(min=0) "Area of surface";
  Modelica.SIunits.CoefficientOfHeatTransfer hCon "variable heat transfer coefficient";

protected
  Modelica.SIunits.Temp_C posDiff=noEvent(abs(port_b.T - port_a.T))
    "Positive temperature difference";
equation

  /*
        port_b -> wall
        port_a -> air
  */

  // ++++++++++++++++EN ISO 6946 Appendix A >>Flat Surfaces<<++++++++++++++++
  // upward heat flow: hCon = 5, downward heat flow: hCon = 0.7, horizontal heat flow: hCon = 2.5
  if calcMethod == 1 then

    // floor (horizontal facing up)
    if surfaceOrientation == 2 then
      hCon = Modelica.Fluid.Utilities.regStep(
        x=port_b.T - port_a.T,
        y1=5,
        y2=0.7,
        x_small=dT_small);

    // ceiling (horizontal facing down)
    elseif surfaceOrientation == 3 then
      hCon = Modelica.Fluid.Utilities.regStep(
        x=port_b.T - port_a.T,
        y1=0.7,
        y2=5,
        x_small=dT_small);

    // vertical
    else
      hCon = 2.5;
    end if;

  // ++++++++++++++++Bernd Glueck++++++++++++++++
  // (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)
  // upward heat flow: hCon = 2*(posDiff^0.31)          - equation 1.27, page 26
  // downward heat flow: hCon = 0.54*(posDiff^0.31)     - equation 1.28, page 26
  // horizontal heat flow: hCon = 0.1.6*(posDiff^0.31)  - equation 1.26, page 26
  elseif calcMethod == 2 then

    // floor (horizontal facing up)
    if surfaceOrientation == 2 then
      hCon = smooth(2, noEvent(if port_b.T >= port_a.T then 2*(posDiff^0.31) else 0.54*(posDiff^0.31)));

    // ceiling (horizontal facing down)
    elseif surfaceOrientation == 3 then
      hCon = smooth(2, noEvent(if port_b.T >= port_a.T then 0.54*(posDiff^0.31) else 2*(posDiff^0.31)));

    // vertical plate
    else
      hCon = 1.6*(posDiff^0.3);
    end if;

  // ++++++++++++++++hCon_const++++++++++++++++
  else
    hCon = hCon_const;
  end if;

  port_a.Q_flow =hCon*A*(port_a.T - port_b.T);
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-80,60},{0,-100}},
          lineColor={0,255,255},
          fillColor={211,243,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
        Rectangle(
          extent={{60,60},{80,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,60},{60,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,60},{40,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={182,182,182},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,60},{20,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,60},{80,60},{60,20},{60,60},{80,60}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={157,166,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,60},{60,20},{40,-20},{40,60},{60,60}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={102,110,139},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,60},{40,-20},{20,-60},{20,60},{40,60}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={75,82,103},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,60},{20,-60},{0,-100},{0,60},{20,60}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={51,56,70},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-58,20},{-68,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-58,20},{-58,-60}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-40,20},{-50,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-40,20},{-40,-60}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-22,20},{-32,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-22,20},{-22,-60}},
          color={0,0,255},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{0,80},{20,-80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,80},{40,-80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={182,182,182},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,80},{60,-80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,80},{80,-80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,80},{0,-80}},
          lineColor={0,255,255},
          fillColor={211,243,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,80},{80,80},{60,40},{60,80},{80,80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={157,166,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,80},{60,40},{40,0},{40,80},{60,80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={102,110,139},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,80},{40,0},{20,-40},{20,80},{40,80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={75,82,103},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,80},{20,-40},{0,-80},{0,80},{20,80}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          lineThickness=0.5,
          fillColor={51,56,70},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,36},{-20,-44}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-20,36},{-30,24}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-38,36},{-48,24}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-54,36},{-64,24}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-38,36},{-38,-44}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-54,36},{-54,-44}},
          color={0,0,255},
          thickness=0.5),
        Rectangle(extent={{-80,80},{80,-80}},  lineColor={0,0,0})}),
    Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  The <b>HeatConvInside</b> model represents the phenomenon of heat
  convection at inside surfaces of walls, with different choice for
  surface orientation.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  In this model the surface orientation can be chosen from a menu for
  an easier adoption to new situations. Following methods to calculate
  the <b>heat convection coefficient</b> <code>hCon</code> can be
  chosen:
</p>
<ol>
  <li>EN ISO 6946: <code>hCon</code> depends on the direction of heat
  transfer (horizontal: <code>hCon</code>= 2.5 m^2 K/W, upwards: <code>
    hCon</code>= 5 m^2 K/W, downwards: <code>hCon</code>=0.7 m^2 K/W,
    EN ISO 6946 table C.1). Switching the heat convection coefficient
    due to a chance of direction of heat transfer would lead to a state
    event. This would force the solver to solve a totally changed
    equation system and extend the calculation time. Therefore the
    <code>regStep</code> function is used to get a continous and
    differenciable expression. If the temperature difference between
    <code>port_b</code> and <code>port_a</code> is between
    -<code>dT_small</code> and <code>dT_small</code> a 2nd order
    polynomial is used for a smooth transition from 5 to 0.7 (facing
    up) or from 0.7 to 5 (facing down).
  </li>
  <li>B. Glueck (default): The following equations are used to
  calculate the heat convection coefficient depending on the direction
  of heat transfer (p. 26):<br/>
    horizontal: <code>hCon = 1.6 * |port_b.T - port_a.T|^0.3</code><br/>
    upwards: <code>hCon = 2 * |port_b.T - port_a.T|^0.31</code><br/>
    downwards: <code>hCon = 0.54 * |port_b.T -
    port_a.T|^0.31</code><br/>
    The smooth function is used in case of changing direction of heat
    transfer.
  </li>
  <li>Constant heat convection coefficient: There is also the
  possibility of setting a constant <code>hCon</code> value
  (<code>hCon_const</code>).
  </li>
</ol>
<h4>
  <span style=\"color: #008000\">Limitations</span>
</h4>
<p>
  ... of the approaches calculating <code>hCon</code>:
</p>
<ul>
  <li>
    <b>EN ISO 6946</b> table C.1 specifies heat convection coefficients
    <b><span style=\"color: #ee2e2f;\">valid for internal or external
    surfaces next to highly ventilated air layers</span></b>. An air
    layer is considered as highly ventilated if the openings between
    air layer and the environment are at least 1.5 m^2 per m length for
    vertical air layers and 1.5 m^2 per m^2 surface for horizontal air
    layers (EN ISO 6946, 6.9.4). Thus, we recommend using the approach
    according to Glueck.
  </li>
  <li>The <b>approach according to Glueck combines free with forced
  convection</b>. Considering Figures 1.14, 1.15 and 1.16 from the
  cited reference the <b>approach is suitable for TSurface-TAir from
  -10 K to +30 K</b>.The surface length varies from 1 m to 3 m.
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>EN ISO 6946:2017 (D), appendix C. <i>Building components and
  building elements - Thermal resistance and thermal transmittance.</i>
  </li>
  <li>Bernd Glueck: <i>Heizen und Kühlen mit Niedrigexergie -
  Innovative Wärmeübertragung und Wärmespeicherung (LowEx) 2008.</i>
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">Example Results</span></b>
</p>
<p>
  <a href=
  \"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test</a>
</p>
<ul>
  <li>
    <i>May 30, 2019</i> by Katharina Brinkmann / Philipp Mehrfeld:<br/>
    <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/711\">#711</a>:<br/>
    - add smooth + noEvent functions<br/>
    - ISO approach now linearized when heat flow reverses (depending on
    newly introduced <code>dT_small</code>)<br/>
    - Approach acc. to Glueck can change heat flow during
    simulation.<br/>
    - Standard Calculation Method now \"Glueck\" due to faster simulation
    speed
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Tobias Blacha:<br/>
    Algorithm for HeatConv_inside is now selectable via parameters
  </li>
  <li>
    <i>June 17, 2015&#160;</i> by Philipp Mehrfeld:<br/>
    Added EN ISO 6946 equations and corrected usage of constant
    hCon_const
  </li>
  <li>
    <i>March 26, 2015&#160;</i> by Ana Constantin:<br/>
    Changed equations for differnet surface orientations according to
    newer work from Glück
  </li>
  <li>
    <i>April 1, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl<br/>
    Formatted documentation according to standards
  </li>
  <li>
    <i>December 15, 2005&#160;</i> by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HeatConvInside;
