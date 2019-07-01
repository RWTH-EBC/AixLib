within AixLib.Utilities.HeatTransfer;
model HeatConvInside
  "Natural convection computation according to B. Glueck or EN ISO 6946, with choice between several types of surface orientation, or a constant convective heat transfer coefficient"
  /* calculation of natural convection in the inside of a building according to B.Glueck, EN ISO 6946 or using a constant convective heat transfer coefficient hConvCustom
  */
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  parameter Integer calcMethodHConv=2 "Calculation Method"
                                                      annotation (Dialog(
        descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Constant hConv",
      radioButtons=true),
      Evaluate=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConvCustom=2.5 "Constant heat transfer coefficient"
                                         annotation (Dialog(descriptionLabel=true,
        enable=if calcMethodHConv == 3 then true else false));

  parameter Modelica.SIunits.TemperatureDifference dT_small = 1 "Linearized function around dT = 0 K +/-" annotation (Dialog(descriptionLabel=true,
        enable=if calcMethodHConv == 1 then true else false));

  // which orientation of surface?
  parameter Integer surfaceOrientation "Surface orientation" annotation (
      Dialog(descriptionLabel=true, enable=if calcMethodHConv == 3 then false else true),
      choices(
      choice=1 "vertical",
      choice=2 "horizontal facing up",
      choice=3 "horizontal facing down",
      radioButtons=true),
      Evaluate=true);
  parameter Modelica.SIunits.Area A(min=0) "Area of surface";
  Modelica.SIunits.CoefficientOfHeatTransfer hConv "variable heat transfer coefficient";

protected
  Modelica.SIunits.Temp_C posDiff=noEvent(abs(port_b.T - port_a.T))
    "Positive temperature difference";
equation

  /*
        port_b -> wall
        port_a -> air
  */

  // ++++++++++++++++EN ISO 6946 Appendix A >>Flat Surfaces<<++++++++++++++++
  // upward heat flow: hConv = 5, downward heat flow: hConv = 0.7, horizontal heat flow: hConv = 2.5
  if calcMethodHConv == 1 then

    // floor (horizontal facing up)
    if surfaceOrientation == 2 then
      hConv = Modelica.Fluid.Utilities.regStep(x=port_b.T - port_a.T,
        y1=5,
        y2=0.7,
        x_small=dT_small);

    // ceiling (horizontal facing down)
    elseif surfaceOrientation == 3 then
      hConv = Modelica.Fluid.Utilities.regStep(x=port_b.T - port_a.T,
        y1=0.7,
        y2=5,
        x_small=dT_small);

    // vertical
    else
      hConv = 2.5;
    end if;

  // ++++++++++++++++Bernd Glueck++++++++++++++++
  // (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)
  // upward heat flow: hConv = 2*(posDiff^0.31)          - equation 1.27, page 26
  // downward heat flow: hConv = 0.54*(posDiff^0.31)     - equation 1.28, page 26
  // horizontal heat flow: hConv = 0.1.6*(posDiff^0.31)  - equation 1.26, page 26
  elseif calcMethodHConv == 2 then

    // floor (horizontal facing up)
    if surfaceOrientation == 2 then
      hConv = smooth(2, noEvent(if port_b.T >= port_a.T then 2*(posDiff^0.31) else 0.54*(posDiff^0.31)));

    // ceiling (horizontal facing down)
    elseif surfaceOrientation == 3 then
      hConv = smooth(2, noEvent(if port_b.T >= port_a.T then 0.54*(posDiff^0.31) else 2*(posDiff^0.31)));

    // vertical plate
    else
      hConv = 1.6*(posDiff^0.3);
    end if;

  // ++++++++++++++++hConvCustom++++++++++++++++
  else
    hConv =hConvCustom;
  end if;

  port_a.Q_flow =hConv *A*(port_a.T - port_b.T);
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
          extent={{0,60},{20,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,60},{40,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={182,182,182},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,60},{60,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,60},{80,-100}},
          lineColor={0,0,255},
          pattern = LinePattern.None,
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{0,-100}},
          lineColor={0,255,255},
          fillColor={211,243,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
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
          points={{-20,16},{-20,-64}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-20,16},{-30,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-38,16},{-48,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-54,16},{-64,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-38,16},{-38,-64}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-54,16},{-54,-64}},
          color={0,0,255},
          thickness=0.5)}),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The <b>HeatConvInside</b> model represents the phenomenon of heat convection at inside surfaces of walls, with different choice for surface orientation. </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>In this model the surface orientation can be chosen from a menu for an easier adoption to new situations. Following methods to calculate the<b> heat convection coefficient </b><span style=\"font-family: Courier New;\">hConv</span> can be chosen:</p>
