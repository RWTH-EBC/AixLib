within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.BaseClasses;
function CalculateNrOfOutputs "Calculates number of outputs"
  input Boolean Cloud_cover "Cloud cover";
  input Boolean Wind_dir "Wind direction";
  input Boolean Wind_speed "Wind speed";
  input Boolean Air_temp "Air temperature";
  input Boolean Air_press "Air pressure";
  input Boolean Mass_frac "Mass fraction of water in dry air";
  input Boolean Rel_hum "Relative humidity";
  input Boolean Sky_rad "Long wave radiation of the sky on horizontal surface";
  input Boolean Ter_rad
    "Long wave terrestrial radiation from horizontal surface";
  output Integer m "Number of Outputs";
algorithm
  m := 0;
  if Cloud_cover then
    m := m + 1;
  end if;
  if Wind_dir then
    m := m + 1;
  end if;
  if Wind_speed then
    m := m + 1;
  end if;
  if Air_temp then
    m := m + 1;
  end if;
  if Air_press then
    m := m + 1;
  end if;
  if Mass_frac then
    m := m + 1;
  end if;
  if Rel_hum then
    m := m + 1;
  end if;
  if Sky_rad then
    m := m + 1;
  end if;
  if Ter_rad then
    m := m + 1;
  end if;
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Calculates the number of outputs based on the given inputs.
</p>
<ul>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately, added descriptions for
    variables
  </li>
</ul>
</html>"));
end CalculateNrOfOutputs;
