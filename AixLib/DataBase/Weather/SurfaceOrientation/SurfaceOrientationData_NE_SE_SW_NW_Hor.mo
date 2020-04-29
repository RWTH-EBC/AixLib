within AixLib.DataBase.Weather.SurfaceOrientation;
record SurfaceOrientationData_NE_SE_SW_NW_Hor
  "Northeast, Southeast, Southwest, Northwest, Horizontal"
  extends SurfaceOrientationBaseDataDefinition(nSurfaces = 5, name = {"NE", "SE", "SW", "NW", "Hor"}, Azimut = {-135, -45, 45, 135, 0}, Tilt = {90, 90, 90, 90, 0});
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Surface Orientation Data for NE,SE,SW and NW
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
        NE
      </p>
    </td>
    <td>
      <p>
        -135
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
        SE
      </p>
    </td>
    <td>
      <p>
        -45
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
        SW
      </p>
    </td>
    <td>
      <p>
        45
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
        NW
      </p>
    </td>
    <td>
      <p>
        135
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
        Hor
      </p>
    </td>
    <td>
      <p>
        0
      </p>
    </td>
    <td>
      <p>
        0
      </p>
    </td>
  </tr>
</table>
<p>
  <br/>
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
end SurfaceOrientationData_NE_SE_SW_NW_Hor;
