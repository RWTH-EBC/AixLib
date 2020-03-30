within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
partial model PartialHuman "Partial model for internal gains of humans"
  extends AixLib.Utilities.Sources.InternalGains.BaseClasses.PartialInternalGain(
    emissivity=0.98,
    gain(final k=specificPersons*roomArea),
    gainSurfaces(final k=specificPersons*roomArea*surfaceAreaOnePersion));
  //Internal Gains People
  parameter Real specificPersons(unit="1/(m.m)") = 0.05 "Specific persons per square metre room area" annotation(Dialog(descriptionLabel = true));
  parameter Real ratioConvectiveHeat=0.5
    "Ratio of convective heat from overall heat output"                                        annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Area roomArea "Area of room" annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.HeatFlowRate specificHeatPerPerson = 70
    "Specific heat output per person";

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    "Room temperature sensor"
   annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, 64})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    "Converter from Kelvin to Celsius"
   annotation(Placement(transformation(extent = {{-82, 46}, {-72, 56}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
    "Air temperature in room"
     annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
protected
  parameter Modelica.SIunits.Area surfaceAreaOnePersion=2 "Human Surface (per person)";
  parameter Modelica.SIunits.HeatFlowRate heatPerPerson=70
    "Average Heat Flow per person taken from DIN V 18599-10"
   annotation(Dialog(descriptionLabel = true));
equation
  connect(TRoom,temperatureSensor. port) annotation(Line(points = {{-90, 90}, {-90, 74}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T,to_degC. u) annotation(Line(points = {{-90, 54}, {-84, 54}, {-84, 52}, {-83, 51}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  annotation(Icon(graphics={  Ellipse(extent = {{-36, 98}, {36, 26}}, lineColor = {255, 213, 170}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-48, 20}, {54, -94}}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None), Text(extent = {{-40, -2}, {44, -44}}, lineColor = {255, 255, 255}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "ERC"), Ellipse(extent = {{-24, 80}, {-14, 70}}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Ellipse(extent = {{10, 80}, {20, 70}}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Line(points = {{-18, 54}, {-16, 48}, {-10, 44}, {-4, 42}, {2, 42}, {10, 44}, {16, 48}, {18, 54}}, color = {0, 0, 0}, thickness = 1)}), Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Partial model for internal gains of a person. The model uses the specific value for <i>Persons/m<sup>2</sup></i> and the <i>RoomArea</i> to calculate the persons in the room considering the schedule. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>A schedule is used as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero.For this reason a limitiation for the surface has been intoduced: as a minimum the surface area of one human and as a maximum a value of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
</html>",  revisions="<html>
 <ul>
 <li>July 10, 2019, by Martin Kremer:<br/>Implemented based on old human model</li>
 </ul>
 </html>"));
end PartialHuman;
