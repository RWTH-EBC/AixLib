within AixLib.BoundaryConditions.SolarGeometry;
package BaseClasses "Package with base classes for AixLib.BoundaryConditions.SolarGeometry"
  extends Modelica.Icons.BasesPackage;

  block DeclinationSpencer "Declination angle after (spencer, 1971)"
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput nDay(quantity="Time", unit="s")
      "Day number with units of seconds"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput decAng(
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg") "Solar declination angle"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
    Real B "Auxiliary parameter";

  equation
    B = (nDay/24/60/60-1)*360/365*Modelica.Constants.pi/180;
    decAng  = 0.006918-0.399912*Modelica.Math.cos(B)+0.070257*Modelica.Math.sin(B)-
    0.006758*Modelica.Math.cos(2*B)+0.000907*Modelica.Math.sin(2*B)-
    0.002697*Modelica.Math.cos(3*B)+0.00148*Modelica.Math.sin(3*B);

    annotation (
      defaultComponentName="decAng",
      Documentation(info="<html>
<p>
This component computes the solar declination after 
(Spencer, 1971, Fourier Series Representation of the Position of the
Sun.) with an <code>error lower than 0.035 °</code>.
It is the angle between the equatorial plane and the solar beam.
The input signal <code>nDay</code> is the one-based number of the day, but in seconds.
Hence, during January 1, we should have <code>nDay = 86400</code> seconds.
Since the effect of using a continuous number rather than an integer is small,
we approximate this so that <code>nDay = 0</code> at the start of January 1,
and <code>nDay = 86400</code> at the end of January 1.
</p>
</html>",   revisions="<html>
<ul>
<li>
June 4, 2019, by Kratz Michael:<br/>
First implementation. 
</li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={  Bitmap(extent={{-90,-90},{90,90}}, fileName=
                "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/Declination.png"),
                                Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255})}));
  end DeclinationSpencer;

annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.BoundaryConditions.SolarGeometry\">AixLib.BoundaryConditions.SolarGeometry</a>.
</p>
</html>"));
end BaseClasses;
