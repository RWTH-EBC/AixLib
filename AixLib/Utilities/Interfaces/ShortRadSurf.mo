within AixLib.Utilities.Interfaces;
expandable connector ShortRadSurf
  "Expandable connector for short wave radiation for a surface inside a room"
  // Note: For this bus, the naming convention was not considered on purpose, as the convention is mainly for bus connectors used in controls.
  Modelica.Units.SI.Power Q_flow_ShoRadOnSur
    "Short waved radiation from the room on to the inner surfaces";
  Modelica.Units.SI.Power Q_flow_ShoRadFroSur
    "Short waved radiation from the inner surfaces to the room";

  Modelica.Units.SI.Length length "Length of surface"
    annotation (HideResult=false);
  Modelica.Units.SI.Height height "Height of surface"
    annotation (HideResult=false);
  Real solar_reflectance "Reflectivity of inner surface"
                                     annotation(HideResult=false);
  Real g "Transmissivity of inner surface"   annotation(HideResult=false);
  Real solar_absorptance "Absorptivity of inner surface, equal to eps or 1-rho-tau"
                                                                  annotation(HideResult=false);
  annotation (Icon(                                             graphics={                                                                       Polygon(points = {{-13, 86}, {13, 86}, {13, 12}, {77, 34}, {85, 6}, {22, -14}, {62, -72}, {37, -88}, {0, -28}, {-35, -88}, {-60, -72}, {-22, -14}, {-85, 6}, {-77, 34}, {-13, 12}, {-13, 86}}, lineColor={0,0,0},
                                                                                                                                                                                                        fillColor={255,255,170},
            fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>
  This connector holds variables used to calculate the short wave
  radiation in a room. As you may notice, some of the variables are
  actually parameters. We chose this approach to pass parameters from
  e.g. a wall model directly to the model which calculates the
  radiation exchange (e.g. <a href=
  \"AixLib.Utilities.HeatTransfer.SolarRadInRoom\">SolarRadInRoom</a>).
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>June, 18, 2020</i> by Fabian Wuellhorst:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/918\">#918</a>:
    Implemented.
  </li>
</ul>
</html>"));
end ShortRadSurf;
