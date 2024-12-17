within AixLib.Utilities.KPIs.Temperature;
model FixedBounds "Temperature assessment with fixed bounds"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialTemperatureAssessment;
  parameter Modelica.Units.SI.Temperature TCom(displayUnit="degC")=295.15
    "Comfort temperature";
  parameter Modelica.Units.SI.TemperatureDifference dTTol(final min=0)=2
    "Tolerance of temperature difference, tolerance band is (TCom - dTTol, TCom + dTTol)";
  Modelica.Blocks.Sources.Constant conTUppBou(k=TCom + dTTol)
    "Upper bound of temperature"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant conTLowBou(k=TCom - dTTol)
    "Lower bound of temperature"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
initial equation
  assert(dTTol > 0, "Tolerance should be greater than 0");
equation
  connect(conTUppBou.y, itgErrDuaBou.refUpp) annotation (Line(points={{-59,50},
          {-40,50},{-40,12},{-24,12}}, color={0,0,127}));
  connect(conTLowBou.y, itgErrDuaBou.refLow) annotation (Line(points={{-59,-50},
          {-40,-50},{-40,-12},{-24,-12}}, color={0,0,127}));
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
end FixedBounds;
