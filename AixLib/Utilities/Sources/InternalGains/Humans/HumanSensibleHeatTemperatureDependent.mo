within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanSensibleHeatTemperatureDependent
  "Model for sensible heat output of humans to environment dependent on the room temperature"
  extends BaseClasses.PartialHuman(productHeatOutput(nu=2));
  parameter Real activityDegree=1.0 "activity degree of persons in room in met";
  BaseClasses.TemperatureDependentHeatOutputSIA2024
    temperatureDependentHeatOutputSIA2024_1(activityDegree=activityDegree)
    "Temperature dependent heat output per person"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(TRoom,temperatureSensor. port) annotation(Line(points = {{-90, 90}, {-90, 74}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T,to_degC. u) annotation(Line(points = {{-90, 54}, {-84, 54}, {-84, 52}, {-83, 51}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(to_degC.y, temperatureDependentHeatOutputSIA2024_1.T) annotation (
      Line(points={{-71.5,51},{-66.75,51},{-66.75,50},{-62,50}}, color={0,0,127}));
  connect(temperatureDependentHeatOutputSIA2024_1.heatOutput, productHeatOutput.u[
    2]) annotation (Line(points={{-39,50},{-28,50},{-28,30},{-54,30},{-54,4},{-40,
          4}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Model for heat output of a person. The model only considers sensible heat. The heat output is dependent on the room temperature.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>A schedule is used as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p>The heat ouput per person is calculated according to SIA 2024 depending on the room temperature. An activity degree can be set to consider different types of activity of the persons.</p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero.For this reason a limitiation for the surface has been intoduced: as a minimum the surface area of one human and as a maximum a value of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>[1]: SIA 2024: Space usage data for energy and building services engineering - 2015 </p>
</html>", revisions="<html>
 <ul>
 <li><i>July 10, 2019&nbsp;</i> by Martin Kremer:<br/>Implemented</li>
 </ul>
</html>"));
end HumanSensibleHeatTemperatureDependent;
