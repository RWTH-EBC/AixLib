within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSimple "Common simple opening (no sash)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
    final useInputPort=false,
    final u_win);
equation
  A = clrOpnArea;
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
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area by a simple opening without window sash.</p>
</html>"));
end OpeningAreaSimple;
