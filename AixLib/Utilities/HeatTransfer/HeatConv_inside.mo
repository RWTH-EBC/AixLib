within AixLib.Utilities.HeatTransfer;
model HeatConv_inside
  "Natural convection computation according to B. Glueck or EN ISO 6946, with choice between several types of surface orientation, or a constant convective heat transfer coefficient"
  /* calculation of natural convection in the inside of a building according to B.Glueck, EN ISO 6946 or using a constant convective heat transfer coefficient alpha_custom
  */
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  parameter Integer calcMethod=1 "Calculation Method" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Constant alpha",
      radioButtons=true));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 2.5
    "Constant heat transfer coefficient" annotation (Dialog(descriptionLabel=true,
        enable=if calcMethod == 3 then true else false));


  // which orientation of surface?
  parameter Integer surfaceOrientation=1 "Surface orientation" annotation (
      Dialog(descriptionLabel=true, enable=if calcMethod == 3 then false else true),
      choices(
      choice=1 "vertical",
      choice=2 "horizontal facing up",
      choice=3 "horizontal facing down",
      radioButtons=true));
  parameter Modelica.SIunits.Area A=16 "Area of surface";
  Modelica.SIunits.CoefficientOfHeatTransfer alpha
    "variable heat transfer coefficient";

protected
  Modelica.SIunits.Temp_C posDiff=noEvent(abs(port_b.T - port_a.T))
    "Positive temperature difference";
equation

  /*
        port_b -> wall
        port_a -> air
  */

  // ++++++++++++++++EN ISO 6946 Appendix A >>Flat Surfaces<<++++++++++++++++
  if calcMethod == 1 then
    if surfaceOrientation == 2 then
      // upward heat flow
      if port_b.T >= port_a.T then
        alpha = 5;
        // downward heat flow
      else
        alpha = 0.7;
      end if;
    elseif surfaceOrientation == 3 then
      // downward heat flow
      if port_b.T >= port_a.T then
        alpha = 0.7;
        // upward heat flow
      else
        alpha = 5;
      end if;
    else
      alpha = 2.5;
    end if;
  // ++++++++++++++++Bernd Glueck++++++++++++++++
  elseif calcMethod == 2 then

    // top side of horizontal plate
// ------------------------------------------------------
  if surfaceOrientation == 2 then
      alpha = 2*(posDiff^0.31);  // equation 1.27, page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)

// down side of horizontal plate
// ------------------------------------------------------

  else
    if surfaceOrientation == 3 then
       alpha = 0.54*(posDiff^0.31);  //equation 1.28, page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)

// vertical plate
//-------------------------------------------------
    else
      alpha = 1.6*(posDiff^0.3);  // equation 1.26 page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)
    end if;
  end if;
  // ++++++++++++++++alpha_custom++++++++++++++++
  else
    // if calcMethod == 3 then
    alpha = alpha_custom;
    // end if;
  end if;

  port_a.Q_flow = alpha*A*(port_a.T - port_b.T);
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
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>HeatConv_inside</b> model represents the phenomenon of heat convection at inside surfaces, with different choice for surface orientation. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>In this model the orientation of the surface can be chosen from a menu for an easier adoption to new situations. This allows calculating <code>alpha</code> depending on orientation and respective direction of heat flow. The equations for <code>alpha</code> are taken from EN ISO 6946 (appendix A.1) and B. Glueck. </p>
<p>The model can in this way be used on inside surfaces. There is also the possibility of setting a constant alpha value.</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<ul>
<li>EN ISO 6946:2008-04, appendix A. Building components and building elements - Thermal resistance and thermal transmittance.</li>
<li>Bernd Glueck:<i> Heizen und K&uuml;hlen mit Niedrigexergie - Innovative W&auml;rme&uuml;bertragung und W&auml;rmespeicherung (LowEx) 2008.</i> </li>
</ul>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test </a></p>
</html>",  revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters</li>
<li><i>June 17, 2015&nbsp;</i> by Philipp Mehrfeld:<br/>Added EN ISO 6946 equations and corrected usage of constant alpha_custom </li>
<li><i>March 26, 2015&nbsp;</i> by Ana Constantin:<br/>Changed equations for differnet surface orientations according to newer work from Gl&uuml;ck </li>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions </li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl<br/>Formatted documentation according to standards </li>
<li><i>December 15, 2005&nbsp;</i> by Peter Matthes:<br/>Implemented. </li>
</ul>
</html>"));
end HeatConv_inside;
