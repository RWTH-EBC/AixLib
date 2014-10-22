within AixLib.Utilities.HeatTransfer;

model HeatConv_outside "Model for heat transfer at outside surfaces. Choice between multiple models"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Integer Model = 1 "Model" annotation(Dialog(group = "Computational Models", compact = true, descriptionLabel = true), choices(choice = 1 "DIN 6946", choice = 2 "ASHRAE Fundamentals", choice = 3 "Custom alpha", radioButtons = true));
  parameter Modelica.SIunits.Area A = 16 "Area of surface" annotation(Dialog(group = "Surface properties", descriptionLabel = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25 "Custom alpha" annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 3));
  parameter DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster() "Surface type" annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 2), choicesAllMatching = true);
  // Variables
  Modelica.SIunits.CoefficientOfHeatTransfer alpha;
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-102, -82}, {-82, -62}}, rotation = 0), iconTransformation(extent = {{-102, -82}, {-82, -62}})));
equation
  // Main equation of heat transfer
  port_a.Q_flow = alpha * A * (port_a.T - port_b.T);
  //Determine alpha
  if Model == 1 then
    alpha = 4 + 4 * WindSpeedPort;
  elseif Model == 2 then
    alpha = surfaceType.D + surfaceType.E * WindSpeedPort + surfaceType.F * WindSpeedPort ^ 2;
  else
    alpha = alpha_custom;
  end if;
  // Dummy variable for WindSpeedPort
  if cardinality(WindSpeedPort) < 1 then
    WindSpeedPort = 0;
  end if;
  annotation(Icon(graphics = {Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Rectangle(extent = {{0, 70}, {20, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 70}, {40, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182}, fillPattern = FillPattern.Solid), Rectangle(extent = {{40, 70}, {60, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207}, fillPattern = FillPattern.Solid), Rectangle(extent = {{60, 70}, {80, -90}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, 70}, {0, -90}}, lineColor = {255, 255, 255}, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Polygon(points = {{80, 70}, {80, 70}, {60, 30}, {60, 70}, {80, 70}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, lineThickness = 0.5, smooth = Smooth.None, fillColor = {157, 166, 208}, fillPattern = FillPattern.Solid), Polygon(points = {{60, 70}, {60, 30}, {40, -10}, {40, 70}, {60, 70}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, lineThickness = 0.5, smooth = Smooth.None, fillColor = {102, 110, 139}, fillPattern = FillPattern.Solid), Polygon(points = {{40, 70}, {40, -10}, {20, -50}, {20, 70}, {40, 70}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, lineThickness = 0.5, smooth = Smooth.None, fillColor = {75, 82, 103}, fillPattern = FillPattern.Solid), Polygon(points = {{20, 70}, {20, -50}, {0, -90}, {0, 70}, {20, 70}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, lineThickness = 0.5, smooth = Smooth.None, fillColor = {51, 56, 70}, fillPattern = FillPattern.Solid), Line(points = {{-20, 26}, {-20, -54}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-20, 26}, {-30, 14}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-38, 26}, {-48, 14}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-54, 26}, {-64, 14}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-38, 26}, {-38, -54}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None), Line(points = {{-54, 26}, {-54, -54}}, color = {255, 255, 255}, thickness = 0.5, smooth = Smooth.None)}), Documentation(info = "<html>
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
 </html>", revisions = "<html>
 <p><ul>
 <li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 </ul></p>
 <ul>
   <li><i>March 30, 2012&nbsp;</i>
          by Ana Constantin:<br>
          Implemented.</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end HeatConv_outside;