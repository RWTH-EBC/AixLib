within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashDIN16798
  "Specified DIN CEN/TR 16798-8: Only valid for bottom- or top-hung opening"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash;
  Real cof "Coefficient depending on the kind of window";
equation
  assert(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    "The model is only valid for top- or bottom-hung opening.",
    AssertionLevel.error);
  opnAng =
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
    winClrWidth, winClrHeight, opnWidth);
  assert((winClrHeight/winClrWidth >= 1) and (winClrHeight/winClrWidth <= 2),
    "For hinged windows, the model applies for height and width geometries of approx. 1:1 to 2:1",
    AssertionLevel.warning);
  cof = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.CoeffOpeningAreaDIN16798(
    opnAng);
  A = cof*AClrOpn;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="DIN CEN/TR 16798-8")}),
                                Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8):2018-03.</p>
<p>Only top- or bottom-hung openings can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashDIN16798;
