within AixLib.Utilities.Interfaces;
expandable connector ShortRadSurf
  "Expandable connector for short wave radiation for a surface"
  Modelica.SIunits.Power QRad_out "Outuput short waved radiation heat flow rate";
  Modelica.SIunits.Power QRad_in "Input short waved radiation heat flow rate";

  Modelica.SIunits.Length L "Length of surface" annotation(HideResult=false);
  Modelica.SIunits.Height H "Height of surface" annotation(HideResult=false);
  Real eps "Emissivity of surface" annotation(HideResult=false);
  Real rho "Reflectivity of surface" annotation(HideResult=false);
  Real tau "Transmissivity of surface" annotation(HideResult=false);
  Real alpha "Absorptivity of surface, equal to eps or 1-rho-tau" annotation(HideResult=false);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={                                                                       Polygon(points = {{-13, 86}, {13, 86}, {13, 12}, {77, 34}, {85, 6}, {22, -14}, {62, -72}, {37, -88}, {0, -28}, {-35, -88}, {-60, -72}, {-22, -14}, {-85, 6}, {-77, 34}, {-13, 12}, {-13, 86}}, lineColor=
              {0,0,0},                                                                                                                                                                                                        fillColor=
              {0,255,0},
            fillPattern=FillPattern.Solid),
      Text(
        extent={{-100,18},{100,-20}},
        lineColor={0,0,0},
        pattern=LinePattern.None,
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
          textString="%name%")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShortRadSurf;
