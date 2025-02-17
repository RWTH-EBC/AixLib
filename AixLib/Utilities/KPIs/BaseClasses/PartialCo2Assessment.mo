within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialCo2Assessment "Partial model for CO2 assessment"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialAssessmentBase;
  Modelica.Blocks.Interfaces.RealInput co2Con(final min=0) "CO2 concentration in ppm"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  annotation (Documentation(info="<html>
<p>This partial model is the base model of CO<sub>2</sub> concentration assessments.</p>
</html>", revisions="<html>
<ul>
  <li>
    January 9, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end PartialCo2Assessment;
