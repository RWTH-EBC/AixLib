within AixLib.Media.Refrigerants.Examples;
model RefrigerantTestImplementationA
  "Model to test the refrigerant implementation"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_340_Formula,
    h_start=151000,
    p_start=150000,
    T_start=333.15,
    fixedMassFlowRate(use_T_ambient=true),
    volume(use_T_start=true),
    ambient(use_T_ambient=true));

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
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    __Dymola_experimentSetupOutput);
end RefrigerantTestImplementationA;
