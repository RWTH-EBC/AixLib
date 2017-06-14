within AixLib.Media.Refrigerants.Examples;
model RefrigerantTestImplementation
  "Model to test the refrigerant implementation"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R1270.R1270_FastPropane,
    p_start = 0.5e5,
    T_start = 263.15,
    h_start = 177e3);

        annotation (experiment(Tolerance=1e-6, StopTime=1.0),
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
</html>"));
end RefrigerantTestImplementation;
