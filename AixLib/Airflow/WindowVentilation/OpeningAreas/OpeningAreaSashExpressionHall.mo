within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashExpressionHall
  "Window opening area according to the empirical expression of Hall"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
    final useInputPort=true,
    redeclare final Modelica.Blocks.Interfaces.RealInput u(
    quantity="Length", unit="m", min=0) "Window sash opening width");
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth";
  parameter Modelica.Units.SI.Length winGapW(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
  Modelica.Units.SI.Length opnWidth(min=0) "Window sash opening width";
  Real C_NPL "Correction factor of the neutral pressure level";
equation
  opnWidth = u;
  assert(winClrH >= winClrW,
    "The model only applies to windows whose height is not less than the width",
    AssertionLevel.warning);
  C_NPL = sqrt((winClrW - opnWidth)/winClrH);
  A = C_NPL*opnWidth*(winClrH*opnWidth/(opnWidth + winSashD) - winClrH*(1- C_NPL))
    + 2*winClrH*winSashD/(opnWidth + winSashD)*winGapW;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,90},{70,-50}},
          lineColor={0,0,0},
          fillColor={102,204,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,-50},{0,90},{70,-50}},
          color={0,0,0},
          thickness=0.5),
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
end OpeningAreaSashExpressionHall;
