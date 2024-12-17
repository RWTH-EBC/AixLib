within AixLib.Utilities.KPIs.Temperature;
model FlexibleBounds "Temperature assessment with flexible bounds"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialTemperatureAssessment;
  Modelica.Blocks.Interfaces.RealInput uppBou(unit="K", displayUnit="degC")
    "Upper temperature bound"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput lowBou(unit="K", displayUnit="degC")
    "Lower temperature bound"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  assert(uppBou > lowBou, "Upper bound should be greater than lower bound");
  connect(itgErrDuaBou.refUpp, uppBou) annotation (Line(points={{-24,12},{-40,12},
          {-40,60},{-120,60}}, color={0,0,127}));
  connect(itgErrDuaBou.refLow, lowBou) annotation (Line(points={{-24,-12},{-40,-12},
          {-40,-60},{-120,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end FlexibleBounds;
