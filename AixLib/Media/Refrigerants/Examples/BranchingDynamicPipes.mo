within AixLib.Media.Refrigerants.Examples;
model BranchingDynamicPipes
  "Example model to test dynamic mass and energy equations"
  extends Modelica.Fluid.Examples.BranchingDynamicPipes(
    redeclare package Medium =
        AixLib.Media.Refrigerants.R744.R744_I0_P10_100_T233_373_Formula,
    boundary1(use_p_in=false, p=5000000),
    ramp1(
      duration=2,
      startTime=1,
      height=30e5,
      offset=11e5),
    boundary4(use_p_in=true, p=1100000),
    system(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_ambient=1100000,
      p_start=1100000),
    pipe4(p_a_start=1102000, p_b_start=1100000),
    pipe2(p_a_start=1103000, p_b_start=1102000),
    pipe3(p_a_start=1103000, p_b_start=1102000),
    pipe1(p_a_start=1105000, p_b_start=1103000));

annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>
This is a simple test for the refrigerant models. This test uses the test
model described in
<a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes \">
Modelica.Fluid.Examples.BranchingDynamicPipes
</a>.
</p>
</html>"));
end BranchingDynamicPipes;
