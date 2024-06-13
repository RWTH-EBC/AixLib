within AixLib.Airflow.WindowVentilation.Utilities;
model alpha_to_s "Convert from window opening angle to opening width"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(
    u(unit="rad"), y(unit="m"));
  parameter Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  parameter Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
equation
  y =
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.AngleToWidth(
    a,
    b,
    u);
  annotation (Icon(graphics={            Text(
              extent={{-20,100},{-100,20}},
          textColor={0,0,0},
          textString="α"),              Text(
              extent={{100,-20},{20,-100}},
          textColor={0,0,0},
          textString="s")}), Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>Convert from window opening angle to opening width.</p>
</html>"));
end alpha_to_s;
