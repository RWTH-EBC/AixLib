within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlow
  "Partial model for empirical expressions of ventilation flow rate"
  parameter Modelica.Units.SI.Length winClrWidth(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrHeight(min=0)
    "Height of the window clear opening";
  final parameter Boolean use_opnWidth_in=openingArea.use_opnWidth_in
    "Use input port for window sash opening";
  Modelica.Blocks.Interfaces.RealInput opnWidth_in(
    final quantity="Length", final unit="m", min=0) if use_opnWidth_in
    "Conditional input port for window sash opening width"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput V_flow(
    final quantity="VolumeFlowRate", final unit="m3/s", min=0)
    "Ventilation flow rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  replaceable AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea
    openingArea constrainedby
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
      final winClrWidth=winClrWidth,
      final winClrHeight=winClrHeight)
    "Model for window opening area calculation"
    annotation (Placement(transformation(extent={{20,60},{40,80}})), choicesAllMatching=true);
equation
  connect(opnWidth_in, openingArea.opnWidth_in) annotation (Line(
      points={{0,120},{0,70},{18,70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash, if use_opnWidth_in then
          LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of models that estimate ventilation volume flow.</p>
</html>"));
end PartialEmpiricalFlow;
