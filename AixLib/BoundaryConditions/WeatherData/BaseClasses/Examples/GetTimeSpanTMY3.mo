within AixLib.BoundaryConditions.WeatherData.BaseClasses.Examples;
model GetTimeSpanTMY3 "Test model to get the time span of a weather file"
  extends Modelica.Icons.Example;

  parameter String filNam = Modelica.Utilities.Files.loadResource(
  "modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    "Name of weather data file";
  parameter String tabNam = "tab1" "Name of table on weather file";

  parameter Modelica.SIunits.Time[2] timeSpan(each fixed=false)
    "Start time, end time of weather data";

protected
  constant Modelica.SIunits.Time endTim = 365*24*3600.;
  constant Modelica.SIunits.Time staTim = 0.;

initial equation
  timeSpan = AixLib.BoundaryConditions.WeatherData.BaseClasses.getTimeSpanTMY3(
  filNam, tabNam);

  assert(abs(timeSpan[2]-endTim) < 1E-5  and abs(timeSpan[1]-staTim) < 1E-5,
      "Error in weather file, start time " + String(timeSpan[1]) +
      " and end time " + String(timeSpan[2]) +
      ", but expected " + String(staTim) + " and " + String(endTim) + ".");

  annotation (
    Documentation(info="<html>
<p>
This example tests getting the time span of a TMY3 weather data file.
</p>
</html>",
revisions="<html>
<ul>
<li>
April 16, 2019, by Michael Wetter:<br/>
Removed call to get the absolute path of the file, corrected the <code>.mos</code>
file name and updated the documentation
</li>
<li>
April 15, 2019, by Ana Constantin:<br/>
First implementation.
</li>
</ul>
</html>"),
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/GetTimeSpanTMY3.mos"
        "Simulate and plot"));
end GetTimeSpanTMY3;
