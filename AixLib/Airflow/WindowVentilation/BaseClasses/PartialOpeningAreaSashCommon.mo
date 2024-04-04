within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialOpeningAreaSashCommon
  "Window common opening areas in four types, different types of sash opening"
  extends PartialOpeningAreaSash;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes
    opnAreaTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window opening area types by calculation";

  /*Characterize lengths*/
  Modelica.Units.SI.Length lenA(min=0)
    "Length A to characterize the hung and pivot window opening:
    length of the hinged axis";
  Modelica.Units.SI.Length lenB(min=0)
    "Length B to characterize the hung and pivot window opening:
    distance from the hinged axis to the frame across the opening area";

  /*Variables to describe the opening*/
  Modelica.Units.SI.Area geoOpnArea(min=0) "Geometric opening area";
  Modelica.Units.SI.Area projOpnArea(min=0) "Projective opening area";
  Modelica.Units.SI.Area eqOpnArea(min=0) "Equivalent opening area";
  Modelica.Units.SI.Area effOpnArea(min=0) "Effective opening area";
protected
  Modelica.Units.SI.Length s90(min=0)
    "Sash opening width by 90° opening / full sliding opening";
  Modelica.Units.SI.Area geoOpnArea90(min=0)
    "Geometric opening area by 90° opening";
  Modelica.Units.SI.Area eqOpnArea90(min=0)
    "Equivalent opening area by 90° opening";
equation
  /*Hinged opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.geometricOpeningArea(
      lenA, lenB, opnWidth);
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.projectiveOpeningArea(
      lenA, lenB, opnWidth);
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.alpha_to_s(
      lenA, lenB, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.geometricOpeningArea(
      lenA, lenB, s90);
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward then
      /*Side-hung*/
      lenA = winClrH;
      lenB = winClrW;
    else
      /*Top-bottom-hung*/
      lenA = winClrW;
      lenB = winClrH;
    end if;

  /*Pivot opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.geometricOpeningArea(
      lenA, lenB, opnWidth)*2;
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.projectiveOpeningArea(
      lenA, lenB, opnWidth)*2;
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.alpha_to_s(
      lenA, lenB, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.geometricOpeningArea(
      lenA, lenB, s90)*2;
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical then
      /*Vertical pivot axis*/
      lenA = winClrH;
      lenB = winClrW/2;
    else
      /*Horizontal pivot axis*/
      lenA = winClrW;
      lenB = winClrH/2;
    end if;

  /*Sliding opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    assert(
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric,
      "By opening type 'Sliding', only 'geometric' opening area is applicable.",
      AssertionLevel.warning);
    lenA = 0;
    lenB = 0;
    projOpnArea = geoOpnArea;
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
      /*Vertical*/
      geoOpnArea = winClrW*opnWidth;
      s90 = winClrH;
      geoOpnArea90 = winClrW*s90;
    else
      /*Horizontal*/
      geoOpnArea = winClrH*opnWidth;
      s90 = winClrW;
      geoOpnArea90 = winClrH*s90;
    end if;

  /*Exceptions*/
  else
    lenA = 0;
    lenB = 0;
    geoOpnArea = 0;
    projOpnArea = 0;
    s90 = 0;
    geoOpnArea90 = 0;
  end if;

  /*Calculate the rest area types*/
  eqOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.equivalentOpeningArea(
    clrOpnArea, geoOpnArea);
  eqOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.equivalentOpeningArea(
    clrOpnArea, geoOpnArea90);
  effOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.effectiveOpeningArea(
    clrOpnArea, eqOpnArea, eqOpnArea90);

  /*Export area to port based on choice*/
  A = if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric then
    geoOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective then
    projOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent then
    eqOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective then
    effOpnArea else 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="%opnAreaTyp")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PartialOpeningAreaSashCommon;
