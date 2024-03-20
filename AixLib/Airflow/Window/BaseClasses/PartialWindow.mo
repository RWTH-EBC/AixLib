within AixLib.Airflow.Window.BaseClasses;
partial model PartialWindow
  "Calculation of the volume flow rate by window ventilation"
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening"
    annotation (Dialog(group="Parameters"));
  parameter Modelica.Units.SI.Length winClrH(min=0)
    "Height of the window clear opening"
    annotation (Dialog(group="Parameters"));
  Modelica.Blocks.Interfaces.RealOutput ventFlow(unit="m3/s")
    "Window ventilation volume flow rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  parameter Modelica.Units.SI.Area crosSecArea=
    Functions.OpeningArea.crossSectionArea(winClrW, winClrH);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialWindow;
