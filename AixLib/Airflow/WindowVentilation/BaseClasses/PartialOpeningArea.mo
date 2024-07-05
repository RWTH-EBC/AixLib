within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningArea
  "Calculation of window opening area, unspecified type"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Length winClrWidth(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrHeight(min=0)
    "Height of the window clear opening";
  parameter Boolean use_opnWidth_in=true
    "Use input port for window sash opening width";
  parameter Modelica.Units.SI.Length prescribedOpnWidth(min=0)=0
    "Fixed value of prescribed opening width"
    annotation(Dialog(enable = not use_opnWidth_in));
  final parameter Modelica.Units.SI.Area AClrOpn = winClrWidth*winClrHeight
    "Window clear opening area";
  Modelica.Blocks.Interfaces.RealInput opnWidth_in(
    final quantity="Length", final unit="m", min=0) if use_opnWidth_in
    "Conditional input port for window sash opening width"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput A(
    final quantity="Area", final unit="m2", min=0)
    "Output port for window opening area, must be defined by extended model"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput opnWidth(final unit="m", min=0)
    "Internal port to connect to opnWidth_in or prescribedOpnWidth";
equation
  connect(opnWidth_in, opnWidth);
  if not use_opnWidth_in then
    opnWidth = prescribedOpnWidth;
  end if;
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
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of window opening area.</p>
</html>"));
end PartialOpeningArea;
