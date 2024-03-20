within AixLib.Airflow.Window.BaseClasses;
partial model PartialWindowBuoyancy
  "Calculation with input ports of temperatures"
  extends PartialWindow;
  Modelica.Blocks.Interfaces.RealInput T_a(unit="K", displayUnit="degC", min=0)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_i(unit="K", displayUnit="degC", min=0)
    "Room temperature"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
end PartialWindowBuoyancy;
