within AixLib.Utilities.HeatTransfer;


model HeatConv_inside
  "Natural convection computation according to B. Glueck, choice between several types of surface orientation, or constant factor"
  /* calculation of natural convection in the inside of a building according to B.Glueck- Waermeuebertragung, 
     Waermeabgabe von Raumheizflaechen und Rohren
  */
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Boolean IsAlphaConstant = false "Use a constant alpha?" annotation(Dialog(descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom
    "Constant heat transfer coefficient"                                                                 annotation(Dialog(descriptionLabel = true, enable = IsAlphaConstant));
  // which orientation of surface?
  parameter Integer surfaceOrientation = 1 "Surface orientation" annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice = 1
        "vertical",                                                                                                    choice = 2
        "horizontal facing up",                                                                                                    choice = 3
        "horizontal facing down",                                                                                                    radioButtons = true));
  parameter Modelica.SIunits.Area A = 16 "Area of surface";
  Modelica.SIunits.CoefficientOfHeatTransfer alpha
    "variable heat transfer coefficient";
protected
  Modelica.SIunits.Temp_C posDiff = noEvent(abs(port_b.T - port_a.T))
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
      alpha = 2 * posDiff ^ 0.31;
    else
      // downward heatflux with function switch
      alpha = if noEvent(posDiff <= 0.0050474370) then 2 * posDiff ^ 0.31 else 1.08 * posDiff ^ 0.31;
    end if;
    // down side of horizontal plate
    // ------------------------------------------------------
  else
    if surfaceOrientation == 3 then
      if noEvent(port_b.T > port_a.T) then
        // downward heatflux
        alpha = if noEvent(posDiff <= 0.0050474370) then 2 * posDiff ^ 0.31 else 1.08 * posDiff ^ 0.31;
      else
        // upward heatflux
        alpha = 2 * posDiff ^ 0.31;
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
      alpha = if noEvent(posDiff <= 5e-12) then 0 else 1.6 * noEvent(posDiff ^ 0.3);
    end if;
  end if;
  port_a.Q_flow = alpha * A * (port_a.T - port_b.T);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent=  {{-80, 60}, {0, -100}}, lineColor=  {0, 255, 255}, fillColor=  {211, 243, 255},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}), Rectangle(extent=  {{60, 60}, {80, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {244, 244, 244},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{40, 60}, {60, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {207, 207, 207},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{20, 60}, {40, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {182, 182, 182},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{0, 60}, {20, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {156, 156, 156},
            fillPattern=                                                                                                    FillPattern.Solid), Polygon(points=  {{80, 60}, {80, 60}, {60, 20}, {60, 60}, {80, 60}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None,
            lineThickness=                                                                                                    0.5, smooth=  Smooth.None, fillColor=  {157, 166, 208},
            fillPattern=                                                                                                    FillPattern.Solid), Polygon(points=  {{60, 60}, {60, 20}, {40, -20}, {40, 60}, {60, 60}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None,
            lineThickness=                                                                                                    0.5, smooth=  Smooth.None, fillColor=  {102, 110, 139},
            fillPattern=                                                                                                    FillPattern.Solid), Polygon(points=  {{40, 60}, {40, -20}, {20, -60}, {20, 60}, {40, 60}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None,
            lineThickness=                                                                                                    0.5, smooth=  Smooth.None, fillColor=  {75, 82, 103},
            fillPattern=                                                                                                    FillPattern.Solid), Polygon(points=  {{20, 60}, {20, -60}, {0, -100}, {0, 60}, {20, 60}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None,
            lineThickness=                                                                                                    0.5, smooth=  Smooth.None, fillColor=  {51, 56, 70},
            fillPattern=                                                                                                    FillPattern.Solid), Line(points=  {{-58, 20}, {-68, 8}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-58, 20}, {-58, -60}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-40, 20}, {-50, 8}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-40, 20}, {-40, -60}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-22, 20}, {-32, 8}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-22, 20}, {-22, -60}}, color=  {0, 0, 255}, thickness=  0.5, smooth=  Smooth.None)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{0, 60}, {20, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{20, 60}, {40, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, 60}, {60, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{60, 60}, {80, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {0, -100}}, lineColor = {0, 255, 255}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Polygon(points = {{80, 60}, {80, 60}, {60, 20}, {60, 60}, {80, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, smooth = Smooth.None, fillColor = {157, 166, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{60, 60}, {60, 20}, {40, -20}, {40, 60}, {60, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, smooth = Smooth.None, fillColor = {102, 110, 139},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{40, 60}, {40, -20}, {20, -60}, {20, 60}, {40, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, smooth = Smooth.None, fillColor = {75, 82, 103},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{20, 60}, {20, -60}, {0, -100}, {0, 60}, {20, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, smooth = Smooth.None, fillColor = {51, 56, 70},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-20, 16}, {-20, -64}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-20, 16}, {-30, 4}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-38, 16}, {-48, 4}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-54, 16}, {-64, 4}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-38, 16}, {-38, -64}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-54, 16}, {-54, -64}}, color = {0, 0, 255}, thickness = 0.5, smooth = Smooth.None)}), Window(x = 0.25, y = 0.38, width = 0.6, height = 0.6), Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>HeatConv_choice</b> model represents the phenomenon of heat convection at inside surfaces, with different choice for surface orientation. </p>
<p><b><font style=\"color: #008000; \">Level of Development</font></b> </p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/> </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>In this model the orientation of the surface can be chosen from a menu for an easier adoption to new situations. This allows to calculate <code>alpha</code> depending on orientation and respective direction of heat flow. The equations for <code>alpha</code> are mainly taken from B. Gl&uuml;ck. </p>
<p>The model can in this way be used on inside surfaces. There is also the possibility of setting a constant alpha value. </p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<ul>
<li>Bernd Glueck:<i> Thermische Bauteilaktivierung - Nutzen von Umweltenergie und Kapillarrohren. 1. Aufl., C.F. Mueller-Verlag 1999.</i> </li>
<li>EN ISO 6946 in case of an outside vertical surface. </li>
</ul>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test </a></p>
</html>",  revisions = "<html>
 <ul>
 <li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 </ul>
 <ul>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl<br/>Formatted documentation according to standards</li>
 <li><i>December 15, 2005&nbsp;</i> by Peter Matthes:<br/>Implemented.</li>
 </ul>
 </html>"), DymolaStoredErrors);
end HeatConv_inside;
