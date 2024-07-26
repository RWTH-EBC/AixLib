within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSimple "Common simple opening (no sash)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
    final use_opnWidth_in=false,
    final prescribedOpnWidth=0);
equation
  A = AClrOpn;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,90},{70,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="Simple")}), Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area by a simple opening without window sash.</p>
</html>"));
end OpeningAreaSimple;
