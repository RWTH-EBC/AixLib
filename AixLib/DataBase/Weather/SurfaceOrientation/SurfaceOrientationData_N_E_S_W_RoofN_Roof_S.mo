within AixLib.DataBase.Weather.SurfaceOrientation;
record SurfaceOrientationData_N_E_S_W_RoofN_Roof_S
  "North, East, South, West, Roof_N, Roof_S suitable to Standard OFD"
  extends SurfaceOrientationBaseDataDefinition(nSurfaces = 6, name = {"N", "O", "S", "W", "Roof_N", "Roof_S"}, Azimut = {180, -90, 0, 90, 180, 0}, Tilt = {90, 90, 90, 90, 45, 45});
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Surface Orientation Data for N,E,S,W,Roof_N and Roof_S suitable to
  standard OFD.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Data in this set:
</p>
<table summary=\"Data\" cellspacing=\"2\" cellpadding=\"0\" border=\"0\">
  <tr>
    <td style=\"background-color: #dcdcdc\">
      <p>
        Orientation
      </p>
    </td>
    <td style=\"background-color: #dcdcdc\">
      <p>
        Azimuth
      </p>
    </td>
    <td style=\"background-color: #dcdcdc\">
      <p>
        Tilt
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        N
      </p>
    </td>
    <td>
      <p>
        180
      </p>
    </td>
    <td>
      <p>
        90
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        E
      </p>
    </td>
    <td>
      <p>
        -90
      </p>
    </td>
    <td>
      <p>
        90
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        S
      </p>
    </td>
    <td>
      <p>
        0
      </p>
    </td>
    <td>
      <p>
        90
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        W
      </p>
    </td>
    <td>
      <p>
        90
      </p>
    </td>
    <td>
      <p>
        90
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Roof_N
      </p>
    </td>
    <td>
      <p>
        180
      </p>
    </td>
    <td>
      <p>
        45
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Roof_S
      </p>
    </td>
    <td>
      <p>
        0
      </p>
    </td>
    <td>
      <p>
        45
      </p>
    </td>
  </tr>
</table>
<p>
  <br/>
  <br/>
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a>
</p>
<ul>
  <li>
    <i>May 07, 2013&#160;</i> by Ole Odendahl:<br/>
    Added basic documentation
  </li>
</ul>
</html>
 "));
end SurfaceOrientationData_N_E_S_W_RoofN_Roof_S;
