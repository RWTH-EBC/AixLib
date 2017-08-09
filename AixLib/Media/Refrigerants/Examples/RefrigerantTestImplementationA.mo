within AixLib.Media.Refrigerants.Examples;
model RefrigerantTestImplementationA
  "Model to test the refrigerant implementation"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_295_T233_370_Record,
    p_start = 0.5e5,
    T_start = 233.15,
    h_start = 151e3);                           //HelmholtzMedia.HelmholtzFluids.R134a
    annotation (experiment(Tolerance=1e-006),
  __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Examples/WaterTestImplementation.mos"
          "Simulate and plot"),
      Documentation(info="<html>
<p>This is a simple test for the refrigerant mode that uses test model described in <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium</a>. </p>
</html>",     revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end RefrigerantTestImplementationA;
