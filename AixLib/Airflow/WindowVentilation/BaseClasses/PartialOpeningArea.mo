within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningArea
  "Calculation of window opening area, unspecified type"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean useInputPort=true "Use input port for window sash opening";
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrH(min=0)
    "Height of the window clear opening";
  Modelica.Units.SI.Area clrOpnArea = winClrW*winClrH
    "Window clear opening area";
  replaceable Modelica.Blocks.Interfaces.RealInput u_win if useInputPort
    constrainedby Modelica.Blocks.Interfaces.RealInput
    "Conditional input port for window sash opening width or opening angle"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput A(quantity="Area", unit="m2", min=0)
    "Output port for window opening area"
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PartialOpeningArea;
