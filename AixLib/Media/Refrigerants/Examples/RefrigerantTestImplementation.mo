within AixLib.Media.Refrigerants.Examples;
model RefrigerantTestImplementation
  "Model to test the refrigerant implementation"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel2(
    fixedMassFlowRate(use_T_ambient=true),
    volume(use_T_start=true),
    ambient(use_T_ambient=true),
    redeclare package Medium = R744.R744_IIR_P1_1000_T233_373_Formula,
    h_start=200000,
    p_start=9500000,
    T_start=363.15);

    annotation (experiment(Tolerance=1e-006),
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
