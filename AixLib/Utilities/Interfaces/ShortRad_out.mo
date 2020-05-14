within AixLib.Utilities.Interfaces;
connector ShortRad_out =output Real(min=0, final unit="W")
  "Output connector for short wave radiation"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Polygon(
      lineColor={0,0,127},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}}),                                                                                      Polygon(points={{
            -38,44},{-22,44},{-22,14},{6,20},{10,8},{-18,2},{0,-24},{-14,-32},{-30,
            -6},{-46,-34},{-60,-26},{-44,0},{-72,10},{-66,24},{-38,14},{-38,44}},                                                                                                                                                                                                        lineColor=
            {0,0,0},                                                                                                                                                                                                        fillColor=
            {0,255,0},
            fillPattern=FillPattern.Solid),
      Text(
        extent={{-56,114},{46,84}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        textString="%name%")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
