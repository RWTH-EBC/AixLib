within AixLib.BoundaryConditions.InternalGains.Humans.BaseClasses;
partial model PartialHuman "Partial model for internal gains of humans"
  extends AixLib.BoundaryConditions.InternalGains.BaseClasses.PartialInternalGain(
    emissivity=0.98,
    gain(final k=specificPersons*roomArea),
    gainSurfaces(final k=specificPersons*roomArea*surfaceAreaOnePersion));
  //Internal Gains People
  parameter Real specificPersons(unit="1/(m.m)") = 0.05 "Specific persons per square metre room area" annotation(Dialog(descriptionLabel = true));
  parameter Real ratioConvectiveHeat=0.5
    "Ratio of convective heat from overall heat output"                                        annotation(Dialog(descriptionLabel = true));
  parameter Modelica.Units.SI.Area roomArea "Area of room"
    annotation (Dialog(descriptionLabel=true));
  parameter Modelica.Units.SI.HeatFlowRate specificHeatPerPerson=70
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
  parameter Modelica.Units.SI.Area surfaceAreaOnePersion=2
    "Human Surface (per person)";
  parameter Modelica.Units.SI.HeatFlowRate heatPerPerson=70
    "Average Heat Flow per person taken from DIN V 18599-10"
    annotation (Dialog(descriptionLabel=true));
equation
  connect(TRoom,temperatureSensor. port) annotation(Line(points = {{-90, 90}, {-90, 74}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T,to_degC. u) annotation(Line(points = {{-90, 54}, {-84, 54}, {-84, 52}, {-83, 51}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  annotation(Icon(graphics={  Ellipse(extent = {{-36, 98}, {36, 26}}, lineColor = {255, 213, 170}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-48, 20}, {54, -94}}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None), Text(extent = {{-40, -2}, {44, -44}}, lineColor = {255, 255, 255}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "ERC"), Ellipse(extent = {{-24, 80}, {-14, 70}}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Ellipse(extent = {{10, 80}, {20, 70}}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Line(points = {{-18, 54}, {-16, 48}, {-10, 44}, {-4, 42}, {2, 42}, {10, 44}, {16, 48}, {18, 54}}, color = {0, 0, 0}, thickness = 1)}), Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Partial model for internal gains of a person. The model uses the
  specific value for <i>Persons/(m<sup>2</sup> room area)</i> and the
  <i>roomArea</i> to calculate the persons in the room considering the
  schedule / input y.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The schedule input y describes the presence of only one person, and
  can take values from 0 to 1.
</p>
<ul>
  <li>
    <i>March 30, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>:
    Summarize models to partial model. Make all models dependant from a
    relative input 0..1. Many refactorings.
  </li>
  <li>July 10, 2019, by Martin Kremer:<br/>
    Implemented based on old human model
  </li>
</ul>
</html>"));
end PartialHuman;
