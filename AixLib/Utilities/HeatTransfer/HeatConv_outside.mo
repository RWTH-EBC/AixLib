within AixLib.Utilities.HeatTransfer;
model HeatConv_outside
  "Model for heat transfer at outside surfaces. Choice between multiple models"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Integer Model = 1 "Model" annotation(Evaluate = true, Dialog(group = "Computational Models", compact = true, descriptionLabel = true), choices(choice = 1
        "DIN 6946",                                                                                                    choice = 2
        "ASHRAE Fundamentals (convective + radiative)",                                                                                                    choice = 3
        "Custom alpha",                                                                                                    radioButtons = true));
  parameter Modelica.SIunits.Area A = 16 "Area of surface" annotation(Dialog(group = "Surface properties", descriptionLabel = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25
    "Custom alpha"                                                                      annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 3));
  parameter
    DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type"                                                                                                     annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 2), choicesAllMatching = true);
  // Variables
  Modelica.SIunits.CoefficientOfHeatTransfer alpha;
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if   Model==1 or Model ==2                         annotation(Placement(transformation(extent = {{-102, -82}, {-82, -62}}), iconTransformation(extent = {{-102, -82}, {-82, -62}})));

protected
  Modelica.Blocks.Interfaces.RealInput WindSpeed_internal(unit="m/s");
equation
  // Main equation of heat transfer
  port_a.Q_flow = alpha*A*(port_a.T - port_b.T);

  //Determine alpha
  if Model == 1 then
    alpha = (4 + 4*WindSpeed_internal);
  elseif Model == 2 then
    alpha = surfaceType.D + surfaceType.E*WindSpeed_internal + surfaceType.F*(WindSpeed_internal^2);
  else
    alpha = alpha_custom;
    WindSpeed_internal = 0;
  end if;

  connect(WindSpeedPort, WindSpeed_internal);
  annotation(Icon(graphics={  Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Rectangle(extent = {{0, 70}, {20, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{20, 70}, {40, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, 70}, {60, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{60, 70}, {80, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 70}, {0, -90}}, lineColor = {255, 255, 255}, fillColor = {85, 85, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Polygon(points = {{80, 70}, {80, 70}, {60, 30}, {60, 70}, {80, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {157, 166, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{60, 70}, {60, 30}, {40, -10}, {40, 70}, {60, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {102, 110, 139},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{40, 70}, {40, -10}, {20, -50}, {20, 70}, {40, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {75, 82, 103},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{20, 70}, {20, -50}, {0, -90}, {0, 70}, {20, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {51, 56, 70},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-20, 26}, {-20, -54}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-20, 26}, {-30, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-38, 26}, {-48, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-54, 26}, {-64, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-38, 26}, {-38, -54}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-54, 26}, {-54, -54}}, color = {255, 255, 255}, thickness = 0.5)}), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The <b>HeatTransfer_outside </b>is a model for the convective heat transfer at outside walls </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>It allows the choice between three different models: </p>
<ul>
<li>after DIN 6946: <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-vd3eY3hw.png\"
    alt=\"alpha = 4 + 4*v\"/> , where
    <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-MU6LPHRs.png\"
    alt=\"alpha\"/> (<b>alpha)</b> is the heat transfer coefficent and
    <b>v</b> is the wind speed </li>
<li>after the ASHRAE Fundamentals Handbook from 1989, the way it is presented
in EnergyPlus Engineering reference from 2011:
<img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-A5RXdOdd.png\"
alt=\"alpha  = D + E*v + F*v^2\"/>, where
<img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-LDgZSLyY.png\" alt=\"alpha\"/>
(<b>alpha</b>) and <b>v</b> are as above and the coefficients <b>D, E, F</b>
depend on the surface of the outer wall.<br/><b>
<span style=\"color: #ff0000;\">Attention:</span></b>
This is a combined coefficient for convective and radiative heat exchange.</li>
<li>with a custom constant <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-BjHulWj5.png\"
alt=\"alpha \"/> (<b>alpha)</b> value </li>
</ul>
<p><b><span style=\"color: #008000;\">References</span></b> </p>
<ul>
<li>DIN 6946 p.20 </li>
<li>ASHRAEHandbook1989, as cited in EnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56 </li>
</ul>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test</a> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatConv_outside\">AixLib.Utilities.Examples.HeatConv_outside</a> </p>
</html>",  revisions="<html>
 <ul>
 <li><i>November 16, 2016&nbsp;</i> by Ana Constantin:<br/>Conditioned input WindSpeedPort and introduced protected input WindSpeed_internal</li>
 </ul>
 <ul>
 <li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 </ul>
 <ul>
   <li><i>March 30, 2012&nbsp;</i>
          by Ana Constantin:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end HeatConv_outside;
