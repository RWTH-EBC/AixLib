within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningArea
  "Calculation of window opening area"
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrH(min=0)
    "Height of the window clear opening";
  Modelica.Units.SI.Area clrOpnArea = winClrW*winClrH
    "Window clear opening area";
  Modelica.Blocks.Interfaces.RealOutput A(quantity="Area", unit="m2", min=0)
    "Window opening area"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialOpeningArea;
