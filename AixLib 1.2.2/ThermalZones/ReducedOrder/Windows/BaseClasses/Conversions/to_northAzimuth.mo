within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions;
function to_northAzimuth
  "Conversion from azimuth based on AixLib to north based azimuth"
  extends Modelica.Units.Icons.Conversion;
  input Modelica.Units.SI.Angle azi "Surface azimuth. azi=-90 degree if surface outward unit normal points
   toward east; azi=0 if it points toward south";
  output Modelica.Units.SI.Angle alpha "North based azimuth. alpha=0 if surface outward unit normal points toward
   north; alpha=90 degree if it points toward east.";
algorithm
  alpha:=Modelica.Constants.pi+azi;

  annotation (Documentation(info="<html><p>
  This Function converts the azimuth based on <a href=
  \"AixLib\">AixLib</a> to the north based definition.
</p>
</html>",
        revisions="<html><ul>
  <li>June 07, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end to_northAzimuth;
