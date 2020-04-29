within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.BaseClasses;
function DeterminePositionsInWeatherVector
  "Determines position in weather vector"
  input Boolean Cloud_cover "Cloud cover";
  input Boolean Wind_dir "Wind direction";
  input Boolean Wind_speed "Wind speed";
  input Boolean Air_temp "Air temperature";
  input Boolean Air_press "Air pressure";
  input Boolean Mass_frac "Mass fraction of water in dry air";
  input Boolean Rel_hum "Relative humidity";
  input Boolean Sky_rad "Long wave sky radiation on horizontal surface";
  input Boolean Ter_rad
    "Long Wave terrestrial radiation from horizontal surface";
  output Integer[9] PosWV = fill(0, 9)
    "Determined postition in weather data vector";
protected
  Integer m;
algorithm
  m := 1;
  if Cloud_cover then
    PosWV[1] := m;
    m := m + 1;
  end if;
  if Wind_dir then
    PosWV[2] := m;
    m := m + 1;
  end if;
  if Wind_speed then
    PosWV[3] := m;
    m := m + 1;
  end if;
  if Air_temp then
    PosWV[4] := m;
    m := m + 1;
  end if;
  if Air_press then
    PosWV[5] := m;
    m := m + 1;
  end if;
  if Mass_frac then
    PosWV[6] := m;
    m := m + 1;
  end if;
  if Rel_hum then
    PosWV[7] := m;
    m := m + 1;
  end if;
  if Sky_rad then
    PosWV[8] := m;
    m := m + 1;
  end if;
  if Ter_rad then
    PosWV[9] := m;
    m := m + 1;
  end if;
  annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately, added variable descriptions
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Determines the position of the given input(s) in the weather vector
  of the <a href=\"Building.Components.Weather.Weather\">weather</a>
  model.
</p>
</html>"));
end DeterminePositionsInWeatherVector;
