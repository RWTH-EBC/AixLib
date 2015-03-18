within AixLib.Building.Components.Sources.InternalGains.Machines;


model Machines_DIN18599
  extends BaseClasses.PartialInternalGain;
  parameter Integer ActivityType = 2 "Machine activity" annotation(Dialog(compact = true, descriptionLabel = true), choices(choice = 1 "low", choice = 2 "middle", choice = 3 "high", radioButtons = true));
  parameter Real NrPeople = 1.0 "Number of people with machines" annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Area SurfaceArea_Machines = 2
    "surface area of radiative heat source";
  parameter Real Emissivity_Machines = 0.98;
  Modelica.Blocks.Math.Gain Nr_People(k = NrPeople) annotation(Placement(transformation(extent = {{-60, -46}, {-48, -34}})));
  Modelica.Blocks.Sources.Constant Activity(k = ActivityType) annotation(Placement(transformation(extent = {{-90, 40}, {-70, 60}})));
  Utilities.HeatTransfer.HeatToStar RadiationConvertor(eps = Emissivity_Machines, A = SurfaceArea_Machines * NrPeople) annotation(Placement(transformation(extent = {{50, -70}, {70, -50}})));
protected
  Modelica.Blocks.Tables.CombiTable1D HeatOutput(smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, tableOnFile = false, table = [1, 50; 2, 100; 3, 150], columns = {2}) annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
  Modelica.Blocks.Math.MultiProduct productHeatOutput(nu = 2) annotation(Placement(transformation(extent = {{-24, -10}, {-4, 10}})));
equation
  connect(HeatOutput.y[1], productHeatOutput.u[1]) annotation(Line(points = {{-39, 50}, {-32, 50}, {-32, 3.5}, {-24, 3.5}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Nr_People.y, productHeatOutput.u[2]) annotation(Line(points = {{-47.4, -40}, {-32, -40}, {-32, -3.5}, {-24, -3.5}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Schedule, Nr_People.u) annotation(Line(points = {{-100, 0}, {-85.6, 0}, {-85.6, -40}, {-61.2, -40}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Activity.y, HeatOutput.u[1]) annotation(Line(points = {{-69, 50}, {-62, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(RadiationConvertor.Star, RadHeat) annotation(Line(points = {{69.1, -60}, {90, -60}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation(Line(points = {{40, -10}, {48, -10}, {48, -60}, {50.8, -60}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(productHeatOutput.y, gain.u) annotation(Line(points = {{-2.3, 0}, {0, 0}, {0, 30}, {3.2, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(productHeatOutput.y, gain1.u) annotation(Line(points = {{-2.3, 0}, {0, 0}, {0, -10}, {3.2, -10}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Icon(graphics = {Text(extent=  {{-40, -20}, {44, -62}}, lineColor=  {255, 255, 255}, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "ERC"), Polygon(points=  {{-90, -86}, {-58, -42}, {60, -42}, {98, -86}, {-90, -86}}, pattern=  LinePattern.None, smooth=  Smooth.None, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-54, -48}, {-46, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-42, -48}, {-34, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-30, -48}, {-22, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-18, -48}, {-10, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-6, -48}, {2, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{6, -48}, {14, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{18, -48}, {26, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{30, -48}, {38, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{42, -48}, {50, -54}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-62, -58}, {-54, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-50, -58}, {-42, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-38, -58}, {-30, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-26, -58}, {-18, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-14, -58}, {-6, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-2, -58}, {6, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{10, -58}, {18, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{22, -58}, {30, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{34, -58}, {42, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{46, -58}, {54, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{58, -58}, {66, -64}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-72, -68}, {-64, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-60, -68}, {-52, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-48, -68}, {-40, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-36, -68}, {-28, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-24, -68}, {-16, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-12, -68}, {-4, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{0, -68}, {8, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{12, -68}, {20, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{24, -68}, {32, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{36, -68}, {44, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{48, -68}, {56, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{60, -68}, {68, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{72, -68}, {80, -74}}, pattern=  LinePattern.None, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-60, 60}, {60, -38}}, fillColor=  {175, 175, 175}, fillPattern=  FillPattern.Solid, pattern=  LinePattern.None), Rectangle(extent=  {{-56, 56}, {56, -34}}, pattern=  LinePattern.None, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, lineColor=  {0, 0, 0}), Text(extent=  {{-54, 30}, {58, -8}}, lineColor=  {255, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, textString=  "ERC")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Heat cource with convective and radiative component. The load is determined by a schedule and the type of activity. </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica:/AixLib/Images/stars2.png\"/></p>
 <p><h4><font color=\"#008000\">Concept</font></h4></p>
 <p>The schedule sets the usage of the room by people. To set a higher number of people, a multiplier is given.</p>
 <p>The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
 <p>The type of activity determines the load by a person in the room according to DIN 18599. The following values are provided:</p>
 <table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
 <td bgcolor=\"#dcdcdc\"><p>Activity Type</p></td>
 <td bgcolor=\"#dcdcdc\"><p>Heat Load [W]</p></td>
 </tr>
 <tr>
 <td><p>1</p></td>
 <td><p>50</p></td>
 </tr>
 <tr>
 <td><p>2</p></td>
 <td><p>100</p></td>
 </tr>
 <tr>
 <td><p>3</p></td>
 <td><p>150</p></td>
 </tr>
 </table>
 <p><h4><font color=\"#008000\">References</font></h4></p>
 <p>DIN 18599 </p>
 <p><h4><font color=\"#008000\">Example Results</font></h4></p>
 <p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Machines\">AixLib.Building.Components.Examples.Sources.InternalGains.Machines </a></p>
 <p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a></p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 </ul></p>
 </html>"));
end Machines_DIN18599;
