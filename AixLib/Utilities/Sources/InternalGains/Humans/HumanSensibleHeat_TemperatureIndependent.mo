within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanSensibleHeat_TemperatureIndependent
  "Model for sensible heat output of humans not depending on the room temperature"
  extends BaseClasses.PartialHuman(productHeatOutput(nu=2));

  parameter Real specificHeatPerPerson(unit="W")=70 "specific heat output per person";

  Modelica.Blocks.Sources.RealExpression specificHeatOutput(y=
        specificHeatPerPerson)
    annotation (Placement(transformation(extent={{-88,28},{-68,48}})));
equation
  connect(specificHeatOutput.y, productHeatOutput.u[2]) annotation (Line(points=
         {{-67,38},{-50,38},{-50,0.5},{-40,0.5}}, color={0,0,127}));
end HumanSensibleHeat_TemperatureIndependent;
