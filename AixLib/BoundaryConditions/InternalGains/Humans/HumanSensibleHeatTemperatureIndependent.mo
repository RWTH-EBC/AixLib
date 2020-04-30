within AixLib.BoundaryConditions.InternalGains.Humans;
model HumanSensibleHeatTemperatureIndependent
  "Model for sensible heat output of humans not depending on the room temperature"
  extends BaseClasses.PartialHuman(productHeatOutput(nu=2));

  Modelica.Blocks.Sources.RealExpression specificHeatOutput(
    y=specificHeatPerPerson)
    "Specific heat output per person"
    annotation (Placement(transformation(extent={{-88,22},{-68,42}})));
equation
  connect(specificHeatOutput.y, productHeatOutput.u[2]) annotation (Line(points={{-67,32},{-40,32},{-40,0},{-20,0}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat output of a person. The model only considers sensible
  heat. The heat output is not dependent on the room temperature.
</p>
<h4>
  The temperature of the heatPort is not used in this model.
</h4>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  A schedule is used as constant presence of people in a room is not
  realistic. The schedule describes the presence of only one person,
  and can take values from 0 to 1.
</p>
<p>
  The heat ouput per person can be set and is multiplied with the
  number of persons in the room.
</p>
<ul>
  <li>July 10, 2019, by Martin Kremer:<br/>
    Implemented
  </li>
</ul>
</html>"), Icon(graphics={                                                                                                                                                  Text(extent={{-40,-48},{44,-90}},     lineColor={255,255,255},     fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
          textString="not f(T)")}));
end HumanSensibleHeatTemperatureIndependent;