<ol>
<li>EN ISO 6946: <span style=\"font-family: Courier New;\">hConv</span> depends on the direction of heat transfer (horizontal: <span style=\"font-family: Courier New;\">hConv</span>= 2.5 m^2 K/W, upwards: <span style=\"font-family: Courier New;\">hConv</span>= 5 m^2 K/W, downwards: <span style=\"font-family: Courier New;\">hConv</span>=0.7 m^2 K/W, EN ISO 6946 table C.1). Switching the heat convection coefficient due to a chance of direction of heat transfer would lead to a state event. This would force the solver to solve a totally changed equation system and extend the calculation time. Therefore the <span style=\"font-family: Courier New;\">regStep</span> function is used to get a continous and differenciable expression. If the temperature difference between<span style=\"font-family: Courier New;\"> port_b</span> and <span style=\"font-family: Courier New;\">port_a</span> is between -<span style=\"font-family: Courier New;\">dT_small</span> and <span style=\"font-family: Courier New;\">dT_small</span> a 2nd order polynomial is used for a smooth transition from 5 to 0.7 (facing up) or from 0.7 to 5 (facing down).</li>
<li>B. Glueck (default): The following equations are used to calculate the heat convection coefficient depending on the direction of heat transfer (p. 26):<br />
horizontal: <span style=\"font-family: Courier New;\">hConv = 1.6 * |port_b.T - port_a.T|^0.3</span><br />
upwards: <span style=\"font-family: Courier New;\">hConv = 2 * |port_b.T - port_a.T|^0.31</span><br />
downwards: <span style=\"font-family: Courier New;\">hConv = 0.54 * |port_b.T - port_a.T|^0.31</span><br />
The smooth function is used in case of changing direction of heat transfer.</li>
<li>Constant heat convection coefficient: There is also the possibility of setting a constant<span style=\"font-family: Courier New;\"> hConv</span> value (<span style=\"font-family: Courier New;\">hConvCustom</span>).</li>
</ol>
<p>Limitations of the approaches calculating <span style=\"font-family: Courier New;\">hConv</span>:</p>
<ul>
<li>EN ISO 6946 table C.1 specifies heat convection coefficients valid for internal or external surfaces next to highly ventilated air layers. An air layer is considered as highly ventilated if the openings between air layer and the environment are at least 1,500 m^2 per m length for vertical air layers and 1,500 m^2 per m^2 surface for horizontal air layers (EN ISO 6946, 6.9.4). Thus we recommend using the approach according to Glueck.</li>
<li>The approach according to Glueck combines free with forced convection. Considering Figures 1.14, 1.15 and 1.16 from the cited reference the approach is suitable for TSurface-TAir from -10 K to +30 K.The surface length varies from 1 m to 3 m.</li>
</ul>
<p><b><span style=\"color: #008000;\">References</span></b> </p>
<ul>
<li>EN ISO 6946:2017 (D), appendix C. <i>Building components and building elements - Thermal resistance and thermal transmittance.</i></li>
<li>Bernd Glueck:<i> Heizen und K&uuml;hlen mit Niedrigexergie - Innovative W&auml;rme&uuml;bertragung und W&auml;rmespeicherung (LowEx) 2008.</i> </li>
</ul>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test </a></p>
</html>",  revisions="<html>
<ul>
<li><i>May 30, 2019</i>  by Katharina Brinkmann / Philipp Mehrfeld:<br/>
<a href=\"https://github.com/RWTH-EBC/AixLib/issues/711\">#711</a>:<br/>
- add smooth + noEvent functions<br/>
- ISO approach now linearized when heat flow reverses (depending on newly introduced <span style=\"font-family: Courier New;\">dT_small</span>)<br/>
- Approach acc. to Glueck can change heat flow during simulation.<br/>
- Standard Calculation Method now &quot;Glueck&quot; due to faster simulation speed</li>
<li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>
Algorithm for HeatConv_inside is now selectable via parameters</li>
<li><i>June 17, 2015&nbsp;</i> by Philipp Mehrfeld:<br/>
Added EN ISO 6946 equations and corrected usage of constant hConvCustom </li>
<li><i>March 26, 2015&nbsp;</i> by Ana Constantin:<br/>
Changed equations for differnet surface orientations according to newer work from Gl&uuml;ck </li>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL and respects the naming conventions </li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl<br/>
Formatted documentation according to standards </li>
<li><i>December 15, 2005&nbsp;</i> by Peter Matthes:<br/>
Implemented. </li>
</ul>
</html>"));
end HeatConvInside;
