within AixLib.Media.Refrigerants.Examples;
model RefrigerantDerivativeCheck
  "Model that tests the derivative implementation"
  extends Modelica.Icons.Example;
  extends AixLib.Media.Examples.BaseClasses.FluidProperties(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R1270.R1270_FastPropane,
    TMin=273.15,
    TMax=373.15);
equation
  // Check the implementation of the base properties
  basPro.state.p=p;
  basPro.state.T=T;
   annotation(experiment(StopTime=80, Tolerance=1e-008),
      __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Examples/WaterDerivativeCheck.mos"
        "Simulate and plot"),
      Documentation(info="<html>
  <p>
  This example checks whether the function derivative
  is implemented correctly. If the derivative implementation
  is not correct, the model will stop with an assert statement.
  </p>
  </html>",     revisions="<html>
  <ul>
  <li>
  August 17, 2015, by Michael Wetter:<br/>
  Changed regression test to have slope different from one.
  This is for
  <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/303\">issue 303</a>.
  </li>
  <li>
  December 18, 2013, by Michael Wetter:<br/>
  First implementation.
  </li>
  </ul>
  </html>"),
    __Dymola_experimentSetupOutput);
end RefrigerantDerivativeCheck;
