within AixLib.Utilities;
package HeatTransfer "Models for different types of heat transfer"
  extends Modelica.Icons.Package;

    model HeatConv
      extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha=2;
      parameter Modelica.SIunits.Area A=16;
    equation

      // no storage of heat
      port_a.Q_flow = alpha*A*(port_a.T - port_b.T);

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}),
                Rectangle(extent=[-80, 60; 0, -100], style(
              color=0,
              rgbcolor={0,0,0},
              pattern=0,
              fillColor=31,
              rgbfillColor={211,243,255},
              fillPattern=1))=
                             {{-80,70},{80,-90}},
             Rectangle(extent=[-80,60; 80,-100],   style(color=0)),
             Rectangle(extent=[60,60; 80,-100], style(
              pattern=0,
              fillColor=7,
              rgbfillColor={244,244,244},
              fillPattern=1)),
             Rectangle(extent=[40,60; 60,-100], style(
              pattern=0,
              fillColor=30,
              rgbfillColor={207,207,207},
              fillPattern=1)),
             Rectangle(extent=[20,60; 40,-100], style(
              pattern=0,
              fillColor=8,
              rgbfillColor={182,182,182},
              fillPattern=1)),
             Rectangle(extent=[0,60; 20,-100], style(
              pattern=0,
              fillColor=9,
              rgbfillColor={156,156,156},
              fillPattern=1)),
          graphics,
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid,      lineColor={0,0,0},
            Rectangle[
              extent]=
                     {{60,70},{80,-90}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={244,244,244},
              fillPattern=FillPattern.Solid,
            Rectangle[
              extent]=
                     {{40,70},{60,-90}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={207,207,207},
              fillPattern=FillPattern.Solid,
            Rectangle[
              extent]=
                     {{20,70},{40,-90}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={182,182,182},
              fillPattern=FillPattern.Solid,
            Rectangle[
              extent]=
                     {{0,70},{20,-90}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
        Icon(Rectangle(extent=[-80, 60; 0, -100], style(
              pattern=0,
              fillColor=31,
              rgbfillColor={211,243,255},
              fillPattern=1)),
             Rectangle(extent=[60,60; 80,-100], style(
              pattern=0,
              fillColor=7,
              rgbfillColor={244,244,244},
              fillPattern=1)),
             Rectangle(extent=[40,60; 60,-100], style(
              pattern=0,
              fillColor=30,
              rgbfillColor={207,207,207},
              fillPattern=1)),
             Rectangle(extent=[20,60; 40,-100], style(
              pattern=0,
              fillColor=8,
              rgbfillColor={182,182,182},
              fillPattern=1)),
             Rectangle(extent=[0,60; 20,-100], style(
              pattern=0,
              fillColor=9,
              rgbfillColor={156,156,156},
              fillPattern=1)),
          graphics={
            Rectangle(
              extent={{-76,80},{4,-80}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid),
            Rectangle(extent={{-76,80},{84,-80}}, lineColor={0,0,0}),
            Rectangle(
              extent={{64,80},{84,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={244,244,244},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{44,80},{64,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={207,207,207},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{24,80},{44,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={182,182,182},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{4,80},{24,-80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid)}),
        Window(
          x=0.25,
          y=0.38,
          width=0.6,
          height=0.6),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>HeatConv</b> model represents the phenomenon of heat convection. No heat is stored.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.HeatTransfer_test </a></p>
</html>", revisions="<html>
<p><ul>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
</ul></p>
<p><ul>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation and formatted appropriately</li>
</ul></p>
</html>"));
    end HeatConv;

    class HeatConv_inside
    "Natural convection computation according to B. Glueck, choice between several types of surface orientation, or constant factor"
    /* calculation of natural convection in the inside of a building according to B.Glueck- Waermeuebertragung, 
   Waermeabgabe von Raumheizflaechen und Rohren
*/
      extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

      parameter Boolean IsAlphaConstant = false "Use a constant alpha?" annotation (Dialog(descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom
      "Constant heat transfer coefficient"                                                                   annotation(Dialog(descriptionLabel = true, enable = IsAlphaConstant));

      // which orientation of surface?
      parameter Integer surfaceOrientation = 1 "Surface orientation"
                     annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice=1
          "vertical",                                                                                                  choice = 2
          "horizontal facing up",                                                                                                  choice = 3
          "horizontal facing down",                                                                                                  radioButtons = true));

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
    // top side of horizontal plate
    // ------------------------------------------------------
      if surfaceOrientation == 2 then
        // upward heat flow
        if noEvent(port_b.T > port_a.T) then
          //
          alpha = 2*(posDiff)^0.31;
        else
          // downward heatflux with function switch
          alpha = if noEvent(posDiff <= 0.0050474370) then 2*(posDiff)^0.31 else
                  1.08*(posDiff)^0.31;
        end if;
    // down side of horizontal plate
    // ------------------------------------------------------

      else
        if surfaceOrientation == 3 then
          if noEvent(port_b.T > port_a.T) then
          // downward heatflux
          alpha = if noEvent(posDiff <= 0.0050474370) then 2*(posDiff)^0.31 else
                  1.08*(posDiff)^0.31;
          else
            // upward heatflux
            alpha = 2*(posDiff)^0.31;
          end if;

    // vertical plate
    //-------------------------------------------------
        else
        /*
       at interior wall according to B. Glueck.
       Also check to prevent small fluctuations which often lead to illeagal functions calls as
       (small negative value)^exponent
 
        at interior wall according to B. Glueck: Waermeuebertragung - 
        Waermeabgabe von Raumheizflaechen und Rohren. 
    */
        alpha = if noEvent(posDiff <= 5e-12) then 0 else (1.6*noEvent(posDiff^
          0.3));
        end if;
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
              pattern=LinePattern.None,
              fillColor={244,244,244},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{40,60},{60,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={207,207,207},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,60},{40,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={182,182,182},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,60},{20,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{80,60},{80,60},{60,20},{60,60},{80,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={157,166,208},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,60},{60,20},{40,-20},{40,60},{60,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={102,110,139},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,60},{40,-20},{20,-60},{20,60},{40,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={75,82,103},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,60},{20,-60},{0,-100},{0,60},{20,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={51,56,70},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-58,20},{-68,8}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-58,20},{-58,-60}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-40,20},{-50,8}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-40,20},{-40,-60}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-22,20},{-32,8}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-22,20},{-22,-60}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None)}),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{0,60},{20,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,60},{40,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={182,182,182},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{40,60},{60,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={207,207,207},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{60,60},{80,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
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
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={157,166,208},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,60},{60,20},{40,-20},{40,60},{60,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={102,110,139},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,60},{40,-20},{20,-60},{20,60},{40,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={75,82,103},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,60},{20,-60},{0,-100},{0,60},{20,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              smooth=Smooth.None,
              fillColor={51,56,70},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,16},{-20,-64}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-20,16},{-30,4}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-38,16},{-48,4}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-54,16},{-64,4}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-38,16},{-38,-64}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-54,16},{-54,-64}},
              color={0,0,255},
              thickness=0.5,
              smooth=Smooth.None)}),
        Window(
          x=0.25,
          y=0.38,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>HeatConv_choice</b> model represents the phenomenon of heat convection at inside surfaces, with different choice for surface orientation.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>In this model the orientation of the surface can be chosen from a menu for an easier adoption to new situations. This allows to calculate <code>alpha</code> depending on orientation and respective direction of heat flow. The equations for <code>alpha</code> are mainly taken from B. Gl&uuml;ck.</p>
<p>The model can in this way be used on inside surfaces. There is also the possibility of setting a constant alpha value.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<ul>
<li>Bernd Gl&uuml;ck:<i> Thermische Bauteilaktivierung - Nutzen von Umweltenergie und Kapillarrohren. 1. Aufl., C.F. M&uuml;ller-Verlag 1999.</i> </li>
<li>EN ISO 6946 in case of an outside vertical surface. </li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test </a></p>
</html>", revisions="<html>
<p><ul>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
</ul></p>
<p><ul>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl<br/>Formatted documentation according to standards</li>
<li><i>December 15, 2005&nbsp;</i> by Peter Matthes:<br/>Implemented.</li>
</ul></p>
</html>"),
        DymolaStoredErrors);
    end HeatConv_inside;

  model HeatConv_outside
    "Model for heat transfer at outside surfaces. Choice between multiple models"
     extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
      parameter Integer Model =  1 "Model"
      annotation(Dialog(group = "Computational Models", compact = true, descriptionLabel = true), choices(choice=1
          "DIN 6946",                                                                                                  choice = 2
          "ASHRAE Fundamentals", choice = 3 "Custom alpha",radioButtons = true));

      parameter Modelica.SIunits.Area A=16 "Area of surface" annotation(Dialog(group = "Surface properties", descriptionLabel = true));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom=25
      "Custom alpha" annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable= Model == 3));
    parameter
      DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
      "Surface type" annotation (Dialog(
        group="Surface properties",
        descriptionLabel=true,
        enable=Model == 2), choicesAllMatching=true);

      // Variables
      Modelica.SIunits.CoefficientOfHeatTransfer alpha;

    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
                           annotation (Placement(transformation(extent={{-102,-82},
              {-82,-62}},      rotation=0), iconTransformation(extent={{-102,-82},
              {-82,-62}})));

  equation
    // Main equation of heat transfer
    port_a.Q_flow = alpha*A*(port_a.T - port_b.T);

    //Determine alpha
    if Model == 1 then
      alpha = (4 + 4*WindSpeedPort);
    elseif Model == 2 then
      alpha = surfaceType.D + surfaceType.E*WindSpeedPort + surfaceType.F*(WindSpeedPort^2);
    else
      alpha = alpha_custom;
    end if;

    // Dummy variable for WindSpeedPort
    if cardinality( WindSpeedPort) < 1 then
      WindSpeedPort = 0;
    end if;

    annotation (Icon(graphics={
          Rectangle(extent={{-80,70},{80,-90}},  lineColor={0,0,0}),
          Rectangle(
            extent={{0,70},{20,-90}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{20,70},{40,-90}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={182,182,182},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{40,70},{60,-90}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={207,207,207},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,70},{80,-90}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={244,244,244},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,70},{0,-90}},
            lineColor={255,255,255},
            fillColor={85,85,255},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-80,70},{80,-90}},  lineColor={0,0,0}),
          Polygon(
            points={{80,70},{80,70},{60,30},{60,70},{80,70}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={157,166,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{60,70},{60,30},{40,-10},{40,70},{60,70}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={102,110,139},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,70},{40,-10},{20,-50},{20,70},{40,70}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={75,82,103},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{20,70},{20,-50},{0,-90},{0,70},{20,70}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={51,56,70},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-20,26},{-20,-54}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-20,26},{-30,14}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-38,26},{-48,14}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-54,26},{-64,14}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-38,26},{-38,-54}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-54,26},{-54,-54}},
            color={255,255,255},
            thickness=0.5,
            smooth=Smooth.None)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>HeatTrasfer_Outside </b>is a model for the convective heat transfer at outside walls</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>It allows the choice between three different models:</p>
