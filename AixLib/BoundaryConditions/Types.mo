within AixLib.BoundaryConditions;

package Types "Package with type definitions"

 extends Modelica.Icons.TypesPackage;

  type DataSource = enumeration(

      File "Use data from file",

      Parameter "Use parameter",

      Input "Use input connector") "Enumeration to define data source"

        annotation(Documentation(info="<html>
<p>
  Enumeration to define the data source used in the weather data reader.
</p></html>",revisions="<html>
<ul>
  <li>July 20, 2011, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
<p>
  Enumeration to define the data source used in the weather data reader.
</p>
<ul>
  <li>August 13, 2012, by Wangda Zuo:<br/>
    First implementation.
  </li>
</ul>
<p>
  Enumeration to define the method used to compute the sky temperature.
</p>
<ul>
  <li>October 3, 2011, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>This package contains type definitions.

</html>"));

end Types;

