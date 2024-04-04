within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashDIN16798
  "Specified DIN CEN/TR 16798-8: Bottom- or Top-hung  opening, input port opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final useInputPort=true,
    redeclare final Modelica.Blocks.Interfaces.RealInput u_win(
      quantity="Length", unit="m", min=0));
protected
  Real C_w "Coefficient depending on the kind of window";
equation
  assert(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    "The model is only valid for top- or bottom-hung opening.",
    AssertionLevel.error);
  opnWidth = u_win;
  opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
      winClrW, winClrH, opnWidth);
  assert((winClrH/winClrW >= 1) and (winClrH/winClrW <= 2),
    "For hinged windows, the model applies for height and width geometries of approx. 1:1 to 2:1",
    AssertionLevel.warning);
  C_w = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.coeffOpeningAreaDIN16798(
    opnAngle);
  A = C_w*clrOpnArea;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="DIN CEN/TR 16798-8")}),
                                Documentation(revisions="<html>
<ul>
  <li>
    <i>April 4, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end OpeningAreaSashDIN16798;