<ul>
<li>after DIN 6946: <img src=\"modelica://AixLib/Images/Equations/equation-235E6PDM.png\" alt=\"alfa = 4 + 4*v\"/> , where <b>alfa</b> is the heat transfer coefficent and <b>v</b> is the wind speed</li>
<li>after the ASHRAE Fundamentals Handbook from 1989, the way it is presented in EnergyPlus Engineering reference from 2011: <img src=\"modelica://AixLib/Images/Equations/equation-zygE8L9u.png\" alt=\"alfa = D + E*v + F*v^2\"/>, where<b> alfa</b> and <b>v</b> are as above and the coefficients <b>D, E, F</b> depend on the surface of the outer wall</li>
<li>with a custom constant <b>alfa</b> value</li>
</ul>
<h4><span style=\"color:#008000\">References</span></h4>
<ul>
<li>DIN 6946 p.20</li>
<li>ASHRAEHandbook1989, as cited in EnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test</a></p>
<p><a href=\"AixLib.Utilities.Examples.HeatConv_outside\">AixLib.Utilities.Examples.HeatConv_outside</a></p>
</html>", revisions="<html>
<p><ul>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
</ul></p>
<ul>
  <li><i>March 30, 2012&nbsp;</i>
         by Ana Constantin:<br>
         Implemented.</li>
