within AixLib.Media.Refrigerants.Examples;
model R134a1 "Example 1 for R134a"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
    redeclare package Medium = R1270.R1270_FastPropane,
    h_start=107390,
    fixedMassFlowRate(use_T_ambient=false),
    volume(use_T_start=false),
    ambient(use_T_ambient=false));
  annotation (experiment(StopTime=1.01));
end R134a1;
