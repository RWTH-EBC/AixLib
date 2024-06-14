within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashCommon
  "Calculate geometric, projective, equivalent, and effective window opening
  areas, by different types of sash opening"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes
    opnAreaTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window opening area types to calculate";

  /*Characterize lengths*/
  final parameter Modelica.Units.SI.Length lenAxs(min=0)=
    if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical) then
    winClrHeight else if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal) then
    winClrWidth else 0
    "Length to characterize the hung and pivot window opening:
    length of the hinged axis";
  final parameter Modelica.Units.SI.Length lenAxsToFrm(min=0)=
    if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward) then
    winClrWidth else if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward) then
    winClrHeight else if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical) then
    winClrWidth/2 else if (opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal) then
    winClrHeight/2 else 0
    "Length to characterize the hung and pivot window opening:
    distance from the hinged axis to the frame across the opening area";

  /*Variables to describe the opening*/
  Modelica.Units.SI.Area AGeoOpn(min=0) "Geometric opening area";
  Modelica.Units.SI.Area APrjOpn(min=0) "Projective opening area";
  Modelica.Units.SI.Area AEqvOpn(min=0) "Equivalent opening area";
  Modelica.Units.SI.Area AEffOpn(min=0) "Effective opening area";
protected
  Modelica.Units.SI.Length opnWidth90(min=0)
    "Sash opening width by 90° opening / full sliding opening";
  Modelica.Units.SI.Area AGeoOpn90(min=0)
    "Geometric opening area by 90° opening";
  Modelica.Units.SI.Area AEqvOpn90(min=0)
    "Equivalent opening area by 90° opening";
equation
  /*Hinged opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    /*Calculate area values*/
    AGeoOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.GeometricOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth);
    APrjOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.ProjectiveOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth);
    opnWidth90 =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.AngleToWidth(
      lenAxs, lenAxsToFrm, Modelica.Constants.pi/2);
    AGeoOpn90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.GeometricOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth90);

  /*Pivot opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    /*Calculate area values*/
    AGeoOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.GeometricOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth)*2;
    APrjOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.ProjectiveOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth)*2;
    opnWidth90 =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.AngleToWidth(
      lenAxs, lenAxsToFrm, Modelica.Constants.pi/2);
    AGeoOpn90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.GeometricOpeningArea(
      lenAxs, lenAxsToFrm, opnWidth90)*2;

  /*Sliding opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    /*Calculate area values*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
      /*Vertical*/
      AGeoOpn = winClrWidth*opnWidth;
      opnWidth90 = winClrHeight;
      AGeoOpn90 = winClrWidth*opnWidth90;
    else
      /*Horizontal*/
      AGeoOpn = winClrHeight*opnWidth;
      opnWidth90 = winClrWidth;
      AGeoOpn90 = winClrHeight*opnWidth90;
    end if;
    assert(
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric,
      "By opening type 'Sliding', only 'geometric' opening area is applicable.",
      AssertionLevel.warning);
    APrjOpn = AGeoOpn;

  /*Exceptions*/
  else
    AGeoOpn = 0;
    APrjOpn = 0;
    opnWidth90 = 0;
    AGeoOpn90 = 0;
  end if;

  /*Calculate the rest area types*/
  AEqvOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.EquivalentOpeningArea(
    AClrOpn, AGeoOpn);
  AEqvOpn90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.EquivalentOpeningArea(
    AClrOpn, AGeoOpn90);
  AEffOpn = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.EffectiveOpeningArea(
    AClrOpn, AEqvOpn, AEqvOpn90);

  /*Export area to port based on choice*/
  A = if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric then
    AGeoOpn else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective then
    APrjOpn else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent then
    AEqvOpn else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective then
    AEffOpn else 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="%opnAreaTyp")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of common window sash opening area, incl. geometric, projective, equivalent, and effective opening area.</p>
</html>"));
end OpeningAreaSashCommon;