</ul>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics));
  end HeatConv_outside;

  class SolarRadToHeat "Compute the heat flow caused by radiation on a surface"
    parameter Real coeff=0.6 "Weight coefficient";
   // parameter Modelica.SIunits.Area A=6 "Area of surface";
    parameter Real A = 10 "Area of surface";

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
        Placement(transformation(extent={{80,-30},{100,-10}}, rotation=0)));
    AixLib.Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
          transformation(extent={{-122,-40},{-80,0}}, rotation=0)));
  equation
    heatPort.Q_flow = -solarRad_in.I*A*coeff;

    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-80,60},{80,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-48,2},{-4,-42}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="I"),
          Text(
            extent={{4,0},{56,-44}},
            lineColor={0,0,0},
            textString="J"),
          Polygon(
            points={{-12,-24},{-12,-16},{10,-16},{10,-10},{22,-20},{10,-30},
                {10,-24},{-12,-24}},
            lineColor={0,0,0},
            smooth=Smooth.None)}),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-80,60},{80,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-58,0},{-14,-44}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="I"),
          Text(
            extent={{0,-2},{52,-46}},
            lineColor={0,0,0},
            textString="J"),
          Polygon(
            points={{-22,-24},{-22,-16},{0,-16},{0,-10},{12,-20},{0,-30},{0,-24},
                {-22,-24}},
            lineColor={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-100,100},{100,60}},
            lineColor={0,0,255},
            textString="%name")}),
      Window(
        x=0.29,
        y=0.14,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
The <b>RadCondAdapt</b> model computes a heat flow rate caused by the absorbance of radiation. The amount of radiation being transformed into a heat flow is controlled by a given coefficient.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>
",    revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Moved and Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
</ul>
</html>"));
  end SolarRadToHeat;

  model HeatToStar "Adaptor for approximative longwave radiation exchange"

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation (
        Placement(transformation(extent={{-102,-10},{-82,10}}, rotation=0)));
    AixLib.Utilities.Interfaces.Star Star annotation (Placement(transformation(extent={{81,
              -10},{101,10}}, rotation=0)));

    parameter Modelica.SIunits.Area A=12 "Area of radiation exchange";
    parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

  equation
    Therm.Q_flow + Star.Q_flow = 0;
    Therm.Q_flow = Modelica.Constants.sigma*eps*A*(Therm.T*Therm.T*Therm.T*Therm.T -Star.T*Star.T*Star.T*Star.T);
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),  graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid), Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid,
            textString="2*")}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid), Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid,
            textString="2*")}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"Interfaces.Star\">Star</a></b> connector. To model longwave radiation exchange of a surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> to the outmost layer of the surface and connect the <b><a href=\"Interfaces.Star\">Star</a></b> connector to the <b><a href=\"Interfaces.Star\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &QUOT;two star&QUOT; room model. </p>
