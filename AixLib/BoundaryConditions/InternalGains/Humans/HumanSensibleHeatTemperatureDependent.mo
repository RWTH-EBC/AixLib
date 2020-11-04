within AixLib.BoundaryConditions.InternalGains.Humans;
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
  connect(temperatureDependentHeatOutputSIA2024_1.heatOutput, productHeatOutput.u[2]) annotation (Line(points={{-39,50},{-34,50},{-34,0},{-20,0}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat output of a person. The model only considers sensible
  heat. The heat output is dependent on the room temperature.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  A schedule is used as constant presence of people in a room is not
  realistic. The schedule describes the presence of only one person,
  and can take values from 0 to 1.
</p>
<p>
  The heat ouput per person is calculated according to SIA 2024
  depending on the room temperature. An activity degree can be set to
  consider different types of activity of the persons.
</p>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  [1]: SIA 2024: Space usage data for energy and building services
  engineering - 2015
</p>
<ul>
  <li>
    <i>July 10, 2019&#160;</i> by Martin Kremer:<br/>
    Implemented
  </li>
</ul>
</html>"), Icon(graphics={                                                                                                                                                  Text(extent={{-40,-48},{44,-90}},     lineColor={255,255,255},     fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
          textString="=f(T)")}));
end HumanSensibleHeatTemperatureDependent;
