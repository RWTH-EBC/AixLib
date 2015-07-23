within AixLib.Fluid;
package Delays "Package with delay models"
  extends Modelica.Icons.VariantsPackage;


annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains components models for transport delays in
piping networks.
</p>
<p>
The model
<a href=\"modelica://AixLib.Fluid.Delays.DelayFirstOrder\">
AixLib.Fluid.Delays.DelayFirstOrder</a>
approximates transport delays using a first order differential equation.
</p>
<p>
For a discretized model of a pipe or duct, see
<a href=\"modelica://AixLib.Fluid.FixedResistances.Pipe\">
AixLib.Fluid.FixedResistances.Pipe</a>.
</p>
</html>"));
end Delays;
