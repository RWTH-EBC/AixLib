within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSash "Window opening with different types of sash"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes
    opnTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward
    "Window opening type";
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes
    opnAreaTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window opening area types for calculation";

  Modelica.Units.SI.Area geoOpnArea(min=0) "Geometric opening area";
  Modelica.Units.SI.Area projOpnArea(min=0) "Projective opening area";
  Modelica.Units.SI.Area eqOpnArea(min=0) "Equivalent opening area";
  Modelica.Units.SI.Area effOpnArea(min=0) "Effective opening area";
  Modelica.Blocks.Interfaces.RealInput s(quantity="Length", unit="m", min=0)
    "Window sash opening width"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.Units.SI.Length s90(min=0) "Sash opening with by 90° opening";
  Modelica.Units.SI.Area geoOpnArea90(min=0) "Geometric opening area by 90° opening";
  Modelica.Units.SI.Area eqOpnArea90(min=0) "Equivalent opening area by 90° opening";
equation
  /*Side-hung*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrH, winClrW, s);
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      winClrH, winClrW, s);
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      winClrH, winClrW, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrH, winClrW, s90);

  /*Top-bottom-hung*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrW, winClrH, s);
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      winClrW, winClrH, s);
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      winClrW, winClrH, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrW, winClrH, s90);

  /*Pivot, vertical*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrH, winClrW/2, s)*2;
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      winClrH, winClrW/2, s)*2;
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      winClrH, winClrW/2, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrH, winClrW/2, s90)*2;

  /*Pivot, horizontal*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrW, winClrH/2, s)*2;
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      winClrW, winClrH/2, s)*2;
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      winClrW, winClrH/2, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      winClrW, winClrH/2, s90)*2;

  /*Sliding, vertical*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
    assert(
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric,
      "By opening type 'SlidingVertical', only 'geometric' opening area is applicable.",
      AssertionLevel.warning);
    geoOpnArea = winClrW*s;
    projOpnArea = winClrW*s;
    s90 = winClrH;
    geoOpnArea90 = winClrW*s90;

  /*Sliding, horizontal*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    assert(
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric,
      "By opening type 'SlidingHorizontal', only 'geometric' opening area is applicable.",
      AssertionLevel.warning);
    geoOpnArea = winClrH*s;
    projOpnArea = winClrH*s;
    s90 = winClrW;
    geoOpnArea90 = winClrH*s90;

  /*Exceptions*/
  else
    geoOpnArea = 0;
    projOpnArea = 0;
    s90 = 0;
    geoOpnArea90 = 0;
  end if;

  /*Calculate the rest area types*/
  eqOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.equivalentOpeningArea(
    clrOpnArea, geoOpnArea);
  eqOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.equivalentOpeningArea(
    clrOpnArea, geoOpnArea90);
  effOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.effectiveOpeningArea(
    clrOpnArea, eqOpnArea, eqOpnArea90);

  /*Export area to port based on choice*/
  A = if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric then
    geoOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective then
    projOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent then
    eqOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective then
    effOpnArea else 0;
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
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="%opnAreaTyp")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
end OpeningAreaSash;
