within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanSensibleHeat_TemperatureIndependent
  "Model for sensible heat output of humans not depending on the room temperature"
  extends BaseClasses.PartialHuman(productHeatOutput(nu=2));

  parameter Real specificHeatPerPerson(unit="W")=70 "specific heat output per person";

  Modelica.Blocks.Sources.RealExpression specificHeatOutput(y=
        specificHeatPerPerson)
    annotation (Placement(transformation(extent={{-88,28},{-68,48}})));
equation
  connect(specificHeatOutput.y, productHeatOutput.u[2]) annotation (Line(points={{-67,38},
          {-50,38},{-50,4},{-40,4}},              color={0,0,127}));
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Model for heat output of a person. The model only considers sensible heat. The heat output is not dependent on the room temperature.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>A schedule is used as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p>The heat ouput per person can be set and is multiplied with the number of persons in the room.</p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero.For this reason a limitiation for the surface has been intoduced: as a minimum the surface area of one human and as a maximum a value of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
</html><html>
</html>", revisions="<html>
 <ul>
 <li><i>July 10, 2019&nbsp;</i> by Martin Kremer:<br/>Implemented</li>
 </ul>
</html>"));
end HumanSensibleHeat_TemperatureIndependent;
