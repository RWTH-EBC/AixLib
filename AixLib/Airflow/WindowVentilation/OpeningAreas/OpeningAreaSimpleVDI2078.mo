within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSimpleVDI2078
  "Specified VDI 2078: Simple opening (no sash)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea(
    final useInputPort=false,
    final u_win);
  Modelica.Units.SI.Height H_eff(min=0)
    "Effective height for the thermal updraft";
equation
  H_eff = 2/3*winClrH;
  A = 1/3*clrOpnArea;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,90},{70,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="VDI 2078")}), Documentation(revisions="<html>
<ul>
  <li>
    <i>April 3, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area by a simple opening without window sash according to VDI 2078:2015-06.</p>
</html>"));
end OpeningAreaSimpleVDI2078;
