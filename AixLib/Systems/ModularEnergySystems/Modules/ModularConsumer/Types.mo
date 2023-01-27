within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
package Types
    extends Modelica.Icons.TypesPackage;
  type InputType = enumeration(
      Constant "Use constant parameter",
      Continuous "Use continuous, real input") "Input options for consumer 
    temperatures"
    annotation (Documentation(info="<html>
 <p>
 This type allows defining which type of input should be used for consumer 
 set temperatures.
 </p>
 <ol>
 <li>
 a constant set point declared by a parameter,
 </li>
 <li>
 a continuously variable set point.
 </li>
 </ol>
 </html>",revisions="<html>
 <ul>
 <li>
 January 27, 2023, by David Jansen:<br/>
 First implementation.
 </li>
 </ul>
 </html>"));
end Types;
