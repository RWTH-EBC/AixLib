within AixLib.Airflow.WindowVentilation.Utilities;
model s_to_alpha "Convert from window opening width to opening angle"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(
    u(unit="m"), y(unit="rad"));
  parameter Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  parameter Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
equation
  y =
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
    a,
    b,
    u);
  annotation (Icon(graphics={            Text(
              extent={{-20,100},{-100,20}},
          textColor={0,0,0},
          textString="s"),               Text(
              extent={{100,-20},{20,-100}},
          textColor={0,0,0},
          textString="α")}), Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>Convert from window opening width to opening angle.</p>
</html>"));
end s_to_alpha;
