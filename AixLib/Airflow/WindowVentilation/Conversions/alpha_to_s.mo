within AixLib.Airflow.WindowVentilation.Conversions;
model alpha_to_s
  "Conversion from window sash opening angle to opening width"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(
    u(unit="rad", displayUnit="deg"), y(unit="m"));
  extends Modelica.Icons.UnderConstruction;

  parameter Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  parameter Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
equation
  y = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.alpha_to_s(
    a, b, u);
end alpha_to_s;
