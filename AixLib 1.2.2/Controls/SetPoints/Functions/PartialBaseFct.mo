within AixLib.Controls.SetPoints.Functions;
partial function PartialBaseFct "Base function of a heating curve"
  extends Modelica.Icons.Function;

  input Modelica.Units.SI.ThermodynamicTemperature T_oda
    "Outdoor air temperature";
  input Modelica.Units.SI.ThermodynamicTemperature TRoom "Room temperature";
  input Boolean isDay "Boolean to evaulate if it is day or night";
  output Modelica.Units.SI.ThermodynamicTemperature TSet
    "Set temperature for the heat generator";

  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Calculate a set temperature based on the outdoor air and room
  temperature. The boolean isDay enables day/night dependent set
  temperatures.
</p>
<p>
  Used in model <a href=
  \"modelica://AixLib.Controls.SetPoints.HeatingCurve\">HeatingCurve</a>.
</p>
</html>"));
end PartialBaseFct;
