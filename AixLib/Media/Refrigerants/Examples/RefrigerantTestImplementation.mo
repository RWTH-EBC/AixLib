within AixLib.Media.Refrigerants.Examples;
model RefrigerantTestImplementation
  "Model to test the refrigerant implementation"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel2(
    fixedMassFlowRate(use_T_ambient=true),
    volume(use_T_start=true, use_p_start=true),
    ambient(use_T_ambient=true),
    redeclare package Medium = R744.R744_IIR_P1_1000_T233_373_Formula,
    h_start=511630,
    p_start=2000000,
    T_start=323.15,
    shortPipe(dp_nominal=10000),
    shortPipe1(dp_nominal=10000));

    annotation (experiment(StopTime=100, Tolerance=1e-06),
      Documentation(info="<html>
<p>
This is a simple test for the refrigerant models. This model uses the test
model described in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium
</a>.
</p>
</html>",
revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end RefrigerantTestImplementation;
