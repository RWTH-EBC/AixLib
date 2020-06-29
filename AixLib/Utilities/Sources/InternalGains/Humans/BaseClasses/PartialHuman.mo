within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
partial model PartialHuman "Partial model for internal gains of humans"
  //Internal Gains People
  parameter Real specificPersons(unit="1/(m.m)") = 1.0 "Specific persons per square metre" annotation(Dialog(descriptionLabel = true));
  parameter Real ratioConvectiveHeat=0.5
    "Ratio of convective heat from overall heat output"                                        annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Area roomArea=20 "Area of room" annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(22)
    "Initial temperature";
  parameter Modelica.SIunits.HeatFlowRate specificHeatPerPerson = 70
    "Specific heat output per person";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convHeat
    "Convective heat output"
   annotation(Placement(transformation(extent = {{80, 40}, {100, 60}})));
  Utilities.HeatTransfer.HeatToStar radiationConvertor(eps=emissivityHuman)
    "Converter for HeatPort to RadPort"
    annotation (Placement(transformation(extent={{48,-22},{72,2}})));
  Interfaces.RadPort radHeat "Radiative heat output"
   annotation(Placement(transformation(extent = {{80, -20}, {100, 0}})));
  Modelica.Blocks.Interfaces.RealInput schedule "Occupancy schedule"
   annotation(Placement(transformation(extent = {{-120, -40}, {-80, 0}}), iconTransformation(extent = {{-102, -22}, {-80, 0}})));
  Modelica.Blocks.Math.Gain nrPeople(k=specificPersons*roomArea)
    "Number of people"
   annotation (Placement(transformation(extent={{-70,-26},{-58,-14}})));
  Modelica.Blocks.Math.Gain surfaceAreaPeople(k=surfaceArea_Human)
    "Human surface"
   annotation (Placement(transformation(extent={{16,-54},{28,-42}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1e+23, uMin=1)
    "Limiter for number of people"
   annotation(Placement(transformation(extent={{-18,-58},
            {2,-38}})));
  Modelica.Blocks.Math.Gain gain(k=ratioConvectiveHeat)
    "Ratio convective heat"
   annotation(Placement(transformation(extent = {{6, 28}, {14, 36}})));
  Modelica.Blocks.Math.Gain gain1(k = 1 -ratioConvectiveHeat)
    "Ratio radiative heat"
   annotation(Placement(transformation(extent = {{6, -12}, {14, -4}})));
  Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=1)
    "Product of heat output per person and number of people"
    annotation (Placement(transformation(extent={{-40,-6},{-20,14}})));
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
  parameter Modelica.SIunits.Area surfaceArea_Human=2 "Human Surface";
  parameter Real emissivityHuman=0.98 "Human emission coefficient";
  parameter Modelica.SIunits.HeatFlowRate heatPerPerson=70
    "Average Heat Flow per person taken from DIN V 18599-10"
   annotation(Dialog(descriptionLabel = true));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow convectiveHeat(
    T_ref = T0)
    "Convective heat output"
   annotation(Placement(transformation(extent = {{18, 20}, {42, 44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow radiativeHeat(
    T_ref = T0)
    "Radiative heat output"
   annotation(Placement(transformation(extent = {{18, -20}, {42, 4}})));
equation
  connect(radiativeHeat.port,radiationConvertor. Therm) annotation(Line(points = {{42, -8}, {44, -8}, {44, -12}, {48, -12}, {48, -10}, {48.96, -10}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(radiationConvertor.Star,radHeat)  annotation(Line(points = {{70.92, -10}, {90, -10}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(schedule, nrPeople.u)
    annotation (Line(points={{-100,-20},{-71.2,-20}}, color={0,0,127}));
  connect(gain.y,convectiveHeat. Q_flow) annotation(Line(points = {{14.4, 32}, {18, 32}}, color = {0, 0, 127}));
  connect(gain1.y,radiativeHeat. Q_flow) annotation(Line(points = {{14.4, -8}, {18, -8}}, color = {0, 0, 127}));
  connect(limiter.y, surfaceAreaPeople.u)
    annotation (Line(points={{3,-48},{14.8,-48}}, color={0,0,127}));
  connect(surfaceAreaPeople.y, radiationConvertor.A_in) annotation (Line(points=
         {{28.6,-48},{40,-48},{40,20},{60,20},{60,0.8}}, color={0,0,127}));
  connect(nrPeople.y, productHeatOutput.u[1]) annotation (Line(points={{-57.4,-20},
          {-54,-20},{-54,4},{-40,4},{-40,4}}, color={0,0,127}));
  connect(productHeatOutput.y, gain1.u) annotation (Line(points={{-18.3,4},{-8,
          4},{-8,-8},{5.2,-8}}, color={0,0,127}));
  connect(productHeatOutput.y, gain.u) annotation (Line(points={{-18.3,4},{-8,4},
          {-8,32},{5.2,32}}, color={0,0,127}));
  connect(nrPeople.y, limiter.u) annotation (Line(points={{-57.4,-20},{-52,-20},
          {-52,-48},{-20,-48}}, color={0,0,127}));
  connect(TRoom,temperatureSensor. port) annotation(Line(points = {{-90, 90}, {-90, 74}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T,to_degC. u) annotation(Line(points = {{-90, 54}, {-84, 54}, {-84, 52}, {-83, 51}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(convectiveHeat.port,convHeat)  annotation (Line(points={{42,32},{64,
          32},{64,50},{90,50}}, color={191,0,0}));
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
