within AixLib.Utilities.Interfaces;
partial connector ShortRadSurf
  "Input connector for short wave radiation for a surface"

  parameter Modelica.SIunits.Area A=0 "Area of surface";
  parameter Real eps=0 "Emissivity of surface";
  parameter Real rho=0 "Reflectivity of surface";
  parameter Real tau=0 "Transmissivity of surface";
  parameter Real alpha = eps "Absorptivity of surface, equal to eps or 1-rho-tau";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={                                                                       Polygon(points={{
              -8,36},{8,36},{8,6},{36,12},{40,0},{12,-6},{30,-32},{16,-40},{0,-14},
              {-16,-42},{-30,-34},{-14,-8},{-42,2},{-36,16},{-8,6},{-8,36}},                                                                                                                                                                                                        lineColor=
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
end ShortRadSurf;
