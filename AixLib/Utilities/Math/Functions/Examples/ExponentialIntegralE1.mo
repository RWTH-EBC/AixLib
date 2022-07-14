within AixLib.Utilities.Math.Functions.Examples;
model ExponentialIntegralE1
  "Test case for the exponential integral, E1"
  extends Modelica.Icons.Example;

  Real E1 "Exponential integral E1";

equation
  E1 = AixLib.Utilities.Math.Functions.exponentialIntegralE1(time);

  annotation (
    __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Functions/Examples/ExponentialIntegralE1.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StartTime=0.01, StopTime=3.0),
    Documentation(info="<html>
 <p>
 This example demonstrates the use of the function for the exponential integral,
 <i>E1</i>.
 </p>
 </html>",revisions="<html>
 <ul>
 <li>
 June 6, 2018, by Massimo Cimmino:<br/>
 First implementation.
 </li>
 </ul>
 </html>"),
  __Dymola_LockedEditing="Model from IBPSA");
end ExponentialIntegralE1;
