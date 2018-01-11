within AixLib.Airflow.AirHandlingUnit.BaseClasses;
block iselement
  "block to proof either an integer is element of a set of integers"

  parameter Integer n=1;
  parameter Integer modes[n];
  Boolean x[n];

  Modelica.Blocks.Interfaces.IntegerInput u    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.BooleanOutput y    annotation (Placement(transformation(extent={{80,52},{118,90}})));

equation
  for i in 1:n loop
    (if Modelica.Math.isEqual(u,modes[i]) then true else false)=x[i];
  end for;

  y=Modelica.Math.BooleanVectors.anyTrue(x);
end iselement;