</html>",
      revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Moved and Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
<li><i>June 16, 2006&nbsp;</i> by Timo Haase:<br>Implemented.</li>
</ul>
</html>"));
  end HeatToStar;

  model HeatToStar_Avar
    "Adaptor for approximative longwave radiation exchange with variable surface Area"

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation (
        Placement(transformation(extent={{-102,-10},{-82,10}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput A "Area of radiation exchange"
      annotation (Placement(transformation(
          origin={0,90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

    AixLib.Utilities.Interfaces.Star Star annotation (Placement(transformation(extent={{81,
              -10},{101,10}}, rotation=0)));
  equation
    Therm.Q_flow + Star.Q_flow = 0;
    Therm.Q_flow = Modelica.Constants.sigma*eps*A*(Therm.T*Therm.T*Therm.T*Therm.T -Star.T*Star.T*Star.T*Star.T);
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid), Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid,
            textString="2*")}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid), Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={135,150,177},
            fillPattern=FillPattern.Solid,
            textString="2*")}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"Interfaces.Star\">Star</a></b> connector. To model longwave radiation exchange of surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector to the outmost layer of the surface and connect the <b><a href=\"Interfaces.Star\">Star</a></b> connector to the <b><a href=\"Interfaces.Star\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &QUOT;two star&QUOT; room model. </p>
</html>",
      revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Moved and Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
<li><i>June 21, 2007&nbsp;</i> by Peter Mattes:<br>Extended model based on TwoStar_RadEx.</li>
</ul>
</html>"));
  end HeatToStar_Avar;
end HeatTransfer;
