within AixLib.Airflow.WindowVentilation.Utilities;
model WindProfilePowerLaw
  "Wind profile power law relationship of Hellmann"
  parameter Modelica.Units.SI.Height height(min=0)
    "Height of the wind speed to calculate";
  parameter Modelica.Units.SI.Height heightRef(min=0)=10
    "Reference height of the known wind speed";
  parameter Modelica.Units.SI.Length lenRuf(min=0)=0.6 "Roughness length";
  Real cof "Hellmann exponent (coefficient)";
  Modelica.Blocks.Interfaces.RealInput winSpeRef(unit="m/s", min=0)
    "Wind speed at the reference height"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput winSpe(unit="m/s", min=0)
    "Wind speed at height"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  assert(
    height > lenRuf,
    "Power law not applicable by height less than the roughness length",
    AssertionLevel.error);
  cof = 1/log(height/lenRuf);
  winSpe = winSpeRef*(height/heightRef)^cof;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model contains the wind profile power law relationship of
  Hellmann.
</p>
<p>
  The power law allows for the calculation of wind speeds at different
  heightghts based on the reference speed and heightght.
</p>
<h4>
  Roughness Classes and Lengths
</h4>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\">
  <tr>
    <td>
      <h4>
        Roughness class
      </h4>
    </td>
    <td>
      <h4>
        Roughness length / m
      </h4>
    </td>
    <td>
      <h4>
        Land cover types
      </h4>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        0
      </p>
    </td>
    <td>
      <p>
        0.0002
      </p>
    </td>
    <td>
      <p>
        Water surfaces: seas and Lakes
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <br/>
        <br/>
        0.5
      </p>
    </td>
    <td>
      <p>
        0.0024
      </p>
    </td>
    <td>
      <p>
        Open terrain with smooth surface, e.g. concrete, airport
        runways, mown grass etc.
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <br/>
        <br/>
        1
      </p>
    </td>
    <td>
      <p>
        0.03
      </p>
    </td>
    <td>
      <p>
        Open agricultural land without fences and hedges; maybe some
        far apart buildings and very gentle hills
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <br/>
        <br/>
        1.5
      </p>
    </td>
    <td>
      <p>
        0.055
      </p>
    </td>
    <td>
      <p>
        Agricultural land with a few buildings and 8 m high hedges
        seperated by more than 1 km
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <br/>
        <br/>
        2
      </p>
    </td>
    <td>
      <p>
        0.1
      </p>
    </td>
    <td>
      <p>
        Agricultural land with a few buildings and 8 m high hedges
        seperated by approx. 500 m
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <br/>
        <br/>
        2.5
      </p>
    </td>
    <td>
      <p>
        0.2
      </p>
    </td>
    <td>
      <p>
        Agricultural land with many trees, bushes and plants, or 8 m
        high hedges seperated by approx. 250 m
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        3
      </p>
    </td>
    <td>
      <p>
        0.4
      </p>
    </td>
    <td>
      <p>
        Towns, villages, agricultural land with many or high hedges,
        forests and very rough and uneven terrain
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        3.5
      </p>
    </td>
    <td>
      <p>
        0.6
      </p>
    </td>
    <td>
      <p>
        Large towns with high buildings
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        4
      </p>
    </td>
    <td>
      <p>
        1.6
      </p>
    </td>
    <td>
      <p>
        Large cities with high buildings and skyscrapers
      </p>
    </td>
  </tr>
</table>
<p>
  <br/>
</p>
<h4>
  References
</h4>
<p>
  <br/>
  Hau, E. (2016). Windkraftanlagen: Grundlagen, Technik, Einsatz,
  Wirtschaftlichkeit (6. Auflage). Springer Vieweg.
</p>
<p>
  <br/>
  <a href=
  \"https://wind-data.ch/tools/profile.php\">https://wind-data.ch/tools/profile.php</a>
</p>
</html>", revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>"));
end WindProfilePowerLaw;
