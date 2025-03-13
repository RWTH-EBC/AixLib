within AixLib.Utilities.KPIs.Temperature;
model DIN16798 "Comfort room temperature based on DIN EN 16798-1"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialTemperatureAssessment;
  Modelica.Blocks.Interfaces.RealInput TAmb(
    final unit="K",
    displayUnit="degC",
    final min=0) "Ambient temperature (hourly averaged)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  AixLib.Utilities.KPIs.BaseClasses.ComfortTemperatureDIN16798 comT
    "Comfort temperature"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
equation
  connect(TAmb, comT.TAmb)
    annotation (Line(points={{-120,60},{-82,60}}, color={0,0,127}));
  connect(comT.TComUppBou, itgErrDuaBou.refUpp) annotation (Line(points={{-59,67},
          {-40,67},{-40,12},{-24,12}}, color={0,0,127}));
  connect(comT.TComLowBou, itgErrDuaBou.refLow) annotation (Line(points={{-59,53},
          {-50,53},{-50,-12},{-24,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model assesses room temperature according to DIN EN 16798-1, where the comfort room temperature is based on the ambient temperature.</p>
</html>"));
end DIN16798;
