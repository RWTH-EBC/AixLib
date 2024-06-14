within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashDIN4108
  "Specified DIN/TS 4108-8: Valid for different opening types"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash;
  parameter Modelica.Units.SI.Thickness sWinSas(min=0) = 0
    "Window sash thickness (depth)"
    annotation(Dialog(enable=(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal)));
equation
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward then
    A = if opnWidth < Modelica.Constants.eps then 0 else
      sqrt(1/((winClrWidth*winClrHeight)^(-2) + (2*winClrWidth*winClrHeight*sin(opnAng/2) + winClrWidth^2*sin(opnAng))^(-2)));

  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    assert((winClrHeight/winClrWidth >= 1) and (winClrHeight/winClrWidth <= 2),
      "For hinged windows, the model applies for height and width geometries of approx. 1:1 to 2:1",
      AssertionLevel.warning);
    assert(opnAng <= Modelica.Units.Conversions.from_deg(30),
      "The model only applies to a maximum tilt angle of 30°",
      AssertionLevel.warning);
    A = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.CoeffOpeningAreaDIN16798(
      opnAng)*winClrWidth*winClrHeight;

  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    A = if opnWidth < Modelica.Constants.eps then 0 else
      min(2*(opnWidth*(winClrWidth - 2*sWinSas) + opnWidth*sqrt((winClrHeight/2*opnWidth/(opnWidth + sWinSas))^2 - 0.25*opnWidth^2)),
      (winClrHeight - sWinSas)*winClrWidth);

  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
    A = opnWidth*winClrWidth;

  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    A = opnWidth*winClrHeight;

  else
    A = 0;
  end if;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="DIN/TS 4108-8")}),
                                Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to DIN/TS 4108-8:2022-09.</p>
<p>All common <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Types/WindowOpeningTypes.mo\">window opening types</a> can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashDIN4108;
