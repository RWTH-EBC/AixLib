within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashHall
  "Specified Hall: Only valid for bottom-hung inwards opening"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward);
  parameter Modelica.Units.SI.Thickness sWinSas(min=0) = 0
    "Window sash thickness (depth)";
  parameter Modelica.Units.SI.Length winGapWidth(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
  Real corNPL "Correction factor of the neutral pressure level";
equation
  assert(winClrHeight >= winClrWidth,
    "The model only applies to windows whose height is not less than the width",
    AssertionLevel.warning);
  corNPL = sqrt((winClrWidth - opnWidth)/winClrHeight);
  A = if noEvent(opnWidth > Modelica.Constants.eps) then
    corNPL*opnWidth*(winClrHeight*opnWidth/(opnWidth + sWinSas) - winClrHeight*(1 - corNPL))
    + 2*winClrHeight*sWinSas/(opnWidth + sWinSas)*winGapWidth else 0;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="Hall")}), Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to the empirical expression developed by Hall.</p>
<p>Only bottom-hung openings can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashHall;
