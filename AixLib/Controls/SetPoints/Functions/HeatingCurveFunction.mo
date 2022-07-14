within AixLib.Controls.SetPoints.Functions;
function HeatingCurveFunction "Linear function with a set temperature of 55degC at -20 degC outdoor air temperature"
  extends PartialBaseFct;

  parameter Modelica.Units.SI.TemperatureDifference TOffNig=10
    "Delta K for night mode of heating system";
  parameter Modelica.Units.SI.ThermodynamicTemperature TDesign=328.15
    "Design temperature of heating system at -20 °C outside air temperature";
algorithm
  if isDay then
    TSet := (TDesign-273.15) + ((TRoom-TDesign)/(TRoom-253.15))*((T_oda-273.15)+20);
  else
    TSet := (TDesign-273.15) + ((TRoom-TDesign)/(TRoom-253.15))*((T_oda-273.15)+20)-TOffNig;
  end if;
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Calculate the set temperature with a linear approach. The room
  temperature serves as the set point(e.g. 20°C).
</p>
</html>"));
end HeatingCurveFunction;
