within AixLib.Airflow.Window.BasicModels;
model DeGids "Model de Gids and Phaff (1982)"
  extends BaseClasses.PartialWindowBuoyancy;
  Modelica.Blocks.Interfaces.RealInput A(unit="m2", min=0) "Opening area"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at height of 10 m"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
protected
  Real delta_T = abs(T_i - T_a) "Temperature difference";
  Real m = 0.001*(u_10^2) + 0.0035*winClrW*delta_T + 0.01;
equation
  assert(m>0, "Polynomial under square root is negative, output the result as 0.", AssertionLevel.warning);
  ventFlow = if m<0 then 0 else 0.5*A*sqrt(m);
end DeGids;
