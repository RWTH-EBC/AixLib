within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlow
  "Partial model for empirical expressions of ventilation flow rate"
  final parameter Boolean useInputPort=openingArea.useInputPort
    "Use input port for window sash opening";
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrH(min=0)
    "Height of the window clear opening";

  /*Opening area model*/
  replaceable model OpeningArea =
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea
    constrainedby
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
      final winClrW=winClrW, final winClrH=winClrH)
    annotation (choicesAllMatching=true);
  OpeningArea openingArea
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Interfaces.RealInput u_win(min=0) if useInputPort
    "Window sash opening width or angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput V_flow(
    quantity="VolumeFlowRate", unit="m3/s", min=0)
    "Ventilation flow rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(u_win, openingArea.u_win) annotation (Line(
      points={{0,120},{0,70},{18,70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash, if useInputPort then LinePattern.Solid
           else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PartialEmpiricalFlow;
