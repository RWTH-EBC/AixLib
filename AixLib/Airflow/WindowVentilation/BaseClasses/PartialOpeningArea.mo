within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningArea
  "Calculation of window opening area"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrH(min=0)
    "Height of the window clear opening";
  Modelica.Units.SI.Area clrOpnArea = winClrW*winClrH
    "Window clear opening area";
  Modelica.Blocks.Interfaces.RealOutput A(quantity="Area", unit="m2", min=0)
    "Window opening area"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,100},{80,-60}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,98},{78,-58}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,92},{72,-52}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialOpeningArea;
