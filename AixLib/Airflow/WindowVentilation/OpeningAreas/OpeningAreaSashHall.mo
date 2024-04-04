within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashHall
  "Specified Hall: Bottom-hung inwards opening, input port opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final useInputPort=true,
    final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    redeclare final Modelica.Blocks.Interfaces.RealInput u(
    quantity="Length", unit="m", min=0) "Window sash opening width");
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth";
  parameter Modelica.Units.SI.Length winGapW(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
  Real C_NPL "Correction factor of the neutral pressure level";
equation
  opnWidth = u;
  opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
    winClrW, winClrH, opnWidth);
  assert(winClrH >= winClrW,
    "The model only applies to windows whose height is not less than the width",
    AssertionLevel.warning);
  C_NPL = sqrt((winClrW - opnWidth)/winClrH);
  A = C_NPL*opnWidth*(winClrH*opnWidth/(opnWidth + winSashD) - winClrH*(1- C_NPL))
    + 2*winClrH*winSashD/(opnWidth + winSashD)*winGapW;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="Hall")}), Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end OpeningAreaSashHall;
