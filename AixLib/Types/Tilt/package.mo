within AixLib.Types;
package Tilt "List of possible constant values for surface tilt"
  extends Modelica.Icons.TypesPackage;

  constant Modelica.SIunits.Angle Ceiling = 0 "Tilt for ceiling";
  constant Modelica.SIunits.Angle Floor =   Modelica.Constants.pi
  "Tilt for floor";
  constant Modelica.SIunits.Angle Wall =    Modelica.Constants.pi/2
  "Tilt for wall";


annotation(preferredView="info", Documentation(info="<html><p>
  Possible constant values to define the tilt of a surface. For
  example, for a construction that is a floor, use
  <code>AixLib.Types.Tilt.Floor</code>.
</p>
<p>
  Note that a ceiling has a tilt of <i>0</i> 
  <!-- @include_Buildings, and also the solar collector models in



  <a href=\"AixLib.Fluid.SolarCollectors\">AixLib.Fluid.SolarCollectors</a>



  require a tilt of <i>0</i>



  -->
   if they are facing straight upwards. This is correct because the
  solar irradiation on a ceiling construction is on the other-side
  surface, which faces upwards toward the sky. Hence, a construction is
  considered a ceiling from the view point of a person standing inside
  a room.
</p>
</html>",
  revisions="<html><ul>
  <li>November 30, 2010, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Tilt;
