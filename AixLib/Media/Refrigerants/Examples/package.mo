within AixLib.Media.Refrigerants;
package Examples "Packages with example models for testing refrigerent models"
  extends Modelica.Icons.ExamplesPackage;





  model BranchingDynamicPipes
  extends Modelica.Fluid.Examples.BranchingDynamicPipes(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
        system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial),
        ramp1(duration=1e-12));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This is a simple test for the refrigerant mode that uses test model described in <a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes \"> Modelica.Fluid.Examples.BranchingDynamicPipes </a>. However, the discrete change in pressure leads to numerical instability and, therefore, the duration of pressure change is set to t = 1e-12 s. </p>
</html>"));
  end BranchingDynamicPipes;

annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 12, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides models to test the refrigerant packages provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. These models are based on the models provided in <a href=\"modelica://AixLib.Media.Examples\">AixLib.Media.Examples</a> and are just adjusted for the refrigerant models.</p>
</html>"));
end Examples;
