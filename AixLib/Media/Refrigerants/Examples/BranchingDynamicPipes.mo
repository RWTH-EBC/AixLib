within AixLib.Media.Refrigerants.Examples;
model BranchingDynamicPipes
  "Example model to test dynamic mass and energy equations"
  extends Modelica.Fluid.Examples.BranchingDynamicPipes(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
        system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial));

annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html><p>
  This is a simple test for the refrigerant models. This test uses the
  test model described in <a href=
  \"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\">Modelica.Fluid.Examples.BranchingDynamicPipes</a>
  .
</p>
</html>"));
end BranchingDynamicPipes;
