within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningAreaSash
  "Window opening area, sash opening"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes
    opnTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward
    "Window opening type";
  /*Variables to describe the opening*/
  Modelica.Units.SI.Angle opnAng(
    min=0, max=Modelica.Constants.pi/2, displayUnit="deg")
    "Window sash opening angle, must be defined by extended model";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,90},{70,-50}},
          lineColor={0,0,0},
          fillColor={102,204,255},
          fillPattern=FillPattern.Solid),
        Line(
          points=DynamicSelect({{-70,90},{70,20},{-70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward
              then {{-70,90},{70,20},{-70,-50}} else {{-70,90}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{-70,90},{70,20},{-70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward
              then {{-70,90},{70,20},{-70,-50}} else {{-70,90}}),
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points=DynamicSelect({{-70,90},{0,-50},{70,90}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward
              then {{-70,90},{0,-50},{70,90}} else {{-70,90}}),
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points=DynamicSelect({{-70,-50},{0,90},{70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward
              then {{-70,-50},{0,90},{70,-50}} else {{-70,-50}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{0,90},{70,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{0,90},{70,20}} else {{0,90}}),
          color={0,0,0},
          thickness=0.5,
          pattern=DynamicSelect(LinePattern.Solid,
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical
              then LinePattern.Solid else LinePattern.Dash)),
        Line(
          points=DynamicSelect({{70,20},{0,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{70,20},{0,-50}} else {{70,20}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{0,-50},{-70,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{0,-50},{-70,20}} else {{0,-50}}),
          color={0,0,0},
          thickness=0.5,
          pattern=DynamicSelect(LinePattern.Dash,
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical
              then LinePattern.Dash else LinePattern.Solid)),
        Line(
          points=DynamicSelect({{-70,20},{0,90}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{-70,20},{0,90}} else {{-70,20}}),
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points=DynamicSelect({{0,40},{0,80}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical
              then {{0,40},{0,80}} else {{0,40}}),
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points=DynamicSelect({{20,20},{60,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal
              then {{20,20},{60,20}} else {{20,20}}),
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled})}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of window sash opening area.</p>
</html>"));
end PartialOpeningAreaSash;
