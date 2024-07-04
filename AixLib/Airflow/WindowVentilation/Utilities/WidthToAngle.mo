within AixLib.Airflow.WindowVentilation.Utilities;
model WidthToAngle
  "Convert from window opening width to opening angle"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(
    u(unit="m"), y(unit="rad"));
  parameter Modelica.Units.SI.Length lenAxs(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  parameter Modelica.Units.SI.Length lenAxsToFrm(min=0)
    "Distance from the hinged axis to the frame across the opening area";
equation
  y =
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
    lenAxs, lenAxsToFrm, u);
  annotation (Icon(graphics={            Text(
              extent={{-20,100},{-100,20}},
          textColor={0,0,0},
          textString="s"),               Text(
              extent={{100,-20},{20,-100}},
          textColor={0,0,0},
          textString="α")}), Documentation(revisions="<html><ul>
  <li>June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  Convert from window opening width to opening angle.
</p>
</html>"));
end WidthToAngle;
