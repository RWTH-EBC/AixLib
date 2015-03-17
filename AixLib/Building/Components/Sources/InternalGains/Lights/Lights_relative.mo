within AixLib.Building.Components.Sources.InternalGains.Lights;


model Lights_relative "light heat source model"
  extends BaseClasses.PartialInternalGain(ratioConv = 0.5);
  parameter Modelica.SIunits.Area RoomArea = 20 "Area of room" annotation(Dialog(descriptionLabel = true));
  parameter Real LightingPower = 10 "Heating power of lighting in W/m2" annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Area SurfaceArea_Lighting = 1;
  parameter Real Emissivity_Lighting = 0.98;
  Modelica.Blocks.Sources.Constant MaxLighting(k = RoomArea * LightingPower) annotation(Placement(transformation(extent = {{-90, 40}, {-70, 60}})));
  Modelica.Blocks.Math.MultiProduct productHeatOutput(nu = 2) annotation(Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  Utilities.HeatTransfer.HeatToStar RadiationConvertor(A = SurfaceArea_Lighting, eps = Emissivity_Lighting) annotation(Placement(transformation(extent = {{50, -70}, {70, -50}})));
equation
  connect(MaxLighting.y, productHeatOutput.u[2]) annotation(Line(points = {{-69, 50}, {-48, 50}, {-48, -3.5}, {-40, -3.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(Schedule, productHeatOutput.u[1]) annotation(Line(points = {{-100, 0}, {-76, 0}, {-76, -20}, {-48, -20}, {-48, -4}, {-40, -4}, {-40, 3.5}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation(Line(points = {{40, -10}, {46, -10}, {46, -60}, {50.8, -60}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(RadiationConvertor.Star, RadHeat) annotation(Line(points = {{69.1, -60}, {90, -60}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(productHeatOutput.y, gain.u) annotation(Line(points = {{-18.3, 0}, {-8, 0}, {-8, 30}, {3.2, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(productHeatOutput.y, gain1.u) annotation(Line(points = {{-18.3, 0}, {-8, 0}, {-8, -10}, {3.2, -10}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Icon(graphics={  Ellipse(extent = {{-52, 72}, {50, -40}}, lineColor = {255, 255, 0}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-26, -48}, {22, -48}}, color = {0, 0, 0}, smooth = Smooth.None, thickness = 1), Line(points = {{-24, -56}, {22, -56}}, color = {0, 0, 0}, smooth = Smooth.None, thickness = 1), Line(points = {{-24, -64}, {22, -64}}, color = {0, 0, 0}, smooth = Smooth.None, thickness = 1), Line(points = {{-24, -72}, {22, -72}}, color = {0, 0, 0}, smooth = Smooth.None, thickness = 1), Line(points = {{-28, -42}, {-28, -80}, {26, -80}, {26, -42}}, color = {0, 0, 0}, smooth = Smooth.None, thickness = 1)}), Documentation(revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Light heat source model. Maximum lighting can be given as input and be adjusted by a schedule input.</p>
 <h4><font color=\"#008000\">Level of Development</font></h4>
 <p><img src=\"modelica://AixLib/Images/stars2.png\" alt=\"stars: 2 out of 5\"/></p>
 <h4><font color=\"#008000\">Known limitation</font></h4>
 <p>The parameter <b>A</b> cannot be set by default since other models must be able to implement their own equations for <b>A</b>.</p>
 <p>The input signal can take values from 0 to 1, and is then multiplied with the maximum lighting power per square meter and the room area. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Lights\">AixLib.Building.Components.Examples.Sources.InternalGains.Lights</a> </p>
 <p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Lights_relative;
