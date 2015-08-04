within AixLib.BoundaryConditions;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
annotation (preferredView="info",
Documentation(info="<html>
<p>This package contains models to read or compute boundary conditions, such as weather data, solar irradition and sky temperatures.
The calculations follow the description in Wetter (2004), Appendix A.4.2.</p>
<h4>Accessing weather data</h4>
<p>
The model
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.ReaderTMY3\">
AixLib.BoundaryConditions.WeatherData.ReaderTMY3</a>
can read TMY3 weather data for different locations.
The documentation of that model explains how to add
weather data for locations that are not distributed with the
<code>AixLib</code> library.
</p>
<p>
To access these weather data from the graphical model editor,
proceed as follows:
</p>
<ol>
<li>
<p>
Create an instance of
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.ReaderTMY3\">
AixLib.BoundaryConditions.WeatherData.ReaderTMY3</a>.
</p>
</li>
<li>
<p>
Create an instance of
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.Bus\">
AixLib.BoundaryConditions.WeatherData.Bus</a>.
</p>
</li>
<li>
<p>
Draw a connection between these two instances.
</p>
</li>
<li>
<p>
Finally, to send weather data to an input connector of a model,
connect the input connector of that model with the instance of
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.Bus\">
AixLib.BoundaryConditions.WeatherData.Bus</a>.
Some models connect to the whole weather data bus, such as
<a href=\"modelica://AixLib.BoundaryConditions.SolarGeometry.Examples.IncidenceAngle\">
AixLib.BoundaryConditions.SolarGeometry.Examples.IncidenceAngle</a>,
in which case the connection will directly be drawn.
Other models require only an individual signal from the weather data bus,
such as
<a href=\"modelica://AixLib.BoundaryConditions.SkyTemperature.Examples.BlackBody\">
AixLib.BoundaryConditions.SkyTemperature.Examples.BlackBody</a>.
In this situation, Modelica modeling environments typically show a window that allows you to
select what data from this weather data bus you want to connect
with your model.
</p>
</li>
</ol>
<h4>Conventions for surface azimuth and tilt</h4>
<p>To compute the solar irradiation, parameters such as the surface azimuth and the surface tilt are defined as shown in the following three figures. </p>
<p align=\"center\"><img alt=\"image\" src=\"modelica://AixLib/Resources/Images/BoundaryConditions/ear_ray.png\"/> </p>
<p align=\"center\"><img alt=\"image\" src=\"modelica://AixLib/Resources/Images/BoundaryConditions/zen_sun.png\"/> </p>
<p align=\"center\"><img alt=\"image\" src=\"modelica://AixLib/Resources/Images/BoundaryConditions/zen_pla.png\"/> </p>
<p>
For the surface azimuth and tilt, the enumerations
<a href=\"modelica://AixLib.Types.Azimuth\">
AixLib.Types.Azimuth</a>
and
<a href=\"modelica://AixLib.Types.Tilt\">
AixLib.Types.Tilt</a>
can be used.
</p>
<p>
Note that a ceiling has a tilt of <i>0</i>, and also the solar collector models
in
<a href=\"AixLib.Fluid.SolarCollectors\">AixLib.Fluid.SolarCollectors</a>
require a tilt of <i>0</i> if they are facing straight upwards.
This is correct because
the solar irradiation on a ceiling construction is on the other-side surface,
which faces upwards toward the sky. Hence, a construction is considered
a ceiling from the view point of a person standing inside a room.
</p>

<h4>References</h4>
<ul>
<li>
Michael Wetter.<br/>
<a href=\"http://simulationresearch.lbl.gov/wetter/download/mwdiss.pdf\">
Simulation-based Building Energy Optimization</a>.<br/>
Dissertation. University of California at Berkeley. 2004.
</li>
</ul>
</html>"));
end UsersGuide;
