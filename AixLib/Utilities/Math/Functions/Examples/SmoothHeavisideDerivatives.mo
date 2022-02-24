within AixLib.Utilities.Math.Functions.Examples;
 model SmoothHeavisideDerivatives
   "Test model for the derivatives of the smoothHeavisidefunction"
   extends Modelica.Icons.Example;
   Real y = AixLib.Utilities.Math.Functions.smoothHeaviside(x=time, delta=0.2) "Function value";
   Real der_y = der(y) "First derivative";
   Real der2_y = der(der_y) "Second derivative";
 equation
 
   annotation (experiment(Tolerance=1e-6, StartTime=-1, StopTime=1.0),
 __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Functions/Examples/SmoothHeavisideDerivatives.mos"
         "Simulate and plot"), Documentation(info="<html>
 <p>
 This model tests the first and second derivative of the twice Lipschitz continuously differentiable function
 <a href=\"modelica://AixLib.Utilities.Math.Functions.smoothHeaviside\">
 AixLib.Utilities.Math.Functions.smoothHeaviside</a>.
 </p>
 </html>", revisions="<html>
 <ul>
 <li>
 October 21, 2019, by Michael Wetter:<br/>
 First implementation.<br/>
 This is for
 <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1202\">issue 1202</a>.
 </li>
 </ul>
 </html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
 end SmoothHeavisideDerivatives;
