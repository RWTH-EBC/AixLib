within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashDIN4108
  "Specified DIN/TS 4108-8: Different openings, input port opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final useInputPort=true,
    redeclare final Modelica.Blocks.Interfaces.RealInput u_win(
      quantity="Length", unit="m", min=0));
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth"
    annotation(Dialog(enable=(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal)));
equation
  opnWidth = u_win;
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward then
    opnAngle =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
      winClrH,
      winClrW,
      opnWidth);
    A = if opnWidth < Modelica.Constants.eps then 0 else sqrt(1/
      ((winClrW*winClrH)^(-2) + (2*winClrW*winClrH*sin(opnAngle/2) + winClrW^2*sin(opnAngle))^(-2)));
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    assert((winClrH/winClrW >= 1) and (winClrH/winClrW <= 2),
      "For hinged windows, the model applies for height and width geometries of approx. 1:1 to 2:1",
      AssertionLevel.warning);
    opnAngle =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
      winClrW,
      winClrH,
      opnWidth);
    assert(opnAngle <= Modelica.Units.Conversions.from_deg(30),
      "The model only applies to a maximum tilt angle of 30°",
      AssertionLevel.warning);
    A = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.CoeffOpeningAreaDIN16798(
      opnAngle)*winClrW*winClrH;
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle =if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical
       then
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
      winClrH,
      winClrW/2,
      opnWidth) else
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
      winClrW,
      winClrH/2,
      opnWidth);
    A = if opnWidth < Modelica.Constants.eps then 0 else
      min(2*(opnWidth*(winClrW - 2*winSashD) + opnWidth*sqrt((winClrH/2*opnWidth/(opnWidth + winSashD))^2 - 0.25*opnWidth^2)),
      (winClrH - winSashD)*winClrW);
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
    opnAngle = 0;
    A = opnWidth*winClrW;
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    opnAngle = 0;
    A = opnWidth*winClrH;
  else
    opnAngle = 0;
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
    <i>April 4, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to DIN/TS 4108-8:2022-09.</p>
<p>All common <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Types/WindowOpeningTypes.mo\">window opening types</a> can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashDIN4108;
